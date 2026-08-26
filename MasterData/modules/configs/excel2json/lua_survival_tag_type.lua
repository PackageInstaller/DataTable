-- chunkname: @modules/configs/excel2json/lua_survival_tag_type.lua

module("modules.configs.excel2json.lua_survival_tag_type", package.seeall)

local lua_survival_tag_type = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_survival_tag_type.onLoad(json)
	lua_survival_tag_type.configList, lua_survival_tag_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_tag_type
