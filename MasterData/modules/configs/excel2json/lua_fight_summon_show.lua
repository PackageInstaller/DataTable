-- chunkname: @modules/configs/excel2json/lua_fight_summon_show.lua

module("modules.configs.excel2json.lua_fight_summon_show", package.seeall)

local lua_fight_summon_show = {}
local fields = {
	audioId = 6,
	effect = 3,
	ingoreEffect = 7,
	skinId = 1,
	effectHangPoint = 5,
	effectTime = 4,
	actionName = 2
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_summon_show.onLoad(json)
	lua_fight_summon_show.configList, lua_fight_summon_show.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_summon_show
