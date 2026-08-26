-- chunkname: @modules/configs/excel2json/lua_activity128_conceal_desc.lua

module("modules.configs.excel2json.lua_activity128_conceal_desc", package.seeall)

local lua_activity128_conceal_desc = {}
local fields = {
	spDesc = 2,
	maxConceal = 3,
	episodeId = 1
}
local primaryKey = {
	"episodeId"
}
local mlStringKey = {
	spDesc = 1
}

function lua_activity128_conceal_desc.onLoad(json)
	lua_activity128_conceal_desc.configList, lua_activity128_conceal_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_conceal_desc
