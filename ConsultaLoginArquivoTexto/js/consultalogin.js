window.onload = function() {
		var fileInput = document.getElementById('fileInput');
		fileInput.addEventListener('change', function(e) {
			var file = fileInput.files[0];
			var textType = /text.*/;

			if (file.type.match(textType)) {
				var reader = new FileReader();

				reader.onload = function(e) {
					console.log( reader.result );
				}

				reader.readAsText(file);
				document.getElementById('fileInput').style.visibility = 'hidden';
				document.getElementById('lblConfig').style.visibility = 'hidden';
				document.getElementById("cpf").focus();
			} else {
				console.log("File not supported!");
			}
		});
}

function Upload() {
	document.getElementById("lblErro").innerHTML = '';
	document.getElementById("lblSenhaAP").innerHTML = '';
	document.getElementById("lblInfoLogin").innerHTML = '';
	var cpf = document.getElementById('cpf').value;
	cpf = cpf.replace('-', '');
	cpf = cpf.replace('.', '');
  var fileUpload = document.getElementById("fileInput");
	if( document.getElementById("fileInput").files.length > 0 ){
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var rows = e.target.result.split("\n");
                var senha_AP = rows[0].split(";")
				document.getElementById("lblSenhaAP").innerHTML = 'Para acessar o AP Senha: ' + senha_AP;
				var found = false;
                for (var i = 1; i < rows.length; i++) {
                    var cells = rows[i].split(";");
					var cpfCell = cells[0];
					if (cpf == cpfCell) {
					  found = true;
					  document.getElementById("lblInfoLogin").innerHTML ='Usuario: ' + cells[1] + ' / Senha: ' + cells[2] ;
					  $("#myModal").modal('show');
					  console.log(cpfCell);
						document.getElementById("cpf").focus();
					  break;
					}
                }
				if (found == false) {
				  document.getElementById("lblInfoLogin").innerHTML = 'Usuário não encontrado.'
        		  $("#myModal").modal('show');
				}
            }
            reader.readAsText(fileUpload.files[0]);
        }
		else {
			document.getElementById("lblErro").innerHTML = "ERRO: This browser does not support HTML5.";
			$("#myModal").modal('show');
        }
	}
    else {
	  document.getElementById("lblErro").innerHTML ="ERRO: Configuração não foi carregada";
	  $("#myModal").modal('show');
	}
	document.getElementById("cpf").value = '';
};


$('#myModal').on('show.bs.modal', function () {
	setTimeout(function(){
			$("#myModal").modal('hide');
	}, 5000);
});


$('#myModal').on('hidden.bs.modal', function () {
	document.getElementById("cpf").focus();
});


$("#cpf").keyup(function(event){
    if(event.keyCode == 13){
        $("#btnConsultar").click();
    }
});

$(document).ready(function(){
  $('.cpf').mask('000.000.000-00', {reverse: true});
});
