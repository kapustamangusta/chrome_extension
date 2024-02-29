const GOOGLE_ORIGIN = 'https://www.google.com';

// chrome.runtime.onInstalled.addListener(() => {
//   chrome.contextMenus.create({
//     id: 'openSidePanel',
//     title: 'Open side panel',
//     contexts: ['all']
//   });
// });

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === 'openSidePanel') {
    // This will open the panel in all the pages on the current window.
    chrome.sidePanel.open({ windowId: tab.windowId });
  }
});





// chrome.runtime.onMessage.addListener(message=>{
//   chrome.windows.getCurrent(window => chrome.sidePanel.open({windowId: window.id}));
// });


var res = "1";
chrome.storage.sync.get("darkMode", function (result) {
  if (chrome.runtime.lastError) {
    reject(chrome.runtime.lastError.message);
  } else {
    res = result["darkMode"];
  }
});

var side = "right";
chrome.storage.sync.get("side", function (result) {
  if (chrome.runtime.lastError) {
    reject(chrome.runtime.lastError.message);
  } else {
    side = result["side"];
  }
});

chrome.runtime.onMessage.addListener(async (message, sender, sendResponse) => {
  console.log(message);
  function foo(result, sendResponse) {
    sendResponse(result);
  }


  if (message.action === 'openSidePanel') {
    if (sender.tab && sender.tab.id) {
      try {
        await chrome.sidePanel.open({ tabId: sender.tab.id });
        console.log('Side panel opened successfully');
        await chrome.tabs.sendMessage(sender.tab.id, { success: true });
      } catch (error) {
        console.error('Error opening side panel:', error);
        await chrome.tabs.sendMessage(sender.tab.id, { success: false, errorMessage: error.message });
      }
      return true; // Indicates an asynchronous response
    } else {
      console.log('No sender tab information available');
      sendResponse({ success: false });
      return false;
    }
  } else if (message.type === 'left') {
    side = 'left';
    chrome.storage.sync.set({ "side": message.type }, function () { });
    chrome.tabs.query({ active: !0, currentWindow: !0 }, function (tabs) {
      chrome.tabs.sendMessage(tabs[0].id, { "type": "notifications", "data": message });
    });
  } else if (message.type === 'right') {
    side = 'right';
    chrome.storage.sync.set({ "side": message.type }, function () { });
    chrome.tabs.query({ active: !0, currentWindow: !0 }, function (tabs) {
      chrome.tabs.sendMessage(tabs[0].id, { "type": "notifications", "data": message });
    });
  } else if (message.type == 'sideGet') {
    sendResponse(side);
    return true;
  } else if (message.type === 'darkMode') {
    chrome.storage.sync.set({ "darkMode": message.data }, function () { });
    chrome.storage.sync.get("darkMode", function (result) {
      if (chrome.runtime.lastError) {
        reject(chrome.runtime.lastError.message);
      } else {
        res = result["darkMode"];
      }
    });
    chrome.tabs.query({ active: !0, currentWindow: !0 }, function (tabs) {
      chrome.tabs.sendMessage(tabs[0].id, { "type": "darkMode", "data": message.data });
    });

  } else if (message.type === 'darkModeGet') {
    //chrome.storage.sync.get("darkMode", foo(sendResponse));
    sendResponse(res);
    return true;
  }

});



function alertMessage(text) {
  alert(text)
}

