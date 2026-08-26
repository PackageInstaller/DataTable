-- chunkname: @modules/configs/excel2json/lua_racing_ultimate.lua

module("modules.configs.excel2json.lua_racing_ultimate", package.seeall)

local lua_racing_ultimate = {}
local fields = {
	energyType = 6,
	effect = 4,
	name = 3,
	live2DAnimation = 7,
	id = 1,
	racer = 2,
	energy = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_racing_ultimate.onLoad(json)
	lua_racing_ultimate.configList, lua_racing_ultimate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_ultimate
