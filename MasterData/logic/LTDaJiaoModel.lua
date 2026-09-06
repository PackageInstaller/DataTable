-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/model/LTDaJiaoModel.lua

module("logic.extensions.luotiandajiao.model.LTDaJiaoModel", package.seeall)

local LTDaJiaoModel = class("LTDaJiaoModel", BaseModel)

function LTDaJiaoModel:ctor()
	return
end

function LTDaJiaoModel:onInit()
	self:onReset()
end

function LTDaJiaoModel:onReset()
	self._curGroup = 0
	self._curGroupRobotInfos = {}
	self._beatIds = {}
	self._gainPrizeIds = {}
	self._buffLevel = 1
	self._isUpgrade = false
	self._curRobot = nil
	self._championStageinfos = nil
end

function LTDaJiaoModel:onLuoTianDaJiaoGetInfoRes(msg)
	self._curGroup = msg.curGroup
	self._curGroupRobotInfos = GameUtil.pbToTable(msg.infos) or {}
	self._beatIds = #msg.beatIds > 0 and (GameUtil.pbToTable(msg.beatIds) or {}) or {}
	self._gainPrizeIds = msg.gainPrizeIds and #msg.gainPrizeIds > 0 and (GameUtil.pbToTable(msg.gainPrizeIds) or {}) or {}
	self._buffLevel = msg.buffLevel
	self._isUpgrade = msg.isUpgrade
	self._curRobot = msg:HasField("curRobot") and msg.curRobot or nil
	self._championStageinfos = #msg.championStageinfos > 0 and GameUtil.pbToTable(msg.championStageinfos) or nil
end

function LTDaJiaoModel:onLuoTianDaJiaoUpgradeRes()
	local cfgs = LTDaJiaoConfig.instance:getBuffCfgs(self:curBuffPlanId())

	if cfgs then
		local maxLevel = #cfgs

		self._buffLevel = self._buffLevel + 1

		if maxLevel < self._buffLevel then
			self._buffLevel = maxLevel
		end
	end

	self._isUpgrade = true
end

function LTDaJiaoModel:onLuoTianDaJiaoChoiceRes(msg)
	self._curRobot = msg.info
end

function LTDaJiaoModel:onLuoTianDaJiaoGainPrizeRes(groupId)
	if groupId and groupId > 0 and not TableUtil.isHad(self._gainPrizeIds, groupId) then
		table.insert(self._gainPrizeIds, groupId)
	end
end

function LTDaJiaoModel:onLuoTianDaJiaoAfterFightRes(msg)
	if msg.isWin then
		self._curRobot = nil

		if #msg.nextGroupRobotIds > 0 then
			self._curGroupRobotInfos = GameUtil.pbToTable(msg.nextGroupRobotIds)
		end

		self._championStageinfos = #msg.championStageInfos > 0 and GameUtil.pbToTable(msg.championStageInfos) or nil
	end

	self._beatIds = GameUtil.pbToTable(msg.beatIds) or {}
	self._curGroup = msg.curGroup
end

function LTDaJiaoModel:curAvailableActivityCfg()
	return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.LuoTianDaJiao)
end

function LTDaJiaoModel:isInActivityTime()
	if self:curAvailableActivityCfg() then
		return true
	else
		return false
	end
end

function LTDaJiaoModel:getActivityId()
	local cfg = self:curAvailableActivityCfg()

	return (cfg or nil) and (cfg.activityId or 0)
end

function LTDaJiaoModel:curChallengePlanId()
	local cfg = LTDaJiaoConfig.instance:getCommonCfg(self:getActivityId())

	return (cfg or nil) and (cfg.challengePlanId or 0)
end

function LTDaJiaoModel:curBuffPlanId()
	local cfg = LTDaJiaoConfig.instance:getCommonCfg(self:getActivityId())

	return (cfg or nil) and (cfg.buffPlanId or 0)
end

function LTDaJiaoModel:curGroupPlanId()
	local cfg = LTDaJiaoConfig.instance:getCommonCfg(self:getActivityId())

	return (cfg or nil) and (cfg.groupPlanId or 0)
end

function LTDaJiaoModel:isChampionship()
	return self._championStageinfos
end

function LTDaJiaoModel:getCurBuffLevel()
	return self._buffLevel
end

function LTDaJiaoModel:isGetedReward(groupId)
	return TableUtil.isHad(self._gainPrizeIds, groupId)
end

function LTDaJiaoModel:isPass(groupId)
	local cfgs = LTDaJiaoConfig.instance:getGroupCfgs(self:curGroupPlanId())

	if cfgs then
		local totalGroupCount = #cfgs

		if self._curGroup == totalGroupCount and groupId == totalGroupCount then
			return #self._beatIds == 3
		else
			return groupId < self._curGroup
		end
	end

	return false
end

function LTDaJiaoModel:isUnlock(groupId)
	if groupId <= self._curGroup then
		local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.LuoTianDaJiao, self:getActivityId())
		local curTimestamp = ServerTime.now()

		if curTimestamp < startTimestamp or endTimestamp < curTimestamp then
			return false
		end

		local startDate = GameUtil.time2date(startTimestamp)
		local groupCfg = LTDaJiaoConfig.instance:getGroupCfgById(self:curGroupPlanId(), groupId)

		if not groupCfg then
			return false
		end

		local delayDay = groupCfg.openTime - 1

		if delayDay < 0 then
			delayDay = 0
		end

		startDate.day = startDate.day + delayDay

		local newTimestamp = os.time(startDate)

		if newTimestamp < curTimestamp then
			return true, newTimestamp
		end

		return false, newTimestamp
	end

	return false
end

function LTDaJiaoModel:isUpgradeToday()
	return self._isUpgrade
end

function LTDaJiaoModel:getCurRobot()
	return self._curRobot
end

function LTDaJiaoModel:getCurGroupRobots()
	return self._curGroupRobotInfos
end

function LTDaJiaoModel:getCurGroupId()
	return self._curGroup
end

function LTDaJiaoModel:getCurBeatRobotCount()
	return #self._beatIds
end

function LTDaJiaoModel:isBeatCurRobot(userId)
	return TableUtil.isHad(self._beatIds, userId)
end

function LTDaJiaoModel:getChampionRobotById(userId)
	for i, v in ipairs(self._curGroupRobotInfos) do
		if v.info.userId == userId then
			return v
		end
	end

	return nil
end

function LTDaJiaoModel:getChampionUserIdListByStage(stage)
	stage = Mathf.Clamp(stage, 1, 4)

	if self._championStageinfos then
		for i, v in ipairs(self._championStageinfos) do
			if v.stage == stage then
				return v.robotIds
			end
		end
	end

	return {}
end

function LTDaJiaoModel:getChampionCurMaxStage()
	if self._championStageinfos then
		return #self._championStageinfos
	else
		return 0
	end
end

function LTDaJiaoModel:isExistUserIdOnStage(stage, userId)
	if self._championStageinfos[stage] then
		for i, v in ipairs(self._championStageinfos[stage].robotIds) do
			if userId == v then
				return true
			end
		end
	end

	return false
end

function LTDaJiaoModel:isMaxBuffLevel(level)
	local cfgs = LTDaJiaoConfig.instance:getBuffCfgs(self:curBuffPlanId())

	if cfgs then
		return level == #cfgs
	else
		return false
	end
end

LTDaJiaoModel.instance = LTDaJiaoModel.New()

return LTDaJiaoModel
