-- chunkname: @modules/configs/excel2json/lua_activity123_equip_tag.lua

module("modules.configs.excel2json.lua_activity123_equip_tag", package.seeall)

local lua_activity123_equip_tag = {}
local fields = {
	id = 2,
	order = 4,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity123_equip_tag.onLoad(json)
	lua_activity123_equip_tag.configList, lua_activity123_equip_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_equip_tag
