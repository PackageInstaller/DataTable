-- chunkname: @modules/configs/excel2json/lua_rouge_genius_overview.lua

module("modules.configs.excel2json.lua_rouge_genius_overview", package.seeall)

local lua_rouge_genius_overview = {}
local fields = {
	name = 2,
	ismul = 4,
	id = 1,
	value = 3,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_genius_overview.onLoad(json)
	lua_rouge_genius_overview.configList, lua_rouge_genius_overview.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_genius_overview
