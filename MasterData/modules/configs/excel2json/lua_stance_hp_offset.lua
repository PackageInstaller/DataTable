-- chunkname: @modules/configs/excel2json/lua_stance_hp_offset.lua

module("modules.configs.excel2json.lua_stance_hp_offset", package.seeall)

local lua_stance_hp_offset = {}
local fields = {
	offsetPos8 = 9,
	offsetPos4 = 5,
	offsetPos1 = 2,
	offsetPos7 = 8,
	offsetPos3 = 4,
	id = 1,
	offsetPos5 = 6,
	offsetPos6 = 7,
	offsetPos2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_stance_hp_offset.onLoad(json)
	lua_stance_hp_offset.configList, lua_stance_hp_offset.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stance_hp_offset
