-- chunkname: @modules/configs/excel2json/lua_arcade_buff.lua

module("modules.configs.excel2json.lua_arcade_buff", package.seeall)

local lua_arcade_buff = {}
local fields = {
	showPriority = 8,
	entityType = 5,
	addPassiveSkillId = 4,
	round = 6,
	effectName = 2,
	loopEffect = 10,
	gainEffect = 9,
	id = 1,
	notSubInRoundBegin = 7,
	effectParam = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_buff.onLoad(json)
	lua_arcade_buff.configList, lua_arcade_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_buff
