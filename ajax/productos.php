<?php
require_once("../config/conexion.php");
header("Content-Type: application/json");

$sql = "SELECT 
    p.id_producto,
    p.nombre_producto,
    p.descripcion,
    p.precio,
    p.stock,
    p.descuento,
    p.publicidad,
    c.nombre_categoria,
    u.nombre AS vendedor
FROM productos p
LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
LEFT JOIN usuarios u ON p.id_usuario = u.id_usuario
ORDER BY p.id_producto DESC";

$result = $conexion->query($sql);

$productos = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $productos[] = $row;
    }
}

echo json_encode($productos);
?>
<!-- Agrega esto al final de tu archivo shop.html antes de </body> -->
<script src="../js/productos.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    cargarProductos();
});
</script>

<div class="col-lg-9 col-md-8">
    <div class="row pb-3">
        <!-- Aquí se insertarán los productos -->
    </div>
</div>