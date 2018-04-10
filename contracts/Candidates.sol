pragma solidity ^0.4.17;

contract Candidates {
    mapping(address => bool) private authorizedCandidates;

    function Candidates(address[] _allCandidates) public{
        require(_allCandidates.length > 3);
        for (uint i=0; i < _allCandidates.length; i++) {
            authorizedCandidates[_allCandidates[i]] = true;
        }
    }

    function isAuthorizedCandidate(address _maybeCandidate) public view returns (bool) {
        return authorizedCandidates[_maybeCandidate];
    }
}
