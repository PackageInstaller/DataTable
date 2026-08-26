-- chunkname: @modules/configs/excel2json/lua_turnback_submodule.lua

module("modules.configs.excel2json.lua_turnback_submodule", package.seeall)

local lua_turnback_submodule = {}
local fields = {
	jumpId = 7,
	name = 3,
	reddotId = 8,
	actDesc = 5,
	id = 1,
	turnbackId = 2,
	showInPopup = 6,
	nameEn = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	actDesc = 3,
	name = 1,
	nameEn = 2
}

function lua_turnback_submodule.onLoad(json)
	lua_turnback_submodule.configList, lua_turnback_submodule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_submodule
