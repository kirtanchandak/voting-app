import React from "react";
import Web3Modal from "web3modal";
import { ethers } from "ethers";
import { create as ipfsHttpClient } from "ipfs-http-client";
import axios from "axios";
import { useRouter } from "next/router";
import { VotingAddressABI, contractAddress } from "./constants";
import { exportPathMap } from "next.config";

const client = ipfsHttpClient("https://ipfs.infura.io:5001/api/v0");

const fetchContract = (signerOrProvider) =>
  new ethers.Contract(contractAddress, VotingAddressABI, signerOrProvider);

export const VotingContext = React.createContext();

export const VotingProvider = ({ children }) => {
  const votingTitle = "I am Kirtan!";
  return (
    <VotingContext.Provider value={{ votingTitle }}>
      {children}
    </VotingContext.Provider>
  );
};

function Voter() {
  return <div>Voter</div>;
}

export default Voter;
