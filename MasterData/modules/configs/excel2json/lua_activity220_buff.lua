-- chunkname: @modules/configs/excel2json/lua_activity220_buff.lua

module("modules.configs.excel2json.lua_activity220_buff", package.seeall)

local lua_activity220_buff = {}
local fields = {
	param = 7,
	lifeRule = 3,
	buffId = 1,
	type = 6,
	attriId = 5,
	icon = 8,
	lifeParam = 4,
	isShow = 2
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}

function lua_activity220_buff.onLoad(json)
	lua_activity220_buff.configList, lua_activity220_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_buff
