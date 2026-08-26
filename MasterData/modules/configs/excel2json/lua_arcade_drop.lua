-- chunkname: @modules/configs/excel2json/lua_arcade_drop.lua

module("modules.configs.excel2json.lua_arcade_drop", package.seeall)

local lua_arcade_drop = {}
local fields = {
	id = 1,
	characterunlock = 4,
	resourcedrop = 2,
	collectiondrop = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_drop.onLoad(json)
	lua_arcade_drop.configList, lua_arcade_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_drop
