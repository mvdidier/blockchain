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
        bool done,
        uint256 createdAt
    );
    event TaskToggledDone(uint256 id, bool done);

    struct Estado{
        int id;
        string nombre;
    }
    
    struct message{
        uint256 id;
        string mensaje;
    }

    event messageCreated(
        uint256 id,
        string mensaje    
    );

    mapping(uint256 => Task) public tasks;

    mapping(int256 => Estado) public Estados;
    int256 private estadoCount=0;

    address owner;

    modifier onlyOwner(){
            require(msg.sender == owner);
            _;}

    constructor() {
        createTask("William Filiberto", "May", "Couoh", "20/05/2000", "H", 30);
    }

    function GenerarCurp(string memory nombres, 
                        string memory apellidopaterno, 
                        string memory apellidomaterno,
                        string memory fecha,
                        string memory genero,
                        int estado
                        ) public   returns (string memory){
        return GenerarCurpInternal( nombres, apellidopaterno, apellidomaterno,fecha,genero,estado);
    }
    
    function TestCURP() public returns (string memory) {
        //string memory curp = 'MOPE150908MYNRCMA';
        //return curp.concat(curp.obtenerUltimoDigito().toString());        
        return GenerarCurpInternal( 'emma cecilia', 'moreno', 'pech','08/09/2015','M',30); //MACW000520HYNYHLA
        //return GenerarCurpInternal( 'didier rene', 'moreno', 'vazquez','06/09/1985','H',30);   //MOVD850906HYNRZD0
        //return GenerarCurpInternal( 'soledad cecilia', 'pech', 'cohuo','25/12/1985','M',30);   //PECS851225MYNCHL0
        //return GenerarCurpInternal( 'william  filiberto', 'may', 'couoh','20/05/2000','H',30); //MACW000520HYNYHLA
    }
    
    function GenerarCurpInternal(
                                    string memory nombres, 
                                    string memory apellidopaterno, 
                                    string memory apellidomaterno,
                                    string memory fecha,
                                    string memory genero,
                                    int estado
     ) private   returns (string memory) {
        
        string memory curp = "";
        
        nombres = nombres.upper();
        apellidopaterno=apellidopaterno.upper();
        apellidomaterno=apellidomaterno.upper();
        genero=genero.upper();
        
        curp  = apellidopaterno.substring(1).concat(apellidopaterno.buscaVocal()).concat(apellidomaterno.substring(1)).concat(nombres.substring(2)); 
        curp  = curp.cambiaPalabra();
        curp  = curp.concat(fecha._substring(2,8)).concat(fecha._substring(2,3)).concat(fecha._substring(2,0));
        curp  = curp.concat(genero); 
        curp  = curp.concat(ObtenerEstado(estado));        
        curp  = curp.concat(apellidopaterno.buscaConsonante()).concat(apellidomaterno.buscaConsonante()).concat(nombres.buscaConsonante());
        curp  = curp.concat(fecha._substring(2,6).obtenerPrimerDigito());
        curp  = curp.concat(curp.obtenerUltimoDigito().toString());

	    return curp;
    }
    
    function ObtenerEstado( int256 index ) private returns (string memory)
    {      
        Estados[estadoCount] = Estado(estadoCount, "DF");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "AS");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "BC");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "BS");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "CC");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "CL");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "CM");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "CS");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "CH");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "DG");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "GT");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "GR");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "HG");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "JC");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "MC");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "MN");
        estadoCount++;
        Estados[estadoCount] = Estado(estadoCount, "MS");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "NT");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "NL");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "OC");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "PL");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "QT");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "QR");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "SP");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "SL");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "SR");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "TC");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "TS");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "TL");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "VZ");
        estadoCount++;
         Estados[estadoCount] = Estado(estadoCount, "YN");
        estadoCount++;
          Estados[estadoCount] = Estado(estadoCount, "ZS");
        estadoCount++;
          Estados[estadoCount] = Estado(estadoCount, "NE");
        estadoCount++;
        return string(Estados[index].nombre);
    }

     function createTask(string memory _nombres, string memory _apaterno, string memory _amaterno, string memory _fechaNacimiento, string memory _genero, int _estado)
        public
    {
        string memory curp;

        curp = GenerarCurp(_nombres, _apaterno, _amaterno, _fechaNacimiento, _genero, _estado);
        tasksCounter++;
        tasks[tasksCounter] = Task(
            tasksCounter,
            _nombres,
            _apaterno,
            _amaterno,
            _fechaNacimiento,
            _genero,
            _estado,
            curp,
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
            curp,
            false,
            block.timestamp
        );

    }
}