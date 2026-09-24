-- chunkname: @modules/configs/excel2json/lua_team_recommend.lua

module("modules.configs.excel2json.lua_team_recommend", package.seeall)

local lua_team_recommend = {}
local fields = {
	pos3 = 5,
	pos1 = 3,
	pos2 = 4,
	teamName = 2,
	id = 1,
	pos4 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	teamName = 1
}

function lua_team_recommend.onLoad(json)
	lua_team_recommend.configList, lua_team_recommend.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_team_recommend
