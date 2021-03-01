const functions = require("firebase-functions");
const admin = require("firebase-admin");
const firebase = require("firebase/app");
require("firebase/auth");
const express = require("express");
const app = express();
const path = require("path");
const methodOverride = require("method-override");
app.use(express.urlencoded({ extended: true }));
app.use(methodOverride("_method"));

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");
app.use(express.static(path.join(__dirname, 'public')))
app.use(express.urlencoded({ extended: true }));
app.use(methodOverride("_method"));
var firebaseConfig = {
  apiKey: "AIzaSyA_JcY_90540GyBp1dOEdOl0X5X-85Mbw0",
  authDomain: "hisab--kitab.firebaseapp.com",
  databaseURL: "https://hisab--kitab-default-rtdb.firebaseio.com",
  projectId: "hisab--kitab",
  storageBucket: "hisab--kitab.appspot.com",
  messagingSenderId: "404112265272",
  appId: "1:404112265272:web:30d5b0d4148f87523ad6cd",
  measurementId: "G-HEBD2LNDSC",
};
var counterP=100;
var counterS=100;
var serviceAccount = require("./permissions.json");
const { chownSync } = require("fs");
firebase.initializeApp({
  apiKey: "AIzaSyA_JcY_90540GyBp1dOEdOl0X5X-85Mbw0",
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://hisab--kitab-default-rtdb.firebaseio.com"
});

admin.initializeApp({
  apiKey: "AIzaSyA_JcY_90540GyBp1dOEdOl0X5X-85Mbw0",
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://hisab--kitab-default-rtdb.firebaseio.com",
});
const db = admin.firestore();
app.get("/", (req, res) => {
  res.render("./landing");
});
app.get("/signing", (req, res) => {
  res.render("./signin");
});
app.get("/:userid/invoice", (req, res) => {
  var userid=req.params.userid;

  res.render("./invoice",{userid:userid});
});
app.get("/signup", (req, res) => {
  res.render("./signup");
});
app.get("/:userid/sales", async(req, res) => {
  var userid=req.params.userid;
  const snapshot = await db.collection('users').doc(userid).collection('sales').get();
  //const sp = snapshot.data();
  sales=[]
  totalprice=[]
  snapshot.forEach((doc) => {
    sales.push(doc.data())
    var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
    totalprice.push(total)
  });
  console.log(sales)
  res.render("./sales",{userid:userid,sales:sales,total:totalprice});
});
app.get("/:userid/purchases", async(req, res) => {
  var userid=req.params.userid;
  const snapshot = await db.collection('users').doc(userid).collection('purchases').get();
  //const sp = snapshot.data();
  purchases=[]
  totalprice=[]
  snapshot.forEach((doc) => {
    purchases.push(doc.data())
    var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
    totalprice.push(total)
  });
  console.log(purchases)
  res.render("./purchases",{userid:userid,purchases,total:totalprice});
});
app.get("/:userid/analytics", async(req, res) => {
  const userid=req.params.userid;
  const sales= await db.collection('users').doc(userid).collection('sales').get();
  const purchases = await db.collection('users').doc(userid).collection('purchases').get();
  monthly=[0,0,0,0,0,0,0,0,0,0,0,0]
  monthly1=[0,0,0,0,0,0,0,0,0,0,0,0]
 var sales1=[];
 var totalsales=[];
 var totalpurchases=[];
 var purchases1=[];
  sales.forEach((doc) => {
    sales1.push(doc.data());
    var total3=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total3=total3+parseInt(doc.data().prices[i]);
    }
    totalsales.push(total3)
    var parts =doc.data().date.split('-');
// Please pay attention to the month (parts[1]); JavaScript counts months from 0:
// January - 0, February - 1, etc.
    if(parts[1]==1)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==2)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==3)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==4)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==5)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==6)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==7)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==8)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==9)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==10)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==11)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
    else if(parts[1]==12)
    {
      var total=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total=total+parseInt(doc.data().prices[i]);
    }
      monthly[parts[1]-1]=  monthly[parts[1]-1]+total;
    }
  });
 // console.log(monthly)
  purchases.forEach((doc) => {
    purchases1.push(doc.data());
    var total3=0;
    for(i=0 ;i<doc.data().prices.length; i++){
      console.log(doc.data().prices[i])
      total3=total3+parseInt(doc.data().prices[i]);
    }
    totalpurchases.push(total3)
    var parts =doc.data().date.split('-');
    // Please pay attention to the month (parts[1]); JavaScript counts months from 0:
    // January - 0, February - 1, etc.
        if(parts[1]==1)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==2)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==3)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==4)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==5)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==6)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==7)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==8)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==9)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==10)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==11)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
        else if(parts[1]==12)
        {
          var total=0;
        for(i=0 ;i<doc.data().prices.length; i++){
          console.log(doc.data().prices[i])
          total=total+parseInt(doc.data().prices[i]);
        }
          monthly1[parts[1]-1]=  monthly1[parts[1]-1]+total;
        }
      });
      //console.log(monthly1)
      purchasesA=[['Month','Sales','Purchases']]
      purchasesA.push(['Oct-20',monthly[9],monthly1[9]])
      purchasesA.push(['Nov-20',monthly[10],monthly1[10]])
      purchasesA.push(['Dec-20',monthly[11],monthly1[11]])
      purchasesA.push(['Jan-21',monthly[0],monthly1[0]])
      purchasesA.push(['Feb-21',monthly[1],monthly1[1]])
      res.render("./dashboard",{userid:userid,sales:sales1,purchases:purchases1,totalsales,totalpurchases});
});


