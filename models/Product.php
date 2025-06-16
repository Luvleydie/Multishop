<?php
require_once __DIR__ . '/../config/conexion.php';

class ProductModel {
    private $conn;

    public function __construct() {
        global $conexion;
        $this->conn = $conexion;
    }

    public function getAll() {
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

        $result = $this->conn->query($sql);
        $productos = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $productos[] = $row;
            }
        }
        return $productos;
    }
}
?>
