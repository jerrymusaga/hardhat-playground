import { HardhatUserConfig, vars } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const INFURA_API_KEY = vars.get("INFURA_API_KEY");

const PRIVATE_KEY = vars.get("PRIVATE_KEY");

const ETHERSCAN_API_KEY = vars.get("ETHERSCAN_API_KEY");

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};

export default config;
