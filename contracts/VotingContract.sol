//SPDX-Lisence-Identifier: UNLICENSED

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Counters.sol";

contract Create {
    using Counters for Counters.Counter;

    Counters.Counter public _voterId;
    Counters.Counter public _candidateId;

    address public votingOrganizer;

    // Candidate data start //
    struct Candidate {
        uint256 candidateId;
        string name;
        string age;
        string image;
        uint256 voteCount;
        string ipfs;
        address _address;
    }

    event CandidateCreate(
        uint256 indexed candidateId,
        string name,
        string age,
        string image,
        uint256 voteCount,
        string ipfs,
        address _address
    );

    address[] public candidateAddress;

    mapping(address => Candidate) public candidates;

    // canditae data end //

    // Voter data start //

    address[] public votedVoters;
    address[] public votersAddress;

    mapping(address => Voter) public voters;

    struct Voter {
        uint256 voter_voterId;
        string voter_name;
        string voter_image;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
        uint256 voter_vote;
        string voter_ipfs;
    }

    event VoterCreated(
        uint256 indexed voter_voterId,
        string voter_name,
        string voter_image,
        address voter_address,
        uint256 voter_allowed,
        bool voter_voted,
        uint256 voter_vote,
        string voter_ipfs
    );

    // end of voter-data //

    constructor() {
        votingOrganizer = msg.sender;
    }

    // -----Candidate Section ------- //

    function setCandidate(
        address _address,
        string memory _name,
        string memory _image,
        string memory _ipfs,
        string memory _age
    ) public {
        require(votingOrganizer == msg.sender, "You are not the organizer");

        _candidateId.increment();
        uint256 idNumber = _candidateId.current();

        Candidate storage candidate = candidates[_address];
        candidate.age = _age;
        candidate.name = _name;
        candidate.candidateId = idNumber;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate._address = _address;
        candidate.ipfs = _ipfs;

        candidateAddress.push(_address);

        emit CandidateCreate(
            idNumber,
            _name,
            _age,
            _image,
            candidate.voteCount,
            _ipfs,
            _address
        );
    }

    function getCandidate() public view returns (address[] memory) {
        return candidateAddress;
    }

    function getCandidateLength() public view returns (uint256) {
        return candidateAddress.length;
    }

    function getCantidateData(address _address)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            string memory,
            uint256,
            string memory,
            address
        )
    {
        Candidate memory candidate = candidates[_address];
        return (
            candidate.candidateId,
            candidate.name,
            candidate.age,
            candidate.image,
            candidate.voteCount,
            candidate.ipfs,
            candidate._address
        );
    }

    // -----Voter Section ------- //

    function voterRight(
        address _address,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require((votingOrganizer == msg.sender), "You are not the organizer");

        _voterId.increment();

        uint256 idNumber = _voterId.current();

        Voter storage voter = voters[_address];

        require(voter.voter_allowed == 0);

        voter.voter_allowed = 1;
        voter.voter_image = _image;
        voter.voter_name = _name;
        voter.voter_address = _address;
        voter.voter_ipfs = _ipfs;
        voter.voter_voterId = idNumber;
        voter.voter_vote = 1000;
        voter.voter_voted = false;

        votersAddress.push(_address);

        emit VoterCreated(
            idNumber,
            _name,
            _image,
            _address,
            voter.voter_allowed,
            voter.voter_voted,
            voter.voter_vote,
            _ipfs
        );
    }

    function vote(address _candidateAddress, uint256 _candidateVoteId)
        external
    {
        Voter storage voter = voters[msg.sender];

        require(!voter.voter_voted, "You have already voted");
        require(voter.voter_allowed != 0, "You are not allowed to vote");

        voter.voter_voted = true;
        voter.voter_vote = _candidateVoteId;

        votedVoters.push(msg.sender);

        candidates[_candidateAddress].voteCount += voter.voter_allowed;
    }

    function getVoterLength() public view returns (uint256) {
        return votersAddress.length;
    }

    function getVotersData(address _address)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            address,
            uint256,
            bool,
            uint256,
            string memory
        )
    {
        Voter memory voter = voters[_address];
        return (
            voter.voter_voterId,
            voter.voter_name,
            voter.voter_image,
            voter.voter_address,
            voter.voter_allowed,
            voter.voter_voted,
            voter.voter_vote,
            voter.voter_ipfs
        );
    }

    function getVotedVoterList() public view returns (address[] memory) {
        return votedVoters;
    }

    function getVoterList() public view returns (address[] memory) {
        return votersAddress;
    }
}
