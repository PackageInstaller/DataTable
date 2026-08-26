-- chunkname: @modules/configs/excel2json/lua_bgm_switch.lua

module("modules.configs.excel2json.lua_bgm_switch", package.seeall)

local lua_bgm_switch = {}
local fields = {
	itemId = 5,
	audioIntroduce = 9,
	audioNameEn = 8,
	audio = 2,
	audioName = 7,
	unlockCondition = 4,
	audioicon = 11,
	sort = 12,
	audioType = 13,
	isNonLoop = 16,
	isReport = 3,
	audioBg = 10,
	id = 1,
	audioEvaluates = 15,
	audioLength = 14,
	defaultUnlock = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	audioIntroduce = 2,
	audioEvaluates = 3,
	audioName = 1
}

function lua_bgm_switch.onLoad(json)
	lua_bgm_switch.configList, lua_bgm_switch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bgm_switch
