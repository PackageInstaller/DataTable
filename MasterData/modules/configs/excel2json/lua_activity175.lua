-- chunkname: @modules/configs/excel2json/lua_activity175.lua

module("modules.configs.excel2json.lua_activity175", package.seeall)

local lua_activity175 = {}
local fields = {
	res_gif1 = 3,
	res_pic = 2,
	activityId = 1,
	res_gif2 = 4
}
local primaryKey = {
	"activityId",
	"res_pic"
}
local mlStringKey = {}

function lua_activity175.onLoad(json)
	lua_activity175.configList, lua_activity175.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity175
