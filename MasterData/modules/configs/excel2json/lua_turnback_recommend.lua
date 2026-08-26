-- chunkname: @modules/configs/excel2json/lua_turnback_recommend.lua

module("modules.configs.excel2json.lua_turnback_recommend", package.seeall)

local lua_turnback_recommend = {}
local fields = {
	jumpId = 10,
	limitCount = 12,
	turnbackId = 1,
	relateActId = 11,
	prepose = 5,
	offlineTime = 8,
	constTime = 6,
	openId = 9,
	onlineTime = 7,
	id = 2,
	icon = 3,
	order = 4
}
local primaryKey = {
	"turnbackId",
	"id"
}
local mlStringKey = {}

function lua_turnback_recommend.onLoad(json)
	lua_turnback_recommend.configList, lua_turnback_recommend.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_recommend
