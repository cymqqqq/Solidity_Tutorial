// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    //an array of 'Todo' structs
    Todo[] public todo;

    function create(string memory _text) public {
        //3 ways to initialize a struct
        //- calling it like a function
        todo.push(Todo(_text, false));

        //key value mappiing
        todo.push(Todo({text: _text, completed: false}));

        //initialize an empty struct and then update it
        Todo memory todos;
        todos.text = _text;
        //todo.completed initialized to false
        todo.push(todos);
    }

    //solidity automativally created a getter for 'todo'
    //so you don't actually need this function
    function get(uint _idx) public view returns (string memory text, bool completed) {
        Todo storage todos = todo[_idx];
        return (todos.text, todos.completed);
    }

    //update text
    function update(uint _idx, string memory _text) public {
        Todo storage todos = todo[_idx];
        todos.text = _text;
    }

    //update completed
    function toggleCompleted(uint _idx) public {
        Todo storage todos = todo[_idx];
        todos.completed = !todos.completed;
    }
}