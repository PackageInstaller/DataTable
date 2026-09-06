-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/model/PowerPillaModel.lua

module("logic.extensions.maintainpowerpilla.model.PowerPillaModel", package.seeall)

local PowerPillaModel = class("PowerPillaModel", BaseModel)

function PowerPillaModel:ctor()
	return
end

function PowerPillaModel:onInit()
	self:onReset()
end

function PowerPillaModel:onReset()
	self._gainedFirstPassPrizeIds = {}
	self._hasGainDailyPrize = false
	self._passGame = false
	self._gridEventEndResMsg = nil
	self._curGrid = nil
	self._curStage = 1
	self._curMaxMainStage = 1
	self._stageInfoList = {}
	self._mapInfo = nil
	self._isChallengedBoss = false
	self._buffInfos = {}
	self._curBuffLevel = 0
	self._curStage = 1
	self._curStoryId = 0
	self._customFmtMo = nil
end

function PowerPillaModel:onMPPGetActInfoRes(msg)
	self._hasGainDailyPrize = msg.hasGainDailyPrize
	self._passGame = msg.passGame
	self._curGrid = msg.curGrid
	self._curMaxMainStage = msg.stageId
	self._curStoryId = msg.storyId

	for _, v in ipairs(msg.stage) do
		self._stageInfoList[v.stageId] = v

		if v.gainedPrize then
			table.insert(self._gainedFirstPassPrizeIds, v.stageId)
		end
	end
end

function PowerPillaModel:onMPPGetGameInfoRes(msg)
	self._curStage = msg.stageId
	self._mapInfo = msg.mapInfo
	self._isChallengedBoss = msg.isChallengedBoss
end

function PowerPillaModel:onMPPSaveLocationRes(gridId)
	if self._mapInfo then
		self._mapInfo.curGridId = gridId
	end
end

function PowerPillaModel:onMPPGainDailyPrizeRes(msg)
	self._hasGainDailyPrize = true
end

function PowerPillaModel:onMPPGetBuffInfoRes(msg)
	self._buffInfos = GameUtil.pbToTable(msg.infos) or {}
end

function PowerPillaModel:onMPPUpgradeBuffRes(msg)
	for i, v in ipairs(self._buffInfos) do
		if v.buffType == msg.curBuffType then
			v.curLevel = msg.curLevel
			v.curBuyTimes = msg.curTimes

			return
		end
	end

	local buffInfo = {}

	buffInfo.buffType = msg.curBuffType
	buffInfo.curLevel = msg.curLevel
	buffInfo.curBuyTimes = msg.curTimes

	table.insert(self._buffInfos, buffInfo)
end

function PowerPillaModel:onMPPGainStagePrizeRes(stageId)
	if not TableUtil.isHad(self._gainedFirstPassPrizeIds, stageId) then
		table.insert(self._gainedFirstPassPrizeIds, stageId)
	end
end

function PowerPillaModel:onMPPDoGridEventEndRes(msg)
	self._mapInfo = msg.mapInfo

	if msg:HasField("passGame") then
		self._passGame = msg.passGame
	end

	if checknumber(msg.damage) > 0 then
		self._isChallengedBoss = true
	end

	self._gridEventEndResMsg = msg
end

function PowerPillaModel:onUnlockStoryRes(msg)
	self._curStoryId = msg.storyId
end

function PowerPillaModel:getActivityId()
	return PowerPillaConfig.instance:getConstValue("ACTIVITYID", true)
end

function PowerPillaModel:getStagePlanId()
	local cfg = PowerPillaConfig.instance:getActivityCfg(self:getActivityId())

	return (cfg or nil) and (cfg.stagePlanId or 0)
end

function PowerPillaModel:getBuffPlanId()
	local cfg = PowerPillaConfig.instance:getActivityCfg(self:getActivityId())

	return (cfg or nil) and (cfg.buffPlanId or 0)
end

function PowerPillaModel:getPetPlanId()
	local cfg = PowerPillaConfig.instance:getActivityCfg(self:getActivityId())

	return (cfg or nil) and (cfg.petPlanId or 0)
end

function PowerPillaModel:getCurStage()
	return self._curStage
end

function PowerPillaModel:getStageInfo(stageId)
	return self._stageInfoList[stageId] or {}
end

function PowerPillaModel:isPassOfStage(stageId)
	return checkbool(self:getStageInfo(stageId).isPass)
end

function PowerPillaModel:getMaxBossDamageOfStage(stageId)
	return checknumber(self:getStageInfo(stageId).maxBossDamage)
