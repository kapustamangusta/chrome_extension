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



chrome.runtime.onMessage.addListener(async (message, sender, sendResponse) => {

  if (message.action === 'openSidePanel') {
    if (sender.tab && sender.tab.id) {
      try {
        await chrome.sidePanel.open({ tabId: sender.tab.id });
        console.log('Side panel opened successfully');
        await chrome.tabs.sendMessage(sender.tab.id, {success: true});
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
  }

});