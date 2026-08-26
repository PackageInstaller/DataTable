-- chunkname: @modules/configs/excel2json/lua_activity218_dailydifficultly.lua

module("modules.configs.excel2json.lua_activity218_dailydifficultly", package.seeall)

local lua_activity218_dailydifficultly = {}
local fields = {
	difficulty = 2,
	day = 1
}
local primaryKey = {
	"day"
}
local mlStringKey = {}

function lua_activity218_dailydifficultly.onLoad(json)
	lua_activity218_dailydifficultly.configList, lua_activity218_dailydifficultly.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity218_dailydifficultly
