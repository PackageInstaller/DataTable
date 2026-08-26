-- chunkname: @modules/configs/excel2json/lua_survival_shelter.lua

module("modules.configs.excel2json.lua_survival_shelter", package.seeall)

local lua_survival_shelter = {}
local fields = {
	versions = 5,
	difficultLv = 3,
	maxNpcNum = 7,
	orderPosition = 9,
	shelterId = 4,
	npcPosition = 12,
	toward = 10,
	stormCenter = 13,
	stormArea = 14,
	mapId = 11,
	seasons = 2,
	id = 1,
	position = 8,
	shelterChange = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_shelter.onLoad(json)
	lua_survival_shelter.configList, lua_survival_shelter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shelter
