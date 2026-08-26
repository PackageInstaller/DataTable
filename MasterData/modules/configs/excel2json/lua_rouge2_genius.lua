-- chunkname: @modules/configs/excel2json/lua_rouge2_genius.lua

module("modules.configs.excel2json.lua_rouge2_genius", package.seeall)

local lua_rouge2_genius = {}
local fields = {
	overviewText = 10,
	name = 2,
	icon = 6,
	talentType = 7,
	replaceId = 4,
	desc = 5,
	effects = 3,
	typeName = 9,
	id = 1,
	talentOrder = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	overviewText = 4,
	name = 1,
	typeName = 3,
	desc = 2
}

function lua_rouge2_genius.onLoad(json)
	lua_rouge2_genius.configList, lua_rouge2_genius.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_genius
