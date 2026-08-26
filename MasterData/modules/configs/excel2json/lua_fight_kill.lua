-- chunkname: @modules/configs/excel2json/lua_fight_kill.lua

module("modules.configs.excel2json.lua_fight_kill", package.seeall)

local lua_fight_kill = {}
local fields = {
	audio = 4,
	effect = 2,
	skinId = 1,
	effectHangPoint = 3,
	duration = 5,
	waitTime = 6
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_kill.onLoad(json)
	lua_fight_kill.configList, lua_fight_kill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_kill
