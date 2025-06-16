<?php
require_once '../models/Product.php';
header("Content-Type: application/json");

$model = new ProductModel();

echo json_encode($model->getAll());
?>
