-- chunkname: @modules/configs/excel2json/lua_college_event.lua

module("modules.configs.excel2json.lua_college_event", package.seeall)

local lua_college_event = {}
local fields = {
	title = 2,
	optionIds = 5,
	body = 3,
	id = 1,
	artAsset = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	body = 2,
	title = 1
}

function lua_college_event.onLoad(json)
	lua_college_event.configList, lua_college_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_event
