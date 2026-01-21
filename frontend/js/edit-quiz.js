// const textarea = document.getElementById('edit-title');

// textarea.addEventListener('input', () => {
//   this.style.height = 'auto';
//   this.style.height = (this.scrollHeight) + 'px';
// });


const textarea = document.querySelector('.auto-expand');

textarea.addEventListener('input', function(){
  this.style.height = 'auto'; 
  this.style.height = this.scrollHeight + 'px'; 
});