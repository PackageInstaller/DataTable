-- chunkname: @modules/configs/excel2json/lua_fight_jia_la_bo_na_ball_audio.lua

module("modules.configs.excel2json.lua_fight_jia_la_bo_na_ball_audio", package.seeall)

local lua_fight_jia_la_bo_na_ball_audio = {}
local fields = {
	id = 1,
	createBallAudio = 2,
	destroyBallAudio = 3,
	moveBallAudio = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_jia_la_bo_na_ball_audio.onLoad(json)
	lua_fight_jia_la_bo_na_ball_audio.configList, lua_fight_jia_la_bo_na_ball_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_jia_la_bo_na_ball_audio
