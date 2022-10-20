document.addEventListener("DOMContentLoaded", () => {
  App.init();
});
/**
 * Task form
 */
const taskForm = document.querySelector("#taskForm");

let obj = {
  "nombres": "William Filiberto",
  "apaterno": "May",
  "amaterno": "Couoh",
  "sexo":0,
  "fechaNacimiento":"2000-05-20",
  "estado":31
};


taskForm.addEventListener("submit", (e) => {
  e.preventDefault();

  const nombres = taskForm["nombres"].value;
  const apaterno = taskForm["apaterno"].value;
  const amaterno = taskForm["amaterno"].value;
  const fechaNacimiento = taskForm["fechaNacimiento"].value;
  const genero = taskForm["genero"].value;
  const estado = taskForm["estado"].value;
  //App.createCurp(nombres, apaterno, amaterno, fechaNacimiento, genero, estado);
  ConsumirApi();

  function PoblarCiudadano() {
    var ciudano = {
      "nombre": nombres,
      "apellidoPaterno" : apaterno,
      "apellidoMaterno" : amaterno,
      "fechaNacimiento": fechaNacimiento,
      "sexo": Number(genero),
      "estado": Number(estado)
    }
    return ciudano;
    }
    
    function LlamarAPIRemoto(Servidor, Tipo, Parametros) {
      $.ajax({
          url: Servidor,
          type: Tipo,
          dataType: 'json',
          contentType: "application/json",
          data: Parametros,
          async: false,
          success: function (xhr, textStatus, errorThrown) {
              curp = xhr.responseText;
              //App.createCurp(nombres, apaterno, amaterno, fechaNacimiento, genero, estado, curp);
          },
          error: function (xhr, textStatus, errorThrown) {
              curp = xhr.responseText;
          }
      });
      debugger;
      App.createCurp(nombres, apaterno, amaterno, fechaNacimiento, genero, estado, curp);
      return datos;
    }
  
    function ConsumirApi(){
      var DatosCurp = PoblarCiudadano();
      var ResultadoApi = LlamarAPIRemoto('http://egobtestapp.eastus.cloudapp.azure.com/APITools/Curp/GenerarCurp', 'POST', JSON.stringify(PoblarCiudadano()));
      console.log(DatosCurp);
      console.log(ResultadoApi);
    }
});