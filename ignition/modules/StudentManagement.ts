import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const StudentManagementModule = buildModule("StudentManagement", (m) => {
  const deploy = m.contract("StudentManagement");

  return { deploy };
});

export default StudentManagementModule;
