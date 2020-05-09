<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">

<title>Asiakaslista</title>
<style>
.vasen{
		text-align:left;
		}
</style>
</head>
<body>
<table id="listaus">
	<thead>		
		
	<tr>
	<th colspan="6" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
	</tr>
	
	<tr>
	<th class="vasen">Hakusana: </th>
	<th colspan="4"><input type="text" id="hakusana"></th>
	<th class="vasen"><input type="button" value="Hae" id="hakunappi"></th>
	</tr>
		
		<tr>
 		<th>Asiakas ID</th>
 		<th>Etunimi</th>
 		<th>Sukunimi</th>
 		<th>Puhelinnumero</th>
 		<th>Sähköposti</th>
 		<th> </th>
		</tr>
		</thead>
		 		
		 <tbody>		 
		 </tbody>
</table>

<script>
$(document).ready(function(){
		$("#uusiAsiakas").click(function() {
			document.location="lisaaasiakas.jsp";
		
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		haeAsiakkaat();
});	
	$(document.body).on("keydown", function(event){ 
	if(event.which==13){
		haeAsiakkaat();
	
	}	
		
	});
	$("#hakusana").focus();
});	


	function haeAsiakkaat(){
		$("#listaus tbody").empty();
		$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.asiakas_id+"</td>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puhelin+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>"; 
			htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}
function poista(asiakas_id){
	if(confirm("Poista asiakas " + asiakas_id +"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { 
	        if(result.response==0){
	        	$("#ilmo").html("Asiakastiedon poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakas_id).css("background-color", "red");
	        	alert("Asiakkaan " + asiakas_id + " poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}
</script>
</body>
</html>