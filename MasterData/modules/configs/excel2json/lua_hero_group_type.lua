-- chunkname: @modules/configs/excel2json/lua_hero_group_type.lua

module("modules.configs.excel2json.lua_hero_group_type", package.seeall)

local lua_hero_group_type = {}
local fields = {
	saveGroup = 4,
	name = 2,
	chapterIds = 3,
	id = 1,
	changeForbiddenEpisode = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_hero_group_type.onLoad(json)
	lua_hero_group_type.configList, lua_hero_group_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_group_type
