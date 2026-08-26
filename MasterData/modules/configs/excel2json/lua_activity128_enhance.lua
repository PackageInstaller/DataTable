-- chunkname: @modules/configs/excel2json/lua_activity128_enhance.lua

module("modules.configs.excel2json.lua_activity128_enhance", package.seeall)

local lua_activity128_enhance = {}
local fields = {
	sort = 3,
	desc = 5,
	characterId = 2,
	activityId = 1,
	exchangeSkills = 4
}
local primaryKey = {
	"activityId",
	"characterId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity128_enhance.onLoad(json)
	lua_activity128_enhance.configList, lua_activity128_enhance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_enhance
