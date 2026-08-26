-- chunkname: @modules/configs/excel2json/lua_activity217_bonus.lua

module("modules.configs.excel2json.lua_activity217_bonus", package.seeall)

local lua_activity217_bonus = {}
local fields = {
	extraBonus = 5,
	chapterId = 3,
	episodeType = 4,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {}

function lua_activity217_bonus.onLoad(json)
	lua_activity217_bonus.configList, lua_activity217_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity217_bonus
