-- chunkname: @modules/configs/excel2json/lua_racing_racer.lua

module("modules.configs.excel2json.lua_racing_racer", package.seeall)

local lua_racing_racer = {}
local fields = {
	id = 1,
	name = 2,
	wrongPercent = 15,
	desc1 = 19,
	skillPic = 16,
	baseSpeed = 5,
	pos = 13,
	baseAcceleration = 6,
	ultimateId = 17,
	pic = 9,
	img = 11,
	desc = 20,
	display = 22,
	cost = 18,
	powerSpeed = 3,
	team = 21,
	uiPic = 10,
	initialEffect = 8,
	maxSpeed = 7,
	dolphinPrefab = 14,
	difficult = 4,
	scale = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	team = 4,
	name = 1,
	desc = 3,
	desc1 = 2
}

function lua_racing_racer.onLoad(json)
	lua_racing_racer.configList, lua_racing_racer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_racer
