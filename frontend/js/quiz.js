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

        }catch(error){
            console.error('Error fatching data.');
        }
    });
});


const formHelp = document.getElementById('help-form');
const overlayHelpExpert = document.getElementById('overlay-helpExpert');
const overlayHelpPublic = document.getElementById('overlay-helpPublic');

const overlayHelpExpertButton = document.getElementById('overlay-helpExpert-button');
const overlayHelpPublicButton = document.getElementById('overlay-helpPublic-button');

const help5050 = document.getElementById('help5050');
const helpExpert = document.getElementById('helpExpert');
const helpPublic = document.getElementById('helpPublic');

overlayHelpExpertButton.addEventListener('click', async (event) => {
    overlayHelpExpert.classList.add('hidden');
});
overlayHelpPublicButton.addEventListener('click', async (event) => {
    overlayHelpPublic.classList.add('hidden');
});

help5050.addEventListener('click', async (event) => {
    event.preventDefault();

    const formAction = formHelp.action + "/5050";

    const buttons = {
        'a': document.getElementById('answerA'),
        'b': document.getElementById('answerB'),
        'c': document.getElementById('answerC'),
        'd': document.getElementById('answerD')
    };

    try{

        help5050.disabled = true;

        const response = await fetch(formAction, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        });


        if(!response.ok) throw new Error('Internal error.');
        const result = await response.json();

        if(result.hide !== null){
            buttons[result.hide[0]].disabled = true;
            buttons[result.hide[1]].disabled = true;
        }

    }catch(error){
        console.error('Error fatching data.');
    }
});
helpExpert.addEventListener('click', async (event) => {
    event.preventDefault();

    const formAction = formHelp.action + "/helpExpert";
    const helpExpertText = document.getElementById('helpExpert-text');

    try{

        helpExpert.disabled = true;

        const response = await fetch(formAction, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        });

        if(!response.ok) throw new Error('Internal error.');
        const result = await response.json();

        if(result.hint !== null){
            helpExpertText.textContent = result.hint;
            overlayHelpExpert.classList.remove('hidden');
        }

    }catch(error){
        console.error('Error fatching data.');
    }
});
helpPublic.addEventListener('click', async (event) => {
    event.preventDefault();

    const formAction = formHelp.action + "/helpPublic";

    const chartAnswer = {
        'a': document.getElementById('chart-answer-A'),
        'b': document.getElementById('chart-answer-B'),
        'c': document.getElementById('chart-answer-C'),
        'd': document.getElementById('chart-answer-D')
    };

    const chartPercentageText = {
        'a': document.getElementById('chart-percentage-A-text'),
        'b': document.getElementById('chart-percentage-B-text'),
        'c': document.getElementById('chart-percentage-C-text'),
        'd': document.getElementById('chart-percentage-D-text')
    };

    try{

        helpPublic.disabled = true;

        const response = await fetch(formAction, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        });


        if(!response.ok) throw new Error('Internal error.');
        const result = await response.json();

        if(result.chartData !== null){
            ['a','b','c','d'].forEach(letter => {
                chartPercentageText[letter].innerText = result.chartData[letter];
            });

            ['a','b','c','d'].forEach(letter => {
                chartAnswer[letter].style.height = (result.chartData[letter] * 2) + "px";
            });

            overlayHelpPublic.classList.remove('hidden');
        }

    }catch(error){
        console.error('Error fatching data.');
    }
});