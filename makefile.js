const { exec } = require("child_process");
const { argv }  =  require('node:process')
const filename = argv[2]
const executeCommands = async (commands) => {
  for(const command of commands){
    const {name, cmdStr } = command
    await exec(cmdStr , (error, stdout, stderr) => {
      console.log('executing command: ',name)
      if (error) {
        console.log(`error: ${error.message}`);
        return;
      }
      if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
      }
      console.log(`stdout: ${stdout}`);
    })
  }
}
const commandObj = [
  {name: 'DASM Assembler', cmdStr: `C:\\dasm\\dasm.exe ${filename} -f3 -v0 -ocart.bin -lcart.lst -scart.sym`},
  {name: 'Stella', cmdStr:  `"C:\\Program Files\\Stella\\Stella.exe" cart.bin` }
]
executeCommands(commandObj)


