-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/config/SystemOpenCO.lua

module("logic.extensions.systemopen.config.SystemOpenCO", package.seeall)

local M = class("SystemOpenCO")

function M:ctor(t)
	self._id = t.code
	self._unlockLevel = t.unlockLevel
	self._unlockTaskStepCode = 0
	self._unlockDuplicateCode = t.unlockDuplicateCode
	self._lockTips = t.lockTips
	self._isShowOnLock = t.isShowOnLock
	self._isDefaultOpen = t.unlockLevel == 0 and self._unlockTaskStepCode == 0 and t.unlockDuplicateCode == 0 and t.unlockGuideCode == 0
end

function M:getId()
	return self._id
end

function M:geUnlockLevel()
	return self._unlockLevel
end

function M:getUnlockTaskStepCode()
	return self._unlockTaskStepCode
end

function M:getUnlockDuplicateCode()
	return self._unlockDuplicateCode
end

function M:getNeedUnlockIndex()
	local index = 0

	index = index + (self:geUnlockLevel() == 0 and 1 or 0)
	index = index + (self:getUnlockDuplicateCode() == 0 and 10 or 0)
	index = index + (self:getUnlockTaskStepCode() == 0 and 100 or 0)

	return tonumber(index)
end

function M:getFullIndex()
	return 1111
end

function M:getLockTips()
	if not SystemOpenModel.instance:getSystemIsOnline(self._id, true) then
		return lang("tip_system_open_not_online")
	end

	return self._lockTips
end

function M:isShowOnLock()
	return self._isShowOnLock > 0
end

function M:isDefaultOpen()
	return self._isDefaultOpen
end

function M:getUnlockText()
	local temp = ""
	local hadCondition = false

	if self:geUnlockLevel() ~= 0 then
		temp = temp .. langF("tip_player_x_level_open", self:_formatLevel(self:geUnlockLevel()))
		hadCondition = true
	elseif self:getUnlockDuplicateCode() ~= 0 then
		local dungeonMO = DungeonModel.instance:getDungeonMoById(self:getUnlockDuplicateCode())

		if dungeonMO then
			temp = temp .. langF("tip_mainline_x_open", dungeonMO:getIndex())
		else
			temp = temp .. langF("tip_mainline_x_open", self:getUnlockDuplicateCode())
		end

		hadCondition = true
	elseif self:getUnlockDuplicateCode() ~= 0 then
		temp = temp .. langF("tip_step_x_open", self:getUnlockDuplicateCode())
		hadCondition = true
	end

	if not hadCondition then
		temp = ""
	end

	return temp
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

return M
