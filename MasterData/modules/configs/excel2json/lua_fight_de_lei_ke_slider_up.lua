-- chunkname: @modules/configs/excel2json/lua_fight_de_lei_ke_slider_up.lua

module("modules.configs.excel2json.lua_fight_de_lei_ke_slider_up", package.seeall)

local lua_fight_de_lei_ke_slider_up = {}
local fields = {
	audioId = 4,
	effectHang = 3,
	destroyTime = 5,
	effect = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_de_lei_ke_slider_up.onLoad(json)
	lua_fight_de_lei_ke_slider_up.configList, lua_fight_de_lei_ke_slider_up.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_de_lei_ke_slider_up
