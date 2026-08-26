-- chunkname: @modules/configs/excel2json/lua_soldier_chess.lua

module("modules.configs.excel2json.lua_soldier_chess", package.seeall)

local lua_soldier_chess = {}
local fields = {
	cost = 8,
	name = 2,
	defaultPower = 6,
	type = 4,
	sell = 7,
	skillId = 12,
	resZoom = 11,
	formationDisplays = 3,
	resPic = 9,
	id = 1,
	resModel = 10,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_soldier_chess.onLoad(json)
	lua_soldier_chess.configList, lua_soldier_chess.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_soldier_chess
