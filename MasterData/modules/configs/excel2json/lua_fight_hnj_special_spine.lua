-- chunkname: @modules/configs/excel2json/lua_fight_hnj_special_spine.lua

module("modules.configs.excel2json.lua_fight_hnj_special_spine", package.seeall)

local lua_fight_hnj_special_spine = {}
local fields = {
	dieAudio = 16,
	dieAnimDuration = 13,
	skinId = 1,
	dieAnim = 12,
	bornAudio = 8,
	pos = 3,
	bornPoint = 7,
	bornEffect = 6,
	resPath = 2,
	effect = 10,
	dieDuration = 17,
	dieEffect = 14,
	bornDuration = 9,
	bornAnim = 4,
	hangPoint = 11,
	bornAnimDuration = 5,
	diePoint = 15
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_hnj_special_spine.onLoad(json)
	lua_fight_hnj_special_spine.configList, lua_fight_hnj_special_spine.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_hnj_special_spine
