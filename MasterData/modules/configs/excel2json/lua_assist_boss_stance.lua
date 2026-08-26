-- chunkname: @modules/configs/excel2json/lua_assist_boss_stance.lua

module("modules.configs.excel2json.lua_assist_boss_stance", package.seeall)

local lua_assist_boss_stance = {}
local fields = {
	sceneId = 2,
	position = 3,
	scale = 4,
	skinId = 1
}
local primaryKey = {
	"skinId",
	"sceneId"
}
local mlStringKey = {}

function lua_assist_boss_stance.onLoad(json)
	lua_assist_boss_stance.configList, lua_assist_boss_stance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assist_boss_stance
