-- chunkname: @modules/configs/excel2json/lua_rouge2_quality.lua

module("modules.configs.excel2json.lua_rouge2_quality", package.seeall)

local lua_rouge2_quality = {}
local fields = {
	relicsColor = 5,
	name = 2,
	buffColor = 4,
	id = 1,
	rareColor = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge2_quality.onLoad(json)
	lua_rouge2_quality.configList, lua_rouge2_quality.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_quality
