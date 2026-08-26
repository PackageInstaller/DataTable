-- chunkname: @modules/configs/excel2json/lua_arcade_state_show.lua

module("modules.configs.excel2json.lua_arcade_state_show", package.seeall)

local lua_arcade_state_show = {}
local fields = {
	id = 1,
	effectId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_state_show.onLoad(json)
	lua_arcade_state_show.configList, lua_arcade_state_show.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_state_show
