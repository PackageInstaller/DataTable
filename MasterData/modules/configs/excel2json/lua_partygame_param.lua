-- chunkname: @modules/configs/excel2json/lua_partygame_param.lua

module("modules.configs.excel2json.lua_partygame_param", package.seeall)

local lua_partygame_param = {}
local fields = {
	focus = 10,
	name = 3,
	camera = 9,
	moveSpeed = 8,
	online = 2,
	envMusic = 17,
	limitTime = 20,
	desc = 4,
	envMusicStop = 18,
	helpId = 19,
	sceneAssetId = 5,
	playerPos = 15,
	isFocusPlayer = 11,
	posIndexLock = 13,
	roleCol = 21,
	openLog = 22,
	bgmId = 16,
	canTeam = 6,
	focusLimit = 12,
	id = 1,
	gameTime = 14,
	weight = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_partygame_param.onLoad(json)
	lua_partygame_param.configList, lua_partygame_param.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_param
