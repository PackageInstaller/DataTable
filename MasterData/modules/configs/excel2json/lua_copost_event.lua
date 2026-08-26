-- chunkname: @modules/configs/excel2json/lua_copost_event.lua

module("modules.configs.excel2json.lua_copost_event", package.seeall)

local lua_copost_event = {}
local fields = {
	frontEventId = 2,
	eventTextId = 6,
	needchaText = 10,
	allTime = 8,
	chaId = 11,
	eventCoordinate = 4,
	reduceTime = 12,
	eventType = 3,
	charaProfile = 9,
	eventTitleId = 5,
	id = 1,
	chaNum = 7,
	bonus = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	needchaText = 2,
	eventTitleId = 1
}

function lua_copost_event.onLoad(json)
	lua_copost_event.configList, lua_copost_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_event
