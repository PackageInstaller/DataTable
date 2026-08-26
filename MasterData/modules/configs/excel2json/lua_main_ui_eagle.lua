-- chunkname: @modules/configs/excel2json/lua_main_ui_eagle.lua

module("modules.configs.excel2json.lua_main_ui_eagle", package.seeall)

local lua_main_ui_eagle = {}
local fields = {
	animName = 5,
	location = 8,
	odds_nextstep = 2,
	isoutline = 9,
	playfadeAnim = 10,
	times = 7,
	loop = 6,
	isSpineAnim = 4,
	id = 1,
	option_nextstep = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_main_ui_eagle.onLoad(json)
	lua_main_ui_eagle.configList, lua_main_ui_eagle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_main_ui_eagle
