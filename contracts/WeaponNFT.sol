// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract WeaponNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  string[] desiredNFT = ["Sword","Staff","Bow"];

  string svgP1 = "<svg id='svg' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 400 400'><defs><clipPath id='dropShadow'></clipPath></defs><rect width='100%' height='100%' fill='black'/><path d='";
  string swordP2 = "M0.000 0.660 C 0.000 1.023,7.860 21.853,17.467 46.949 C 27.074 72.045,35.072 92.949,35.240 93.401 C 35.409 93.854,40.645 98.933,46.875 104.687 C 53.105 110.442,60.840 117.664,64.063 120.737 C 67.285 123.810,72.734 128.897,76.172 132.040 C 81.837 137.221,97.814 152.095,110.938 164.405 C 113.730 167.025,120.934 173.732,126.946 179.311 C 142.295 193.553,160.285 210.302,172.656 221.870 C 178.457 227.293,186.016 234.317,189.453 237.478 C 192.891 240.638,200.977 248.158,207.422 254.187 C 226.797 272.312,238.936 283.617,248.979 292.887 L 258.505 301.680 255.531 306.504 C 253.895 309.157,249.872 315.638,246.591 320.906 C 238.434 334.002,238.429 333.921,248.117 343.782 C 259.425 355.291,258.968 355.393,277.099 337.325 C 289.381 325.085,290.645 324.039,291.928 325.058 C 294.803 327.341,345.020 372.917,347.461 375.458 C 348.858 376.913,350.000 378.929,350.000 379.942 C 350.000 386.214,357.886 395.617,365.563 398.499 C 390.188 407.742,411.195 377.949,394.119 357.999 C 391.217 354.609,383.049 350.000,379.942 350.000 C 378.929 350.000,376.913 348.858,375.458 347.461 C 372.917 345.020,327.341 294.803,325.058 291.928 C 324.039 290.645,325.085 289.381,337.325 277.099 C 355.393 258.968,355.291 259.425,343.782 248.117 C 333.109 237.631,335.886 237.119,307.683 254.773 L 301.695 258.522 292.887 248.987 C 284.559 239.971,280.550 235.665,253.125 206.274 C 246.895 199.597,237.230 189.213,231.649 183.200 C 226.068 177.186,219.365 169.980,216.753 167.188 C 210.157 160.134,191.431 140.008,179.311 126.946 C 173.732 120.934,167.025 113.730,164.405 110.938 C 152.095 97.814,137.221 81.837,132.040 76.172 C 128.897 72.734,123.823 67.285,120.764 64.063 C 117.706 60.840,110.465 53.105,104.672 46.875 C 94.689 36.137,93.856 35.437,88.672 33.442 C 9.004 2.772,0.000 -0.556,0.000 0.660 M46.875 31.735 C 89.340 47.933,86.251 46.577,89.926 50.628 C 91.757 52.646,97.692 59.043,103.113 64.844 C 118.457 81.260,133.457 97.356,139.453 103.838 C 142.461 107.090,154.436 119.949,166.064 132.414 C 177.692 144.879,192.081 160.352,198.040 166.797 C 203.999 173.242,210.858 180.625,213.282 183.203 C 221.364 191.796,239.404 211.150,254.355 227.266 C 262.487 236.032,273.813 248.239,279.523 254.392 L 289.906 265.581 285.102 268.532 C 276.069 274.083,274.547 275.506,270.254 282.414 C 267.923 286.166,265.789 289.285,265.511 289.345 C 265.054 289.443,223.198 250.902,207.031 235.497 C 203.379 232.017,190.020 219.548,177.344 207.789 C 141.108 174.173,101.177 137.024,92.552 128.906 C 88.215 124.824,76.221 113.646,65.899 104.065 C 49.445 88.792,46.931 86.145,45.496 82.581 C 43.410 77.399,41.766 73.129,31.743 46.875 C 27.231 35.059,23.280 24.714,22.963 23.888 C 22.482 22.636,22.636 22.482,23.888 22.963 C 24.714 23.280,35.059 27.228,46.875 31.735 M334.216 257.252 L 335.892 259.036 297.406 297.516 L 258.921 335.995 257.159 334.120 L 255.397 332.245 264.686 317.099 C 269.795 308.769,276.371 298.068,279.299 293.320 L 284.623 284.686 300.710 274.767 C 309.558 269.311,320.137 262.763,324.219 260.217 C 332.947 254.772,332.117 255.019,334.216 257.252 M338.194 326.700 L 361.742 352.618 359.030 354.853 C 357.539 356.083,355.493 358.144,354.484 359.433 L 352.649 361.777 328.864 340.201 C 315.782 328.334,304.031 317.599,302.751 316.345 L 300.423 314.065 307.030 307.423 C 310.664 303.770,313.864 300.781,314.142 300.781 C 314.420 300.781,325.243 312.444,338.194 326.700 M380.044 364.046 C 387.485 367.648,389.188 377.307,383.441 383.324 C 374.087 393.119,358.028 381.599,364.214 369.531 C 367.363 363.388,373.961 361.101,380.044 364.046"; 
  string staffP2 = "M69.922 1.143 C 38.144 6.964,11.290 29.464,2.573 57.572 C -0.228 66.603,-0.706 97.990,1.820 107.031 C 7.817 128.498,26.202 148.000,47.251 155.222 C 83.301 167.592,113.452 155.462,113.630 128.516 C 113.723 114.494,102.890 108.112,87.818 113.310 C 71.582 118.910,55.225 112.613,50.045 98.769 C 35.704 60.441,80.159 34.377,109.375 63.984 C 120.335 75.090,123.171 83.255,124.191 106.641 C 125.164 128.952,126.266 133.031,134.212 143.750 C 144.544 157.686,155.398 169.912,178.573 193.719 C 185.909 201.256,195.226 210.924,199.276 215.204 C 203.327 219.484,209.980 226.514,214.063 230.826 C 229.614 247.252,240.254 258.120,264.909 282.761 C 278.910 296.754,300.456 318.574,312.790 331.250 C 347.135 366.549,377.295 395.125,383.758 398.490 C 396.481 405.116,404.680 391.001,397.029 375.644 C 393.873 369.312,389.312 363.313,375.971 347.954 C 370.044 341.130,360.809 330.498,355.449 324.327 C 350.089 318.157,344.169 311.301,342.293 309.093 C 340.418 306.885,332.684 298.074,325.106 289.514 C 317.528 280.953,304.152 265.836,295.382 255.920 C 286.612 246.004,273.215 230.859,265.612 222.266 C 187.058 133.479,178.242 121.113,176.496 97.266 C 171.520 29.276,128.442 -9.577,69.922 1.143 M107.868 15.121 C 138.994 22.383,160.006 54.071,163.240 98.626 C 164.952 122.206,174.945 138.736,216.735 187.109 C 223.364 194.783,255.533 231.258,289.082 269.141 C 316.343 299.923,340.268 327.188,350.000 338.561 C 351.504 340.319,355.205 344.579,358.225 348.027 C 376.901 369.351,386.905 382.106,385.812 383.198 C 384.521 384.489,266.929 266.807,217.196 214.453 C 204.134 200.703,187.451 183.301,180.121 175.781 C 161.398 156.571,144.760 136.917,140.872 129.415 C 138.728 125.279,138.265 122.071,137.518 106.217 C 136.088 75.832,129.551 61.227,111.310 47.662 C 83.313 26.842,41.239 40.872,35.399 72.976 C 30.611 99.297,41.704 120.481,63.705 127.029 C 70.815 129.145,84.163 128.957,90.018 126.658 C 92.661 125.621,95.696 125.003,97.440 125.147 L 100.391 125.391 100.264 129.104 C 99.867 140.737,91.321 146.291,73.828 146.286 C 31.863 146.275,5.047 109.700,14.452 65.303 C 22.037 29.503,66.693 5.514,107.868 15.121";
  string bowP2 = "M390.287 0.697 C 389.507 1.958,376.308 6.807,369.141 8.465 C 352.504 12.314,342.755 12.382,308.594 8.886 C 256.224 3.527,222.474 6.704,187.342 20.301 C 112.687 49.194,36.599 129.461,14.487 202.647 C 4.750 234.876,3.653 261.964,9.848 317.188 C 13.161 346.718,9.918 374.652,1.521 388.912 C -1.837 394.616,0.425 400.000,6.181 400.000 C 9.600 400.000,12.167 397.672,14.036 392.877 C 15.661 388.706,388.350 16.056,392.959 13.993 C 399.920 10.877,402.316 5.441,398.438 1.562 C 396.813 -0.062,391.129 -0.666,390.287 0.697 M316.406 22.754 C 335.486 24.613,357.308 24.425,366.406 22.322 C 369.199 21.677,372.011 21.136,372.656 21.121 C 373.300 21.106,294.565 100.357,197.688 197.233 C 100.812 294.110,21.416 373.239,21.252 373.075 C 21.088 372.911,21.549 370.025,22.275 366.662 C 24.509 356.311,24.674 336.082,22.684 316.406 C 14.256 233.071,36.047 180.286,108.850 107.682 C 165.345 51.341,212.823 25.662,269.531 20.774 C 276.576 20.167,300.013 21.157,316.406 22.754";
  string svgP3 = "' stroke='none' fill='white' fill-rule='evenodd' filter= 'drop-shadow(0px 0px 10px "; 
  // P4 #9F00FF random color
  string svgP5 = ")'></path><style>.myText { fill: white; font-family: cursive; font-size: 16px; }</style><text x='50%' y='97%' class='myText' dominant-baseline='middle' text-anchor='middle'>";

  //Event to get OpenSea Link (line 1)
  event weaponNFTMinted(address sender, uint256 tokenId);

  // We need to pass the name of our NFTs token and it's symbol.
  constructor() ERC721 ("Weapon NFT's", "EPIC") {
    console.log("This is my NFT contract. Woah!");
  }

  // function setDesiredNFT(string memory NFT) public returns (string memory){
  //   desiredNFT = NFT;
  //   console.log(desiredNFT);
  //   return desiredNFT;
  // }

  string[] firstWords = [""];
  string[] secondWords = [""];
  string[] color = ["#00FF00", "#0000FF", "#FF00FF", "#FFFF00", "#FF0000"];

  // I tired to store this in a library however you can't store []'s =(
  // Sword
  string[] swordFirst = ["Majestic", "Eternal", "Influential", "Potent", "Persuasive", "Holy", "Godly", "Perpetual", "Mighty", "Commanding", "Vigorous", "Formidable", "Weak", "Cowardly", "Incompetent", "Pathetic"];
  string[] swordSecond = ["Power", "Sharpness", "Strength", "Damage", "Pain", "Suffering", "Bleeding"];
  
  // Staff
  string[] staffFirst = ["Majestic", "Eternal", "Influential", "Potent", "Persuasive", "Holy", "Godly", "Perpetual", "Mighty", "Commanding", "Vigorous", "Formidable", "Weak", "Cowardly", "Incompetent", "Pathetic"];
  string[] staffSecond = ["Power", "Fire", "Water", "Earth", "Air", "Light", "Darkness"];
  
  // Bow
  string[] bowFirst = ["Majestic", "Eternal", "Influential", "Potent", "Persuasive", "Holy", "Godly", "Perpetual", "Mighty", "Commanding", "Vigorous", "Formidable", "Weak", "Cowardly", "Incompetent", "Pathetic"];
  string[] bowSecond = ["Power", "Accuracy", "Cripling", "Poison", "Long Range", "Speed", "Impact"];


  // I create a function to randomly pick a word from each array.
  function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
    // I seed the random generator. More on this in the lesson. 
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    // Squash the # between 0 and the length of the array to avoid going out of bounds.
    rand = rand % firstWords.length;
    return firstWords[rand];
  }

  function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % secondWords.length;
    return secondWords[rand];
  }

  function pickRandomColor(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
    rand = rand % color.length;
    return color[rand];
  }

  function pickRandomNFT(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("DESIREDNFT", Strings.toString(tokenId))));
    rand = rand % desiredNFT.length;
    return desiredNFT[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  // A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();
    
    string memory chosenNFT = pickRandomNFT(newItemId);
    string memory p2;
    // Could pull this out into a sperate function just like setWordsToUse
    //most retared thing ever convert string to a hash so we can check equallity keccak256(bytes(a)) == keccak256(bytes(b)
    //https://ethereum.stackexchange.com/questions/30912/how-to-compare-strings-in-solidity
    if(keccak256(bytes(chosenNFT)) == keccak256(bytes("Sword"))){
      p2 = swordP2; //imported from /libraries/Images.sol
      firstWords = swordFirst; //imported from /libraries/Words.sol
      secondWords = swordSecond;
     }
    else if (keccak256(bytes(chosenNFT)) == keccak256(bytes("Staff"))){
      p2 = staffP2;
      firstWords = staffFirst;
      secondWords = staffSecond;
    }
    else if (keccak256(bytes(chosenNFT)) == keccak256(bytes("Bow"))){
      p2 = bowP2;
      firstWords = bowFirst;
      secondWords = bowSecond;
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
    string memory combinedWord = string(abi.encodePacked(chosenNFT, " of ", first, " ", second));

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
                    '", "description": "A highly acclaimed collection of Weapon NTFs.", "image": "data:image/svg+xml;base64,',
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
    emit weaponNFTMinted(msg.sender, newItemId);
  }
}