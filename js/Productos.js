let productosTodos = [];
let productosFiltrados = [];
let paginaActual = 1;
const POR_PAGINA = 9;

function cargarProductos (){
    fetch('../ajax/productos.php')
    .then(res => res.json())
    .then(productos => { 
        productosTodos = productos;
        productosFiltrados = productos;
        renderProductos();
        agregarListeners();
    })
    .catch(err=>console.error('Error al cargar los produtos:', err));
   }

function agregarListeners(){
    const searchInput = document.getElementById('serch-input');
    if (searchInput) {
        document.querySelectorAll('[id^="price-"]').forEach(cb => {
            cb.addEventListener('change', aplicarFiltros);
        });
        searchInput.addEventListener('input', aplicarFiltros);
    }
}

function aplicarFiltros() {
    const search = document.getElementById('serch-input').value.toLowerCase();
    const precios = Array.from(document.querySelectorAll('[id^="price-"]:checked')).map(c => c.id);
}
