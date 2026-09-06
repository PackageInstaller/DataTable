-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/controller/MissionMsgBlockController.lua

module("logic.extensions.mission.controller.MissionMsgBlockController", package.seeall)

local MissionMsgBlockController = class("MissionMsgBlockController", BaseController)
local BlockWhitelist = {
	[-1] = {
		[0] = true
	},
	{
		[0] = true
	},
	[4] = {
		[9] = true
	},
	[29] = {
		[0] = true
	}
}

function MissionMsgBlockController:onInit()
	self._isBlocking = false
	self._blockTags = {}
	self._errorBlockList = {}
	self._isEnableDebug = true

	self:onReset()
end

function MissionMsgBlockController:onReset()
	self:setIsBlocking(false)
end

function MissionMsgBlockController:setIsBlocking(isBlocking, isForce)
	if not isForce and self._isBlocking == isBlocking then
		return
	end

	self:_clearAllBlockTag()

	self._isBlocking = isBlocking
end

function MissionMsgBlockController:tryBlockMsg(extId, cmd)
	if not self._isBlocking or self:_isInWhitelist(extId, cmd) then
		return
	end

	self:_addBlockTag(extId, cmd)
end

function MissionMsgBlockController:tryUnBlockMsg(extId, cmd, status)
	if not self._isBlocking or not self:_isBlockedMsg(extId, cmd) then
		return
	end

	if status ~= 0 then
		if self._isEnableDebug then
			self:_printAllBlockInfo(extId, cmd, status)
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MissionMsgBlockController:_addBlockTag(extId, cmd)
	self._blockTags[extId] = self._blockTags[extId] or {}
	self._blockTags[extId][cmd] = true
end

function MissionMsgBlockController:_isBlockedMsg(extId, cmd)
	return (self._blockTags[extId] or nil) and (self._blockTags[extId][cmd] or false)
end

function MissionMsgBlockController:_clearAllBlockTag()
	table.clear(self._blockTags)
	table.clear(self._errorBlockList)
end

function MissionMsgBlockController:_isInWhitelist(extId, cmd)
	if BlockWhitelist[extId] then
		if BlockWhitelist[extId][cmd] then
			return true
		elseif BlockWhitelist[extId][0] == true then
			return true
		end
	end

	return false
end

function MissionMsgBlockController:_printAllBlockInfo(eExtId, eCmd, eStatus)
	if next(self._blockTags) == nil then
		return
	end

	local errorStr = string.format("%s_%s:%s", eExtId, eCmd, eStatus)
	local blockListStr = ""

	for extId, cmds in pairs(self._blockTags) do
		for cmd, isBlocking in pairs(cmds) do
			if isBlocking then
				blockListStr = blockListStr .. string.format("%s_%s#", extId, cmd)
			end
		end
	end

	if #blockListStr > 0 then
		blockListStr = blockListStr:sub(1, -#"#" - 1)
	end

	forcePrint(string.format("进战斗前错误码: %s  [ %s ]", errorStr, blockListStr))
end

MissionMsgBlockController.instance = MissionMsgBlockController.New()

return MissionMsgBlockController
