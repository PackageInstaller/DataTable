-- chunkname: @modules/configs/excel2json/lua_udimo_state.lua

module("modules.configs.excel2json.lua_udimo_state", package.seeall)

local lua_udimo_state = {}
local fields = {
	emoji = 3,
	param = 4,
	udimoId = 1,
	state = 2
}
local primaryKey = {
	"udimoId",
	"state"
}
local mlStringKey = {}

function lua_udimo_state.onLoad(json)
	lua_udimo_state.configList, lua_udimo_state.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_state
