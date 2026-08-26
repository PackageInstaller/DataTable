-- chunkname: @modules/configs/excel2json/lua_assassin_quest_type.lua

module("modules.configs.excel2json.lua_assassin_quest_type", package.seeall)

local lua_assassin_quest_type = {}
local fields = {
	icon = 3,
	name = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	name = 1
}

function lua_assassin_quest_type.onLoad(json)
	lua_assassin_quest_type.configList, lua_assassin_quest_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_quest_type
