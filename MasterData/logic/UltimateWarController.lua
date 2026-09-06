-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/controller/UltimateWarController.lua

module("logic.extensions.ultimatewar.controller.UltimateWarController", package.seeall)

local UltimateWarController = class("UltimateWarController", BaseController)

function UltimateWarController:onInit()
	self:onReset()
end

function UltimateWarController:onReset()
	local activityId = self:getActivityId()

	if self:isInActivityTime(activityId) then
		GlobalDispatcher:addListener(GlobalNotify.HandBookInit, self._handleHandBookUpdate, self)
		GlobalDispatcher:addListener(GlobalNotify.HandBookAttributeChange, self._handleHandBookUpdate, self)
	else
		GlobalDispatcher:removeListener(GlobalNotify.HandBookInit, self._handleHandBookUpdate, self)
		GlobalDispatcher:removeListener(GlobalNotify.HandBookAttributeChange, self._handleHandBookUpdate, self)
	end
end

function UltimateWarController:_handleHandBookUpdate()
	local activityId = self:getActivityId()

	if self:isInActivityTime(activityId) then
		self:_updateFirstStepRed(activityId)
	end
end

function UltimateWarController:sendPM_UltimateWarGetMainInfoReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarGetMainInfoReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarGetMainInfoRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarGetMainInfoRes(msg)
	self:_updatePetUpRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarGetMainInfoRes)
end

function UltimateWarController:sendPM_UltimateWarUpPetLevelReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarUpPetLevelReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarUpPetLevelRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarUpPetLevelRes(msg)
	self:_updatePetUpRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarUpPetLevelRes)
end

function UltimateWarController:sendPM_UltimateWarFinishPlotReq(activityId, plotId)
	UltimateWarAgent.instance:sendPM_UltimateWarFinishPlotReq(activityId, plotId)
end

function UltimateWarController:handlePM_UltimateWarFinishPlotRes(status, msg)
	if status == 0 then
		local mo = self:getUltimateWarMo(msg.activityId)

		mo:handlePM_UltimateWarFinishPlotRes(msg)
		self:_updatePetUpRed(msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarFinishPlotRes, status, msg)
end

function UltimateWarController:sendPM_UltimateWarFirstStepInfoReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarFirstStepInfoReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarFirstStepInfoRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarFirstStepInfoRes(msg)
	self:_updateFirstStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarFirstStepInfoRes)
end

function UltimateWarController:sendPM_UltimateWarDispatchReq(activityId, pointId, raceIds)
	UltimateWarAgent.instance:sendPM_UltimateWarDispatchReq(activityId, pointId, raceIds)
end

function UltimateWarController:handlePM_UltimateWarDispatchRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarDispatchRes(msg)
	self:_updateFirstStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarDispatchRes)
end

function UltimateWarController:sendPM_UltimateWarGainHangingPrizeReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarGainHangingPrizeReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarGainHangingPrizeRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarGainHangingPrizeRes(msg)
	self:_updateFirstStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarGainHangingPrizeRes)
end

function UltimateWarController:sendPM_UltimateWarSecondStepInfoReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarSecondStepInfoReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarSecondStepInfoRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarSecondStepInfoRes(msg)
	self:_updateSecondStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarSecondStepInfoRes)
end

function UltimateWarController:sendPM_UltimateWarTowerFightReq(activityId, towerId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local stageId = 0
		local maxStageCount = 0
		local msg = self._endBattleInTowerStageMsg

		if msg then
			stageId = msg.stageId
			maxStageCount = UltimateWarConfig.instance:getMaxStageCount(msg.activityId, msg.towerId)
		end

		if stageId > 1 or stageId == 1 and msg.isWin then
			local passCount = msg.isWin and stageId or stageId - 1

			BattleSettlementController.instance:addConditionElement(langPara("已通关第<color=#20b376>%s</color>/%s关", passCount, maxStageCount))
			UIStateManager.instance:open(ViewName.BattleSettlementSuccess)
		else
			UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
		end

		return true
	end)
	UltimateWarAgent.instance:sendPM_UltimateWarTowerFightReq(activityId, towerId, form)
end

function UltimateWarController:handlePM_UltimateWarTowerFightRes(msg)
	return
end

