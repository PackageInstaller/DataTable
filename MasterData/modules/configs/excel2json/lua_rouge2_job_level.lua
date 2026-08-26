-- chunkname: @modules/configs/excel2json/lua_rouge2_job_level.lua

module("modules.configs.excel2json.lua_rouge2_job_level", package.seeall)

local lua_rouge2_job_level = {}
local fields = {
	geniusId = 2,
	talent = 1
}
local primaryKey = {
	"talent"
}
local mlStringKey = {}

function lua_rouge2_job_level.onLoad(json)
	lua_rouge2_job_level.configList, lua_rouge2_job_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_job_level
