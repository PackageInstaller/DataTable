-- chunkname: @modules/configs/excel2json/lua_activity104_retail_new.lua

module("modules.configs.excel2json.lua_activity104_retail_new", package.seeall)

local lua_activity104_retail_new = {}
local fields = {
	level = 4,
	equipRareWeight = 5,
	retailEpisodeId = 2,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"retailEpisodeId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity104_retail_new.onLoad(json)
	lua_activity104_retail_new.configList, lua_activity104_retail_new.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_retail_new
