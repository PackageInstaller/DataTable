-- chunkname: @modules/configs/excel2json/lua_atomic_talent_branch.lua

module("modules.configs.excel2json.lua_atomic_talent_branch", package.seeall)

local lua_atomic_talent_branch = {}
local fields = {
	id = 1,
	name = 2,
	skillId = 5,
	unlockTips = 4,
	unlockCondition = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockTips = 2,
	name = 1
}

function lua_atomic_talent_branch.onLoad(json)
	lua_atomic_talent_branch.configList, lua_atomic_talent_branch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_talent_branch
