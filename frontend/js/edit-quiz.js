const automaticRowSize = document.querySelectorAll('.automatic-row-size');

automaticRowSize.forEach(element => {
  element.addEventListener('input', function(){
    this.style.height = 'auto'; 
    this.style.height = this.scrollHeight + 'px'; 
  });
});