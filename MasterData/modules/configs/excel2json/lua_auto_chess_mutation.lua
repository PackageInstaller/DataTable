-- chunkname: @modules/configs/excel2json/lua_auto_chess_mutation.lua

module("modules.configs.excel2json.lua_auto_chess_mutation", package.seeall)

local lua_auto_chess_mutation = {}
local fields = {
	name = 3,
	statusBuffId = 8,
	isOnline = 11,
	statusStyle = 7,
	sequence = 10,
	desc = 6,
	masterLibraryId = 4,
	skillId = 5,
	id = 1,
	icon = 9,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_auto_chess_mutation.onLoad(json)
	lua_auto_chess_mutation.configList, lua_auto_chess_mutation.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_mutation
