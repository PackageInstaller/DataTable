-- chunkname: @modules/configs/excel2json/lua_eliminate_slot.lua

module("modules.configs.excel2json.lua_eliminate_slot", package.seeall)

local lua_eliminate_slot = {}
local fields = {
	defaultUnlock = 2,
	chessId = 1
}
local primaryKey = {
	"chessId"
}
local mlStringKey = {}

function lua_eliminate_slot.onLoad(json)
	lua_eliminate_slot.configList, lua_eliminate_slot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_slot
