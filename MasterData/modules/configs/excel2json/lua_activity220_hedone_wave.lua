-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_wave.lua

module("modules.configs.excel2json.lua_activity220_hedone_wave", package.seeall)

local lua_activity220_hedone_wave = {}
local fields = {
	id = 1,
	randomType = 2,
	randomParam = 3,
	isBossWave = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_hedone_wave.onLoad(json)
	lua_activity220_hedone_wave.configList, lua_activity220_hedone_wave.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_wave
