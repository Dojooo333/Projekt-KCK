// Funkcje odpowiedzialne za aktualizacje elementów na stronie
document.addEventListener('DOMContentLoaded', () => {

  // Overlay - ukrycie i pokazanie
  const overlayConfirm = document.getElementById('overlay-confirm');
  const buttonExitEdit = document.getElementById('button-exit-edit');
  const buttonContinueEdit = document.getElementById('button-continue-edit');

  overlayConfirm.addEventListener('click', (element) => {
    if(element.target === overlayConfirm){
      overlayConfirm.classList.add('hidden');
    }
  });

  buttonExitEdit.addEventListener('click', (element) => {
    element.preventDefault();
    overlayConfirm.classList.remove('hidden');
  });

  buttonContinueEdit.addEventListener('click', (element) => {
    overlayConfirm.classList.add('hidden');
  });

  // Podłączenie listnera na input do elementu - automatycznie poszerzanie wysokości
  function attachAutomaticRowSize(element){
    element.addEventListener('input', function(){
      this.style.height = 'auto'; 
      this.style.height = this.scrollHeight + 'px'; 
    });
  }

  // Podpięcie pod wszsytkie istniejące elementy listnera na input
  const automaticRowSize = document.querySelectorAll('.automatic-row-size');
  automaticRowSize.forEach(element => attachAutomaticRowSize(element));




  // Obserwujemy wszystkie klikane elementy
  document.addEventListener('click', (element) => {

    // Dodawanie nowego pytania
    if(element.target && element.target.classList.contains('question-new') && !element.target.classList.contains('save')){
      addQuestion(element.target);
    }

    // Reset przycisków usunięcia pytań na stronie - klinięcie w inne miejsce
    if(!element.target.closest('.delete.step-2')){
      document.querySelectorAll('.delete.step-2').forEach(button => {

        // Resetowanie intervalu jeśli ustawiony
        if(button.dataset.timerID){
          clearInterval(button.dataset.timerID);
          delete button.dataset.timerID;
        }

        // Resetowanie tekstu jesli ustawione
        if(button.dataset.originalText){
          const span = button.querySelector('span');
          if(span) span.innerHTML = button.dataset.originalText;
          delete button.dataset.originalText;
        }

        // Czyszczenie samego elementu
        button.classList.add('hidden');
        button.disabled = false;

      });
      document.querySelectorAll('.delete.step-1').forEach(button => button.classList.remove('hidden'));
    }

    // Pierwsze kliknięcie w przycisk usunięcia
    if(element.target.closest('.delete.step-1')){
      const buttonStep1 = element.target.closest('.delete.step-1');
      const buttonStep2 = buttonStep1.nextElementSibling;

      if(buttonStep2 && buttonStep2.classList.contains('step-2')){
        buttonStep1.classList.add('hidden');
        buttonStep2.classList.remove('hidden');

        // Odliczanie do pojawienia się przycisku
        let timeLeft = 2000;
        const span = buttonStep2.querySelector('span');
        const text = span.innerHTML;

        buttonStep2.disabled = true;
        span.textContent = `Poczekaj\n${(timeLeft/1000).toFixed(1)}s`;

        const interval = setInterval(() => {
          timeLeft -=100;
          if(timeLeft > 0){
            span.textContent = `Poczekaj\n${(timeLeft/1000).toFixed(1)}s`;
          }else{
            clearInterval(interval);
            buttonStep2.disabled = false;
            span.innerHTML = text;
          }
        }, 100);

        buttonStep2.dataset.timerID = interval;
        buttonStep2.dataset.originalText = text;
      }
    }

    // Kliknięcie w potwierdzenie usunięcia
    if(element.target.closest('.delete.step-2')){
      const question = element.target.closest('.question');
      const buttonAfter = question.nextElementSibling;

      if(buttonAfter && buttonAfter.classList.contains('question-new')){
        buttonAfter.remove();
        question.remove();
        reindexQuestions();
      }
    }

    // Przesunięcie pytania w górę
    if(element.target.closest('.move-up')){
      const question = element.target.closest('.question');
      const buttonBefore = question.previousElementSibling;

      if(buttonBefore && buttonBefore.classList.contains('question-new')){
        const questionBefore = buttonBefore.previousElementSibling;

        if(questionBefore && questionBefore.classList.contains('question')){
          const targetBeforeButton = question.nextElementSibling;

          questionBefore.before(question);
          question.after(targetBeforeButton);

          reindexQuestions();

          question.scrollIntoView({ behavior: 'auto', block: 'center' });
        }
      }
    }

    // Przesunięcie pytania w dół
    if(element.target.closest('.move-down')){
      const question = element.target.closest('.question');
      const buttonAfter = question.nextElementSibling;
      const questionAfter = buttonAfter.nextElementSibling;

      if(questionAfter && questionAfter.classList.contains('question') && questionAfter.id !== 'question-template'){
        const targetAfterButton = questionAfter.nextElementSibling;

        targetAfterButton.after(buttonAfter);
        buttonAfter.before(question);

        reindexQuestions();

        question.scrollIntoView({ behavior: 'auto', block: 'center' });
      }
    }

  });

  // Funkcja, której zadaniem jest dodanie nowego pytania i przycisku
  function addQuestion(clickedButton){

    // Pobranie szablonów nowych elementów
    const questionTemplate = document.getElementById('question-template');
    const buttonTemplate = document.getElementById('question-new-template');

    // Klonowanie szablonów
    const newQuestion = questionTemplate.cloneNode(true);
    const newButton = buttonTemplate.cloneNode(true);

    // Czyszczenie ID szablonów i nadanego stylu display none
    newQuestion.removeAttribute('id');
    newQuestion.style.display = '';
    newButton.removeAttribute('id');
    newButton.style.display = '';

    // Podpięcie automatycznego rozszerzania pod nowe pola tekstowe
    const newInputElements = newQuestion.querySelectorAll('.automatic-row-size');
    newInputElements.forEach(el => attachAutomaticRowSize(el));

    // Wstawianie nowych elementów
    clickedButton.after(newQuestion);
    newQuestion.after(newButton);

    // Zmiany numeracji pytań
    reindexQuestions();

  }

  function reindexQuestions(){
    
    // Pobieramy wszystkie pytania (poza template) i na każdym wykonujemy zmiany
    const allQuestions = document.querySelectorAll('.question:not(#question-template)');

    const radioStates = [];
    allQuestions.forEach(element => {
      const checked = element.querySelector('.right-answer-radio:checked');
      radioStates.push(checked.value);
    });

    allQuestions.forEach((questionElement, index) => {

      // Aktualizacja numeru pytania
      const questionNr = questionElement.querySelector('.question-nr');
      questionNr.textContent = index + 1;

      // Aktualizacja atrybutu name pytania
      const questionTitle = questionElement.querySelector('.question-title');
      questionTitle.name = `questions[${index}][question]`;


      // Aktualizacja atrybutów name dla każdej z odpowiedzi w danym pytaniu
      ['a','b','c','d'].forEach(letter => {
        const answer = questionElement.querySelector(`.answer-${letter} .quiz-answer-abcd`);
        answer.name = `questions[${index}][${letter}]`;
      });

      // Aktualizacja atrybutów name dla przycisków z dobrą odpowiedzią
      const rightAnswers = questionElement.querySelectorAll('.right-answer-radio')
      rightAnswers.forEach(radio => {
        radio.name = `questions[${index}][correct]`;
      });

      // Przywrócenie stanu zaznaczonego elementu
      const checkedRadio = questionElement.querySelector(`.right-answer-radio[value="${radioStates[index]}"]`);
      checkedRadio.checked = true;

      // Wyłączenie niepotrzebnych przycisków przesunięcia
      const buttonUp = questionElement.querySelector('.move-up');
      const buttonDown = questionElement.querySelector('.move-down');

      buttonUp.disabled = false;
      buttonDown.disabled = false;

      if(index === 0){
        buttonUp.disabled = true;
      }
      if(index === allQuestions.length - 1){
        buttonDown.disabled = true;
      }

      // Blokada przycisku usunięcia, jeżeli jest tylko jedno pytania
      const deleteButtons  = questionElement.querySelectorAll('.delete');

      deleteButtons.forEach(button => {
        button.disabled = false;
        button.style.cursor = "";
      });

      if(allQuestions.length === 1){
        deleteButtons.forEach(button => {
          button.disabled = true;
          button.style.cursor = "default";
        });
      }


    });

  }

  // Początkowe wyszarzenie pierwszego przycisku move-up i ostatniego move-down
  reindexQuestions();

});
