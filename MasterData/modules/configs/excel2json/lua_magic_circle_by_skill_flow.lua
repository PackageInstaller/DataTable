-- chunkname: @modules/configs/excel2json/lua_magic_circle_by_skill_flow.lua

module("modules.configs.excel2json.lua_magic_circle_by_skill_flow", package.seeall)

local lua_magic_circle_by_skill_flow = {}
local fields = {
	closeEffect = 6,
	enterTime = 3,
	posArr = 9,
	closeTime = 7,
	enterEffect = 2,
	enterAudio = 4,
	loopEffect = 5,
	id = 1,
	closeAudio = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_magic_circle_by_skill_flow.onLoad(json)
	lua_magic_circle_by_skill_flow.configList, lua_magic_circle_by_skill_flow.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_magic_circle_by_skill_flow
