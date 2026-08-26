-- chunkname: @modules/configs/excel2json/lua_rouge_map_choice.lua

module("modules.configs.excel2json.lua_rouge_map_choice", package.seeall)

local lua_rouge_map_choice = {}
local fields = {
	groupId = 2,
	layerId = 1,
	dropId = 3
}
local primaryKey = {
	"layerId"
}
local mlStringKey = {}

function lua_rouge_map_choice.onLoad(json)
	lua_rouge_map_choice.configList, lua_rouge_map_choice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_map_choice
