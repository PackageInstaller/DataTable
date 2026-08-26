-- chunkname: @modules/configs/excel2json/lua_activity241_bonus.lua

module("modules.configs.excel2json.lua_activity241_bonus", package.seeall)

local lua_activity241_bonus = {}
local fields = {
	voteNum = 2,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"voteNum"
}
local mlStringKey = {}

function lua_activity241_bonus.onLoad(json)
	lua_activity241_bonus.configList, lua_activity241_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity241_bonus
