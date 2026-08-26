-- chunkname: @modules/configs/excel2json/lua_fight_anan_focus_timeline.lua

module("modules.configs.excel2json.lua_fight_anan_focus_timeline", package.seeall)

local lua_fight_anan_focus_timeline = {}
local fields = {
	id = 1,
	timeline = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_anan_focus_timeline.onLoad(json)
	lua_fight_anan_focus_timeline.configList, lua_fight_anan_focus_timeline.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_anan_focus_timeline
