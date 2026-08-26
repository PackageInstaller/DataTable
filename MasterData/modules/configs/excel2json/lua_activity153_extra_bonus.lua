-- chunkname: @modules/configs/excel2json/lua_activity153_extra_bonus.lua

module("modules.configs.excel2json.lua_activity153_extra_bonus", package.seeall)

local lua_activity153_extra_bonus = {}
local fields = {
	chapterId = 3,
	extraBonus = 4,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {}

function lua_activity153_extra_bonus.onLoad(json)
	lua_activity153_extra_bonus.configList, lua_activity153_extra_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity153_extra_bonus
