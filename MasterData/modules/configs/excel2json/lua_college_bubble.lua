-- chunkname: @modules/configs/excel2json/lua_college_bubble.lua

module("modules.configs.excel2json.lua_college_bubble", package.seeall)

local lua_college_bubble = {}
local fields = {
	text = 4,
	buildingId = 2,
	dailyPlayOnce = 6,
	id = 1,
	actorId = 3,
	weight = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1
}

function lua_college_bubble.onLoad(json)
	lua_college_bubble.configList, lua_college_bubble.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_bubble
