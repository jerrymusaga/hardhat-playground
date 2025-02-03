// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract StudentManagement {
    address owner;
    uint256 public registrationFee = 0.01 ether;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the admin");
        _;
    }

    enum Gender{ Male, Female }

    mapping (uint256 => string) name;
    mapping(uint8 => Student) students;
    mapping(address => uint256) public payments;
   
    struct Student {
        string name;
        uint8 age;
        string class;
        Gender gender;
        address studentAddress;
    }

    uint8 studentId = 0;
    // Student[] allStudents;
    

    function registerStudent(
        string memory _name,
        uint8 _age,
        string memory _class,
        Gender _gender
    ) public payable {
        require(msg.value >= registrationFee, "Insufficient registration fee");
        Student memory student = Student({
            name: _name,
            age: _age,
            class: _class,
            gender: _gender,
            studentAddress: msg.sender
        });

        
        studentId++;
        students[studentId] = student;
        payments[msg.sender] += msg.value;
    }



    function getStudent(uint8 _studentId) public view returns (Student memory student_) {
        student_ = students[_studentId];
    }

    function getStudents() public view returns (Student[] memory students_) {
        students_ = new Student[](studentId);

       for (uint8 i = 1; i <= studentId; i++) {
        students_[i - 1] = students[i];
       }

       students_;
    }

    function getStudentFromName(string memory _name) public view returns (Student memory) {
        for (uint8 i = 1; i <= studentId; i++) {
            if (keccak256(bytes(students[i].name)) == keccak256(bytes(_name))) {
                return students[i];
            }
        }
        revert("Student not found");
    }

    function updateRegistrationFee(uint256 _newFee) external onlyOwner {
        registrationFee = _newFee;
    }

    function withdrawFees() 
        external 
        onlyOwner 
    {
        uint256 schoolBalance = address(this).balance;
        require(schoolBalance > 0, "No fees to withdraw");
        
        (bool success, ) = owner.call{value: schoolBalance}("");
        require(success, "the school balance cannot be withdrawn cos it failed");
    }

     receive() external payable {}
   
}