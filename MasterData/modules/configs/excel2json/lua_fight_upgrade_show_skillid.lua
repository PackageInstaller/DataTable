-- chunkname: @modules/configs/excel2json/lua_fight_upgrade_show_skillid.lua

module("modules.configs.excel2json.lua_fight_upgrade_show_skillid", package.seeall)

local lua_fight_upgrade_show_skillid = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_upgrade_show_skillid.onLoad(json)
	lua_fight_upgrade_show_skillid.configList, lua_fight_upgrade_show_skillid.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_upgrade_show_skillid
