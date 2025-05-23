if (process.argv.length <= 2){
    console.log("Input QMK json file")
    return
}

const filename = process.argv[2]

const fs = require("node:fs");
fs.readFile(filename, "utf8", (err, data)=>{
    if (err) {
        console.log(err)
    } else {
        let bruh = JSON.parse(data)
        bruh.layers.map((layer) => {return mirror(layer)})
        fs.writeFile(`left_mirrored.json`, JSON.stringify(bruh), 'utf8', ()=>{})
    }
})

function mirror(curr_layer ){
    for (let idx = 0; idx < curr_layer.length; idx++){
        if (idx < 36){
            const row_len = 12
            const row = Math.floor(idx/row_len)
            const col = idx % row_len
            const opp = ((row + 1) * row_len) - col - 1;

            if (col >= Math.floor(row_len/2)){
                idx += (row_len/2) - 1
                continue
            }

            const temp = curr_layer[idx]
            curr_layer[idx] = curr_layer[opp]
            curr_layer[opp] = temp

            continue
        }

        if (idx < 50){
            const row_len = 14
            const col = idx-36
            const opp = 50 - col - 1;

            if (col >= Math.floor(row_len/2)){
                idx += (row_len/2) - 1
                continue
            }

            const temp = curr_layer[idx]
            curr_layer[idx] = curr_layer[opp]
            curr_layer[opp] = temp

            continue
        }

        //else
        const row_len = 6
        const col = idx - 50
        const opp = 56 - col - 1;

        if (col >= Math.floor(row_len/2)){
            idx += (row_len/2) - 1
            continue
        }

        const temp = curr_layer[idx]
        curr_layer[idx] = curr_layer[opp]
        curr_layer[opp] = temp
    }
    return curr_layer
}

function debug(layer){
    console.log(layer.slice(0, 6).join("  "), "                          ", layer.slice(6, 12).join("  "))
    console.log(layer.slice(12, 18).join("  "), "                            ", layer.slice(18, 24).join("  "))
    console.log(layer.slice(24, 30).join("  "), "                          ", layer.slice(30, 36).join("  "))
    console.log(layer.slice(36, 43).join("  "), "          ", layer.slice(43, 50).join("  "))
    console.log("                        ", layer.slice(50, 53).join("  "), "    ", layer.slice(53, 56).join("  "))
    console.log("\n\n\n")
}
