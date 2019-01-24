var StellarSdk = require('stellar-sdk');
var rootAccount = require('./rootAccount.json');
var server = new StellarSdk.Server('http://localhost:8000',{allowHttp: true});
StellarSdk.Network.use(new StellarSdk.Network("stellar"));

var sourceKeys = StellarSdk.Keypair.fromSecret(rootAccount.privateKey);
var pair = StellarSdk.Keypair.random();
console.log('privateKey: '+pair.secret());
console.log('publicKey: '+pair.publicKey());
var transaction;

server.loadAccount(sourceKeys.publicKey())
  .then(function(sourceAccount) {
    transaction = new StellarSdk.TransactionBuilder(sourceAccount)
                .addOperation(StellarSdk.Operation.createAccount({
                    destination: pair.publicKey(),
                    startingBalance: "10000"
                  }))
                .addMemo(StellarSdk.Memo.text('Hello world!'))
                .build(); 
    transaction.sign(sourceKeys);
    return server.submitTransaction(transaction);
  })
  .then(function(result) {
    console.log('Success! Results:', result);
  })
  .catch(function(error) {
    console.error('Something went wrong!', error);
  });