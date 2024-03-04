
import { product } from "../../declarations/product";

window.addEventListener("load",async function(){
  //console.log("loading completed");
  const manufacturerId=this.document.getElementById("manufacturer").value.toString();
  const productName=this.document.getElementById("product").value;
  const productId=this.document.getElementById("productid").value;
  const seller=this.document.getElementById("seller").value;
  var data=await product.addProductToSeller(manufacturerId,productName,productId,seller);
  console.log(data);
  //this.document.getElementById("manufacturer").innerText=data;
});
