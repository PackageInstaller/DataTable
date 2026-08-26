-- chunkname: @modules/configs/excel2json/lua_survival_goods.lua

module("modules.configs.excel2json.lua_survival_goods", package.seeall)

local lua_survival_goods = {}
local fields = {
	id = 1,
	shopGroup = 2,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_goods.onLoad(json)
	lua_survival_goods.configList, lua_survival_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_goods
