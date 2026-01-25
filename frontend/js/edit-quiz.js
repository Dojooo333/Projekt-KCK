// Funkcje odpowiedzialne za aktualizacje elementów na stronie
document.addEventListener('DOMContentLoaded', () => {

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

    // Usuwanie jednego z pytań
    if(element.target && element.target.classList.contains('delete')){
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
      console.log(buttonUp, buttonDown, "-----------------");
      if(index === 0){
        buttonUp.disabled = true;
      }else if(index === allQuestions.length - 1){
        buttonDown.disabled = true;
      }else{
        buttonUp.disabled = false;
        buttonDown.disabled = false;
      }

    });

  }

  // Początkowe wyszarzenie pierwszego przycisku move-up i ostatniego move-down
  reindexQuestions();

});