app.get('/:userid/profile',async (req,res)=>{
  const userid=req.params.userid;
  const snapshot = await db.collection('users').doc(userid).get();
  const sp = snapshot.data();
  res.render('./profile',{name:sp['name'],email:sp['email'],phone:sp['phone'],gst:sp['gst'],address:sp['address'],company:sp['company'] , userid: userid})
})
app.post("/:userId/purchases", async (req, res) => {
  var userid=req.params.userId;
  //console.log(req.body)
  const snapshot = await db.collection('users').doc(userid).get();
  const sp = snapshot.data();
    var timeElapsed = Date.now();
  var today = new Date(timeElapsed);
  today = today.toLocaleDateString();
  counterP = counterP + 1;
  db.collection("users").doc(userid).collection("purchases").add({
    items:req.body.Item,
    prices:req.body.Price,
    quantities:req.body.Quantity,
    company:req.body.company,
    address:req.body.address,
    date:today,
    invoiceNumber:counterP
  });
  
  //const snapshot = await db
  //  .collection("users")
   // .doc(userid)
 //   .get();
 // const snapData = await snapshot.data();
 // counter = counter + 1;
  var snapData={
    items:req.body.Item,
    prices:req.body.Price,
    quantities:req.body.Quantity,
    company:req.body.company,
    address:req.body.address,
    date:today,
    invoiceNumber:counterP,
    sellerCompany: sp['company'],
    sellerPhone: sp['phone'],
    sellerEmail: sp['email']
  }
  //console.log(sp['company']);
  res.render(`./invoice`, { snapData, counter:counterP, today });
});
app.post("/:userid/sales", async (req, res) => {
  console.log(req.body)
  var userid=req.params.userid;
  var timeElapsed = Date.now();
  var today = new Date(timeElapsed);
  today = today.toLocaleDateString();
  counterS = counterS + 1;
  db.collection("users").doc(userid).collection("sales").add({
    items:req.body.Item,
    prices:req.body.Price,
    quantities:req.body.Quantity,
    company:req.body.company,
    address:req.body.address,
    date: today,
    invoiceNumber: counterS
  });
  const sp1 = await db.collection('users').doc(userid).get()
  const sp=sp1.data();
  var snapData={
    items:req.body.Item,
    prices:req.body.Price,
    quantities:req.body.Quantity,
    company:req.body.company,
    address:req.body.address,
    date:today,
    invoiceNumber:counterP,
    sellerCompany:sp['company'],
    sellerPhone: sp['phone'],
    sellerEmail: sp['email']
  }
  res.render(`./invoice`, { snapData, counter:counterS, today });
});
app.post("/", async (req, res) => {
  console.log(req.body);
  db.collection("users").add({
    first: "Ada",
    last: "Lovelace",
    born: 1815,
  });
});
app.post("/login", async (req, res) => {
  console.log(req.body);
  try {
    var auth1=await firebase
      .auth()
      .createUserWithEmailAndPassword(req.body["email"], req.body["password"]);
      console.log(auth1.user)
      await db.collection("users").doc(auth1.user.uid).set({
        email:req.body["email"],
        name: req.body["name"],
        password:req.body["password"],
        phone:req.body["phone"],
        gst:req.body["GST"],
        address:req.body["address"],
        company:req.body["company"]
      });
      res.redirect(`./${auth1.user.uid}/analytics`)
  } catch (e) {
    console.log(111);
    console.log(e);
  }
});
app.post("/signin", async (req, res) => {
  try {
    var auth2=await firebase.auth().signInWithEmailAndPassword(req.body["email"], req.body["password"])
    console.log(auth2.user.uid)
    res.redirect(`/${auth2.user.uid}/analytics`)
  }
  catch(e)
  {
    console.log(e);
  }
});
app.listen(3000, () => {
  console.log("Serving on port 3000");
});
