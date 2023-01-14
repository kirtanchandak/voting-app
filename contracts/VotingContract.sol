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
}
