const { deploy } = require("@truffle/contract/lib/execute");

const TasksContract = artifacts.require("TasksContract.sol");
const libA = artifacts.require("./lib/Strings.sol");
const libB = artifacts.require("./lib/Integers.sol");

module.exports = function (deployer) {
  deployer.deploy(libA);
  deployer.deploy(libB);
  deployer.link(libA, TasksContract);
  deployer.link(libB, TasksContract);
  deployer.deploy(TasksContract);
};