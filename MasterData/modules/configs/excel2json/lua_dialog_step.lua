-- chunkname: @modules/configs/excel2json/lua_dialog_step.lua

module("modules.configs.excel2json.lua_dialog_step", package.seeall)

local lua_dialog_step = {}
local fields = {
	id = 2,
	name = 5,
	avatar = 6,
	type = 3,
	groupId = 1,
	chessId = 7,
	content = 4
}
local primaryKey = {
	"groupId",
	"id"
}
local mlStringKey = {
	content = 1,
	name = 2
}

function lua_dialog_step.onLoad(json)
	lua_dialog_step.configList, lua_dialog_step.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dialog_step
