-- chunkname: @modules/configs/excel2json/lua_open_lang.lua

module("modules.configs.excel2json.lua_open_lang", package.seeall)

local lua_open_lang = {}
local fields = {
	id = 1,
	langStoryVoice = 4,
	langTxts = 2,
	langVoice = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_open_lang.onLoad(json)
	lua_open_lang.configList, lua_open_lang.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_open_lang
