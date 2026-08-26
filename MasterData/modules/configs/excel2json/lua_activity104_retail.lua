-- chunkname: @modules/configs/excel2json/lua_activity104_retail.lua

module("modules.configs.excel2json.lua_activity104_retail", package.seeall)

local lua_activity104_retail = {}
local fields = {
	retailEpisodeIdPool = 3,
	equipRareWeight = 6,
	activityId = 1,
	stage = 2,
	enemyTag = 4,
	level = 5
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {
	enemyTag = 1
}

function lua_activity104_retail.onLoad(json)
	lua_activity104_retail.configList, lua_activity104_retail.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_retail
