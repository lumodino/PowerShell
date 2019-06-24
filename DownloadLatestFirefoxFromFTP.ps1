#DESCARGA LA ULTIMA VERSION DE FIREFOX O THUNDERBIRD DEL FTP WEB DE MOZILLA
#INTERCAMBIAR # DEL COMENTARIO ENTRE PRIMERA Y SEGUNDA LINEA PARA DESCARGAR LA VERSION DE THUNDERBIRD O LA DE FIREFOX

#[string]$aplicacion="Thunderbird"
[string]$aplicacion="Firefox"
[string]$rutadescarga="$env:homepath\Downloads"
$mozilla = $aplicacion.ToLower()
[string]$rutadescargas="/pub/$mozilla/releases/"
$webdescargafirefox = Invoke-WebRequest -Uri "http://ftp.mozilla.org$rutadescargas" -UseBasicParsing
($webdescargafirefox.Links).href | ForEach-Object {$_.TrimStart("$rutadescargas")}`
    | ForEach-Object {$_.TrimEnd("/")}`
    | Where-Object {($_ -Match '\d\d\W\d+\W\d+$') -or ($_ -Match '\d\d\W\d+$')}`
    | foreach-object {[System.Version]$_}`
    | Sort-Object `
    | Select-Object -Last 1 `
    | ForEach-Object {[string]$versionmozilla=$_.tostring()}
New-Item "$rutadescarga\$($aplicacion)32\" -ItemType Directory -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri "http://ftp.mozilla.org$rutadescargas$versionmozilla/win32/es-ES/$aplicacion Setup $versionmozilla.exe" -OutFile "$rutadescarga\$($aplicacion)32\$aplicacion Setup $versionmozilla.exe" -UseBasicParsing
New-Item "$rutadescarga\$($aplicacion)64\" -ItemType Directory -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri "http://ftp.mozilla.org$rutadescargas$versionmozilla/win64/es-ES/$aplicacion Setup $versionmozilla.exe" -OutFile "$rutadescarga\$($aplicacion)64\$aplicacion Setup $versionmozilla.exe" -UseBasicParsing
