-- chunkname: @modules/configs/excel2json/lua_racing_gift_group.lua

module("modules.configs.excel2json.lua_racing_gift_group", package.seeall)

local lua_racing_gift_group = {}
local fields = {
	group = 1,
	icon = 2,
	name = 3,
	desc = 4
}
local primaryKey = {
	"group"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_racing_gift_group.onLoad(json)
	lua_racing_gift_group.configList, lua_racing_gift_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_gift_group
