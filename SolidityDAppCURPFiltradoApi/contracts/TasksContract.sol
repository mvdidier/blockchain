// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "./lib/Strings.sol";
import "./lib/Integers.sol";

contract TasksContract {
    uint256 public tasksCounter = 0;
    string curpFinal;
    using Strings for string;
    using Integers for uint;

    struct Task {
        uint256 id;
        string nombres;
        string apaterno;
        string amaterno;
        string fechaNacimiento;
        string genero;
        int estado;
        string curp;
        address contrato;
        bool done;
        uint256 createdAt;
    }

    event TaskCreated(
        uint256 id,
        string nombres,
        string apaterno,
        string amaterno,
        string fechaNacimiento,
        string genero,
        int estado,
        string curp,
        address contrato,
        bool done,
        uint256 createdAt
    );
    event TaskToggledDone(uint256 id, bool done);

    struct Estado{
        int id;
        string nombre;
    }

    mapping(uint256 => Task) public tasks;
    mapping(int256 => Estado) public Estados;
    int256 private estadoCount=0;
    //Variable dirección para el contrato
    address private owner;

    //Variable para la estructura
    bool public EsOwner;

    modifier onlyOwner{
        //La condición es el inverso
        require(msg.sender == owner, "Solo el owner puede interactuar con el contrato");
        _;
    }

    constructor() {
        owner = msg.sender;
        createTask("William Filiberto", "May", "Couoh", "20/05/2000", "H", 30, "MACW000520HYNYHLA7");
    }

    function createTask(string memory _nombres, string memory _apaterno, string memory _amaterno, string memory _fechaNacimiento, string memory _genero, int _estado, string memory _curp)
        public
    {
        tasksCounter++;
        tasks[tasksCounter] = Task(
            tasksCounter,
            _nombres,
            _apaterno,
            _amaterno,
            _fechaNacimiento,
            _genero,
            _estado,
            _curp,
            msg.sender,
            false,
            block.timestamp
        );
        emit TaskCreated(
            tasksCounter,
            _nombres,
            _apaterno,
            _amaterno,
            _fechaNacimiento,
            _genero,
            _estado,
            _curp,
            msg.sender,
            false,
            block.timestamp
        );

    }
}