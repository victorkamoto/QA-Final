import { expect } from "chai";
import { ethers } from "hardhat";
import { KethToken } from "../typechain-types";

describe("KethToken", function () {
  // We define a fixture to reuse the same setup in every test.

  let token: KethToken;
  before(async () => {
    const tokenFactory = await ethers.getContractFactory("KethToken");
    token = (await tokenFactory.deploy()) as KethToken;
    await token.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should have the right message on deploy", async function () {
      expect(await token.greeting()).to.equal("Keth token!!!");
    });
  });
});
