/*
Se debe cambiar los siguientes puntos por el que corresponda.
USUARIO
CONTRASEÑA
DB_SERVER_HOSTNAME.DOMAIN
*/
var http = require('http'),
        oracledb = require('oracledb');
http.createServer(function(request, response) {
        oracledb.getConnection({
        user: 'USUARIO',
                password: 'CONTRASEÑA',
                connectString: "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=DB_SERVER_HOSTNAME.DOMAIN)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=NMPDEV)))"
        }, function(err, connection) {
                console.log(connection);
                if (err) {
                        console.log("Error");
                        console.log(err);
                        response.writeHead(200, { 'Content-Type': 'text/plain' });
                        response.send(err);
                } else {
                        console.log("Se conecto ok a oracle");
                        response.writeHead(200, { 'Content-Type': 'text/plain' });
                        response.end("Se conecto OK a Oracledb");
                        connection.release();
                }
        });
}).listen(8001);
console.log("Servidor corriendo en el puerto 8001");
