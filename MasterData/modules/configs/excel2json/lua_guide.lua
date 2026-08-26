-- chunkname: @modules/configs/excel2json/lua_guide.lua

module("modules.configs.excel2json.lua_guide", package.seeall)

local lua_guide = {}
local fields = {
	id = 1,
	priority = 7,
	isOnline = 3,
	trigger = 4,
	desc = 2,
	invalid = 5,
	parallel = 8,
	restart = 9,
	interruptFinish = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_guide.onLoad(json)
	lua_guide.configList, lua_guide.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_guide
