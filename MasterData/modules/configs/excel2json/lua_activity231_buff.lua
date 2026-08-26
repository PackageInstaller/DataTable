-- chunkname: @modules/configs/excel2json/lua_activity231_buff.lua

module("modules.configs.excel2json.lua_activity231_buff", package.seeall)

local lua_activity231_buff = {}
local fields = {
	id = 1,
	name = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity231_buff.onLoad(json)
	lua_activity231_buff.configList, lua_activity231_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_buff
