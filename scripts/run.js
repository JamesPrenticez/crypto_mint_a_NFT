const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("EgyptianNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  //Call the function desired NFT and fake an answer "Amun", "Ra", "Seshat", "Tutankhamun"
  //let abc = await nftContract.setDesiredNFT("Tutankhamun")
  // Wait for a selection
  // await abc.wait()

  let txn = await nftContract.makeAnEpicNFT();
  await txn.wait();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
