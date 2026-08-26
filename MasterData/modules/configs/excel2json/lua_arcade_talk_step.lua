-- chunkname: @modules/configs/excel2json/lua_arcade_talk_step.lua

module("modules.configs.excel2json.lua_arcade_talk_step", package.seeall)

local lua_arcade_talk_step = {}
local fields = {
	groupId = 1,
	block = 4,
	content = 3,
	step = 2
}
local primaryKey = {
	"groupId",
	"step"
}
local mlStringKey = {
	content = 1
}

function lua_arcade_talk_step.onLoad(json)
	lua_arcade_talk_step.configList, lua_arcade_talk_step.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_talk_step
