-- chunkname: @modules/configs/excel2json/lua_bbs_main.lua

module("modules.configs.excel2json.lua_bbs_main", package.seeall)

local lua_bbs_main = {}
local fields = {
	decs = 7,
	name = 5,
	date = 6,
	type = 3,
	bbsName = 10,
	image = 8,
	citeStep = 9,
	ipAdress = 11,
	trigger = 12,
	triggerDecs = 13,
	id = 1,
	activityId = 2,
	step = 4
}
local primaryKey = {
	"id",
	"activityId",
	"step"
}
local mlStringKey = {
	triggerDecs = 5,
	name = 1,
	date = 2,
	bbsName = 4,
	decs = 3
}

function lua_bbs_main.onLoad(json)
	lua_bbs_main.configList, lua_bbs_main.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bbs_main
