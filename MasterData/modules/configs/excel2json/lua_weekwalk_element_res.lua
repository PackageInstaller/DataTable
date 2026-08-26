-- chunkname: @modules/configs/excel2json/lua_weekwalk_element_res.lua

module("modules.configs.excel2json.lua_weekwalk_element_res", package.seeall)

local lua_weekwalk_element_res = {}
local fields = {
	id = 1,
	res = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk_element_res.onLoad(json)
	lua_weekwalk_element_res.configList, lua_weekwalk_element_res.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_element_res
