-- chunkname: @modules/configs/excel2json/lua_bp_skin_view_param.lua

module("modules.configs.excel2json.lua_bp_skin_view_param", package.seeall)

local lua_bp_skin_view_param = {}
local fields = {
	audioId = 2,
	storePrefab = 3,
	closeAudioId = 5,
	skinId = 1,
	online = 6,
	openAudioId = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_bp_skin_view_param.onLoad(json)
	lua_bp_skin_view_param.configList, lua_bp_skin_view_param.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bp_skin_view_param
