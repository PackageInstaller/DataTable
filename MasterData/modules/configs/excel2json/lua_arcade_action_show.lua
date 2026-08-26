-- chunkname: @modules/configs/excel2json/lua_arcade_action_show.lua

module("modules.configs.excel2json.lua_arcade_action_show", package.seeall)

local lua_arcade_action_show = {}
local fields = {
	id = 1,
	effectIds = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_action_show.onLoad(json)
	lua_arcade_action_show.configList, lua_arcade_action_show.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_action_show
