-- chunkname: @modules/configs/excel2json/lua_assassin_effect.lua

module("modules.configs.excel2json.lua_assassin_effect", package.seeall)

local lua_assassin_effect = {}
local fields = {
	resName = 2,
	duration = 3,
	id = 1,
	audioId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_assassin_effect.onLoad(json)
	lua_assassin_effect.configList, lua_assassin_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_effect
