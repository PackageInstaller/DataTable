-- chunkname: @modules/configs/excel2json/lua_equip_trial.lua

module("modules.configs.excel2json.lua_equip_trial", package.seeall)

local lua_equip_trial = {}
local fields = {
	equipId = 2,
	equipRefine = 4,
	equipLv = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_equip_trial.onLoad(json)
	lua_equip_trial.configList, lua_equip_trial.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_trial
