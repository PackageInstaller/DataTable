-- chunkname: @modules/configs/excel2json/lua_activity104_equip_tag.lua

module("modules.configs.excel2json.lua_activity104_equip_tag", package.seeall)

local lua_activity104_equip_tag = {}
local fields = {
	order = 5,
	name = 4,
	id = 2,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 2,
	desc = 1
}

function lua_activity104_equip_tag.onLoad(json)
	lua_activity104_equip_tag.configList, lua_activity104_equip_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_equip_tag
