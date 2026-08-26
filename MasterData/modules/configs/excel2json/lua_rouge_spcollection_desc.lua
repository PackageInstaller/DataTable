-- chunkname: @modules/configs/excel2json/lua_rouge_spcollection_desc.lua

module("modules.configs.excel2json.lua_rouge_spcollection_desc", package.seeall)

local lua_rouge_spcollection_desc = {}
local fields = {
	descSimply = 6,
	conditionSimply = 5,
	effectId = 2,
	id = 1,
	condition = 3,
	desc = 4
}
local primaryKey = {
	"id",
	"effectId"
}
local mlStringKey = {
	conditionSimply = 3,
	descSimply = 4,
	condition = 1,
	desc = 2
}

function lua_rouge_spcollection_desc.onLoad(json)
	lua_rouge_spcollection_desc.configList, lua_rouge_spcollection_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_spcollection_desc
