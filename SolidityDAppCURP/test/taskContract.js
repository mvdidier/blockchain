const TasksContract = artifacts.require("TasksContract");

contract("TasksContract", () => {

    before(async() => {
        this.tasksContract = await TasksContract.deployed();
    });

    it('migrate deployed successfully', async() => {
        const address = this.tasksContract.address

        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
        assert.notEqual(address, 0x0);
        assert.notEqual(address, "");
    });

    it('get Tasks List', async() => {
        const tasksCounter = await this.tasksContract.taskCounter()
        const task = await this.tasksContract.tasks(tasksCounter)

        assert.equal(task.id.toNumber(), tasksCounter);
        assert.equal(task.title, "Tarea de ejemplo");
        assert.equal(task.description, "Asignaciones bot");
        assert.equal(task.done, false);
        assert.equal(tasksCounter, 1);
    });

    it('task created successfuly', async() =>{
        const result = await this.tasksContract.createTask("Inv", "Redes privadas");
        const taskEvent = result.logs[0].args;
        const tasksCounter = await this.tasksContract.taskCounter();

        assert.equal(tasksCounter, 2);
        assert.equal(taskEvent.id.toNumber(), 2);
        assert.equal(taskEvent.title, "Inv");
        assert.equal(taskEvent.description, "Redes privadas");
        assert.equal(taskEvent.done, false);
    });

    it('Task toogle done', async() =>{
        const result = await this.tasksContract.toogleDone(1);
        const taskEvent = result.logs[0].args;
        const task = await this.tasksContract.tasks(1);

        assert.equal(task.done, true);
        assert.equal(taskEvent.done, true);
        assert.equal(taskEvent.id, 1);
    });
});