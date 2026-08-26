-- chunkname: @modules/configs/excel2json/lua_warmup_h5.lua

module("modules.configs.excel2json.lua_warmup_h5", package.seeall)

local lua_warmup_h5 = {}
local fields = {
	activityId = 1,
	link = 2,
	bgResUrl = 3
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_warmup_h5.onLoad(json)
	lua_warmup_h5.configList, lua_warmup_h5.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_warmup_h5
