-- chunkname: @modules/configs/excel2json/lua_weekwalk_bonus.lua

module("modules.configs.excel2json.lua_weekwalk_bonus", package.seeall)

local lua_weekwalk_bonus = {}
local fields = {
	bonusId = 3,
	bonusGroup = 1,
	bonus = 2
}
local primaryKey = {
	"bonusGroup"
}
local mlStringKey = {}

function lua_weekwalk_bonus.onLoad(json)
	lua_weekwalk_bonus.configList, lua_weekwalk_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_bonus
