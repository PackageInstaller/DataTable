-- chunkname: @modules/configs/excel2json/lua_weekwalk_buff.lua

module("modules.configs.excel2json.lua_weekwalk_buff", package.seeall)

local lua_weekwalk_buff = {}
local fields = {
	param = 4,
	name = 7,
	rare = 9,
	type = 3,
	preBuff = 5,
	desc = 8,
	replaceBuff = 6,
	id = 1,
	icon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_weekwalk_buff.onLoad(json)
	lua_weekwalk_buff.configList, lua_weekwalk_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_buff
