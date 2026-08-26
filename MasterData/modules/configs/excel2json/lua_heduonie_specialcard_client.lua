-- chunkname: @modules/configs/excel2json/lua_heduonie_specialcard_client.lua

module("modules.configs.excel2json.lua_heduonie_specialcard_client", package.seeall)

local lua_heduonie_specialcard_client = {}
local fields = {
	roleid = 1,
	skillcard = 3,
	skillLevel = 2
}
local primaryKey = {
	"roleid",
	"skillLevel"
}
local mlStringKey = {}

function lua_heduonie_specialcard_client.onLoad(json)
	lua_heduonie_specialcard_client.configList, lua_heduonie_specialcard_client.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_heduonie_specialcard_client
