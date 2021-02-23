"use strict";

var timesNotFound=0;

function showHint(str){
	document.getElementById("file_name").style.borderColor="#512268";
	document.getElementById("file_content").innerHTML="";
}
function findFiles(){
	findFile(document.getElementById("file_name").value+".html");
	findFile(document.getElementById("file_name").value+".txt");	
}
function turnRed(){
	if(timesNotFound++>=2){
		timesNotFound=0;
		document.getElementById("file_name").style.borderColor="red";
		document.getElementById("file_content").innerHTML="";
	}
}
async function findFile(fileName){
	let httpReq=new XMLHttpRequest();
	httpReq.open("GET",fileName,true);
	httpReq.onreadystatechange= function(){
		if(this.readyState===4 && this.status===200 && (RegExp(".html$").test(fileName) || document.getElementById("file_content").innerHTML==="")){
			document.getElementById("file_content").innerHTML=this.responseText;
		}else if(this.readyState===4 && this.status!==200)turnRed();
	}
	httpReq.send();
}
