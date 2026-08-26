-- chunkname: @modules/configs/excel2json/lua_turnback_daily_bonus.lua

module("modules.configs.excel2json.lua_turnback_daily_bonus", package.seeall)

local lua_turnback_daily_bonus = {}
local fields = {
	bonus = 3,
	turnbackId = 1,
	day = 2
}
local primaryKey = {
	"turnbackId",
	"day"
}
local mlStringKey = {}

function lua_turnback_daily_bonus.onLoad(json)
	lua_turnback_daily_bonus.configList, lua_turnback_daily_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_daily_bonus
