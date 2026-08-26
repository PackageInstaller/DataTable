-- chunkname: @modules/configs/excel2json/lua_main_act_atmosphere.lua

module("modules.configs.excel2json.lua_main_act_atmosphere", package.seeall)

local lua_main_act_atmosphere = {}
local fields = {
	id = 1,
	mainView = 3,
	isShowActBg = 7,
	isShowLogo = 6,
	mainViewActBtn = 4,
	mainThumbnailViewActBg = 10,
	effectDuration = 2,
	mainViewActBtnPrefix = 5,
	mainThumbnailView = 8,
	isShowfx = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_main_act_atmosphere.onLoad(json)
	lua_main_act_atmosphere.configList, lua_main_act_atmosphere.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_main_act_atmosphere
