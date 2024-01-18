
function init(){
    let button = document.createElement('div');
    button.id = "open-button";
    // Задаем стили кнопки
    button.style.position = 'fixed';
    button.style.zIndex="99999"
    button.style.top = '65%';
    button.style.right = "-75px"
    button.style.backgroundColor = '#4CAF50';
    button.style.color = 'white';
    button.style.border = 'none';
    button.style.cursor = 'pointer';
    button.style.fontSize ="16px";
    button.style.padding ="8px 20px"
    button.style.borderRadius ="20px 0 0 20px";
    button.style.transition = "transform 0.3s ease-in-out"
    button.addEventListener('mouseover', function() {
        button.style.transform = 'translateX(-75px)';
    });
    
    button.addEventListener('mouseout', function() {
        button.style.transform = 'none';
    });
    // Добавляем текст кнопки
    button.textContent = 'GPT СTRL-?';


    // Добавляем кнопку на страницу
    document.body.appendChild(button);

    //document.body.style.overflow="hidden";

    // Добавляем обработчик события нажатия на кнопку
    button.addEventListener('click', function() {
        chrome.runtime.sendMessage({todo: "showSideBar"});
    });
}

init();