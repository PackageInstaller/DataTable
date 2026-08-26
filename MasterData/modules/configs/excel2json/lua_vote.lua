-- chunkname: @modules/configs/excel2json/lua_vote.lua

module("modules.configs.excel2json.lua_vote", package.seeall)

local lua_vote = {}
local fields = {
	bindActivityIds = 3,
	isOnline = 2,
	voteId = 1
}
local primaryKey = {
	"voteId"
}
local mlStringKey = {}

function lua_vote.onLoad(json)
	lua_vote.configList, lua_vote.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_vote
