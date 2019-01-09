/***
 * Evernote Word Counter
 *
 * Paste this into the javascript console while editing your note to get an updating word count at the bottom.
 *
 */



// function countWords(text) {
//     text = text.replace(/(^\s*)|(\s*$)/gi,"");
//     text = text.replace(/[ ]{2,}/gi," ");
//     text = text.replace(/\n /,"\n");
//     return text.split(' ').length;
// }
countWords = function(text) {
    text = text.replace(/(^\s*)|(\s*$)/gi,"");
    text = text.replace(/[ ]{2,}/gi," ");
    text = text.replace(/\n /,"\n");
    return text.split(' ').length;
}

var innerDoc = document.getElementById('qa-COMMON_EDITOR_IFRAME').contentDocument;

var noteElement = innerDoc.getElementById('en-note');

// noteElement = document.getElementById('en-note');
countWords(noteElement.innerText);

var wordCountNode = innerDoc.createElement('div');
innerDoc.body.appendChild(wordCountNode);

wordCountNode.innerText = countWords(noteElement.innerText) + " words";

// Styling we want for the element
// element.style {
//     position: fixed;
//     bottom: 0;
//     padding: 0.2rem;
//     border-top: 1px solid;
//     width: 100%;
//     text-align: right;
//     background: #ddd;
// }

wordCountNode.style.position = 'fixed';
wordCountNode.style.bottom = '0';
wordCountNode.style.padding = '0.25rem';
wordCountNode.style.borderTop = '1px solid';
wordCountNode.style.width = '100%';
wordCountNode.style.textAlign = 'right';
wordCountNode.style.background = '#ddd';

noteElement.addEventListener('textInput', function (e) {
    console.log("Haribol! Text has changed");
    hasTextChanged = true;
});

var hasTextChanged = false;

updateWordCount = function() {
    // only try to update if field has changed, to avoid unnecessary CPU cycles
    if (! hasTextChanged) { return; }
    wordCountNode.innerText = countWords(noteElement.innerText) + " words";
    hasTextChanged = false;
};

interval = setInterval(updateWordCount, 1000);
