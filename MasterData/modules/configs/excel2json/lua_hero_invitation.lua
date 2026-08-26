-- chunkname: @modules/configs/excel2json/lua_hero_invitation.lua

module("modules.configs.excel2json.lua_hero_invitation", package.seeall)

local lua_hero_invitation = {}
local fields = {
	head = 3,
	rewardDisplayList = 4,
	name = 2,
	storyId = 6,
	id = 1,
	elementId = 5,
	restoryId = 7,
	openTime = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_hero_invitation.onLoad(json)
	lua_hero_invitation.configList, lua_hero_invitation.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_invitation
