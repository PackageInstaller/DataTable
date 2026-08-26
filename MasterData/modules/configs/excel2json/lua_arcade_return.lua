-- chunkname: @modules/configs/excel2json/lua_arcade_return.lua

module("modules.configs.excel2json.lua_arcade_return", package.seeall)

local lua_arcade_return = {}
local fields = {
	refundDesc = 6,
	coinCount = 4,
	preActivityId = 3,
	difficultyId = 2,
	activityId = 1,
	rewardLimit = 5
}
local primaryKey = {
	"activityId",
	"difficultyId"
}
local mlStringKey = {}

function lua_arcade_return.onLoad(json)
	lua_arcade_return.configList, lua_arcade_return.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_return
