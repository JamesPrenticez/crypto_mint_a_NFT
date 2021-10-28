####  Give user their OpenSea link
One thing that’d be awesome is after the NFT is minted we actually give a link to their NFT on OpenSea that they’d be able to share on Twitter or with their friends!!

The link for an NFT on OpenSea looks like this:
```https://testnets.opensea.io/assets/0x88a3a1dd73f982e32764eadbf182c3126e69a5cb/9```
Basically, these are the variables.
```https://testnets.opensea.io/assets/INSERT_CONTRACT_ADDRESS_HERE/INSERT_TOKEN_ID_HERE```

So, our web app has the contract address, but not the token id! So, we’ll need to change up our contract to retrieve that. Let’s do it.

We’re going to be using something called **Events** in Solidity. These are sorta like webhooks. Lets write out some of the code and get it working first!

At a basic level, events are messages our smart contracts throw out that we can capture on our client in real-time. In the case of our NFT, just because our transaction is mined does not mean the transaction resulted in the NFT being minted. It could have just error’d out!! Even if it error’d out, it would have still been mined in the process.

Thats why I use events here. I’m able to emit an event on the contract and then capture that event on the frontend. Notice in my event I send the newItemId which we need on the frontend, right :)?

Be sure to read more on events (here)[https://docs.soliditylang.org/en/v0.4.21/contracts.html#events].

### Web3.js contract methods
