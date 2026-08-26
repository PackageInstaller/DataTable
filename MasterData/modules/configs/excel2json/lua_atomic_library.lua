-- chunkname: @modules/configs/excel2json/lua_atomic_library.lua

module("modules.configs.excel2json.lua_atomic_library", package.seeall)

local lua_atomic_library = {}
local fields = {
	unlockTips = 7,
	res = 5,
	type = 4,
	id = 1,
	title = 2,
	content = 3,
	detail = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockTips = 3,
	title = 1,
	content = 2
}

function lua_atomic_library.onLoad(json)
	lua_atomic_library.configList, lua_atomic_library.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_library
