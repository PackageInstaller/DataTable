-- chunkname: @modules/configs/excel2json/lua_fight_sp_sm.lua

module("modules.configs.excel2json.lua_fight_sp_sm", package.seeall)

local lua_fight_sp_sm = {}
local fields = {
	audioId = 5,
	action = 3,
	buffId = 2,
	skinId = 1,
	duration = 6,
	nextActionName = 7,
	actionName = 4
}
local primaryKey = {
	"skinId",
	"buffId",
	"action"
}
local mlStringKey = {}

function lua_fight_sp_sm.onLoad(json)
	lua_fight_sp_sm.configList, lua_fight_sp_sm.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_sm
