-- chunkname: @modules/configs/excel2json/lua_activity176_dogtag.lua

module("modules.configs.excel2json.lua_activity176_dogtag", package.seeall)

local lua_activity176_dogtag = {}
local fields = {
	content4 = 6,
	content2 = 4,
	id = 2,
	content1 = 3,
	activityId = 1,
	content3 = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	content2 = 2,
	content1 = 1,
	content4 = 4,
	content3 = 3
}

function lua_activity176_dogtag.onLoad(json)
	lua_activity176_dogtag.configList, lua_activity176_dogtag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity176_dogtag
