-- chunkname: @modules/configs/excel2json/lua_gpu_level.lua

module("modules.configs.excel2json.lua_gpu_level", package.seeall)

local lua_gpu_level = {}
local fields = {
	level = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}

function lua_gpu_level.onLoad(json)
	lua_gpu_level.configList, lua_gpu_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_gpu_level
