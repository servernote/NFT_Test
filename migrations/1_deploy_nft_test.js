const NFT_Test = artifacts.require("NFT_Test");

module.exports = function(deployer) {
    deployer.deploy(NFT_Test);
};
