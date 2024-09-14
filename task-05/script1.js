document.addEventListener('DOMContentLoaded', function() {
    var terminalOutput = document.querySelector('.terminal-output');
    var terminalInput = document.querySelector('input[type="text"]');
    var productCatalog = document.querySelector('.product-catalog');
    var products = [];

    function handleInput(command) {
        var parts = command.trim().split(' ');
        var action = parts[0];
        var args = parts.slice(1);

        switch (action) {
            case 'help':
                viewCommand();
                break;
            case 'list':
                listProducts();
                break;
            case 'details':
                fetchProductDetails(args[0]);
                break;
            case 'add':
                addToCart(args[0]);
                break;
            case 'remove':
                removeFromCart(args[0]);
                break;
            case 'cart':
                viewCart();
                break;
            case 'clear':
                terminalOutput.innerHTML = '';
                break;
            case 'search':
                searchProducts(args.join(' '));
                break;
            case 'sort':
                sortProducts(args[0]);
                break;
            case 'buy':
                buy();
                break;
            default:
                terminalOutput.innerHTML += 'Invalid command: ' + command + '\n';
                break;
        }

        terminalInput.value = '';
    }

    function viewCommand() {
        terminalOutput.innerHTML += `
Available Commands:
- help: Show this help message
- list: Display all available products
- details 'product_id': View details of a specific product
- add 'product_id': Add a product to the cart
- remove 'product_id': Remove a product from the cart
- cart: View the current items in your cart
- buy: Proceed to checkout
- clear: Clear the terminal screen
- search 'product_name': Search for a product by name
- sort 'price/name': Sort products by price or name
\n`;
    }

    function listProducts() {
        if (products.length === 0) {
            terminalOutput.innerHTML += 'No products available\n';
            return;
        }
        var output = products.map(function(product) {
            return product.id + ': ' + product.title + ' - $' + product.price;
        }).join('\n');
        terminalOutput.innerHTML += output + '\n';
    }

    function fetchProductDetails(productId) {
        var product = products.find(function(p) {
            return p.id == productId;
        });
        if (product) {
            terminalOutput.innerHTML += `
Title: ${product.title}
Description: ${product.description}
Price: $${product.price}
Category: ${product.category}
Rating: ${product.rating ? product.rating.rate + ' (' + product.rating.count + ' reviews)' : 'No rating'}
Image: ${product.image}\n`;
        } else {
            terminalOutput.innerHTML += 'Product not found\n';
        }
    }

    function searchProducts(query) {
        var filteredProducts = products.filter(function(p) {
            return p.title.toLowerCase().includes(query.toLowerCase());
        });
        var output = filteredProducts.length > 0
            ? filteredProducts.map(function(p) {
                return p.id + ': ' + p.title + ' - $' + p.price;
            }).join('\n')
            : 'No products found';
        terminalOutput.innerHTML += output + '\n';
    }

    function sortProducts(criteria) {
        var sortedProducts;
        if (criteria === 'price') {
            sortedProducts = products.slice().sort(function(a, b) {
                return a.price - b.price;
            });
        } else if (criteria === 'name') {
            sortedProducts = products.slice().sort(function(a, b) {
                return a.title.localeCompare(b.title);
            });
        } else {
            terminalOutput.innerHTML += 'Invalid sort criteria: ' + criteria + '\n';
            return;
        }
        var output = sortedProducts.map(function(p) {
            return p.id + ': ' + p.title + ' - $' + p.price;
        }).join('\n');
        terminalOutput.innerHTML += output + '\n';
    }

    function addToCart(productId) {
        terminalOutput.innerHTML += 'Added product ' + productId + ' to cart\n';
    }

    function removeFromCart(productId) {
        terminalOutput.innerHTML += 'Removed product ' + productId + ' from cart\n';
    }

    function viewCart() {
        terminalOutput.innerHTML += 'Viewing cart\n';
    }

    function buy() {
        terminalOutput.innerHTML += 'Proceeding to checkout\n';
    }

    function fetchProducts() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'https://fakestoreapi.com/products');
        xhr.onload = function() {
            if (xhr.status === 200) {
                products = JSON.parse(xhr.responseText);
                var productCards = products.map(function(product) {
                    return '<div class="product-card">' +
                        '<img src="' + product.image + '" alt="' + product.title + '">' +
                        '<div class="product-card-content">' +
                            '<h2>' + product.title + '</h2>' +
                            
                            '<div class="price">$' + product.price + '</div>' +
                            
                        '</div>' +
                    '</div>';
                }).join('');
                productCatalog.innerHTML = productCards;
            } else {
                console.error('Error fetching products:', xhr.status);
            }
        };
        xhr.send();
    }

    document.addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            var command = terminalInput.value.trim();
            handleInput(command);
        }
    });

    fetchProducts();
});
