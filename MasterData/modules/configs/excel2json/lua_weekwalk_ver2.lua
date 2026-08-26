-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2.lua

module("modules.configs.excel2json.lua_weekwalk_ver2", package.seeall)

local lua_weekwalk_ver2 = {}
local fields = {
	chooseSkillNum = 10,
	resIdRear = 9,
	preId = 4,
	fightIdFront = 6,
	sceneId = 5,
	issueId = 3,
	resIdFront = 7,
	id = 1,
	fightIdRear = 8,
	layer = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk_ver2.onLoad(json)
	lua_weekwalk_ver2.configList, lua_weekwalk_ver2.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_ver2
