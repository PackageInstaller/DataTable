-- chunkname: @modules/configs/excel2json/lua_odyssey_fight_element.lua

module("modules.configs.excel2json.lua_odyssey_fight_element", package.seeall)

local lua_odyssey_fight_element = {}
local fields = {
	reward = 7,
	desc = 6,
	param = 3,
	type = 2,
	enemyLevel = 9,
	title = 5,
	episodeId = 4,
	randomDrop = 8,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_odyssey_fight_element.onLoad(json)
	lua_odyssey_fight_element.configList, lua_odyssey_fight_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_fight_element
