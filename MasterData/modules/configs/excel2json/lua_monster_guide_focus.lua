-- chunkname: @modules/configs/excel2json/lua_monster_guide_focus.lua

module("modules.configs.excel2json.lua_monster_guide_focus", package.seeall)

local lua_monster_guide_focus = {}
local fields = {
	param = 3,
	invokeType = 2,
	completeWithGroup = 5,
	isActivityVersion = 7,
	id = 1,
	icon = 6,
	monster = 4,
	des = 8
}
local primaryKey = {
	"id",
	"invokeType",
	"param",
	"monster"
}
local mlStringKey = {
	des = 1
}

function lua_monster_guide_focus.onLoad(json)
	lua_monster_guide_focus.configList, lua_monster_guide_focus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_guide_focus
