-- chunkname: @modules/configs/excel2json/lua_rouge2_result_assess.lua

module("modules.configs.excel2json.lua_rouge2_result_assess", package.seeall)

local lua_rouge2_result_assess = {}
local fields = {
	spriteName = 3,
	needScore = 2,
	spriteBgName = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_rouge2_result_assess.onLoad(json)
	lua_rouge2_result_assess.configList, lua_rouge2_result_assess.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_result_assess
