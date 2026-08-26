-- chunkname: @modules/configs/excel2json/lua_partygame_snatchplaid.lua

module("modules.configs.excel2json.lua_partygame_snatchplaid", package.seeall)

local lua_partygame_snatchplaid = {}
local fields = {
	showNum = 8,
	showCount = 7,
	answerTime = 5,
	stopTime = 4,
	settleTime = 6,
	num = 2,
	round = 1,
	showTime = 3
}
local primaryKey = {
	"round"
}
local mlStringKey = {}

function lua_partygame_snatchplaid.onLoad(json)
	lua_partygame_snatchplaid.configList, lua_partygame_snatchplaid.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_snatchplaid
