-- chunkname: @modules/configs/excel2json/lua_auto_chess_buff.lua

module("modules.configs.excel2json.lua_auto_chess_buff", package.seeall)

local lua_auto_chess_buff = {}
local fields = {
	durationDeduction = 7,
	effect = 4,
	triggerPoint = 3,
	type = 5,
	buffeffectID = 8,
	condition = 2,
	id = 1,
	cover = 6,
	downline = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_buff.onLoad(json)
	lua_auto_chess_buff.configList, lua_auto_chess_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_buff
