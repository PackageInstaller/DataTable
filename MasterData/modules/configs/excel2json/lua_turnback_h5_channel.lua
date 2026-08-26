-- chunkname: @modules/configs/excel2json/lua_turnback_h5_channel.lua

module("modules.configs.excel2json.lua_turnback_h5_channel", package.seeall)

local lua_turnback_h5_channel = {}
local fields = {
	id = 1,
	channelId = 2,
	testUrl = 4,
	url = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_turnback_h5_channel.onLoad(json)
	lua_turnback_h5_channel.configList, lua_turnback_h5_channel.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_h5_channel
