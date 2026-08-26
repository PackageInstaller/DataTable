-- chunkname: @modules/configs/excel2json/lua_equip_tag.lua

module("modules.configs.excel2json.lua_equip_tag", package.seeall)

local lua_equip_tag = {}
local fields = {
	id = 1,
	name = 2,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_equip_tag.onLoad(json)
	lua_equip_tag.configList, lua_equip_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_tag
