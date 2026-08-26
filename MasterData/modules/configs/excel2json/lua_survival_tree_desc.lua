-- chunkname: @modules/configs/excel2json/lua_survival_tree_desc.lua

module("modules.configs.excel2json.lua_survival_tree_desc", package.seeall)

local lua_survival_tree_desc = {}
local fields = {
	nodeId = 2,
	result = 6,
	id = 1,
	icon = 4,
	condition = 5,
	desc = 3
}
local primaryKey = {
	"id",
	"nodeId"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_tree_desc.onLoad(json)
	lua_survival_tree_desc.configList, lua_survival_tree_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_tree_desc
