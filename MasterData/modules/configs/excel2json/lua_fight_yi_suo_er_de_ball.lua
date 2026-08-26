-- chunkname: @modules/configs/excel2json/lua_fight_yi_suo_er_de_ball.lua

module("modules.configs.excel2json.lua_fight_yi_suo_er_de_ball", package.seeall)

local lua_fight_yi_suo_er_de_ball = {}
local fields = {
	id = 1,
	effect = 3,
	buffId = 2,
	audio = 4
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}

function lua_fight_yi_suo_er_de_ball.onLoad(json)
	lua_fight_yi_suo_er_de_ball.configList, lua_fight_yi_suo_er_de_ball.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_yi_suo_er_de_ball
