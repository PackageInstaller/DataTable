-- chunkname: @modules/configs/excel2json/lua_activity166_info_analy.lua

module("modules.configs.excel2json.lua_activity166_info_analy", package.seeall)

local lua_activity166_info_analy = {}
local fields = {
	content = 6,
	infoId = 2,
	consume = 4,
	stage = 3,
	activityId = 1,
	bonus = 5
}
local primaryKey = {
	"activityId",
	"infoId",
	"stage"
}
local mlStringKey = {
	content = 1
}

function lua_activity166_info_analy.onLoad(json)
	lua_activity166_info_analy.configList, lua_activity166_info_analy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_info_analy
