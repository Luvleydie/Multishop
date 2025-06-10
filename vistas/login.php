<?php
require_once '../config/conexion.php';
header('Content-Type: application/json');

// Ruta del archivo log en la raíz del proyecto
$logFile = 'login.log';

// Verifica que el archivo sea escribible o que pueda crearse
if (!file_exists($logFile)) {
    if (!is_writable(__DIR__)) {
        echo json_encode([
            "success" => false,
            "message" => "No hay permisos para crear el archivo de log en la raíz."
        ]);
        exit;
    }
}

// Función para escribir en el log
function guardarLog($usuario, $estado) {
    global $logFile;
    $fecha = date('Y-m-d H:i:s');
    $ip = $_SERVER['REMOTE_ADDR'] ?? 'N/A';
    $navegador = $_SERVER['HTTP_USER_AGENT'] ?? 'N/A';
    $entrada = "[$fecha] IP: $ip - Usuario: $usuario - 
    Resultado: $estado - Navegador: $navegador\n";
    file_put_contents($logFile, $entrada, FILE_APPEND);
}

// Leer los datos del JSON enviado por JS
$input = json_decode(file_get_contents('php://input'), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $input) {
    $nombre = $conexion->real_escape_string($input['nombre'] ?? '');
    $pass = $conexion->real_escape_string($input['pass'] ?? '');

    // Consulta usando el campo correcto 'contrasena'
    $sql = "SELECT * FROM usuarios WHERE nombre = '$nombre' AND contrasena = '$pass'";
    $result = $conexion->query($sql);

    if ($result && $result->num_rows === 1) {
        guardarLog($nombre, "Éxito");
        echo json_encode([
            "success" => true,
            "message" => "Bienvenido, $nombre."
        ]);
    } else {
        guardarLog($nombre, "Fallo");
        echo json_encode([
            "success" => false,
            "message" => "Usuario o contraseña incorrectos."
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Solicitud inválida o datos incompletos."
    ]);
}
?>
