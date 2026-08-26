-- chunkname: @modules/configs/excel2json/lua_handbook_character_age.lua

module("modules.configs.excel2json.lua_handbook_character_age", package.seeall)

local lua_handbook_character_age = {}
local fields = {
	id = 1,
	image = 3,
	rewardIcon = 4,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_handbook_character_age.onLoad(json)
	lua_handbook_character_age.configList, lua_handbook_character_age.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_handbook_character_age