function UltimateWarController:sendPM_UltimateWarContinueTowerFightReq(activityId, towerId)
	UltimateWarAgent.instance:sendPM_UltimateWarContinueTowerFightReq(activityId, towerId)
end

function UltimateWarController:handlePM_UltimateWarContinueTowerFightRes(msg)
	return
end

function UltimateWarController:handlePM_UltimateWarNotifyTowerFightRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarNotifyTowerFightRes(msg)
	BattleFacade.instance:startUltimateWarTowerStageBattle()

	self._continueBattleInTowerStageMsg = msg
	self._endBattleInTowerStageMsg = msg

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarNotifyTowerFightRes)
end

function UltimateWarController:sendPM_UltimateWarTowerBossFightReq(activityId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getUltimateWarMo(activityId)
		local msg = mo:getTowerBossMsg()

		if msg then
			UIStateManager.instance:push(ViewName.UltimateWarTowerBossResultPopView, activityId)

			result = true
		end

		return result
	end)
	UltimateWarAgent.instance:sendPM_UltimateWarTowerBossFightReq(activityId, form)
end

function UltimateWarController:handlePM_UltimateWarTowerBossFightRes(msg)
	return
end

function UltimateWarController:handlePM_UltimateWarNotifyTowerBossFightRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarNotifyTowerBossFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarNotifyTowerBossFightRes)
end

function UltimateWarController:sendPM_UltimateWarGainTowerBossPrizeReq(activityId, type, subId, prizeIdList)
	UltimateWarAgent.instance:sendPM_UltimateWarGainTowerBossPrizeReq(activityId, type, subId, prizeIdList)
end

function UltimateWarController:handlePM_UltimateWarGainTowerBossPrizeRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarGainTowerBossPrizeRes(msg)
	self:_updateSecondStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarGainTowerBossPrizeRes)
end

function UltimateWarController:sendPM_UltimateWarSubmitTowerBossFormReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarSubmitTowerBossFormReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarSubmitTowerBossFormRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarSubmitTowerBossFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarSubmitTowerBossFormRes)
end

function UltimateWarController:sendPM_UltimateWarThirdStepInfoReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarThirdStepInfoReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarThirdStepInfoRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarThirdStepInfoRes(msg)
	self:_updateThirdStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarThirdStepInfoRes)
end

function UltimateWarController:sendPM_UltimateWarThirdStepFightReq(activityId, bossId, form)
	UltimateWarAgent.instance:sendPM_UltimateWarThirdStepFightReq(activityId, bossId, form)
end

function UltimateWarController:handlePM_UltimateWarThirdStepFightRes(msg)
	return
end

function UltimateWarController:handlePM_UltimateWarNotifyThirdStepFightRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarNotifyThirdStepFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarNotifyThirdStepFightRes)
end

function UltimateWarController:sendPM_UltimateWarThirdStepCheckInReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarThirdStepCheckInReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarThirdStepCheckInRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarThirdStepCheckInRes(msg)
	self:_updateThirdStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarThirdStepCheckInRes)
end

function UltimateWarController:sendPM_UltimateWarThirdStepGainPrizeReq(activityId, prizeId)
	UltimateWarAgent.instance:sendPM_UltimateWarThirdStepGainPrizeReq(activityId, prizeId)
end

function UltimateWarController:handlePM_UltimateWarThirdStepGainPrizeRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarThirdStepGainPrizeRes(msg)
	self:_updateThirdStepRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarThirdStepGainPrizeRes)
end

function UltimateWarController:sendPM_UltimateWarRankViewReq(activityId, type)
	UltimateWarAgent.instance:sendPM_UltimateWarRankViewReq(activityId, type)
end

function UltimateWarController:handlePM_UltimateWarRankViewRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarRankViewRes, msg)
end

function UltimateWarController:sendPM_UltimateWarRecordReq(activityId)
	UltimateWarAgent.instance:sendPM_UltimateWarRecordReq(activityId)
end

function UltimateWarController:handlePM_UltimateWarRecordRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarRecordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarRecordRes)
end

function UltimateWarController:sendPM_UltimateWarVoteReq(activityId, selectVoteId)
	UltimateWarAgent.instance:sendPM_UltimateWarVoteReq(activityId, selectVoteId)
