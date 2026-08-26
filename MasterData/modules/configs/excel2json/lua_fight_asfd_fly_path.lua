-- chunkname: @modules/configs/excel2json/lua_fight_asfd_fly_path.lua

module("modules.configs.excel2json.lua_fight_asfd_fly_path", package.seeall)

local lua_fight_asfd_fly_path = {}
local fields = {
	flyDuration = 2,
	id = 1,
	lineType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_asfd_fly_path.onLoad(json)
	lua_fight_asfd_fly_path.configList, lua_fight_asfd_fly_path.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_asfd_fly_path
