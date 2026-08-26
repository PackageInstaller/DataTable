-- chunkname: @modules/configs/excel2json/lua_fight_timeline_speed.lua

module("modules.configs.excel2json.lua_fight_timeline_speed", package.seeall)

local lua_fight_timeline_speed = {}
local fields = {
	speed = 2,
	timeline = 1
}
local primaryKey = {
	"timeline"
}
local mlStringKey = {}

function lua_fight_timeline_speed.onLoad(json)
	lua_fight_timeline_speed.configList, lua_fight_timeline_speed.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_timeline_speed
