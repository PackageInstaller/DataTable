-- chunkname: @modules/configs/excel2json/lua_reward_source.lua

module("modules.configs.excel2json.lua_reward_source", package.seeall)

local lua_reward_source = {}
local fields = {
	sourceid = 1
}
local primaryKey = {
	"sourceid"
}
local mlStringKey = {}

function lua_reward_source.onLoad(json)
	lua_reward_source.configList, lua_reward_source.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_reward_source
