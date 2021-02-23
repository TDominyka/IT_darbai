"use strict";
function add_file(directory_name){
	let failas=directory_name+"_failas";
	let clone = document.getElementsByName("myfile")[0].cloneNode(false);
	clone.value = "";
	document.getElementById(failas).appendChild(clone);
	document.getElementById(failas).insertAdjacentHTML( 'beforeend', '<br><br>' );
}
function add_internal_directory(parent_directory_name, directory_name){
	//console.log(document.getElementById(parent_directory_name)+"   "+directory_name)
	let branch=parent_directory_name+"/"+directory_name;
	let failas=branch+"_failas";
	document.getElementsByName(parent_directory_name)[0].insertAdjacentHTML( 'beforeend', `<div id='root' name=${branch} title=${branch}> \
  							<label for="myfile">Pasirinkite failus kėlimui į direktoriją ${branch}:</label> \
							<a class="btn" onclick=add_file("${branch}")>+</a> \
							<label for="directory_name">Naujo aplanko pavadinimas:</label>
  							<input type="text" id="${branch}" name="directory_name" placeholder="pvz.: root">
			<a class="btn" onclick="add_internal_directory('${branch}', document.getElementById('${branch}').value)">Sukurti</a><br> \
							<div id="${failas}"> \
  								<input type="file" id="myfile" name="myfile"><br><br> \
							</div></div>` );
}
