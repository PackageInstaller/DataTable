-- chunkname: @modules/configs/excel2json/lua_fight_appear_timeline_extend.lua

module("modules.configs.excel2json.lua_fight_appear_timeline_extend", package.seeall)

local lua_fight_appear_timeline_extend = {}
local fields = {
	groupId = 1,
	monsterIdList = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}

function lua_fight_appear_timeline_extend.onLoad(json)
	lua_fight_appear_timeline_extend.configList, lua_fight_appear_timeline_extend.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_appear_timeline_extend
