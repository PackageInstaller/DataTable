-- chunkname: @modules/configs/excel2json/lua_activity158_evaluate.lua

module("modules.configs.excel2json.lua_activity158_evaluate", package.seeall)

local lua_activity158_evaluate = {}
local fields = {
	id = 1,
	round = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity158_evaluate.onLoad(json)
	lua_activity158_evaluate.configList, lua_activity158_evaluate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity158_evaluate
