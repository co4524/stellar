var StellarSdk = require('stellar-sdk');
var server = new StellarSdk.Server('http://localhost:8000',{allowHttp: true});

//use private network
StellarSdk.Network.use(new StellarSdk.Network("stellar"));
//If the local Horizon connects with the testnet
//var server = new StellarSdk.Server('http://10.91.5.43:8000',{allowHttp:true});
var rootAccount = require('./'+process.argv[3]);
var wallet = require('./'+process.argv[2]);
//var sourceKeys = account.privateKey;

var sourceKeys = StellarSdk.Keypair.fromSecret(rootAccount.privateKey);
//console.log(sourceKeys);
//var destinationId = 'GBBAJPWGVUWJM7DWKKKH5NOONYJL3NPWRZTQCYFQPAUYN34LH6NNNJZ3';
// Transaction will hold a built transaction we can resubmit if the result is unknown.
var transaction;

// First, check to make sure that the destination account exists.
// You could skip this, but if the account does not exist, you will be charged
// the transaction fee when the transaction fails.
server.loadAccount(wallet.publicKey)
  // If the account is not found, surface a nicer error message for logging.
  .catch(StellarSdk.NotFoundError, function (error) {
    throw new Error('The destination account does not exist!');
  })
  // If there was no error, load up-to-date information on your account.
  .then(function() {
    return server.loadAccount(sourceKeys.publicKey());
  })

  .then(function(sourceAccount) {
    // Start building the transaction.
    transaction = new StellarSdk.TransactionBuilder(sourceAccount)
      .addOperation(StellarSdk.Operation.payment({
        destination: wallet.publicKey,
        // Because Stellar allows transaction in many currencies, you must
        // specify the asset type. The special "native" asset represents Lumens.
        asset: StellarSdk.Asset.native(),
        amount: "100"
      }))
      // A memo allows you to add your own metadata to a transaction. It's
      // optional and does not affect how Stellar treats the transaction.
      .addMemo(StellarSdk.Memo.text('Test Transaction'))
      .setTimeout(30)
      .build();
    // Sign the transaction to prove you are actually the person sending it.
    transaction.sign(sourceKeys);
    // And finally, send it off to Stellar!
    return server.submitTransaction(transaction);
  })
  .then(function(result) {
    console.log('Success! Results:', result);
  })
  .catch(function(error) {
    console.error('Something went wrong!', error);
    // If the result is unknown (no response body, timeout etc.) we simply resubmit
    // already built transaction:
    // server.submitTransaction(transaction);
  });
