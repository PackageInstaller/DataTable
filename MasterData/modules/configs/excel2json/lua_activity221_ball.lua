-- chunkname: @modules/configs/excel2json/lua_activity221_ball.lua

module("modules.configs.excel2json.lua_activity221_ball", package.seeall)

local lua_activity221_ball = {}
local fields = {
	skillIds = 2,
	image = 4,
	action = 3,
	ballType = 1
}
local primaryKey = {
	"ballType"
}
local mlStringKey = {}

function lua_activity221_ball.onLoad(json)
	lua_activity221_ball.configList, lua_activity221_ball.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity221_ball