end

function UltimateWarController:handlePM_UltimateWarVoteRes(msg)
	local mo = self:getUltimateWarMo(msg.activityId)

	mo:handlePM_UltimateWarVoteRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_UltimateWarVoteRes)
end

function UltimateWarController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function UltimateWarController:getActivityType()
	return GameEnum.ActivityType.UltimateWar
end

function UltimateWarController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function UltimateWarController:getUltimateWarMo(activityId)
	return UltimateWarModel.instance:getUltimateWarMo(activityId)
end

function UltimateWarController:updateTotalRedPoint(activityId)
	self:_updateFirstStepRed(activityId)
	self:_updateSecondStepRed(activityId)
	self:_updateThirdStepRed(activityId)
end

function UltimateWarController:_updateFirstStepRed(activityId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILY, false)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILYFIRSTDISPATCH, false)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_CANDISPATCH, false)

	local resultOfEnterStep = self:getTryEnterStepResultAndTips(false, activityId, UltimateWarEnum.StepId_One)

	if resultOfEnterStep == GameEnum.ResultCode.Success then
		RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILY)
		RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILYFIRSTDISPATCH)

		if self:isCanDisPatchInAll(activityId) then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_CANDISPATCH, true)
		end
	end
end

function UltimateWarController:_updateSecondStepRed(activityId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_BOSSPRIZE, false)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_STAGEPRIZE, false)

	if self:isInActivityTime(activityId) then
		local mo = self:getUltimateWarMo(activityId)
		local cfg = UltimateWarConfig.instance:getTowerCfg(activityId)

		if cfg then
			for _, data in ipairs(cfg) do
				local towerInfo = mo:getTowerInfo(data.towerId)

				if towerInfo and towerInfo:isCanGetPrizeInTower() then
					RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_STAGEPRIZE, true)

					break
				end
			end
		end
	end

	if self:getTryEnterSecondBossTowerResultAndTips(false, activityId) == GameEnum.ResultCode.Success then
		local mo = self:getUltimateWarMo(activityId)

		if mo:isCanGetPrizeOfAllInTowerBoss(activityId) then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_BOSSPRIZE, true)
		end
	end
end

function UltimateWarController:_updateThirdStepRed(activityId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BOSSPrize, false)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BUFF, false)

	local resultOfEnterStep = self:getTryEnterStepResultAndTips(false, activityId, UltimateWarEnum.StepId_Three)

	if resultOfEnterStep == GameEnum.ResultCode.Success then
		local mo = self:getUltimateWarMo(activityId)

		if mo:isCanGetPrizeOfAllInFinalBoss(activityId) then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BOSSPrize, true)
		end

		if self:getTryGetBuffInFInalBossResultAndTips(false, activityId) == GameEnum.ResultCode.Success then
			RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BUFF)
		end
	end
end

function UltimateWarController:_updatePetUpRed(activityId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_PET_UP, false)

	local result = UltimateWarController.instance:getTryUpPetLevelResultAndTips(false, activityId)

	if result == GameEnum.ResultCode.Success then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_ULTIMATEWAR_PET_UP, true)
	end
end

