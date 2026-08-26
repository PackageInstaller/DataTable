-- chunkname: @modules/configs/excel2json/lua_fight_sp_500m_model.lua

module("modules.configs.excel2json.lua_fight_sp_500m_model", package.seeall)

local lua_fight_sp_500m_model = {}
local fields = {
	headIcon = 5,
	behind = 4,
	headIconName = 6,
	front = 2,
	monsterId = 1,
	center = 3
}
local primaryKey = {
	"monsterId"
}
local mlStringKey = {}

function lua_fight_sp_500m_model.onLoad(json)
	lua_fight_sp_500m_model.configList, lua_fight_sp_500m_model.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_500m_model
