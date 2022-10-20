document.addEventListener("DOMContentLoaded", () => {
  App.init();
});

/**
 * Task form
 */
const taskForm = document.querySelector("#taskForm");

taskForm.addEventListener("submit", (e) => {
  e.preventDefault();
  const nombres = taskForm["nombres"].value;
  const apaterno = taskForm["apaterno"].value;
  const amaterno = taskForm["amaterno"].value;
  const fechaNacimiento = taskForm["fechaNacimiento"].value;
  const genero = taskForm["genero"].value;
  const estado = taskForm["estado"].value;
  App.createCurp(nombres, apaterno, amaterno, fechaNacimiento, genero, estado);
});

/*taskForm.addEventListener("submit", (e) => {
  e.preventDefault();
  const title = taskForm["title"].value;
  const description = taskForm["description"].value;
  //App.createTask(title, description);
  App.createTask(title, description);
});*/