-- chunkname: @modules/configs/excel2json/lua_talent_style_cost.lua

module("modules.configs.excel2json.lua_talent_style_cost", package.seeall)

local lua_talent_style_cost = {}
local fields = {
	styleId = 2,
	heroId = 1,
	consume = 3
}
local primaryKey = {
	"heroId",
	"styleId"
}
local mlStringKey = {}

function lua_talent_style_cost.onLoad(json)
	lua_talent_style_cost.configList, lua_talent_style_cost.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_style_cost
