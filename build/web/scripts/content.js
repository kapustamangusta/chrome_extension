var openPanel = false;
var side = "right";
function init() {
    // var flutter = document.getElementsByTagName("flutter-view")[0];
    // console.log(flutter);
    let button = document.createElement('div');
    button.id = "open-button";
    // Задаем стили кнопки
    button.style.position = 'fixed';
    button.style.zIndex = "99999"
    button.style.top = '65%';
    button.style.right = "-75px";
    button.style.backgroundColor = 'white';
    button.style.color = "red";
    button.style.boxShadow = "0px 8px 15px rgba(0, 0, 0, 0.1)";
    button.style.border = 'none';
    button.style.cursor = 'pointer';
    button.style.fontSize = "16px";
    button.style.padding = "8px 20px"
    button.style.borderRadius = "20px 0 0 20px";
    button.style.transition = "transform 0.3s ease-in-out"

    chrome.storage.sync.get("darkMode", function (result) {
        if (chrome.runtime.lastError) {
            reject(chrome.runtime.lastError.message);
        } else {
            if (result["darkMode"] == "true") {
                button.style.backgroundColor = 'black';
            };
        }
    });


    button.addEventListener('mouseover', function () {
        if (!openPanel) {
            if (side == "right") {
                button.style.transform = 'translateX(-75px)';
            }
            else if (side == "left") {
                //button.style.transform = 'translateX(75px)';
            }
        }

    });

    button.addEventListener('mouseout', function () {
        //button.style.transform = 'none';
    });
    // Добавляем текст кнопки
    button.textContent = 'GPT СTRL-?';


    // Добавляем кнопку на страницу
    document.body.appendChild(button);


    // Добавляем обработчик события нажатия на кнопку
    button.addEventListener('click', function () {
        //chrome.runtime.sendMessage({ action: 'openSidePanel' });
        var flutter = document.getElementsByTagName("flutter-view")[0];
        if (!openPanel) {
            if (side == "right") {
                rightMoveOnClosedPanel(flutter, button);
            } else if (side == "left") {
                flutter.style.transform = 'translateX(-500px)';
                button.style.transform = 'translateX(500px)';
            }
            //

        }
        else {
            if (side == "right") {
                rightMoveOnOpenedPanel(button, flutter);
            } else if (side == "left") {
                button.style.transform = 'translateX(0px)';
                flutter.style.transform = 'translateX(-1000px)';
            }

            //rightMoveOnOpenedPanel(button, flutter);
        }

        openPanel = !openPanel;


    });

    chrome.runtime.connect({
        name: 'mySidepanel'
    });
}

chrome.runtime.onMessage.addListener(function (message, sender, sendResponse) {
    var flutter = document.getElementsByTagName("flutter-view")[0];
    var button = document.getElementById("open-button");
    if (message.type == "notifications") {
        if (message.data.type == "left") {
            side = "left";
            console.log(message);
            flutter.style.inset = "0";
            flutter.style.left = "500px";
            setLeftButtonStyle(button);
        } else if (message.data.type == "right") {
            side = "right";
            console.log(message);
            flutter.style.inset = "0 0 0 auto";
            flutter.style.right = "-500px";
            setRightButtonStyle(button);

        }
    } else if (message.type == "darkMode") {

        if (message.data == "true") {
            button.style.backgroundColor = "black";
        } else if (message.data == "false") {
            button.style.backgroundColor = "white";
        }
    }
});


init();



const targetNode = document.querySelector('body');




// Параметры наблюдателя
const config = { attributes: false, childList: true, subtree: true };

// Функция обратного вызова, которая будет выполнена при изменении
const callback = function (mutationsList, observer) {
    for (let mutation of mutationsList) {
        if (mutation.type === 'childList') {
            mutation.addedNodes.forEach(node => {
                if (node.nodeType === 1) { // Проверяем, что узел является элементом
                    if (node.nodeName === 'FLUTTER-VIEW') {
                        //document.body.removeChild(node);
                        targetNode.style.overflow = "scroll";
                        targetNode.style.overflowX = "hidden";
                        targetNode.style.position = "relative";
                        node.style.width = "500px";
                        node.style.position = "fixed";
                        node.style.inset = "0 0 0 auto";

                        node.style.right = "-500px"

                        node.style.overflow = "hidden";
                        node.style.zIndex = "999999";
                        node.style.transition = "transform 0.5s ease-in-out";


                    }
                }
            });
        }
    }
};

// Создаем экземпляр MutationObserver с указанной функцией обратного вызова
const observer = new MutationObserver(callback);

// Начинаем наблюдение с указанными параметрами
observer.observe(targetNode, config);

console.log(chrome.runtime.getURL("assets/FontManifest.json"));

function rightMoveOnOpenedPanel(button, flutter) {
    button.style.transform = 'translateX(0px)';
    flutter.style.transform = 'translateX(0px)';
}

function rightMoveOnClosedPanel(flutter, button) {
    flutter.style.transform = 'translateX(-500px)';
    button.style.transform = 'translateX(-575px)';
}

function setRightButtonStyle(button) {
    button.style.right = "-75px";
    button.style.left = "auto";
    button.style.transform = 'translateX(-500px)';
    button.textContent = 'GPT СTRL-?';
    button.style.borderRadius = "20px 0 0 20px";
}

function setLeftButtonStyle(button) {
    button.style.right = "auto";
    button.style.left = "0";
    button.style.transform = 'translateX(500px)';
    button.textContent = 'GPT';
    button.style.borderRadius = "0 20px 20px 0 ";
}
