const form = document.getElementById('send-answer');
const overlayCorrect = document.getElementById('overlay-correct');
const overlayIncorrect = document.getElementById('overlay-incorrect');
const overlayFinished = document.getElementById('overlay-finished');
const answerButtons = document.querySelectorAll('.answer');

answerButtons.forEach((btn) => {
    btn.classList.remove('blink-processing','correct-answer','wrong-answer','selected-answer');
    btn.disabled = false;
});
overlayCorrect.classList.add('hidden');
overlayIncorrect.classList.add('hidden');
overlayFinished.classList.add('hidden');

form.addEventListener('sumbit', async(event) => {
    event.preventDefault();
});

answerButtons.forEach(buttonClicked => {
    buttonClicked.addEventListener('click', async (event) => {
        event.preventDefault();

        const buttonValue = buttonClicked.value;
        const formAction = form.action;

        answerButtons.forEach(buttonToDisable => {
            buttonToDisable.disabled = true;
        });
        buttonClicked.classList.add('selected-answer');

        try{
            const [response,_] = await Promise.all([
                fetch(formAction, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({answer: buttonValue})
                }),
                new Promise(resolve => setTimeout(resolve, 3000))
            ]);
            
            if(!response.ok) throw new Error('Internal error.');
            const result = await response.json();

            buttonClicked.classList.remove('selected-answer');

            setTimeout(() => {
                if(result.correct === true){
                    buttonClicked.classList.add('correct-answer');
                }else{
                    buttonClicked.classList.add('wrong-answer');
                }
                setTimeout(() => {
                    if(result.correct === true){
                        if(result.finished === true){
                            overlayFinished.classList.remove('hidden');
                        }else{
                            overlayCorrect.classList.remove('hidden');
                        }
                    }else{
                        overlayIncorrect.classList.remove('hidden');
                    }
                }, 1000);
            }), 1000;

            console.log(result);
        }catch(error){
            console.error('Error fatching data.');
        }
    });
});