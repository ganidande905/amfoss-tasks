document.addEventListener('DOMContentLoaded', function() {
    const productContainer = document.querySelector('.products');
    const terminalInput = document.querySelector('.terminal-input input');
    const terminalOutput = document.querySelector('.terminal-output');
    let products = [];
    let cart = [];
    fetch('https://fakestoreapi.com/products')
        .then(response => response.json())
        .then(fetchedProducts => {
            products = fetchedProducts;
            let productHTML = '';
            products.forEach(product => {
                productHTML += `
                    <div class="product-card">
                        <img src="${product.image}" alt="${product.title}">
                        <h2>${product.title}</h2>
                        <span class="price">$${product.price}</span>
                        <div class="product-icons">
                            <i class="fas fa-heart"></i>
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                    </div>
                `;
            });
            productContainer.innerHTML = productHTML;
        })
        .catch(error => console.log('Error:', error));

   
    terminalInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            const command = terminalInput.value.trim();
            executeCommand(command);
            terminalInput.value = '';
        }
    });

    function executeCommand(command) {
        let output = '';
        const parts = command.toLowerCase().split(' ');
        const action = parts[0];
        const args = parts.slice(1);

        switch(action) {
            case 'help':
                output = `
Available Commands:
- help: Show this help message\n
- list: Display all available products\n
- details 'product_id': View details of a specific product\n
- add 'product_id': Add a product to the cart\n
- remove 'product_id': Remove a product from the cart\n
- cart: View the current items in your cart\n
- buy: Proceed to checkout\n
- clear: Clear the terminal screen\n
- search 'product_name': Search for a product by name\n
- sort 'price/name': Sort products by price or name\n
                `;
                break;
            case 'list':
                output = 'Available Products:\n';
                products.forEach((product, index) => {
                    output += `${product.id}: ${product.title} - $${product.price}\n`;
                });
                break;
            case 'details':
                const productId = args[0];
                const product = products.find(p => p.id == productId);
                if (product) {
                    output = `
Title: ${product.title}
Description: ${product.description}
Price: $${product.price}
Category: ${product.category}
Rating: ${product.rating ? product.rating.rate + ' (' + product.rating.count + ' reviews)' : 'No rating'}
Image: ${product.image}
                    `;
                } else {
                    output = 'Product not found';
                }
                break;
            case 'add':
                const addId = args[0];
                const addProduct = products.find(p => p.id == addId);
                if (addProduct) {
                    cart.push(addProduct);
                    output = `Added ${addProduct.title} to cart`;
                } else {
                    output = 'Product not found';
                }
                break;
            case 'remove':
                const removeId = args[0];
                const removeIndex = cart.findIndex(p => p.id == removeId);
                if (removeIndex > -1) {
                    const removedProduct = cart.splice(removeIndex, 1)[0];
                    output = `Removed ${removedProduct.title} from cart`;
                } else {
                    output = 'Product not in cart';
                }
                break;
            case 'cart':
                if (cart.length === 0) {
                    output = 'Cart is empty';
                } else {
                    output = 'Items in Cart:\n';
                    cart.forEach((item, index) => {
                        output += `${index + 1}. ${item.title} - $${item.price}\n`;
                    });
                }
                break;
            case 'buy':
                if (cart.length === 0) {
                    output = 'Cart is empty. Add items to cart before buying.';
                } else {
                    output = 'Successfully purchased\n';
                    cart = []; 
                }
                break;
            case 'search':
                const query = args.join(' ');
                const filteredProducts = products.filter(p => p.title.toLowerCase().includes(query.toLowerCase()));
                output = filteredProducts.length > 0
                    ? filteredProducts.map(p => `${p.id}: ${p.title} - $${p.price}`).join('\n')
                    : 'No products found';
                break;
            case 'sort':
                const criteria = args[0];
                let sortedProducts;
                if (criteria === 'price') {
                    sortedProducts = products.slice().sort((a, b) => a.price - b.price);
                } else if (criteria === 'name') {
                    sortedProducts = products.slice().sort((a, b) => a.title.localeCompare(b.title));
                } else {
                    output = 'Invalid sort criteria';
                    displayOutput(output);
                    return; 
                }
                output = sortedProducts.map(p => `${p.id}: ${p.title} - $${p.price}`).join('\n');
                break;
            case 'clear':
                terminalOutput.innerHTML = '';
                return; 
            default:
                output = `Command not recognized: ${command}`;
                break;
        }

        displayOutput(output);
    }

    function displayOutput(output) {
        const newLine = document.createElement('div');
        newLine.innerHTML = output.replace(/\n/g, '<br>'); 
        terminalOutput.appendChild(newLine);
        terminalOutput.scrollTop = terminalOutput.scrollHeight;
    }
    
});
