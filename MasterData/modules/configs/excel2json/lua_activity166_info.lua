-- chunkname: @modules/configs/excel2json/lua_activity166_info.lua

module("modules.configs.excel2json.lua_activity166_info", package.seeall)

local lua_activity166_info = {}
local fields = {
	initContent = 10,
	name = 6,
	reportRes = 8,
	unlockParam = 4,
	infoId = 2,
	reportPic = 9,
	unlockType = 3,
	unlockDes = 5,
	activityId = 1,
	nameEn = 7
}
local primaryKey = {
	"activityId",
	"infoId"
}
local mlStringKey = {
	initContent = 3,
	name = 2,
	unlockDes = 1
}

function lua_activity166_info.onLoad(json)
	lua_activity166_info.configList, lua_activity166_info.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_info
