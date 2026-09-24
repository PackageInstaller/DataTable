-- chunkname: @modules/configs/excel2json/lua_college_actor_growth.lua

module("modules.configs.excel2json.lua_college_actor_growth", package.seeall)

local lua_college_actor_growth = {}
local fields = {
	cost = 3,
	entryPool = 5,
	id = 1,
	dismissReward = 4,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}

function lua_college_actor_growth.onLoad(json)
	lua_college_actor_growth.configList, lua_college_actor_growth.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_actor_growth
