import React, { useContext } from "react";
import { VotingContext } from "context/Voter";

const HOME = () => {
  const { votingTitle } = useContext(VotingContext);
  return <div>{votingTitle}</div>;
};

export default HOME;
