-- chunkname: @modules/configs/excel2json/lua_activity11502_episode_element.lua

module("modules.configs.excel2json.lua_activity11502_episode_element", package.seeall)

local lua_activity11502_episode_element = {}
local fields = {
	id = 1,
	finishEffectOffsetPos = 3,
	finishEffect = 2,
	mapIds = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity11502_episode_element.onLoad(json)
	lua_activity11502_episode_element.configList, lua_activity11502_episode_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity11502_episode_element
