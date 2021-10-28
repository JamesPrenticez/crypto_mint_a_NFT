// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";
import { Images } from "./libraries/Images.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract EgyptianNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string desiredNFT = "";
  string svgP1 = "<svg width='300' height='450'><defs><radialGradient id='RadialGradient' cx='0.5' cy='0.5' r='0.5'><stop offset='0%' stop-color='yellow'/><stop offset='100%' stop-color='orange'/></radialGradient><clipPath id='dropShadow'></clipPath></defs><rect width='100%' height='100%' fill='url(#RadialGradient)'/><image width='250' height='350' y='25' href='";
  // P2 "https://i.imgur.com/WGc6zQS.png"
  string svgP3 = "' filter= 'drop-shadow(0px 0px 10px "; 
  // P4 #9F00FF random color
  string svgP5 = ")'/><style>.myText { fill: black; font-family: cursive; font-size: 16px; }</style><text x='50%' y='93%' class='myText' dominant-baseline='middle' text-anchor='middle'>";

  //Event to get OpenSea Link (line 1)
  event EgyptianNFTMinted(address sender, uint256 tokenId);

  // We need to pass the name of our NFTs token and it's symbol.
  constructor() ERC721 ("Ancient Egyiptian NFTs", "SLURP") {
    console.log("This is my NFT contract. Woah!");
  }

  function setDesiredNFT(string memory NFT) public returns (string memory){
    desiredNFT = NFT;
    console.log(desiredNFT);
    return desiredNFT;
  }

  string[] firstWords = [""];
  string[] secondWords = [""];
  string[] thirdWords = [""];
  string[] color = ["#1339FF", "#9F00FF", "#FF1338", "#DA14FF", "#39ff14"];

  // I tired to store this in a library however you can't store []'s =(
  // Tutankhamun
  string[] tutankhamunFirst = ["Tutankhamun"];
  string[] tutankhamunSecond = ["Majestic", "Exalted", "Powerful", "Eternal", "Dignified", "Influential", "Potent", "Persuasive", "Revered", "Holy", "Godly", "Immortal", "Indestructible", "Perpetual", "Mighty", "Commanding", "Vigorous", "Formidable", "Weak", "Cowardly", "Sick", "Frail", "Incompetent", "Pathetic", "Dying"];
  string[] tutankhamunThird = ["Pharaoh", "Legend", "King", "Ruler", "Sovereign", "Emperor", "Monarch", "Leader", "Commander", "Boss", "Lord", "Director", "Dynast", "Child"];

  // Ra
  string[] raFirst = ["Ra"];
  string[] raSecond = ["Majestic", "Exalted", "Powerful", "Eternal", "Dignified", "Influential", "Potent", "Persuasive", "Revered", "Holy", "Godly", "Immortal", "Indestructible", "Perpetual", "Mighty", "Commanding", "Vigorous", "Formidable", "Weak", "Cowardly", "Sick", "Frail", "Incompetent", "Pathetic", "Dying"];
  string[] raThird = ["God", "Pharaoh", "Legend", "King", "Ruler", "Sovereign", "Emperor", "Monarch", "Leader", "Commander", "Boss", "Lord", "Director", "Dynast", "Child"];

  // Seshat
  string[] seshatFirst = ["Seshat"];
  string[] seshatSecond = ["Majestic", "Exalted", "Powerful", "Eternal", "Dignified", "Influential", "Potent", "Persuasive", "Revered", "Holy", "Godly", "Immortal", "Indestructible", "Perpetual", "Mighty", "Commanding", "Vigorous", "Formidable", "Weak", "Cowardly", "Sick", "Frail", "Incompetent", "Pathetic", "Dying"];
  string[] seshatThird = ["Pharaoh", "Queen", "Ruler", "Sovereign", "Emperor", "Monarch", "Leader", "Commander", "Boss", "Lord", "Director", "Dynast", "Child"];

  // Amun
  string[] amunFirst = ["Amun"];
  string[] amunSecond = ["Skilled", "Intellectual", "Adept", "Expert", "Specialist", "Influential", "Novice", "Bold", "Loved", "Admired", "Feared", "Friendly", "Loyal", "Stupid", "Mighty", "Commanding", "Vigorous", "Formidable", "Weak", "Cowardly", "Sick", "Frail", "Incompetent", "Pathetic", "Dying"];
  string[] amunThird = ["Scribe", "Baker", "Farmer", "Priest", "Doctor", "Craftsman", "Merchant", "Herbalist", "Thief", "Captian", "Major", "Lieutenant", "Recruit", "Sailor", "Traveller", "Ship-maker", "Stableman" ];

  // I create a function to randomly pick a word from each array.
  function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
    // I seed the random generator. More on this in the lesson. 
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    // Squash the # between 0 and the length of the array to avoid going out of bounds.
    rand = rand % firstWords.length;
    return firstWords[rand];
  }

  function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked(" SECOND_WORD ", Strings.toString(tokenId))));
    rand = rand % secondWords.length;
    return secondWords[rand];
  }

  function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % thirdWords.length;
    return thirdWords[rand];
  }

  function pickRandomColor(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
    rand = rand % color.length;
    return color[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  // A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();
    string memory p2;

    // Could pull this out into a sperate function just like setWordsToUse
    //most retared thing ever convert string to a hash so we can check equallity keccak256(bytes(a)) == keccak256(bytes(b)
    //https://ethereum.stackexchange.com/questions/30912/how-to-compare-strings-in-solidity
    if(keccak256(bytes(desiredNFT)) == keccak256(bytes("Amun"))){
      p2 = Images.Amun; //imported from /libraries/Images.sol
      firstWords = amunFirst; //imported from /libraries/Words.sol
      secondWords = amunSecond;
      thirdWords = amunThird;
    }
    else if (keccak256(bytes(desiredNFT)) == keccak256(bytes("Ra"))){
      p2 = Images.Ra;
      firstWords = raFirst;
      secondWords = raSecond;
      thirdWords = raThird;
    }
    else if (keccak256(bytes(desiredNFT)) == keccak256(bytes("Seshat"))){
      p2 = Images.Seshat;
      firstWords = seshatFirst;
      secondWords = seshatSecond;
      thirdWords = seshatThird;
    }
    else if (keccak256(bytes(desiredNFT)) == keccak256(bytes("Tutankhamun"))){
      p2 = Images.Tutankhamun;
      firstWords = tutankhamunFirst;
      secondWords = tutankhamunSecond;
      thirdWords = tutankhamunThird;
    }
    else { 
      return;
    }

    string memory p1 = svgP1;
    //p2 Images.Name
    string memory p3 = svgP3;
    string memory p4 = pickRandomColor(newItemId);
    string memory p5 = svgP5;

    string memory combinedImage = string(abi.encodePacked(p1, p2, p3, p4, p5));

    string memory first = pickRandomFirstWord(newItemId);
    string memory second = pickRandomSecondWord(newItemId);
    string memory third = pickRandomThirdWord(newItemId);
    string memory combinedWord = string(abi.encodePacked(first, " ", second, " ", third));

    // I concatenate it all together, and then close the <text> and <svg> tags.
    string memory finalSVG = string(abi.encodePacked(combinedImage, combinedWord, "</text></svg>"));

    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    combinedWord,
                    '", "description": "A highly acclaimed collection of Egyptian NTFs v1."',
                    '"image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSVG)), 
                    '"}'
                )
            )
        )
    );

    // Just like before, we prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    console.log("\n--------------------");
    console.log(finalTokenUri);
    console.log("--------------------\n");

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, finalTokenUri);

    //console.log to help us see when the NFT is minted and to who!
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();

    //Event (line 2)
    emit EgyptianNFTMinted(msg.sender, newItemId);
  }
}