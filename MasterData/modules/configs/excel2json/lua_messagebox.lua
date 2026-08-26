-- chunkname: @modules/configs/excel2json/lua_messagebox.lua

module("modules.configs.excel2json.lua_messagebox", package.seeall)

local lua_messagebox = {}
local fields = {
	id = 1,
	title = 3,
	content = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1,
	title = 2
}

function lua_messagebox.onLoad(json)
	lua_messagebox.configList, lua_messagebox.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_messagebox
