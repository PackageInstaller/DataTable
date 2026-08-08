local json = require("json")
local lfs = require("lfs")

function jsonToLua(jsonString)
    return json.decode(jsonString)
end

function processJsonFilesInDirectory(directory)
    for file in lfs.dir(directory) do
        if file ~= "." and file ~= ".." then
            local filePath = directory .. "/" .. file
            local attr = lfs.attributes(filePath)
            if attr.mode == "file" then
                if string.sub(file, -6) == ".bytes" then
                    local jsonFile = io.open(filePath, "r")
                    local jsonString = jsonFile:read("*a")
                    jsonFile:close()

                    local luaData = jsonToLua(jsonString)

                    local luaFileName = string.sub(file, 1, -6) .. "lua"
                    local luaFile = io.open(directory .. "/" .. luaFileName, "w")
                    luaFile:write("return ")
                    luaFile:write(table_dump(luaData))
                    luaFile:close()

                    print("Converted " .. file .. " to " .. luaFileName)
                end
            end
        end
    end
end

function table_dump(tbl, indent)
    indent = indent or 0
    local str = "{\n"
    for k, v in pairs(tbl) do
        local key = type(k) == "number" and "[" .. k .. "]" or k
        if type(v) == "table" then
            str = str .. string.rep("  ", indent+1) .. key .. " = " .. table_dump(v, indent + 1) .. ",\n"
        else
            if type(v) == "string" then
                str = str .. string.rep("  ", indent+1) .. key .. " = \"" .. tostring(v) .. "\",\n"
            else
                str = str .. string.rep("  ", indent+1) .. key .. " = " .. tostring(v) .. ",\n"
            end
        end
    end
    str = str .. string.rep("  ", indent) .. "}"
    return str
end

-- 指定目录路径
local directoryPath = "./"

processJsonFilesInDirectory(directoryPath)
