-- chunkname: @modules/configs/excel2json/lua_atomic_fight_element.lua

module("modules.configs.excel2json.lua_atomic_fight_element", package.seeall)

local lua_atomic_fight_element = {}
local fields = {
	showType = 3,
	id = 1,
	param = 4,
	type = 2,
	desc = 9,
	title = 8,
	reward = 10,
	episodeId = 5,
	randomEpisodeIds = 6,
	roundWarning = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_atomic_fight_element.onLoad(json)
	lua_atomic_fight_element.configList, lua_atomic_fight_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_fight_element
