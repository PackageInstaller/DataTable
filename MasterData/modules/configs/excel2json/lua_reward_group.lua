-- chunkname: @modules/configs/excel2json/lua_reward_group.lua

module("modules.configs.excel2json.lua_reward_group", package.seeall)

local lua_reward_group = {}
local fields = {
	group = 2,
	materialId = 4,
	count = 5,
	shownum = 7,
	id = 1,
	label = 6,
	materialType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_reward_group.onLoad(json)
	lua_reward_group.configList, lua_reward_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_reward_group
