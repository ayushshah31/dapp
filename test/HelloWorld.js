const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld", () => {
    it('Testing' , async()=>{
        const instance = await HelloWorld.deployed();
        await instance.setMessage('Hello AS');
        const message = await instance.message();
        assert(message === 'Hello AS');
    })
})