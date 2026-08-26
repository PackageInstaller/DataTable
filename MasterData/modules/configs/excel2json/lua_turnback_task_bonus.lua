-- chunkname: @modules/configs/excel2json/lua_turnback_task_bonus.lua

module("modules.configs.excel2json.lua_turnback_task_bonus", package.seeall)

local lua_turnback_task_bonus = {}
local fields = {
	character = 5,
	needPoint = 7,
	extraBonus = 4,
	id = 2,
	turnbackId = 1,
	content = 6,
	bonus = 3
}
local primaryKey = {
	"turnbackId",
	"id"
}
local mlStringKey = {}

function lua_turnback_task_bonus.onLoad(json)
	lua_turnback_task_bonus.configList, lua_turnback_task_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_task_bonus
