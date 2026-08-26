-- chunkname: @modules/configs/excel2json/lua_fight_eziozhuangbei_icon.lua

module("modules.configs.excel2json.lua_fight_eziozhuangbei_icon", package.seeall)

local lua_fight_eziozhuangbei_icon = {}
local fields = {
	weaponId = 1,
	name = 5,
	firsticon = 3,
	type = 2,
	secondicon = 4
}
local primaryKey = {
	"weaponId"
}
local mlStringKey = {
	name = 1
}

function lua_fight_eziozhuangbei_icon.onLoad(json)
	lua_fight_eziozhuangbei_icon.configList, lua_fight_eziozhuangbei_icon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_eziozhuangbei_icon
