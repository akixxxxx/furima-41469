const calculateAndDisplay = () => {
  const taxRate = 0.1;
  const priceInput = document.getElementById("item-price");

  if (priceInput) { 
    const inputValue = parseFloat(priceInput.value) || 0; 

    const addTaxDom = document.getElementById("add-tax-price");
    const taxAmount = Math.floor(inputValue * taxRate);
    addTaxDom.innerHTML = taxAmount; 

    const grossProfitValue = Math.floor(inputValue - taxAmount);
    const grossProfit = document.getElementById("profit");
    grossProfit.innerHTML = grossProfitValue;
  }
};
const setupPriceInputListener = () => {
  calculateAndDisplay(); 

  const priceInput = document.getElementById("item-price");

  if (priceInput) { 
    priceInput.addEventListener("input", calculateAndDisplay);
  }
};

window.addEventListener("turbo:load", setupPriceInputListener);
window.addEventListener("turbo:render", setupPriceInputListener);
window.addEventListener("DOMContentLoaded", setupPriceInputListener); 