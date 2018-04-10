pragma solidity ^0.4.17;
import "browser/Voters.sol";
import "browser/Candidates.sol";

contract Election {
    Voters private voters;
    Candidates private candidates;
    mapping(address => uint) private candidateRace;
    mapping(address => Vote) private alreadyVoted;

    struct Vote {
            address first;
            address second;
            address third;
    }

    event Voted(Vote);

    modifier uniqueVoter() {
        if (alreadyVoted[msg.sender].first != 0 && voters.isAuthorizedVoter(msg.sender)) _;
    }

    function Election(Voters _voters, Candidates _candidates) public {
        voters = _voters;
        candidates = _candidates;
    }

    function myVote(address[3] _myVotes) public uniqueVoter {
        require(_myVotes.length == 3);
        require(candidates.isAuthorizedCandidate(_myVotes[0]));
        require(candidates.isAuthorizedCandidate(_myVotes[1]));
        require(candidates.isAuthorizedCandidate(_myVotes[2]));
        require(notRepeted(_myVotes));
        candidateRace[_myVotes[0]] += 3;
        candidateRace[_myVotes[1]] += 2;
        candidateRace[_myVotes[2]] += 1;
        Vote memory vote = Vote(_myVotes[0], _myVotes[1], _myVotes[2]);
        alreadyVoted[msg.sender] = vote;
        emit Voted(vote);
    }

    function notRepeted(address[3] _myVotes) private pure returns (bool){
        return (_myVotes[0] != _myVotes[1] && _myVotes[0] != _myVotes[2]
        && _myVotes[1] != _myVotes[2]);
    }
}
