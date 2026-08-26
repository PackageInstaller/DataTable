-- chunkname: @modules/configs/excel2json/lua_atomic_arena.lua

module("modules.configs.excel2json.lua_atomic_arena", package.seeall)

local lua_atomic_arena = {}
local fields = {
	unlockSeq = 2,
	arenaId = 1,
	scale = 3
}
local primaryKey = {
	"arenaId"
}
local mlStringKey = {}

function lua_atomic_arena.onLoad(json)
	lua_atomic_arena.configList, lua_atomic_arena.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_arena
