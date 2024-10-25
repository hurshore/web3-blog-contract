// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Blog {
  constructor()  {}

  struct Post {
    uint256 id;
    string title;
    string content;
    uint256 timestamp;
    address author;
    string[] tags;
  }

  Post[] public posts;
  uint256 public postCount;

  event PostCreated(
    uint256 id,
    string title,
    string content,
    uint256 timestamp,
    address author,
    string[] tags
  );

  function createPost(string memory _title, string memory _content, string[] memory _tags) public {
    posts.push(Post({
      id: postCount + 1,
      title: _title,
      content: _content,
      tags: _tags,
      timestamp: block.timestamp,
      author: msg.sender
    }));
    postCount++;
  }

  function getPosts() public view returns (Post[] memory) {
    return posts;
  }

  function getPost(uint256 _id) public view returns (Post memory) {
    return posts[_id - 1] ;
  }

  function getPostsByAuthor(address _author) public view returns (Post[] memory) {
    Post[] memory _posts = new Post[](posts.length);
    uint256 count = 0;
    for (uint i = 0; i < posts.length; i++) {
      if (posts[i].author == _author) {
        _posts[count] = posts[i];
        count++;
      }
    }
    return _posts;
  }

  function donateToAuthor(address payable _author) public payable {
    require(msg.value > 0, "Amount must be greater than 0");
    require(_author != address(0), "Invalid author address");
    _author.transfer(msg.value);
  }
}
