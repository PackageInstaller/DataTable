-- chunkname: @modules/configs/excel2json/lua_v2a1_activity101_moonfestivalsign.lua

module("modules.configs.excel2json.lua_v2a1_activity101_moonfestivalsign", package.seeall)

local lua_v2a1_activity101_moonfestivalsign = {}
local fields = {
	desc = 3,
	titile = 4,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	titile = 2,
	desc = 1
}

function lua_v2a1_activity101_moonfestivalsign.onLoad(json)
	lua_v2a1_activity101_moonfestivalsign.configList, lua_v2a1_activity101_moonfestivalsign.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a1_activity101_moonfestivalsign
