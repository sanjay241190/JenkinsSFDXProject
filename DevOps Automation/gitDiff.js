console.log("Test");
const exec = require('child_process').exec;
var fs = require("fs");

//console.log(rows.includes('acceptCase23.html'));

const myShellScript = exec('sh fetchfiles3.sh feature/0001 "2024-1-1 12:00:00"');
myShellScript.stdout.on('data', (data)=>{
    console.log(data); 
    // READ CSV INTO STRING
var commonComponentsData = fs.readFileSync("commonComponents.csv").toLocaleString();
//run command to oush modified files to modified.txt

var commonComponentsDataRow = commonComponentsData.split("\n"); // SPLIT ROWS
var modifiedComponentsData = fs.readFileSync("modified.txt").toLocaleString();
var modifiedComponentsDataRow = modifiedComponentsData.split("\n"); // SPLIT ROWS
for(const val of commonComponentsDataRow) {
    //if modified components are having common components
    if(modifiedComponentsDataRow.includes(val)){
        console.log('--' + val);
    }
}
    // do whatever you want here with data

});
myShellScript.stderr.on('data', (data)=>{
    console.error(data);
});