

#### Using window.ethereum()
So, in order for our website to talk to the blockchain, we need to somehow connect our wallet to it. Once we connect our wallet to our website, our website will have permission to call smart contracts on our behalf. Remember, it's just like authenticating into a website.

We need to create a connectWallet button. In the world of Web3, connecting your wallet is literally a "Login" button for your user.

#### Mint NFT thorugh out website
```const provider = new ethers.providers.Web3Provider(ethereum);
const signer = provider.getSigner();```

ethers is a library that helps our frontend talk to our contract. Be sure to import it at the top using import { ethers } from "ethers";.

A "Provider" is what we use to actually talk to Ethereum nodes. Remember how we were using Alchemy to deploy? Well in this case we use nodes that Metamask provides in the background to send/receive data from our deployed contract.

(Here)[https://docs.ethers.io/v5/api/signer/#signers]  a link explaining what a signer is on line 2.
```const connectedContract = new ethers.Contract(CONTRACT_ADDRESS, myEpicNft.abi, signer);```

We'll cover this in a bit. Just know that this line is what actually **creates the connection to our contract**. It needs: the contract's address, something called an abi file, and a signer. These are the three things we always need to communicate with contracts on the blockchain.

Notice how I hardcode const CONTRACT_ADDRESS? **Be sure to change this variable to the deployed contract address of your latest deployed contract.** If you forgot it or lost it don't worry, just re-deploy the contract and get a new address :).

#### ABI files
Read more about api files (here)[https://docs.soliditylang.org/en/v0.5.3/abi-spec.html]

We now need to create a folder called utilities and a file inside it called MyEpicNFT.json

After we have deployed our contract and got an address: 0x25428A51dc7b4b61882382b9D20Af76114189A27

We then go to artifacts > contracts > MyEpicNFT.sol > MyEpicNFT.json

and we copy paste that into our new  utilities/MyEpicNFT.json on the web app side of things

Then we ```import myEpicNFT from "./utilities/MyEpicNFT.json"```

** Remember every time you update your contract you have to 1. update your address and 2. update your abi file.**

The 3 magic steps when we change our contract
Let's say you want to change your contract. You'd need to do 3 things:
1. We need to deploy it again.
2. We need to update the contract address on our frontend.
3. We need to update the abi file on our frontend.

