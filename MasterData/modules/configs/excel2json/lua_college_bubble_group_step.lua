-- chunkname: @modules/configs/excel2json/lua_college_bubble_group_step.lua

module("modules.configs.excel2json.lua_college_bubble_group_step", package.seeall)

local lua_college_bubble_group_step = {}
local fields = {
	text = 4,
	name = 3,
	position = 7,
	chessPosition = 8,
	groupId = 1,
	actorId = 5,
	pos = 6,
	step = 2
}
local primaryKey = {
	"groupId",
	"step"
}
local mlStringKey = {
	text = 2,
	name = 1
}

function lua_college_bubble_group_step.onLoad(json)
	lua_college_bubble_group_step.configList, lua_college_bubble_group_step.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_bubble_group_step
