-- chunkname: @modules/configs/excel2json/lua_monster_skin_custom_click_box.lua

module("modules.configs.excel2json.lua_monster_skin_custom_click_box", package.seeall)

local lua_monster_skin_custom_click_box = {}
local fields = {
	box = 2,
	monsterSkinId = 1
}
local primaryKey = {
	"monsterSkinId"
}
local mlStringKey = {}

function lua_monster_skin_custom_click_box.onLoad(json)
	lua_monster_skin_custom_click_box.configList, lua_monster_skin_custom_click_box.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_skin_custom_click_box
