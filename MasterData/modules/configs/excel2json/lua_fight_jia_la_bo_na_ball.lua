-- chunkname: @modules/configs/excel2json/lua_fight_jia_la_bo_na_ball.lua

module("modules.configs.excel2json.lua_fight_jia_la_bo_na_ball", package.seeall)

local lua_fight_jia_la_bo_na_ball = {}
local fields = {
	destroyBallEffect = 5,
	createBallEffect = 4,
	id = 1,
	buffTypeId = 2,
	ballEffect = 3
}
local primaryKey = {
	"id",
	"buffTypeId"
}
local mlStringKey = {}

function lua_fight_jia_la_bo_na_ball.onLoad(json)
	lua_fight_jia_la_bo_na_ball.configList, lua_fight_jia_la_bo_na_ball.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_jia_la_bo_na_ball
