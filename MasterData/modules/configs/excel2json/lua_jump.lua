-- chunkname: @modules/configs/excel2json/lua_jump.lua

module("modules.configs.excel2json.lua_jump", package.seeall)

local lua_jump = {}
local fields = {
	id = 1,
	name = 2,
	param = 4,
	openId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_jump.onLoad(json)
	lua_jump.configList, lua_jump.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_jump
