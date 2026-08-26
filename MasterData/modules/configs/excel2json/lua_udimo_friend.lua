-- chunkname: @modules/configs/excel2json/lua_udimo_friend.lua

module("modules.configs.excel2json.lua_udimo_friend", package.seeall)

local lua_udimo_friend = {}
local fields = {
	emoji = 5,
	friendId = 2,
	udimo2 = 4,
	belongBG = 1,
	udimo1 = 3
}
local primaryKey = {
	"belongBG",
	"friendId"
}
local mlStringKey = {}

function lua_udimo_friend.onLoad(json)
	lua_udimo_friend.configList, lua_udimo_friend.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_friend