function UltimateWarController:getTryEnterStepResultAndTips(isShowTips, activityId, stepId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self:getUltimateWarMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif not mo:isUnLockStepByTime(stepId) then
		result = GameEnum.ResultCode.Error
		tips = "未开启"
	elseif not mo:isUnLockStepByPreCond(stepId) then
		result = GameEnum.ResultCode.Error

		local lastStepId = stepId - 1
		local data = UltimateWarConfig.instance:getStepData(activityId, lastStepId)

		tips = data and string.format("请先进入%s，再进入本阶段", data.desc) or "请先进入上一阶段，再进入本阶段"
	else
		local data = UltimateWarConfig.instance:getStepData(activityId, stepId)
		local level = mo:getPetLevel()
		local needLevel = UltimateWarEnum.StepUnlock_Levels[stepId]

		if level < needLevel then
			tips = string.format("斐希司强化到%s级，才能进入%s", needLevel, data.desc)
			result = GameEnum.ResultCode.Error
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function UltimateWarController:getTryUpPetLevelResultAndTips(isShowTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local mo = self:getUltimateWarMo(activityId)
		local curLevel = mo:getPetLevel()
		local maxLevel = mo:getMaxPetLevel()
		local nextLevel = curLevel + 1

		if maxLevel < nextLevel then
			result = GameEnum.ResultCode.IsMaxLimit
			tips = "等级已满"
		else
			local data = UltimateWarConfig.instance:getPetLevelData(activityId, nextLevel)
			local arr = string.split(data.param, "$")
			local cond = arr[1]

			if cond == "COST" then
				local matType, matId, matNum = MaterialMgr.getMatParams(arr[2])
				local cur = MaterialModel.instance:getMaterialsNumber(matType, matId)

				if cur < matNum then
					result = GameEnum.ResultCode.Error

					local matName = MaterialMgr.getMaterialsNameByCfg(arr[2])

					tips = string.format("%s不足", matName)
				end
			elseif cond == "PLOT" then
				local plotId = checknumber(arr[2])

				if not mo:isFinishPlotId(plotId) then
					result = GameEnum.ResultCode.Error

					local plotData = UltimateWarConfig.instance:getPlotData(activityId, plotId)

					tips = string.format("未解锁%s", plotData.name)
				end
			end
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function UltimateWarController:getTryEnterSecondBossTowerResultAndTips(isShowTips, activityId)
	local tips = ""
	local result = self:getTryEnterStepResultAndTips(isShowTips, activityId, UltimateWarEnum.StepId_Two)

	if result == GameEnum.ResultCode.Success then
		local mo = self:getUltimateWarMo(activityId)

		if not mo:isPassAllTower() then
			result = GameEnum.ResultCode.Error
			tips = "通关所有元素塔后开启"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function UltimateWarController:isCanDisPatchInAll(activityId)
	local result = false
	local cfg = UltimateWarConfig.instance:getDefenceLineCfg(activityId)

	if cfg then
		local mo = self:getUltimateWarMo(activityId)
		local raceIdLists = self:getCanDispatchAllPets(activityId)

		for _, data in ipairs(cfg) do
			local pointInfo = mo:getPointInfo(data.pointId)
			local oldRaceIdList = pointInfo:getAllRaceIds()

			if not raceIdLists[data.pointId] then
				if self:isNeedDispatchInPointByList(oldRaceIdList, raceIdLists[data.pointId]) then
					result = true

					break
				end
			end
		end
	end

	return result
end

function UltimateWarController:getCanDispatchAllPets(activityId)
	local bagPetsDic = {}
	local bagPets = HandbookModel.instance:getUserOwnedRaceIdMap()

	for raceId, awakenLv in pairs(bagPets) do
		if self:_isCanDispatchRace(raceId) then
			local attrs = PetSkinConfig.instance:getAllElementAttrs(raceId)

			for _, attr in ipairs(attrs) do
				bagPetsDic[attr] = bagPetsDic[attr] or {}
				bagPetsDic[attr][awakenLv] = bagPetsDic[attr][awakenLv] or {}

				table.insert(bagPetsDic[attr][awakenLv], raceId)
			end
		end
	end

	local rareA, rareB

	for attr, awakenLvs in pairs(bagPetsDic) do
		for level, list in pairs(awakenLvs) do
			table.sort(list, function(a, b)
				rareA = CharacterConfig.instance:getInitRare(a)
				rareB = CharacterConfig.instance:getInitRare(b)

				return rareA > rareB
			end)
		end
	end

	local raceIds = {}
	local raceIdLists = {}
	local cfg = UltimateWarConfig.instance:getDefenceLineCfg(activityId)

	for _, data in ipairs(cfg or {}) do
		local pointId = data.pointId

		raceIdLists[pointId] = {}

		for _, raceId in ipairs(data.specialRaceIds) do
			if self:_isCanDispatchRace(raceId) then
				raceIds[raceId] = raceId

				table.insert(raceIdLists[pointId], raceId)
			end
		end

		local maxCount = data.normalPetCountLimit

		if not data.attributes then
			local attributes = {}
			local count = 0
			local isEnd = false

			for awakenLv = 6, 0, -1 do
				for _, attr in ipairs(attributes) do
					if bagPetsDic[attr] and bagPetsDic[attr][awakenLv] then
						for idx, raceId in ipairs(bagPetsDic[attr][awakenLv]) do
							if raceIds[raceId] == nil then
								raceIds[raceId] = raceId

								table.insert(raceIdLists[pointId], raceId)

								count = count + 1

								if maxCount <= count then
									isEnd = true

									break
								end
							end
						end
					end

					if isEnd then
						break
					end
				end

				if isEnd then
					break
				end
			end
		end
	end

	return raceIdLists
end

function UltimateWarController:isNeedDispatchInPointByList(oldRaceIdList, newRaceIdList)
	return (not self:isSameAwakenLevelTotalForRaces(oldRaceIdList, newRaceIdList) or nil) and true
end

function UltimateWarController:isSameAwakenLevelTotalForRaces(oldRaceIdList, newRaceIdList)
	if #oldRaceIdList == #newRaceIdList then
		local oldValue = self:getTotalAwakeCount(oldRaceIdList)
		local newValue = self:getTotalAwakeCount(newRaceIdList)

		return oldValue == newValue
	else
		return false
	end
end

function UltimateWarController:getTotalAwakeCount(raceIds)
	local value = 0

	for _, raceId in pairs(raceIds) do
		value = value + HandbookModel.instance:getAwakenNum(raceId)
	end

	return value
end

function UltimateWarController:_isCanDispatchRace(raceId)
	return HandbookController.instance:isActivePet(raceId) or BagModel.instance:isExistRaceId(raceId)
end

function UltimateWarController:enterBattleTowerStage(activityId, towerId)
	local fmtMo = UltimateWarModel.instance:getTowerStageFmtMo()

	fmtMo:updateCfg(activityId, towerId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function UltimateWarController:isCanNextBattleInTowerStage()
	return self._curBattleResultIdx > -1
end

function UltimateWarController:getCurBattleResultIdxInTowerStage()
	return self._curBattleResultIdx
end

function UltimateWarController:tryNextBattleInTowerStage()
	self._curBattleResultIdx = -1

	local msg = self._continueBattleInTowerStageMsg

	self._continueBattleInTowerStageMsg = nil

	if msg and msg.isWin then
		local activityId, towerId, stageId = msg.activityId, msg.towerId, msg.stageId
		local maxStageCount = UltimateWarConfig.instance:getMaxStageCount(activityId, towerId)

		if stageId < maxStageCount then
			self._curBattleResultIdx = stageId - 1

			UltimateWarController.instance:sendPM_UltimateWarContinueTowerFightReq(activityId, towerId)
		end
	end

	return self._curBattleResultIdx > -1
end

function UltimateWarController:enterBattleTowerBoss(activityId)
	local fmtMo = UltimateWarModel.instance:getTowerBossFmtMo()

	fmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function UltimateWarController:enterBattleFinalBoss(activityId, bossId)
	local fmtMo = UltimateWarModel.instance:getFinalBossFmtMo()

	fmtMo:updateCfg(activityId, bossId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function UltimateWarController:getTryGetBuffInFInalBossResultAndTips(isShowTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local mo = self:getUltimateWarMo(activityId)

		if mo:isFullDay() then
			result = GameEnum.ResultCode.Error
			tips = "签到已满"
		elseif mo:isTodayCheckIn() then
			result = GameEnum.ResultCode.Error
			tips = "今天已签到"
		elseif mo:isPassAllFinalBoss() then
			result = GameEnum.ResultCode.Error
			tips = "已通关"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function UltimateWarController:openCommonTabRank(activityId, defaultKey)
	local params = CommonTabRankParams.New()

	params:addTabData(ViewName.UltimateWarTowerStageRankChildView, ViewName.UltimateWarTowerStageRankChildView, "元素塔排行榜", {
		activityId
	})
	params:addTabData(ViewName.UltimateWarTowerBossRankChildView, ViewName.UltimateWarTowerBossRankChildView, "领主伤害排行", {
		activityId
	})
	params:addTabData(ViewName.UltimateWarTowerFinalBossRankChildView, ViewName.UltimateWarTowerFinalBossRankChildView, "最终决战排行榜", {
		activityId
	})
	params:setDafaultOpenTab(defaultKey)
	UIStateManager.instance:push(ViewName.CommonTabRankFatherView, params)
end

UltimateWarController.instance = UltimateWarController.New()

return UltimateWarController
