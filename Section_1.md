# epic-nfts

## Packages
 - ``` npm install --save-dev hardhat ```
 - ``` npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers ```
 - ``` npm install @openzeppelin/contracts ```

## Hardhat
```npx hardhat```

Try running some of the following tasks:
```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
#### Deploy to a local blockchain
```npx hardhat run scripts/sample-script.js```
1. Hardhat compiles your smart contract from solidity to bytecode.
2. Hardhat will spin up a "local blockchain" on your computer. It's like a mini, test version of Ethereum running on your computer to help you quickly test stuff!
3. Hardhat will then "deploy" your compiled contract to your local blockchain. That's that address you see at the end there. It's our deployed contract, on our mini version of Ethereum.
4. If you're curious, feel free to look at the code inside the project to see how it works. Specifically, check out Greeter.sol which is the smart contract and sample-script.js which actually runs the contract.

#### Clean up
- We want to delete all the lame starter code generated for us. We're going to write this stuff ourselves! Go ahead and delete the file sample-test.js under test.  Also, delete sample-script.js under scripts. Then, delete Greeter.sol under contracts. Don't delete the actual folders!

# Writing our First Contract
Create a file named MyEpicNFT.sol under the contracts directory. File structure is super important when using Hardhat, so, be careful here!

Install the solidity extension by Juan Blanco

Note: Sometimes VSCode itself will throw errors that aren't real, for example, it may underline the hardhat import and say it doesn't exist. These happen because your global Solidity compiler isn't set locally. If you don't know how to fix this, don't worry. Ignore these for now. Also I recommend that you don't use VSCode's terminal, use your own separate terminal! Sometimes the VSCode terminal gives issues if the compiler isn't set.

(SPDX License)[https://spdx.org/licenses/]

```pragma solidity ^0.8.0; ```
This is the version of the Solidity compiler we want our contract to use. It basically says "when running this, I only want to use version 0.8.0 of the Solidity compiler, nothing lower. Note, be sure your compiler is set to 0.8.0 in hardhat.config.js.


```import "hardhat/console.sol";``` 
Some magic given to us by Hardhat to do some console logs in our contract. It's actually challenging to debug smart contracts but this is one of the goodies Hardhat gives us to make life easier.
- ``` contract MyEpicNFT {
    constructor() {
        console.log("This is my NFT contract. Whoa!");
    }
} ``` So, smart contracts kinda look like a class in other languages, if you've ever seen those! Once we initialize this contract for the first time, that constructor will run and print out that line.

Awesome — we've got a smart contract! But, we don't know if it works. We need to actually:
    1. Compile it.
    2. Deploy it to our local blockchain.
    3. Once it's there, that console.log will run.

We're just going to write a custom script that handles those 3 steps for us

# Writing our first script
``` const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT"); ```
This will actually compile our contract and generate the necessary files we need to work with our contract under the artifacts directory. Go check it out after you run this :).
```const nftContract = await nftContractFactory.deploy();```
This is pretty fancy :).
What's happening here is Hardhat will create a local Ethereum network for us, but just for this contract. Then, after the script completes it'll destroy that local network. So, every time you run the contract, it'll be a fresh blockchain. Whats the point? It's kinda like refreshing your local server every time so you always start from a clean slate which makes it easy to debug errors.
```await nftContract.deployed();```
We'll wait until our contract is officially mined and deployed to our local blockchain! That's right, hardhat actually creates faker "miners" on your machine to try its best to imitate the actual blockchain.
```console.log("Contract deployed to:", nftContract.address);```
Our constructor runs when we actually are fully deployed!
Finally, once it's deployed nftContract.address will basically give us the address of the deployed contract. This address is how we can actually find our contract on the blockchain. Right now on our local blockchain it's just us. So, this isn't that cool.
### Running our contract
Before you run this, be sure to change solidity: "0.8.4", to solidity: "0.8.0", in your hardhat.config.js.

```npx hardhat run scripts/run.js```

### WDF is HRE? (hardhat runtime enviroment)
In these code blocks you will constantly notice that we use hre.ethers, but hre is never imported anywhere? What type of sorcery is this?

