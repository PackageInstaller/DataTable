-- chunkname: @modules/configs/excel2json/lua_pat_face.lua

module("modules.configs.excel2json.lua_pat_face", package.seeall)

local lua_pat_face = {}
local fields = {
	patFaceOrder = 5,
	patFaceStoryId = 4,
	id = 1,
	patFaceViewName = 3,
	patFaceActivityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_pat_face.onLoad(json)
	lua_pat_face.configList, lua_pat_face.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_pat_face
