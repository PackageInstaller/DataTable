-- chunkname: @modules/configs/excel2json/lua_rouge_illustration_list.lua

module("modules.configs.excel2json.lua_rouge_illustration_list", package.seeall)

local lua_rouge_illustration_list = {}
local fields = {
	nameEn = 5,
	name = 4,
	eventId = 9,
	fullImage = 8,
	season = 1,
	image = 7,
	desc = 6,
	dlc = 10,
	id = 2,
	order = 3
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_illustration_list.onLoad(json)
	lua_rouge_illustration_list.configList, lua_rouge_illustration_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_illustration_list
