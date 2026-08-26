-- chunkname: @modules/configs/excel2json/lua_fight_skin_scale_by_z.lua

module("modules.configs.excel2json.lua_fight_skin_scale_by_z", package.seeall)

local lua_fight_skin_scale_by_z = {}
local fields = {
	posZ = 3,
	priority = 2,
	posXOffset = 5,
	id = 1,
	scale = 4
}
local primaryKey = {
	"id",
	"priority"
}
local mlStringKey = {}

function lua_fight_skin_scale_by_z.onLoad(json)
	lua_fight_skin_scale_by_z.configList, lua_fight_skin_scale_by_z.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_skin_scale_by_z
