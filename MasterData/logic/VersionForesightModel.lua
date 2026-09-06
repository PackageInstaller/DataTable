-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/versionforesight/model/VersionForesightModel.lua

module("logic.extensions.versionforesight.model.VersionForesightModel", package.seeall)

local VersionForesightModel = class("VersionForesightModel", BaseModel)

function VersionForesightModel:ctor()
	return
end

function VersionForesightModel:onInit()
	self:onReset()
end

function VersionForesightModel:onReset()
	self._activityId = 0
	self._unlockIds = {}
	self._gainBoxPrize = false
	self._todayGameTimes = 0
	self._newUnlockId = {}
	self._changeSetId = 0
end

function VersionForesightModel:getActivityId()
	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.VersionForesight)
	end

	return self._activityId
end

function VersionForesightModel:setInfo(msg)
	self._unlockIds = GameUtil.pbToTable(msg.unlockIds) or {}
	self._gainBoxPrize = msg.gainBoxPrize
	self._todayGameTimes = msg.todayGameTimes
end

function VersionForesightModel:setNewInfo(msg)
	self._newUnlockId = GameUtil.pbToTable(msg.newUnlockId)
	self._changeSetId = msg.changeSetId
	self._todayGameTimes = msg.todayGameTimes

	for i, v in ipairs(self._newUnlockId) do
		table.insert(self._unlockIds, v)
	end
end

function VersionForesightModel:getUnlockIds()
	return self._unlockIds
end

function VersionForesightModel:getUnlockIdsLen()
	return #self._unlockIds
end

function VersionForesightModel:getTodayGameTimes()
	local cfg = VersionForesightConfig.instance:getCfgById(self:getActivityId())

	return cfg.dailyTimes + self:getDailyTimes() - self._todayGameTimes
end

function VersionForesightModel:getDailyTimes()
	local cfg = VersionForesightConfig.instance:getAddTimesById(self:getActivityId())
	local info = DiamondTaskModel.instance:getTaskInfoByType(GameEnum.TaskViewTab.Daily)
	local times = 0

	for i, v in ipairs(cfg) do
		if info.activityScore >= v.dailyActivityScore then
			times = times + v.incTimes
		end
	end

	return times
end

function VersionForesightModel:getNewUnlockId()
	return self._newUnlockId[1]
end

function VersionForesightModel:getIsFinal()
	return #self._newUnlockId > 1
end

function VersionForesightModel:getGainBoxPrize()
	return self._gainBoxPrize
end

function VersionForesightModel:getChangeSetId()
	return self._changeSetId
end

function VersionForesightModel:getSplittingPoint()
	local cfg = VersionForesightConfig.instance:getCfgById(self:getActivityId())
	local overTime = GameUtil.string2time(cfg.splittingPoint)

	return overTime > ServerTime.now()
end

VersionForesightModel.instance = VersionForesightModel.New()

return VersionForesightModel
