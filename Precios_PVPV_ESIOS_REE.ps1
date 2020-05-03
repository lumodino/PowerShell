#DATOS PARA LA PETICION
$cabeceras = @{"Accept"="application/json; application/vnd.esios-api-v1+json";"Content-Type"="application/json";"Host"="api.esios.ree.es";"Cookie"= ""}

#PETICION WEB
$resultado=Invoke-WebRequest -Method get -Uri "https://api.esios.ree.es/archives/70/download_json?locale=es" -UseBasicParsing -Headers $cabeceras

#CONVERSION JSON
$datos = ConvertFrom-Json $resultado.Content

#SE MUESTRA LA INFORMACION EN COLUMNAS, POR HORAS.
#TARIFA GENERAL, NOCTURNA, VEHICULO ELECTRICO
$datos.PVPC | select hora,gen,noc,vhc
