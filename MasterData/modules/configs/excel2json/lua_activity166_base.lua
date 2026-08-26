-- chunkname: @modules/configs/excel2json/lua_activity166_base.lua

module("modules.configs.excel2json.lua_activity166_base", package.seeall)

local lua_activity166_base = {}
local fields = {
	talentId = 4,
	name = 5,
	desc = 6,
	level = 7,
	baseId = 2,
	strategy = 8,
	activityId = 1,
	episodeId = 3
}
local primaryKey = {
	"activityId",
	"baseId"
}
local mlStringKey = {
	strategy = 3,
	name = 1,
	desc = 2
}

function lua_activity166_base.onLoad(json)
	lua_activity166_base.configList, lua_activity166_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_base
