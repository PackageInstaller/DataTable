-- chunkname: @modules/configs/excel2json/lua_fight_skin_replace_magic_effect.lua

module("modules.configs.excel2json.lua_fight_skin_replace_magic_effect", package.seeall)

local lua_fight_skin_replace_magic_effect = {}
local fields = {
	closeEffect = 7,
	enterTime = 4,
	skinId = 2,
	closeTime = 8,
	enterEffect = 3,
	enterAudio = 5,
	posArr = 11,
	loopEffect = 6,
	id = 1,
	closeAudio = 10,
	closeAniName = 9
}
local primaryKey = {
	"id",
	"skinId"
}
local mlStringKey = {}

function lua_fight_skin_replace_magic_effect.onLoad(json)
	lua_fight_skin_replace_magic_effect.configList, lua_fight_skin_replace_magic_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_skin_replace_magic_effect
