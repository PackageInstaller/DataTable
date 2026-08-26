-- chunkname: @modules/configs/excel2json/lua_fight_replace_timeline.lua

module("modules.configs.excel2json.lua_fight_replace_timeline", package.seeall)

local lua_fight_replace_timeline = {}
local fields = {
	condition = 6,
	priority = 3,
	timeline = 2,
	id = 1,
	target = 4,
	simulate = 5
}
local primaryKey = {
	"id",
	"timeline"
}
local mlStringKey = {}

function lua_fight_replace_timeline.onLoad(json)
	lua_fight_replace_timeline.configList, lua_fight_replace_timeline.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_replace_timeline
