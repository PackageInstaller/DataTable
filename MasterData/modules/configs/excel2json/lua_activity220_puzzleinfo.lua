-- chunkname: @modules/configs/excel2json/lua_activity220_puzzleinfo.lua

module("modules.configs.excel2json.lua_activity220_puzzleinfo", package.seeall)

local lua_activity220_puzzleinfo = {}
local fields = {
	img = 2,
	fragment = 1
}
local primaryKey = {
	"fragment"
}
local mlStringKey = {}

function lua_activity220_puzzleinfo.onLoad(json)
	lua_activity220_puzzleinfo.configList, lua_activity220_puzzleinfo.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_puzzleinfo
