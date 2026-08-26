-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_item.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_item", package.seeall)

local lua_activity_nuodika_180_item = {}
local fields = {
	itemId = 1,
	name = 2,
	canMove = 6,
	canEmpty = 7,
	skillID = 8,
	picture = 4,
	pictureOffset = 5,
	desc = 3
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity_nuodika_180_item.onLoad(json)
	lua_activity_nuodika_180_item.configList, lua_activity_nuodika_180_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_nuodika_180_item