end

function PowerPillaModel:getTotalBossDamageOfStage(stageId)
	return checknumber(self:getStageInfo(stageId).totalBossDamage)
end

function PowerPillaModel:getFightBossTimesOfStage(stageId)
	return checknumber(self:getStageInfo(stageId).fightBossTimes)
end

function PowerPillaModel:getFinishEventNumOfStage(stageId)
	return checknumber(self:getStageInfo(stageId).finishEventNum)
end

function PowerPillaModel:isChallengedBoss()
	return checkbool(self._isChallengedBoss)
end

function PowerPillaModel:isRewardGeted(stage)
	return TableUtil.isHad(self._gainedFirstPassPrizeIds, stage)
end

function PowerPillaModel:isRewardCanGet(stage)
	if not self._passGame then
		local isEnough = stage < self._curMaxMainStage

		isEnough = isEnough or self:isPassStage()

		if isEnough then
			local isGeted = self:isRewardGeted(stage)

			return not isGeted
		else
			return false
		end
	end
end

function PowerPillaModel:isAnyRewardCanGet()
	local passStage = self._curMaxMainStage - 1

	if passStage > 0 then
		for i = 1, passStage do
			if self:isRewardCanGet(i) then
				return true
			end
		end
	end

	return false
end

function PowerPillaModel:getCurMaxMainStage()
	return self._curMaxMainStage or 0
end

function PowerPillaModel:getCurStoryId()
	return self._curStoryId or 0
end

function PowerPillaModel:getStageOfRecord()
	return (self._curGrid or nil) and (self._curGrid.stageId or 0)
end

function PowerPillaModel:isPassStage()
	local maxMainStage = PowerPillaController.instance:getMaxMainStage(self:getActivityId())

	return self:isPassOfStage(maxMainStage)
end

function PowerPillaModel:getResultParam()
	return self._gridEventEndResMsg and self._gridEventEndResMsg.resultParam
end

function PowerPillaModel:isSignInDaily()
	return self._hasGainDailyPrize
end

function PowerPillaModel:getBuffInfoList()
	return self._buffInfos or {}
end

function PowerPillaModel:getBuffLevel(type)
	for i, v in ipairs(self._buffInfos) do
		if v.buffType == type then
			return v.curLevel
		end
	end

	return 0
end

function PowerPillaModel:getBuffBuyTimes(type)
	for i, v in ipairs(self._buffInfos) do
		if v.buffType == type then
			return v.curBuyTimes
		end
	end

	return 0
end

function PowerPillaModel:isExitMapInfo()
	return self._mapInfo
end

function PowerPillaModel:getCurGridId()
	if self._mapInfo then
		return self._mapInfo.curGridId
	end

	return 0
end

function PowerPillaModel:isTriggeredEvent(gridId)
	if self._mapInfo and self._mapInfo.triggerGridIds then
		return TableUtil.isHad(self._mapInfo.triggerGridIds, gridId)
	else
		return false
	end
end

function PowerPillaModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = PowerPillaCustomFmtMo.New()
	end

	return self._customFmtMo
end

function PowerPillaModel:isGetedAllBox()
	if self._mapInfo and self._mapInfo.triggerGridIds then
		local dic = {}

		for i, v in ipairs(self._mapInfo.triggerGridIds) do
			dic[v] = true
		end

		local gridCfgs = PowerPillaConfig.instance:getGridDataListByStage(self:getActivityId(), self:getCurStage())

		for i, v in ipairs(gridCfgs) do
			if v.eventType == PPLMapCell.Box then
				local isGetedBox = dic[v.gridId]

				if not isGetedBox then
					return false
				end
			end
		end

		return true
	end

	return false
end

function PowerPillaModel:isOpenByCurrentStage(isTips, planId, stageId)
	planId = planId or self:getStagePlanId()
	stageId = stageId or self:getCurStage()

	local cfg = PowerPillaConfig.instance:getStageCfg(planId, stageId)

	if not cfg then
		if isTips then
			FloatWordMgr.instance:show("配置不存在")
		end

		return false
	end

	if ServerTime.now() < GameUtil.string2time(cfg.openTime) then
		if isTips then
			local date = GameUtil.string2date(cfg.openTime)

			FloatWordMgr.instance:show(string.format("第%d关 %02d.%02d 5:00 开放", stageId, date.month, date.day))
		end

		return false
	end

	return true
end

PowerPillaModel.instance = PowerPillaModel.New()

return PowerPillaModel
