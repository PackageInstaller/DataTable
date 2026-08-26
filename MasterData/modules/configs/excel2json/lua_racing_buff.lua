-- chunkname: @modules/configs/excel2json/lua_racing_buff.lua

module("modules.configs.excel2json.lua_racing_buff", package.seeall)

local lua_racing_buff = {}
local fields = {
	kind = 2,
	prefab = 7,
	time = 4,
	anim = 9,
	includeTypes = 5,
	typeId = 3,
	icon = 10,
	camera = 8,
	id = 1,
	features = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_racing_buff.onLoad(json)
	lua_racing_buff.configList, lua_racing_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_buff