Directly from the (Hardhat docs)[https://hardhat.org/advanced/hardhat-runtime-environment.html] themselves you will notice this:
    The Hardhat Runtime Environment, or HRE for short, is an object containing all the functionality that Hardhat exposes when running a task, test or script. In reality, Hardhat is the HRE.

So what does this mean? Well, every time you run a terminal command that starts with npx hardhat you are getting this hre object built on the fly using the hardhat.config.js specified in your code! This means you will never have to actually do some sort of import into your files like:
const hardhat = require("hardhat")

### 4. Create a contract the mints NFT's
The NFT standard is known as (ERC721)[https://eips.ethereum.org/EIPS/eip-721] OpenZeppelin essentially implements the NFT standard for us and then lets us write our own logic on top of it to customize it.

It'd be crazy to write a HTTP server from scratch without using a library, right? Of course, unless you wanted to explore lol. But we just wanna get up and running here.

Similarly — it'd be crazy to just write an NFT contract from complete scratch! You can explore the ERC721 contract we're inheriting from (here)[https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol].

``` uint256 newItemId = _tokenIds.current(); ```
Wtf is _tokenIds? Well, remember the Picasso example? He had 100 NFT sketches named like Sketch #1, Sketch #2, Sketch #3, etc. Those were the unique identifiers.

Same thing here, we're using _tokenIds to keep track of the NFTs unique identifier, and it's just a number! It's automatically initialized to 0 when we declare private _tokenIds. So, when we first call makeAnEpicNFT, newItemId is 0. When we run it again, newItemId will be 1, and so on!

_tokenIds is state variable which means if we change it, the value is stored on the contract directly.

``` _safeMint(msg.sender, newItemId); ```
When we do _safeMint(msg.sender, newItemId) it's pretty much saying: "mint the NFT with id newItemId to the user with address msg.sender". Here, msg.sender is a variable (Solidity itself)[https://docs.soliditylang.org/en/develop/units-and-global-variables.html#block-and-transaction-properties] provides that easily gives us access to the public address of the person calling the contract.

What's awesome here is this is a super-secure way to get the user's public address. Keeping public address itself a secret isn't an issue, that's already public!! Everyone sees it. But, by using msg.sender you can't "fake" someone else's public address unless you had their wallet credentials and called the contract on their behalf!

You can't call a contract anonymously, you need to have your wallet credentials connected. This is almost like "signing in" and being authenticated :).

```_setTokenURI(newItemId, "blah");```
After the NFT is minted, we increment tokenIds using _tokenIds.increment() (which is a function OpenZeppelin gives us). This makes sure that next time an NFT is minted, it'll have a different tokenIds identifier. No one can have a tokenIds that's already been minted too.

``` tokenURI ```
The tokenURI is where the actual NFT data lives. And it usually links to a JSON file called the metadata that looks something like this:
```
{
    "name": "Spongebob Cowboy Pants",
    "description": "A silent hero. A watchful protector.",
    "image": "https://i.imgur.com/v7U019j.png"
}
``` 
You can customize this, but, almost every NFT has a name, description, and a link to something like a video, image, etc. It can even have custom attributes on it!

This is all part of the ERC721 standards and it allows people to build websites on top of NFT data. For example, OpenSea is a marketplace for NFTs. And, every NFT on OpenSea follows the ERC721 metadata standard which makes it easy for people to buy/sell NFTs. Imagine if everyone followed their own NFT standards and structured their metadata however they wanted, it'd be chaos!

We can copy the Spongebob Cowboy Pants JSON metadata above and paste it into (this website)[https://jsonkeeper.com/]. This website is just an easy place for people to host JSON data and we'll be using it to keep our NFT data for now. Once you click "Save" you'll get a link to the JSON file. (For example, mines is https://jsonkeeper.com/b/RUUS). Be sure to test your link out and be sure it all looks good! Ours is https://jsonkeeper.com/b/6FD5

Note: I'd love for you to create your own JSON metadata instead of just copying mine. Use your own image, name, and description. Maybe you want your NFT to an image of your fav anime character, fav band, whatever!! Make it custom. Don't worry, we'll be able to change this in the future! Here is my Tutankhamun JSON data https://jsonkeeper.com/b/V6XN

Now, lets head to our smart contract and change one line. Instead of:
```_setTokenURI(newItemId, "blah")```
We're going to actually set the URI as the link to our JSON file.
```_setTokenURI(newItemId, "INSERT_YOUR_JSON_URL_HERE");```
Under that line, we can also add a console.log to help us see when the NFT is minted and to who!
```console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);```

### 4. Updating our Run Script
```   // Call the function.
  let txn = await nftContract.makeAnEpicNFT()
  // Wait for it to be mined.
  await txn.wait()

  // Mint another NFT for fun.
  txn = await nftContract.makeAnEpicNFT()
  // Wait for it to be mined.
  await txn.wait()
```

### 4. Deploy to Rinkeby adn see on OpenSea
When we use run.js, it's just us working locally.

The next step is a testnet which you can think of as like a "staging" environment. When we deploy to a testnet we'll actually be able to to view our NFT online and we are a step closer to getting this to real users.

### 4. Transactions
So, when we want to perform an action that changes the blockchain we call it a transaction. For example, sending someone ETH is a transaction because we're changing account balances. Doing something that updates a variable in our contract is also considered a transaction because we're changing data. Minting an NFT is a transaction because we're saving data on the contract.

Deploying a smart contract is also a transaction.

Remember, the blockchain has no owner. It's just a bunch of computers around the world run by miners that have a copy of the blockchain.

When we deploy our contract, we need to tell all those miners, "hey, this is a new smart contract, please add my smart contract to the blockchain and then tell everyone else about it as well".

This is where (Alchemy)[https://www.alchemy.com/] comes in.

Alchemy essentially helps us broadcast our contract creation transaction so that it can be picked up by miners as quickly as possible. Once the transaction is mined, it is then broadcasted to the blockchain as a legit transaction. From there, everyone updates their copy of the blockchain.

We dont want to use Mainnet we want to use Rinkeyby as a test enviroment

### 4. Testnets
We're not going to be deploying to the "Ethereum mainnet" for now. Why? Because it costs real $ and it's not worth messing up! We're just learning right now. We're going to start with a "testnet" which is a clone of "mainnet" but it uses fake $ so we can test stuff out as much as we want.

But, it's important to know that testnets are run by actual miners and mimic real-world scenarios.

This is awesome because we can test our application in a real-world scenario where we're actually going to:
1. Broadcast our transaction
2. Wait for it to be picked up by actual miners
3. Wait for it to be mined
4. Wait for it be broadcasted back to the blockchain telling all the other miners to update their copies

There are a few testnets out there and the one we'll be using is called "Rinkeby" which is run by the Ethereum foundation.

In order to deploy to Rinkeby, we need fake ETH. Why? Because if you were deploying to the actual Ethereum mainnet, you'd use real money! So, testnets copies how mainnet works, only difference is no real money is involved.

In order get fake ETH, we have to ask the network for some. This fake ETH will only work on this specific testnet. You can grab some fake Ethereum for Rinkeby through a faucet. You just gotta find one that works lol.

https://faucet.rinkeby.io/
https://twitter.com/James73614858/status/1452804503074324483

### 4. Setup a deploy.js file
It's good practice to separate your deploy script from your run.js script. run.js is where we mess around a lot, we want to keep it separate. Go ahead and create a file named deploy.js under the scripts folder. Copy-paste all of run.js into deploy.js. It's going to be exactly the same right now. I added some console.log statements, though.

### 4. Deploy to Rinkeby testnet
We'll need to change our hardhat.config.js file. You can find this in the root directory of your smart contract project.

```
require('@nomiclabs/hardhat-waffle');

module.exports = {
  solidity: '0.8.0',
  networks: {
    rinkeby: {
      url: 'YOUR_ALCHEMY_API_URL',
      accounts: ['YOUR_PRIVATE_RINKEBY_ACCOUNT_KEY'],
    },
  },
};`
```

You can grab your API URL from the Alchemy dashboard and paste that in. Then, you'll need your private (rinkeby key)[https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key] (not your public address!) which you can grab from metamask and paste that in there as well.

Note: DON'T COMMIT THIS FILE TO GITHUB. IT HAS YOUR PRIVATE KEY. YOU WILL GET HACKED + ROBBED. THIS PRIVATE KEY IS THE SAME AS YOUR MAINNET PRIVATE KEY. We'll talk about .env variables later and how to keep this stuff secret.

```npx hardhat run scripts/deploy.js --network rinkeby```
It takes like 20-40 seconds to deploy usually. We're not only deploying! We're also minting NFTs in deploy.js so that'll take some time as well. We actually need to wait for the transaction to be mined + picked up by miners. Pretty epic :). That one command does all that!
<img src="/img/4.png"/>

We can make sure it all worked properly using (Rinkeby Etherscan)[https://rinkeby.etherscan.io/]where you can paste the contract address and see what's up with it!

Get used to using Etherscan because it's like the easiest way to track deployments and if something goes wrong. If it's not showing up on Etherscan, then that means it's either still processing or something went wrong!
If it worked — AWEEEEESOME YOU JUST DEPLOYED A CONTRACT YESSSS.

``` Contract deployed to: 0xb26d52C783e469b6CEbAa39425B0DA6C9BBe769A ```

### View on OpeaSea
Believe it or not. The NFTs you just minted will be on OpenSea's TestNet site.

Head to testnets.opensea.io. Search for your contract address which is the address we deployed to that you can find in your terminal, Don't click enter, click the collection itself when it comes up in the search.

```https://testnets.opensea.io/collection/squarenft-wn0qljmkhr ```

HOOOOLY SHIT LETS GO. IM HYPE FOR YOU.

Pretty epic, we've created our own NFT contract and minted two NFTs. Epic. WHILE THIS IS EPIC, it is kinda lame — right? It's just the same Spongebob picture every time! How can we add some randomness to this and generate stuff on the fly? That's what we'll be getting into next :).

(Rarible)[rinkeby.rarible.com] is another NFT marketplace like OpenSea.
