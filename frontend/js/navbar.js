document.addEventListener('click', function(event){
    const container = document.getElementById('user');

    if(container.contains(event.target) === true || container === event.target){
        container.classList.add('show-logout');
    }else{
        container.classList.remove('show-logout');
    }
});