-- chunkname: @modules/configs/excel2json/lua_activity179_tone.lua

module("modules.configs.excel2json.lua_activity179_tone", package.seeall)

local lua_activity179_tone = {}
local fields = {
	id = 1,
	name = 3,
	instrument = 2,
	resource = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity179_tone.onLoad(json)
	lua_activity179_tone.configList, lua_activity179_tone.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity179_tone
