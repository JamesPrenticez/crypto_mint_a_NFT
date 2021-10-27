###  What "on-chain" means and why it's important.

We have a big problem right now with our NFTs.

What happens if imgur goes down? Well — then our image link is absolutely useless and our NFT is lost and our Spongebob is lost! Even worse, what happens if that website that hosts the JSON file goes down? Well — then our NFT is completely broken because the metadata wouldn't be accesible.

One way to fix this problem is to store all our NFT data "on-chain" meaning the data lives on the contract itself vs in the hands of a third-party. This means our NFT will truly be permanent :). In this case, the only situation where we lose our NFT data is if the blockchain itself goes down. And if that happens — well then we have bigger problems!

But, assuming the blockchain stays up forever — our NFT will be up forever! This is very appealing because it also means if you sell an NFT, the buyer can be confident the NFT won't break. Many popular projects use on-chain data, (Loot)[https://techcrunch.com/2021/09/03/loot-games-the-crypto-world/] is one very popular example!

### What about a SVG?
A common way to store NFT data for images is using a SVG. A SVG is an image, but the image itself is built with code.
[https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial]
[https://www.svgviewer.dev/]

### Create our SVG
We can convert a SVG to base64 using this website [https://www.utilities-online.info/base64]

Now, ready for some magic? Open a new tab. And in the URL bar paste this:
``` data:image/svg+xml;base64,INSERT_YOUR_BASE64_ENCODED_SVG_HERE ```

```
data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU+CiAgICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJibGFjayIgLz4KICAgIDx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBjbGFzcz0iYmFzZSIgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+RXBpY0xvcmRIYW1idXJnZXI8L3RleHQ+Cjwvc3ZnPg==
```
We turned our SVG code into a nice string :). base64 is basically an accepted standard for encoding data into a string. So when we say data:image/svg+xml;base64 it's basically saying, "Hey, I'm about to give you base64 encoded data please process it as a SVG, thank you!".

But wait — where will our fancy new JSON file go? Right now, we host it on this random website. If that website goes down, our beautiful NFT is gone forever! Here's what we're going to do. We're going to base64 encode our entire JSON file. Just like we encoded our SVG.

Head to [this](https://www.utilities-online.info/base64) website again. Paste in your full JSON metadata with the base64 encoded SVG (should look sorta like what I have above) and then click "encode" to get you encoded JSON.

<img src="/img/5.png"/>
<img src="/img/6.png"/>

data:application/json;base64,ewogICAgIm5hbWUiOiAiQ29zbWljVGFibGVUZWEiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIGNvc21pYyBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHhrWldaelBnb2dJQ0FnSUNBOGNtRmthV0ZzUjNKaFpHbGxiblFnYVdROUlsSmhaR2xoYkVkeVlXUnBaVzUwSWlCamVEMGlNQzQxSWlCamVUMGlNQzQxSWlCeVBTSXdMalVpUGdvZ0lDQWdJQ0FnSUR4emRHOXdJRzltWm5ObGREMGlNQ1VpSUhOMGIzQXRZMjlzYjNJOUlubGxiR3h2ZHlJdlBnb2dJQ0FnSUNBZ0lEeHpkRzl3SUc5bVpuTmxkRDBpTVRBd0pTSWdjM1J2Y0MxamIyeHZjajBpYjNKaGJtZGxJaTgrQ2lBZ0lDQWdJRHd2Y21Ga2FXRnNSM0poWkdsbGJuUStDaUFnUEM5a1pXWnpQZ29nSUFvZ0lDQWdQSE4wZVd4bFBpNWlZWE5sSUhzZ1ptbHNiRG9nSTBZMU1FSTVORHNnWm05dWRDMW1ZVzFwYkhrNklIWmxjbVJoYm1FN0lHWnZiblF0YzJsNlpUb2dNakp3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKMWNtd29JMUpoWkdsaGJFZHlZV1JwWlc1MEtTSWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStRMjl6YldsalZHRmliR1ZVWldFOEwzUmxlSFErQ2p3dmMzWm5QZ289Igp9

Okay awesome, we've got this fancy base64 encoded JSON file. How do we get it on our contract? Simple head to MyEpicNFT.sol and — we just copy-paste the whole big string into our contract.

Finally, let's deploy our updated contract, mint the NFT, and make sure it works properly on OpenSea! Deploy using the same command. I changed my deploy script a little to only mint one NFT instead of two, feel free to do the same!

``` npx hardhat run scripts/deploy.js --network rinkeby ```

Then same as before, wait a minute or two, take the contract address, search it on https://testnets.opensea.io/ and you should see your NFT there :). Again, don't click "Enter" when searching -- you need to actually click the collection when it pops up in the search bar.

### Randomly generate words on a image
Cool — we created a contract that's now minting NFTs all on-chain. But, it's still always the same NFT argh!!! Let's make it dynamic.

Perhaps you wanna generate random band name. Perhaps you wanna generate random character names for your Dungeons and Dragons games. Do whatever you want. Maybe you don't give a shit about three word combinations and just want to make SVGs of pixel art penguins. Go for it. Do whatever you want :).

Note: I recommend like 15-20 words per array. I've noticed around 10 it's usually not random enough.

``` function pickRandomFirstWord ```
This function looks kinda funky. Right? Lets talk about how we're randomly picking stuff from the arrays.

So, generating a random number in smart contracts is widely known as a difficult problem.

Why? Well, think about how a random number is generated normally. When you generate a random number normally in a program, it will take a bunch of different numbers from your computer as a source of randomness like: the speed of the fans, the temperature of the CPU, the number of times you've pressed "L" at 3:52PM since you've bought the computer, your internet speed, and tons of other #s that are difficult for you to control. It takes all these numbers that are "random" and puts them together into an algorithm that generates a number that it feels is the best attempt at a truly "random" number. Make sense?

On the blockchain, there is nearly no source of randomness. It's deterministic and everything the contract sees, the public sees. Because of that, someone could game the system by just looking at the smart contract, seeing what #'s it relies on for randomness, and then the person could game it if they wanted to.

``` random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))); ```
What this is doing is it's taking two things: The actual string FIRST_WORD and a stringified version of the tokenId. I combine these two strings using abi.encodePacked and then that combined string is what I use as the source of randomness.

**This isn't true randomness**. But it's the best we got for now!

There are other ways to generate random numbers on the blockchain (check out (Chainlink)[https://docs.chain.link/docs/chainlink-vrf/]) but Solidity doesn't natively give us anything reliable because it can't! All the #'s our contract can access are public and never truly random.

  string[] firstWords = ["Astronomical", "Cosmic", "Gargantuan", "Bumper", "Colossal", "Monstrous"];
  string[] secondWords = ["Rough", "Smooth", "Hard", "Soft", "Thick", "Thin"];
  string[] thirdWords = ["Tea", "Coffee", "Water", "Juice", "Milk", "Soda"];

```
$ npx hardhat run scripts/run.js
This is my NFT contract. Woah!
Contract deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3

--------------------
<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 35top-color='orange'/></radialGradient></defs><style>.base { fill: #F50B94; font-family: verdnt-baseline='middle' text-anchor='middle'>AstronomicalHardJuice</text></svg>
--------------------

An NFT w/ ID 0 has been minted to 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266

--------------------
<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 35top-color='orange'/></radialGradient></defs><style>.base { fill: #F50B94; font-family: verdnt-baseline='middle' text-anchor='middle'>MonstrousSoftJuice</text></svg>
--------------------

An NFT w/ ID 1 has been minted to 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
```

### Dynamically generate the metadata.
Now, we need to actually set the JSON metadata! First, we need some helper functions. Create a folder called libraries under contracts. In libraries create a file named Base64.sol and copy-paste the code from (here)[https://gist.github.com/farzaa/f13f5d9bda13af68cc96b54851345832] into there. This file has some helper functions created by someone else to help us convert our SVG and JSON to Base64 in Solidity.

### How tf does finalTokenUri work?
That big line with string memory json = Base64.encode may look pretty confusing, but, it only looks confusing because of all the quotation marks lol. All we're doing is we're base64 encoding the JSON metadata! But — it's all on-chain. So, all that JSON will live on the contract itself.

We also dynamically add the name and the base64 encoded SVG as well!

Finally, we've got this finalTokenUri where we put it all together where we do:
```abi.encodePacked("data:application/json;base64,", json)```

### Deploy or test
Test on the local block chain
```npx hardhat run scripts/run.js```

Deploy to the testnet
```npx hardhat run scripts/deploy.js --network rinkeby```

``` https://testnets.opensea.io/ ```
Contract deployed to: 0x25428A51dc7b4b61882382b9D20Af76114189A27
```https://testnets.opensea.io/collection/bigtexturedbeveragesnft```

**Contracts are permanent. So, whenever we re-deploy our contract we're actually creating a whole new collection.**