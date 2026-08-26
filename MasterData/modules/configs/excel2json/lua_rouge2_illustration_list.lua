-- chunkname: @modules/configs/excel2json/lua_rouge2_illustration_list.lua

module("modules.configs.excel2json.lua_rouge2_illustration_list", package.seeall)

local lua_rouge2_illustration_list = {}
local fields = {
	nameEn = 6,
	name = 3,
	fullImage = 9,
	type = 5,
	eventId = 10,
	image = 8,
	desc = 7,
	nameOther = 4,
	id = 1,
	eventAttribute = 11,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameOther = 2,
	name = 1,
	desc = 3
}

function lua_rouge2_illustration_list.onLoad(json)
	lua_rouge2_illustration_list.configList, lua_rouge2_illustration_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_illustration_list
