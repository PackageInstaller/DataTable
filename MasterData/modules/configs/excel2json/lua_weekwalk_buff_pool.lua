-- chunkname: @modules/configs/excel2json/lua_weekwalk_buff_pool.lua

module("modules.configs.excel2json.lua_weekwalk_buff_pool", package.seeall)

local lua_weekwalk_buff_pool = {}
local fields = {
	id = 1,
	buffId = 2
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}

function lua_weekwalk_buff_pool.onLoad(json)
	lua_weekwalk_buff_pool.configList, lua_weekwalk_buff_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_buff_pool
