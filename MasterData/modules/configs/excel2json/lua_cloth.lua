-- chunkname: @modules/configs/excel2json/lua_cloth.lua

module("modules.configs.excel2json.lua_cloth", package.seeall)

local lua_cloth = {}
local fields = {
	name = 2,
	skinId = 5,
	id = 1,
	icon = 4,
	enname = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_cloth.onLoad(json)
	lua_cloth.configList, lua_cloth.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_cloth
