pragma solidity ^0.4.17;

contract Voters {
    mapping(address => bool) private authorizedVoters;
    address private owner;

    function Voters(address[] _allVoters) public{
        require(_allVoters.length > 0);
        for (uint i=0; i < _allVoters.length; i++) {
            authorizedVoters[_allVoters[i]] = true;
        }
        owner = msg.sender;
    }

    function isAuthorizedVoter(address _maybeVoter) public view returns (bool) {
        return authorizedVoters[_maybeVoter];
    }
}
