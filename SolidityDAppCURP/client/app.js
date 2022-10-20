App = {
  contracts: {},
  init: async () => {
    await App.loadWeb3();
    await App.loadAccount();
    await App.loadContract();
    await App.render();
    await App.renderTasks();
  },
  loadWeb3: async () => {
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      await window.ethereum.request({ method: "eth_requestAccounts" });
    } else if (web3) {
      web3 = new Web3(window.web3.currentProvider);
    } else {
      console.log(
        "No ethereum browser is installed. Try it installing MetaMask "
      );
    }
  },
  loadAccount: async () => {
    const accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    App.account = accounts[0];
  },
  loadContract: async () => {
    try {
      const res = await fetch("TasksContract.json");
      const tasksContractJSON = await res.json();
      App.contracts.TasksContract = TruffleContract(tasksContractJSON);
      App.contracts.TasksContract.setProvider(App.web3Provider);

      App.tasksContract = await App.contracts.TasksContract.deployed();
    } catch (error) {
      console.error(error);
    }
  },
  render: async () => {
    document.getElementById("account").innerText = App.account;
  },
  renderTasks: async () => {
    const tasksCounter = await App.tasksContract.tasksCounter();
    const taskCounterNumber = tasksCounter.toNumber();

    let html = "";

    for (let i = 1; i <= taskCounterNumber; i++) {
      const task = await App.tasksContract.tasks(i);
      const taskId = task[0].toNumber();
      const _nombres = task[1];
      const _apaterno = task[2];
      const _amaterno = task[3];
      const _fechaNacimiento = task[4];
      const _genero = task[5];
      const _estado = task[6];
      const _curp = task[7];
      const taskDone = task[8];
      const taskCreatedAt = task[9];

      // Creating a task Card
      let taskElement = `<div class="card bg-dark rounded-0 mb-2">
        <div class="card-header d-flex justify-content-between align-items-center">
          <span>${_curp}</span>
          <div class="form-check form-switch">
            <input class="form-check-input" data-id="${taskId}" type="checkbox" onchange="App.toggleDone(this)" ${
              taskDone === true && "checked"
            }>
          </div>
        </div>
        <div class="card-body">
          <span>${"Datos de consulta"}</span>
          <span>${_nombres}</span>
          <span>${_apaterno}</span>
          <span>${_amaterno}</span>
          <span>${_fechaNacimiento}</span>
          <p class="text-muted">Creado el ${new Date(
            taskCreatedAt * 1000
          ).toLocaleString()}</p>
          </label>
        </div>
      </div>`;
        html += taskElement;
    }

    document.querySelector("#tasksList").innerHTML = html;
  },
  createTask: async (title, description) => {
    try {
      const result = await App.tasksContract.createTask(title, description,{
      //createTask(title, description, {
        from: App.account,
      });
      console.log(result.logs[0].args);
      window.location.reload();
    } catch (error) {
      console.error(error);
    }
  },

  createCurp: async (nombres, apaterno, amaterno, fechaNacimiento, genero, estado) => {
    try {
      const result = await App.tasksContract.createTask(nombres, apaterno, amaterno, fechaNacimiento, genero, estado,{
      //createTask(title, description, {
        from: App.account,
      });
      console.log(result.logs[0].args);
      window.location.reload();
    } catch (error) {
      console.error(error);
    }
  },



  //Función nueva para crear un curp
  /*createCurp: async (nombres, apaterno, amaterno, fechaNacimiento, genero, estado) => {
    try {
      const result = await App.tasksContract.GenerarCurp(nombres, apaterno, amaterno, fechaNacimiento, genero, estado, {
        from: App.account,
      });
      console.log(result.logs[0].args);
      window.location.reload();
    } catch (error) {
      console.error(error);
    }
  },*/

  toggleDone: async (element) => {
    const taskId = element.dataset.id;
    await App.tasksContract.toggleDone(taskId, {
      from: App.account,
    });
    window.location.reload();
  },
};