-- chunkname: @modules/configs/excel2json/lua_odyssey_religion.lua

module("modules.configs.excel2json.lua_odyssey_religion", package.seeall)

local lua_odyssey_religion = {}
local fields = {
	tips = 7,
	name = 3,
	notExposeName = 6,
	type = 5,
	desc = 4,
	isBoss = 9,
	pos = 8,
	clueList = 2,
	elementId = 10,
	autoExpose = 12,
	id = 1,
	icon = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 5,
	name = 1,
	notExposeName = 4,
	type = 3,
	desc = 2
}

function lua_odyssey_religion.onLoad(json)
	lua_odyssey_religion.configList, lua_odyssey_religion.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_religion
