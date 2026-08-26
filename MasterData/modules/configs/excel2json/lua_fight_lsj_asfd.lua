-- chunkname: @modules/configs/excel2json/lua_fight_lsj_asfd.lua

module("modules.configs.excel2json.lua_fight_lsj_asfd", package.seeall)

local lua_fight_lsj_asfd = {}
local fields = {
	action = 5,
	missileDelay = 6,
	spineRes = 2,
	missileOffset = 7,
	index = 1,
	duration = 4,
	pos = 3
}
local primaryKey = {
	"index"
}
local mlStringKey = {}

function lua_fight_lsj_asfd.onLoad(json)
	lua_fight_lsj_asfd.configList, lua_fight_lsj_asfd.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_lsj_asfd
