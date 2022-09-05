require("@nomiclabs/hardhat-waffle");
require('dotenv').config({path:"/.env"})

const PRIVATE_KEY = process.env["PRIVATE_KEY"];

module.exports = {
    solidity: "0.8.9",
    networks: {

      hardhat: {
        forking: {
          url: "https://eth-rinkeby.alchemyapi.io/v2/l_yaM0kU4-JhjYTSwoPx5KBB_Ma-SRtv",
        }
      },

      mainnet: {
        url: `https://api.avax.network/ext/bc/C/rpc`,
          accounts: process.env["PRIVATE_KEY"],
      },
      fuji: {
        url: `https://api.avax-test.network/ext/bc/C/rpc`,
          accounts: process.env["PRIVATE_KEY"],
      }
    }
};