-- chunkname: @modules/configs/excel2json/lua_critter_tag_effect.lua

module("modules.configs.excel2json.lua_critter_tag_effect", package.seeall)

local lua_critter_tag_effect = {}
local fields = {
	catalogue = 3,
	target = 2,
	previewCondition = 5,
	type = 6,
	id = 1,
	parameter = 7,
	condition = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_critter_tag_effect.onLoad(json)
	lua_critter_tag_effect.configList, lua_critter_tag_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_tag_effect
