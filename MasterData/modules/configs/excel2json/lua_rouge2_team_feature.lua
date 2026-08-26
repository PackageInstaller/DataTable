-- chunkname: @modules/configs/excel2json/lua_rouge2_team_feature.lua

module("modules.configs.excel2json.lua_rouge2_team_feature", package.seeall)

local lua_rouge2_team_feature = {}
local fields = {
	id = 1,
	name = 2,
	skill = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge2_team_feature.onLoad(json)
	lua_rouge2_team_feature.configList, lua_rouge2_team_feature.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_team_feature
