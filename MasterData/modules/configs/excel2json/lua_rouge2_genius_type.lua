-- chunkname: @modules/configs/excel2json/lua_rouge2_genius_type.lua

module("modules.configs.excel2json.lua_rouge2_genius_type", package.seeall)

local lua_rouge2_genius_type = {}
local fields = {
	pointCost = 4,
	talent = 1,
	geniusId = 2,
	careerExp = 3,
	order = 5
}
local primaryKey = {
	"talent",
	"geniusId"
}
local mlStringKey = {}

function lua_rouge2_genius_type.onLoad(json)
	lua_rouge2_genius_type.configList, lua_rouge2_genius_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_genius_type
