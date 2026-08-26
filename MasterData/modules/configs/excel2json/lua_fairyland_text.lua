-- chunkname: @modules/configs/excel2json/lua_fairyland_text.lua

module("modules.configs.excel2json.lua_fairyland_text", package.seeall)

local lua_fairyland_text = {}
local fields = {
	id = 1,
	node = 4,
	question = 2,
	answer = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	question = 1,
	answer = 2
}

function lua_fairyland_text.onLoad(json)
	lua_fairyland_text.configList, lua_fairyland_text.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fairyland_text
