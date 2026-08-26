-- chunkname: @modules/configs/excel2json/lua_fight_wmz_timeline.lua

module("modules.configs.excel2json.lua_fight_wmz_timeline", package.seeall)

local lua_fight_wmz_timeline = {}
local fields = {
	id = 2,
	skin = 1,
	timeline = 3
}
local primaryKey = {
	"skin",
	"id"
}
local mlStringKey = {}

function lua_fight_wmz_timeline.onLoad(json)
	lua_fight_wmz_timeline.configList, lua_fight_wmz_timeline.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_wmz_timeline
