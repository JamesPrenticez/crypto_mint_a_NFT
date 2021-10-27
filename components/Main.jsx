import { ethers } from 'ethers';
import { useEffect, useState } from 'react'
import myEpicNFT from "../utilities/MyEpicNFT.json"
import Images from './Images';

function Main() {
    const [currentAccount, setCurrentAccount] = useState("");
    
    useEffect(() => {
        checkIfWalletIsConnected()
    }, [])

    //Check we have access to the ethereum.window object
    const checkIfWalletIsConnected = async () => {
        const { ethereum } = window;

        if(!ethereum){
            console.log("Make sure you have metamask!")
            return;
        } else {
            console.log("We have the ethereum object", ethereum)
        }
        //Check if we're authorized to access the users wallet
        const accounts = await ethereum.request({ method: 'eth_accounts'});

        //Users can have multiple authorized accounts, we grab the first one if its there!
        if(accounts.length !== 0){
            const account = accounts[0]
            console.log("Found an authorized account:", account)
            setCurrentAccount(account)
        } else {
            console.log("No authorized account found")
        }
    }

    // Implement connectWallet method 
    const connectWallet = async () => {
        try {
            const { ethereum } = window;

            if(!ethereum){
                alert("Get MetaMask!")
                return;
            }

            // Fancy method to request access to account
            const accounts = await ethereum.request({ method: "eth_requestAccounts"})

            //Boom! This should print out public address once we authorize Metamask
            console.log("connected", accounts[0])
            
            // Set State please?
            setCurrentAccount(accounts[0])

        } catch(error){
            console.log(error)
        }
    }

    // Request the contract
    const askContractToMintNFT = async () => {
        //Be sure to change this variable to the deployed contract address of your latest deployed contract
        const CONTRACT_ADDRESS = "0x25428A51dc7b4b61882382b9D20Af76114189A27"
            try{
                const { ethereum } = window;

                if(ethereum){
                    const provider = new ethers.providers.Web3Provider(ethereum)
                    const signer = provider.getSigner()
                    const connectedContract = new ethers.Contract(CONTRACT_ADDRESS, myEpicNFT.abi, signer)

                    console.log("Going to pop wallet now to pay gas...")
                    let nftTxn = await connectedContract.makeAnEpicNFT();

                    console.log("Mining...please wait.")
                    await nftTxn.wait();

                    console.log(`Mined, see transaction: https://rinkeby.etherscan.io/tx/${nftTxn.hash}`);
                } else {
                    console.log("Ethereum object doesn't exist!")
                }
            } catch (error){
                console.log(error)
            }
    }


    // We conditialnal render if wallet is connected or not
    return (
      <main className="w-full text-center">
        <h1 className="text-6xl font-bold">
          Welcome to <p className="bg-gradient-to-r from-yellow-400 to-red-400 text-transparent bg-clip-text text-6xl leading-relaxed">Egyptian NFT's!</p>
        </h1>

        <div className="p-4 font-bold text-xl">
            <p>Each unique. Each beutiful.</p>
        </div>

        <Images />

        {currentAccount === "" ? (
        <button onClick={connectWallet} className="mt-16 w-2/6 p-4 bg-gradient-to-r from-yellow-400 to-red-600 text-2xl font-bold rounded transform transition-all hover:scale-125 duration-500 ease-out">
            Connect Wallet!
        </button>
        ) : (
        <button onClick={askContractToMintNFT} className="mt-16 w-2/6 p-4 bg-gradient-to-r from-purple-700 to-blue-700 text-2xl font-bold rounded transform transition-all hover:scale-125 duration-500 ease-out">
            Mint NFT!
        </button> 
        )}

      </main>
    );
}

export default Main