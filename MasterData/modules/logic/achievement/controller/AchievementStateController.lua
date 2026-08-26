-- chunkname: @modules/logic/achievement/controller/AchievementStateController.lua

module("modules.logic.achievement.controller.AchievementStateController", package.seeall)

local AchievementStateController = class("AchievementStateController", BaseController)

function AchievementStateController:addConstEvents()
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onCheckFuncUnlock, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._onNewFuncOpen, self)
end

function AchievementStateController:reInit()
	self:release()
end

function AchievementStateController:_onCheckFuncUnlock()
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement)

	if not isUnlock then
		return
	end

	AchievementConfig.instance:initWaitAchievements()
	self:checkReadyAchievmeentOnline()
end

function AchievementStateController:_onNewFuncOpen(newIds)
	if tabletool.indexOf(newIds, OpenEnum.UnlockFunc.Achievement) then
		AchievementConfig.instance:initWaitAchievements()
		self:checkReadyAchievmeentOnline()
	end
end

function AchievementStateController:checkReadyAchievmeentOnline()
	local readyOnlineList = AchievementConfig.instance:getWaitOnlineAchievementList()
	local readyOfflineList = AchievementConfig.instance:getWaitOfflineAchievementList()

	if readyOnlineList and #readyOnlineList > 0 then
		self._onlinePriorityQueue = PriorityQueue.New(function(achievementCfg1, achievementCfg2)
			return achievementCfg1.startTime < achievementCfg2.startTime
		end)

		for _, readyOnlienCfg in pairs(readyOnlineList) do
			self._onlinePriorityQueue:add(readyOnlienCfg)
		end

		self:startTickAchievementOnline()
	end

	if readyOfflineList and #readyOfflineList > 0 then
		self._offlinePriorityQueue = PriorityQueue.New(function(achievementCfg1, achievementCfg2)
			return achievementCfg1.endTime < achievementCfg2.endTime
		end)

		for _, readyOfflineCfg in ipairs(readyOfflineList) do
			self._offlinePriorityQueue:add(readyOfflineCfg)
		end

		self:startTickAchievementOffline()
	end
end

function AchievementStateController:startTickAchievementOnline()
	local fistReadyOnlineCfg = self._onlinePriorityQueue:getFirst()
	local onlineLeftSec = self:getAchievementStartLeftSeconds(fistReadyOnlineCfg)

	TaskDispatcher.cancelTask(self.onAchievementOnline, self)
	TaskDispatcher.runDelay(self.onAchievementOnline, self, onlineLeftSec)
end

function AchievementStateController:onAchievementOnline()
	local fistReadyOnlineCfg = self._onlinePriorityQueue:getFirst()

	AchievementConfig.instance:onAchievementArriveOnlineTime(fistReadyOnlineCfg.id)
	AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievementState)
	self._onlinePriorityQueue:getFirstAndRemove()

	if self._onlinePriorityQueue:getSize() > 0 then
		self:startTickAchievementOnline()
	else
		self._onlinePriorityQueue = nil
	end
end

function AchievementStateController:startTickAchievementOffline()
	local firstReadyOfflineCfg = self._offlinePriorityQueue:getFirst()
	local offlineLeftSec = self:getAchievementEndLeftSeconds(firstReadyOfflineCfg)

	logNormal(string.format("成就{%s}准备下架,倒计时:{%s}秒", firstReadyOfflineCfg.id, offlineLeftSec))
	TaskDispatcher.cancelTask(self.onAchievementOffline, self)
	TaskDispatcher.runDelay(self.onAchievementOffline, self, offlineLeftSec)
end

function AchievementStateController:onAchievementOffline()
	local firstReadyOfflineCfg = self._offlinePriorityQueue:getFirst()

	AchievementConfig.instance:onAchievementArriveOfflineTime(firstReadyOfflineCfg.id)
	AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievementState)
	self._offlinePriorityQueue:getFirstAndRemove()
	logNormal(string.format("成就{%s}下架", firstReadyOfflineCfg.id))

	if self._offlinePriorityQueue:getSize() > 0 then
		self:startTickAchievementOnline()
	else
		self._offlinePriorityQueue = nil
	end
end

function AchievementStateController:getAchievementStartLeftSeconds(achievementCfg)
	local startTime = achievementCfg.startTime
	local leftSec = TimeUtil.stringToTimestamp(startTime) + ServerTime.clientToServerOffset()

	leftSec = leftSec - ServerTime.now()

	return leftSec
end

function AchievementStateController:getAchievementEndLeftSeconds(achievementCfg)
	local endTime = achievementCfg.endTime
	local leftSec = TimeUtil.stringToTimestamp(endTime) + ServerTime.clientToServerOffset()

	leftSec = leftSec - ServerTime.now()

	return leftSec
end

function AchievementStateController:release()
	TaskDispatcher.cancelTask(self.onAchievementOnline, self)
	TaskDispatcher.cancelTask(self.onAchievementOffline, self)

	self._offlinePriorityQueue = nil
	self._onlinePriorityQueue = nil
end

AchievementStateController.instance = AchievementStateController.New()

return AchievementStateController
