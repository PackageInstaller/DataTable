--保存关卡信息为lua文件
local cjson = require "cjson"
-- for k, v in pairs(_G) do
-- 	print(k,v)
-- end

-- print("--------------------")
-- local ok, err = pcall(require, "aaa")
-- print(ok, err)
require "luaext"
function SaveLevelData(levelDataJson, savePath)
	local levelData = cjson.decode(levelDataJson)
	local path = string.format("%sLevel_%d.lua", savePath, levelData.levelData.levelNum)
	local file = io.open(path,"w")
	io.output(file)
	-- tablex.dumpSetting.ShowQuote = true
	tablex.dumpSetting.ShowIndex = false
	io.write("return " .. tablex.dump(levelData.levelData))
	io.close()
end

local itemsCombineTable = {}
function InitItemsCombineTable()
	itemsCombineTable = {}
end

function AddItemCombine(itemCombineJson)
	local itemCombine = cjson.decode(itemCombineJson)
	table.insert(itemsCombineTable, itemCombine)
end

function SaveItemsCombineData(savePath)
	local path = string.format("%sItemsCombineData.lua", savePath)
	local file = io.open(path,"w")
	io.output(file)
	-- tablex.dumpSetting.ShowQuote = true
	tablex.dumpSetting.ShowIndex = false
	io.write("return " .. tablex.dump(itemsCombineTable))
	io.close()
end