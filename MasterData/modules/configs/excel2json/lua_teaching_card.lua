-- chunkname: @modules/configs/excel2json/lua_teaching_card.lua

module("modules.configs.excel2json.lua_teaching_card", package.seeall)

local lua_teaching_card = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_teaching_card.onLoad(json)
	lua_teaching_card.configList, lua_teaching_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_teaching_card
