-- chunkname: @modules/configs/excel2json/lua_skill_bufftype.lua

module("modules.configs.excel2json.lua_skill_bufftype", package.seeall)

local lua_skill_bufftype = {}
local fields = {
	removeNum = 10,
	skipDelay = 11,
	dontShowFloat = 9,
	type = 2,
	includeTypes = 4,
	takeStage = 6,
	cannotRemove = 8,
	excludeTypes = 5,
	sortPriority = 15,
	takeAct = 7,
	matSort = 12,
	aniSort = 13,
	id = 1,
	playEffect = 14,
	group = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skill_bufftype.onLoad(json)
	lua_skill_bufftype.configList, lua_skill_bufftype.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_bufftype
