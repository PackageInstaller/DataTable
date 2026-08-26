-- chunkname: @modules/configs/excel2json/lua_odyssey_myth.lua

module("modules.configs.excel2json.lua_odyssey_myth", package.seeall)

local lua_odyssey_myth = {}
local fields = {
	elementId = 4,
	res = 3,
	name = 2,
	pos = 6,
	id = 1,
	unlockMap = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_odyssey_myth.onLoad(json)
	lua_odyssey_myth.configList, lua_odyssey_myth.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_myth
