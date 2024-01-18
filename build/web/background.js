const GOOGLE_ORIGIN = 'https://www.google.com';

chrome.permissions.request({
  permissions: [ "activeTab","sidePanel", "contextMenus","activeTab", "storage", "tabs"],
  origins: [ "<all_urls>"]
}, function(granted) {
  if (granted) {
    console.log('Access granted');
  } else {
    console.log('Access denied');
  }
});

chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: 'openSidePanel',
    title: 'Open side panel',
    contexts: ['all']
  });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === 'openSidePanel') {
    // This will open the panel in all the pages on the current window.
    chrome.sidePanel.open({ windowId: tab.windowId });
  }
});





chrome.runtime.onMessage.addListener(message=>{
  chrome.windows.getCurrent(window => chrome.sidePanel.open({windowId: window.id}));
});
