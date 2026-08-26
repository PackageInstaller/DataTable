-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_buff.lua

module("modules.configs.excel2json.lua_activity220_hedone_buff", package.seeall)

local lua_activity220_hedone_buff = {}
local fields = {
	lifeRule = 2,
	lifeParam = 4,
	buffId = 1,
	subLifeRule = 3,
	affectParam = 6,
	affectType = 5
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}

function lua_activity220_hedone_buff.onLoad(json)
	lua_activity220_hedone_buff.configList, lua_activity220_hedone_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_buff
