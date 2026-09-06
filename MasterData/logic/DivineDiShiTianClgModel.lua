-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/model/DivineDiShiTianClgModel.lua

module("logic.extensions.divinedishitianclg.model.DivineDiShiTianClgModel", package.seeall)

local DivineDiShiTianClgModel = class("DivineDiShiTianClgModel", BaseModel)

DivineDiShiTianClgModel.MaxExtremeStepNum = 3

function DivineDiShiTianClgModel:onInit()
	self:onReset()
end

function DivineDiShiTianClgModel:onReset()
	self._agentDic = {}
end

function DivineDiShiTianClgModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function DivineDiShiTianClgModel:_initAgent(info)
	info.activityId = 0
	info.normalInfo = {}
	info.normalInfo.passNum = 0
	info.normalInfo.gainedPrizeIds = {}
	info.normalInfo.todayRefreshTimes = 0
	info.normalInfo.indexs = {}
	info.normalInfo.isWin = false
	info.extremeInfo = {}
	info.extremeInfo.curStep = 1
	info.extremeInfo.passStageIds = {}
	info.extremeInfo.petHps = {}
	info.extremeInfo.hadGainedPrize = false
	info.extremeInfo.isWin = false
	info.normalFmtMo = nil
	info.extremeFmtMo1 = nil
	info.extremeFmtMo2 = nil
end

function DivineDiShiTianClgModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(DivineDiShiTianClgConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function DivineDiShiTianClgModel:getActivityType()
	return GameEnum.ActivityType.DivineDiShiTian
end

function DivineDiShiTianClgModel:getNormalFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.normalFmtMo == nil then
		info.normalFmtMo = DivineDiShiTianClgFmtMo.New()
	end

	return info.normalFmtMo
end

function DivineDiShiTianClgModel:getExtremeFmtMo1(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extremeFmtMo1 == nil then
		info.extremeFmtMo1 = DivineDishiTianExtremeOneFmtMo.New()
	end

	return info.extremeFmtMo1
end

function DivineDiShiTianClgModel:getExtremeFmtMo2(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extremeFmtMo2 == nil then
		info.extremeFmtMo2 = DivineDishiTianExtremeTwoFmtMo.New()
	end

	return info.extremeFmtMo2
end

function DivineDiShiTianClgModel:onInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.normalInfo.passNum = msg.normalInfo.passNum
	info.normalInfo.gainedPrizeIds = GameUtil.pbToTable(msg.normalInfo.gainedPrizeIds) or {}
	info.normalInfo.todayRefreshTimes = msg.normalInfo.todayRefreshTimes
	info.normalInfo.indexs = GameUtil.pbToTable(msg.normalInfo.indexs) or {}

	for i, normalStageInfo in ipairs(info.normalInfo.indexs) do
		normalStageInfo.pos = normalStageInfo.pos or {}
		normalStageInfo.posDic = normalStageInfo.posDic or {}

		for j, posInfo in ipairs(normalStageInfo.pos) do
			normalStageInfo.posDic[posInfo.posId] = posInfo
		end
	end

	info.extremeInfo.curStep = msg.extremeInfo.curStep
	info.extremeInfo.passStageIds = GameUtil.pbToTable(msg.extremeInfo.passStageIds) or {}
	info.extremeInfo.petHps = GameUtil.pbToTable(msg.extremeInfo.petHps) or {}
	info.extremeInfo.hadGainedPrize = msg.extremeInfo.hadGainedPrize
end

function DivineDiShiTianClgModel:onNormalRes(msg)
	return
end

function DivineDiShiTianClgModel:onRefreshLimitRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.normalInfo.todayRefreshTimes = info.normalInfo.todayRefreshTimes + 1

	for i, normalStageInfo in ipairs(info.normalInfo.indexs) do
		if normalStageInfo.index == msg.index then
			normalStageInfo.pos = GameUtil.pbToTable(msg.pos) or {}
			normalStageInfo.posDic = normalStageInfo.posDic or {}

			table.clear(normalStageInfo.posDic)

			for j, posInfo in ipairs(normalStageInfo.pos) do
				normalStageInfo.posDic[posInfo.posId] = posInfo
			end
		end
	end
end

function DivineDiShiTianClgModel:onGainNormalPrizeRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if not TableUtil.isHad(info.normalInfo.gainedPrizeIds, msg.prizeId) then
		table.insert(info.normalInfo.gainedPrizeIds, msg.prizeId)
	end
end

function DivineDiShiTianClgModel:onExtremeRes(msg)
	return
end

function DivineDiShiTianClgModel:onExtremeResetRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	table.clear(info.extremeInfo.passStageIds)
	table.clear(info.extremeInfo.petHps)
end

function DivineDiShiTianClgModel:onExtremeGainPrizeRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.extremeInfo.hadGainedPrize = true
end

function DivineDiShiTianClgModel:onNotifyNormalFinishRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.normalInfo.isWin = msg.isWin

	if msg.isWin then
		info.normalInfo.passNum = info.normalInfo.passNum + 1

		for i, v in ipairs(info.normalInfo.indexs) do
			if v.index == msg.index then
				v.todayIsPass = true
			end
		end
	end
end

function DivineDiShiTianClgModel:onNotifyExtremeFinishRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.extremeInfo.isWin = msg.isWin

	if msg.isWin then
		if msg.passStep then
			info.extremeInfo.curStep = info.extremeInfo.curStep + 1

			table.clear(info.extremeInfo.passStageIds)
			table.clear(info.extremeInfo.petHps)
		else
			if not TableUtil.isHad(info.extremeInfo.passStageIds, msg.stageId) then
				table.insert(info.extremeInfo.passStageIds, msg.stageId)
			end

			local petHps = GameUtil.pbToTable(msg.petHps) or {}
			local newAddList = {}

			for i, newInfo in ipairs(petHps) do
				local isNewPet = true

				for i2, oldInfo in ipairs(info.extremeInfo.petHps) do
					if newInfo.petId == oldInfo.petId then
						isNewPet = false
						oldInfo.hp = newInfo.hp
					end
				end

				if isNewPet then
					table.insert(newAddList, newInfo)
				end
			end

			for i, v in ipairs(newAddList) do
				table.insert(info.extremeInfo.petHps, v)
			end
		end
	end
end

function DivineDiShiTianClgModel:isPassNormalAll(activityId)
	local info = self:getAgentInfo(activityId)
	local curGetedRewardCount = #info.normalInfo.gainedPrizeIds
	local cfgPrizeList = DivineDiShiTianClgConfig.instance:getNormalPrizeList(activityId)
	local maxRewardCount = #cfgPrizeList

	return maxRewardCount <= curGetedRewardCount
end

function DivineDiShiTianClgModel:isPassExtremeAll(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extremeInfo.curStep > DivineDiShiTianClgModel.MaxExtremeStepNum then
		return info.extremeInfo.hadGainedPrize
	end

	return false
end

function DivineDiShiTianClgModel:isPassExtremeAllStages(activityId)
	local info = self:getAgentInfo(activityId)

	return info.extremeInfo.curStep > DivineDiShiTianClgModel.MaxExtremeStepNum
end

function DivineDiShiTianClgModel:getRewardProgress(activityId)
	local info = self:getAgentInfo(activityId)

	return info.normalInfo.passNum
end

function DivineDiShiTianClgModel:isPlayerRewardGeted(activityId, prizeId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.normalInfo.gainedPrizeIds, prizeId)
end

function DivineDiShiTianClgModel:isPlayerRewardCanGet(activityId, prizeId, progress)
	local isScoreEnough = progress <= self:getRewardProgress(activityId)

	return isScoreEnough and not self:isPlayerRewardGeted(activityId, prizeId)
end

function DivineDiShiTianClgModel:isAnyNormalRewardCanGet(activityId)
	local cfgs = DivineDiShiTianClgConfig.instance:getNormalPrizeList(activityId)

	for i, v in ipairs(cfgs) do
		if self:isPlayerRewardCanGet(activityId, v.prizeId, v.number) then
			return true
		end
	end

	return false
end

function DivineDiShiTianClgModel:isPassNormalStage(activityId, index)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.normalInfo.indexs) do
		if v.index == index then
			return v.todayIsPass
		end
	end

	return false
end

function DivineDiShiTianClgModel:getPosLimitInfo(activityId, index, posId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.normalInfo.indexs) do
		if v.index == index then
			return v.posDic[posId]
		end
	end
end

function DivineDiShiTianClgModel:getTodayRefreshTimes(activityId)
	local info = self:getAgentInfo(activityId)

	return info.normalInfo.todayRefreshTimes
end

function DivineDiShiTianClgModel:getExtremeCurStep(activityId)
	local info = self:getAgentInfo(activityId)
	local curStep = 1

	curStep = info.extremeInfo.curStep <= DivineDiShiTianClgModel.MaxExtremeStepNum and info.extremeInfo.curStep or DivineDiShiTianClgModel.MaxExtremeStepNum

	local cfg = DivineDiShiTianClgConfig.instance:getExtremeStepCfg(activityId, curStep)

	if cfg and cfg.openTime then
		local isUnlock = ServerTime.now() >= GameUtil.string2time(cfg.openTime)

		curStep = isUnlock and curStep or Mathf.Max(1, curStep - 1)
	end

	return curStep
end

function DivineDiShiTianClgModel:getCurMaxStep(activityId)
	local info = self:getAgentInfo(activityId)

	return info.extremeInfo.curStep
end

function DivineDiShiTianClgModel:isExtremeStepPass(activityId, stepId, stageId)
	local info = self:getAgentInfo(activityId)

	if stepId < info.extremeInfo.curStep then
		return true
	elseif stepId > info.extremeInfo.curStep then
		return false
	else
		return TableUtil.isHad(info.extremeInfo.passStageIds, stageId)
	end
end

function DivineDiShiTianClgModel:isExtremeStepPassAnyOne(activityId, stepId)
	local info = self:getAgentInfo(activityId)

	if stepId < info.extremeInfo.curStep then
		return true
	elseif stepId > info.extremeInfo.curStep then
		return false
	else
		return #info.extremeInfo.passStageIds
	end
end

function DivineDiShiTianClgModel:isExtremeCanGetReward(activityId)
	local info = self:getAgentInfo(activityId)

	return self:isPassExtremeAllStages(activityId) and not info.extremeInfo.hadGainedPrize
end

function DivineDiShiTianClgModel:isExtremeGetedReward(activityId)
	local info = self:getAgentInfo(activityId)

	return info.extremeInfo.hadGainedPrize
end

function DivineDiShiTianClgModel:isPetLock(activityId, petId)
	local info = self:getAgentInfo(activityId)
	local isLock = false

	for i, v in ipairs(info.extremeInfo.petHps) do
		if v.petId == petId and v.hp == 0 then
			isLock = true

			break
		end
	end

	return isLock
end

function DivineDiShiTianClgModel:getPetHp(activityId, petId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.extremeInfo.petHps) do
		if v.petId == petId then
			return v.hp
		end
	end

	local petMo = BagPetsController.instance:getPet(petId)

	if petMo then
		return petMo._maxHp
	end

	return 0
end

function DivineDiShiTianClgModel:getPetHpPercent(activityId, petId)
	local petMo = BagPetsController.instance:getPet(petId)
	local curHp = self:getPetHp(activityId, petId)

	return Mathf.Clamp01(curHp / ((petMo or nil) and petMo._maxHp))
end

DivineDiShiTianClgModel.instance = DivineDiShiTianClgModel.New()

return DivineDiShiTianClgModel
