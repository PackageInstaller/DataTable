-- chunkname: @modules/configs/excel2json/lua_playercard_badge.lua

module("modules.configs.excel2json.lua_playercard_badge", package.seeall)

local lua_playercard_badge = {}
local fields = {
	id = 1,
	name = 2,
	taskId = 6,
	group = 4,
	icon = 3,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_playercard_badge.onLoad(json)
	lua_playercard_badge.configList, lua_playercard_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_playercard_badge
