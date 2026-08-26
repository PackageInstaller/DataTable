-- chunkname: @modules/configs/excel2json/lua_activity191_node.lua

module("modules.configs.excel2json.lua_activity191_node", package.seeall)

local lua_activity191_node = {}
local fields = {
	selectNum = 4,
	ruleId = 1,
	random = 3,
	node = 2,
	desc = 5
}
local primaryKey = {
	"ruleId",
	"node"
}
local mlStringKey = {
	desc = 1
}

function lua_activity191_node.onLoad(json)
	lua_activity191_node.configList, lua_activity191_node.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_node
