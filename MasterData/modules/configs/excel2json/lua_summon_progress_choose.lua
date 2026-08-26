-- chunkname: @modules/configs/excel2json/lua_summon_progress_choose.lua

module("modules.configs.excel2json.lua_summon_progress_choose", package.seeall)

local lua_summon_progress_choose = {}
local fields = {
	groupId = 1,
	chooseRewards = 3,
	progress = 2
}
local primaryKey = {
	"groupId",
	"progress"
}
local mlStringKey = {}

function lua_summon_progress_choose.onLoad(json)
	lua_summon_progress_choose.configList, lua_summon_progress_choose.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_progress_choose
