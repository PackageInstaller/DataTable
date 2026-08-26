-- chunkname: @modules/configs/excel2json/lua_activity235_preparation.lua

module("modules.configs.excel2json.lua_activity235_preparation", package.seeall)

local lua_activity235_preparation = {}
local fields = {
	buffdesc = 4,
	name = 2,
	unlockpara = 9,
	unlockdesc = 7,
	material = 3,
	buffpara = 6,
	buffcond = 5,
	id = 1,
	unlockcond = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	buffdesc = 1,
	unlockdesc = 2
}

function lua_activity235_preparation.onLoad(json)
	lua_activity235_preparation.configList, lua_activity235_preparation.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity235_preparation
