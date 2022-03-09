// update the option select price
if (document.querySelector(".product #product-form")) {
    document.querySelectorAll(".product #product-form select").forEach(ele => {
        ele.onchange = () => {
            let price = 0.00;
            document.querySelectorAll(".product #product-form select").forEach(e => {
                if (e.value) {
                    price += parseFloat(e.options[e.selectedIndex].dataset.price);
                }
            });
            if (price > 0.00) {
                document.querySelector(".product .price").innerHTML = '€' + price.toFixed(2);
            }
        };
    });
}

if (document.querySelector(".cart .ajax-update")) {
    document.querySelectorAll(".cart .ajax-update").forEach(ele => {
        ele.onchange = () => {
            let formEle = document.querySelector(".cart form");
            let formData = new FormData(formEle);
            formData.append("update", "Update");
            fetch(formEle.action, {
                method: "POST",
                body: formData
            }).then(response => response.text()).then(function(html) {
                let parser = new DOMParser();
                let doc = parser.parseFromString(html, "text/html");
                document.querySelector(".subtotal").innerHTML = doc.querySelector(".subtotal").innerHTML;
                document.querySelector(".shipping").innerHTML = doc.querySelector(".shipping").innerHTML;
                document.querySelector(".total").innerHTML = doc.querySelector(".total").innerHTML;
                document.querySelectorAll(".product-total").forEach((e,i) => {
                    e.innerHTML = doc.querySelectorAll(".product-total")[i].innerHTML;
                })
            });
        };
    });
}
