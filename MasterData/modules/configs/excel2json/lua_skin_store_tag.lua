-- chunkname: @modules/configs/excel2json/lua_skin_store_tag.lua

module("modules.configs.excel2json.lua_skin_store_tag", package.seeall)

local lua_skin_store_tag = {}
local fields = {
	id = 1,
	color = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_skin_store_tag.onLoad(json)
	lua_skin_store_tag.configList, lua_skin_store_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_store_tag
