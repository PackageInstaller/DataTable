-- chunkname: @modules/configs/excel2json/lua_activity166_train.lua

module("modules.configs.excel2json.lua_activity166_train", package.seeall)

local lua_activity166_train = {}
local fields = {
	trainId = 2,
	name = 7,
	winDesc = 12,
	needStar = 4,
	strategy = 11,
	firstBonus = 6,
	level = 10,
	episodeId = 3,
	desc = 9,
	type = 5,
	activityId = 1,
	nameEn = 8
}
local primaryKey = {
	"activityId",
	"trainId"
}
local mlStringKey = {
	strategy = 3,
	name = 1,
	winDesc = 4,
	desc = 2
}

function lua_activity166_train.onLoad(json)
	lua_activity166_train.configList, lua_activity166_train.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_train
