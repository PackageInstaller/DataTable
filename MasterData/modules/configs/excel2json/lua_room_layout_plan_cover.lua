-- chunkname: @modules/configs/excel2json/lua_room_layout_plan_cover.lua

module("modules.configs.excel2json.lua_room_layout_plan_cover", package.seeall)

local lua_room_layout_plan_cover = {}
local fields = {
	id = 1,
	name = 2,
	coverResPath = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_room_layout_plan_cover.onLoad(json)
	lua_room_layout_plan_cover.configList, lua_room_layout_plan_cover.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_layout_plan_cover
