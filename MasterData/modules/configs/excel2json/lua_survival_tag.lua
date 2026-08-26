-- chunkname: @modules/configs/excel2json/lua_survival_tag.lua

module("modules.configs.excel2json.lua_survival_tag", package.seeall)

local lua_survival_tag = {}
local fields = {
	tagType = 5,
	name = 2,
	effect = 6,
	color = 7,
	id = 1,
	suggestMap = 8,
	beHidden = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_tag.onLoad(json)
	lua_survival_tag.configList, lua_survival_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_tag
