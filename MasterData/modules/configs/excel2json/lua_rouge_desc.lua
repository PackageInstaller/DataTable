-- chunkname: @modules/configs/excel2json/lua_rouge_desc.lua

module("modules.configs.excel2json.lua_rouge_desc", package.seeall)

local lua_rouge_desc = {}
local fields = {
	descExtra = 6,
	name = 2,
	descType = 5,
	effectId = 3,
	id = 1,
	descSimply = 7,
	descExtraSimply = 8,
	desc = 4
}
local primaryKey = {
	"id",
	"effectId"
}
local mlStringKey = {
	descExtra = 3,
	descSimply = 4,
	name = 1,
	descExtraSimply = 5,
	desc = 2
}

function lua_rouge_desc.onLoad(json)
	lua_rouge_desc.configList, lua_rouge_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_desc
