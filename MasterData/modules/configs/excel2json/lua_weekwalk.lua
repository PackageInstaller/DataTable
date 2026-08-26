-- chunkname: @modules/configs/excel2json/lua_weekwalk.lua

module("modules.configs.excel2json.lua_weekwalk", package.seeall)

local lua_weekwalk = {}
local fields = {
	notCdHeroCount = 5,
	resIdRear = 11,
	preId = 3,
	type = 4,
	fightIdFront = 8,
	sceneId = 6,
	issueId = 7,
	resIdFront = 9,
	id = 1,
	fightIdRear = 10,
	layer = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk.onLoad(json)
	lua_weekwalk.configList, lua_weekwalk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk
