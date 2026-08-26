-- chunkname: @modules/configs/excel2json/lua_activity130_decrypt.lua

module("modules.configs.excel2json.lua_activity130_decrypt", package.seeall)

local lua_activity130_decrypt = {}
local fields = {
	puzzleType = 6,
	operGroupId = 4,
	puzzleMapId = 3,
	maxStep = 9,
	extStarDesc = 13,
	errorTip = 10,
	maxOper = 8,
	extStarCondition = 12,
	puzzleTip = 11,
	answer = 7,
	puzzleTxt = 5,
	activityId = 1,
	puzzleId = 2
}
local primaryKey = {
	"activityId",
	"puzzleId"
}
local mlStringKey = {
	extStarDesc = 2,
	puzzleTxt = 1
}

function lua_activity130_decrypt.onLoad(json)
	lua_activity130_decrypt.configList, lua_activity130_decrypt.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity130_decrypt
