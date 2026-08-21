-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemjump/config/SystemJumpConfig.lua

module("logic.extensions.systemjump.config.SystemJumpConfig", package.seeall)

local M = class("SystemJumpConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.SystemJump
	}
end

function M:getJumpInfo(jumpId)
	local tableInfo = self._dict[ConfigName.SystemJump]
	local findInfo = tableInfo and tableInfo[jumpId] or false

	return findInfo
end

M.instance = M.New()

return M
