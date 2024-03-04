import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Random "mo:base/Random";
import Time "mo:base/Time";
import Principal "mo:base/Principal";
//import Actor "mo:base/actor";
actor product{
  stable var finalProducts:[(Text,Nat)]=[];
  stable var manufacturersArray:[(Text,Text)]=[];
  stable var sellersArray:[(Text,(Text,Nat))]=[];
  stable var sellerIds:[Text]=[];
  stable var productIds:[Nat]=[];
  //Debug.print(debug_show("hello"));
  var sellers=HashMap.HashMap<Text,(Text,Nat)>(1,Text.equal,Text.hash);
  Debug.print("products available are "#debug_show(finalProducts));
  Debug.print("Manufacturers and their sellers data "#debug_show(manufacturersArray));
  Debug.print("Trusted sellers data "#debug_show(sellersArray));
  var products=HashMap.HashMap<Text,Nat>(1,Text.equal,Text.hash);
  Debug.print(debug_show(sellerIds));
  //Debug.print(debug_show(Iter.toArray(products.entries())));
  var manufacturersData=HashMap.HashMap<Text,Text>(1,Text.equal,Text.hash);
  var sellerDetails=HashMap.HashMap<Text,Nat>(1,Text.equal,Text.hash);
  public func addProductToSeller(manufacturerId:Text,newproduct:Text,id:Nat,sellerId:Text) :async Text{
    if(products.get(newproduct)==null){
      products.put(newproduct,id);
      sellers.put(sellerId,(newproduct,id));
      sellerDetails.put(sellerId,id);
      productIds:=Array.append(productIds,[id]);
      //sellerIds:=Array.append(sellerIds,[sellerId]);
      manufacturersData.put(manufacturerId,sellerId);
    };
    return "product sold to the seller "#sellerId # " by " #manufacturerId;
  };
  public func buyProduct(consumerName:Text,productName:Text,productId:Nat,sellerId:Text):async Text{
    var num:Nat=0;
    var c:Nat=0;
    var p:Nat=0;
    for(id in sellerIds.vals()){
      if(id==sellerId){
        return "This product is already sold by the seller";
      };
    };
    for(sid in sellers.keys()){
      if(sid==sellerId){
        num+=1;
      };
    };
    Debug.print(debug_show(num));
    if(num!=0){
      if(products.get(productName)!=null){
        for (pid in products.vals()){
          if(pid==productId){
            c+=1;
          };
        };
        Debug.print(debug_show(c));
        if(c!=0){
          //var removedProduct=await removeProduct(sellerId);
          //Debug.print("seller ID'S"#debug_show(sellerIds));
          sellerIds:=Array.append(sellerIds,[sellerId]);
          Debug.print(debug_show(Iter.toArray(sellers.entries())));
          var checkQr:Text=await QrCode(productId);
          sellerDetails.put(sellerId,0);
          //var removedProduct=await removeProduct(sellerId);
          return checkQr;
        }else{
          return "product id not correct please enter correct product id";
        }
      }else{
        return "product not found";
      }
    }else{
      return "seller is not trusted";
    };
    return "";
    
  };
  public func QrCode(productId:Nat):async Text{
    var count:Nat=0;
    for (id in productIds.vals()){
      if(id==productId){
        count+=1;
      };
    };
    if(count!=0){
      var product:Text = Nat.toText(productId);
      var url :Text="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data="#product;
      return url;
    };
    return "sorry id is not present";
  };
  public func removeProduct(sellerId:Text):async Text{
    //sellerIds:=Array.append(sellerIds,[sellerId]);
    var deleteProduct=sellers.remove(sellerId);
    return "product removed succesfully";
  };
  //adds the entries of hashmap to the stable array before every upgrade
  system func preupgrade(){
    finalProducts:=Iter.toArray(products.entries());
    sellersArray:=Iter.toArray(sellers.entries());
    manufacturersArray:=Iter.toArray(manufacturersData.entries());

  };
  //after the upgrade the unstable ledger(Hashmap) collects the elements of the stable array
  system func postupgrade(){
    products:=HashMap.fromIter<Text,Nat>(finalProducts.vals(),1,Text.equal,Text.hash);
    sellers:=HashMap.fromIter<Text,(Text,Nat)>(sellersArray.vals(),1,Text.equal,Text.hash);
    manufacturersData:=HashMap.fromIter<Text,Text>(manufacturersArray.vals(),1,Text.equal,Text.hash);
  };
}
