-- chunkname: @modules/configs/excel2json/lua_survival_block.lua

module("modules.configs.excel2json.lua_survival_block", package.seeall)

local lua_survival_block = {}
local fields = {
	preAttrDesc = 10,
	name = 2,
	rotate = 7,
	grid = 6,
	resource = 5,
	preAttr = 9,
	subType = 4,
	copyIds = 3,
	id = 1,
	weight = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	preAttrDesc = 2,
	name = 1
}

function lua_survival_block.onLoad(json)
	lua_survival_block.configList, lua_survival_block.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_block
