-- chunkname: @modules/configs/excel2json/lua_activity194_buff.lua

module("modules.configs.excel2json.lua_activity194_buff", package.seeall)

local lua_activity194_buff = {}
local fields = {
	effectDesc = 4,
	buffType = 2,
	buffId = 1,
	effectType = 3
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {
	effectDesc = 1
}

function lua_activity194_buff.onLoad(json)
	lua_activity194_buff.configList, lua_activity194_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_buff
