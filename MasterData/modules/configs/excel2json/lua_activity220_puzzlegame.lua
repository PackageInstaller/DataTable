-- chunkname: @modules/configs/excel2json/lua_activity220_puzzlegame.lua

module("modules.configs.excel2json.lua_activity220_puzzlegame", package.seeall)

local lua_activity220_puzzlegame = {}
local fields = {
	puzzleid = 2,
	fragment = 3,
	gameid = 1,
	targetPosition = 5,
	specialEnd = 8,
	bg = 6,
	initialPosition = 4,
	img = 7
}
local primaryKey = {
	"gameid",
	"puzzleid"
}
local mlStringKey = {}

function lua_activity220_puzzlegame.onLoad(json)
	lua_activity220_puzzlegame.configList, lua_activity220_puzzlegame.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_puzzlegame
