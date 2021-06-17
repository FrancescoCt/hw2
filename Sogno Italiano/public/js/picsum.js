
const header = document.querySelector('header');

fetch("https://picsum.photos/2000/400").then(onResponse, onError);

function onResponse(response){
    
    header.style.backgroundImage = "url("+response.url+")";
}
function onError(error){
    console.log(error);
    header.style.backgroundImage = "url(img.jpg)";
	header.style.backgroundSize = "cover";
}
