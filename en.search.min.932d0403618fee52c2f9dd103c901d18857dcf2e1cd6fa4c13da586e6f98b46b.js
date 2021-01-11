'use strict';(function(){function focusSearchFieldOnKeyPress(e){if(input===document.activeElement){return;}
const characterPressed=String.fromCharCode(e.charCode);if(!isHotkey(characterPressed)){return;}
input.focus();e.preventDefault();}
function isHotkey(character){const dataHotkeys=input.getAttribute('data-hotkeys')||'';return dataHotkeys.indexOf(character)>=0;}
function init(){input.removeEventListener('focus',init);input.required=true;loadScript('/flexsearch.min.js');loadScript('/en.search-data.min.b97d990bd56847b0c5fac45d389c73b9713643394b5d69f4eab2698033c1a230.js',function(){input.required=false;search();});}
function search(){while(results.firstChild){results.removeChild(results.firstChild);}
if(!input.value){return;}
const searchHits=window.bookSearchIndex.search(input.value,10);searchHits.forEach(function(page){const li=document.createElement('li'),a=li.appendChild(document.createElement('a'));a.href=page.href;a.textContent=page.title;results.appendChild(li);});}
function loadScript(src,callback){const script=document.createElement('script');script.defer=true;script.async=false;script.src=src;script.onload=callback;document.head.appendChild(script);}})();