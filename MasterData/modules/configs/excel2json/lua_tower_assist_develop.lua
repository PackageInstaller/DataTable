-- chunkname: @modules/configs/excel2json/lua_tower_assist_develop.lua

module("modules.configs.excel2json.lua_tower_assist_develop", package.seeall)

local lua_tower_assist_develop = {}
local fields = {
	bossId = 1,
	passiveSkills = 5,
	talentPoint = 4,
	attribute = 3,
	extraRule = 6,
	level = 2
}
local primaryKey = {
	"bossId",
	"level"
}
local mlStringKey = {}

function lua_tower_assist_develop.onLoad(json)
	lua_tower_assist_develop.configList, lua_tower_assist_develop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_assist_develop
