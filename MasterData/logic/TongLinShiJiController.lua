-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/controller/TongLinShiJiController.lua

module("logic.extensions.tonglinshiji.controller.TongLinShiJiController", package.seeall)

local TongLinShiJiController = class("TongLinShiJiController", BaseController)

function TongLinShiJiController:ctor()
	return
end

function TongLinShiJiController:onInit()
	return
end

function TongLinShiJiController:onReset()
	return
end

function TongLinShiJiController:sendPM_JiClgGetInfoReq(activityId)
	TongLinShiJiAgent.instance:sendPM_JiClgGetInfoReq(activityId)
end

function TongLinShiJiController:handlePM_JiClgGetInfoRes(msg)
	TongLinShiJiModel.instance:handlePM_JiClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_JiClgGetInfoRes)
end

function TongLinShiJiController:sendPM_JiClgNormalStageReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEndNor, self, activityId, stageId))
	TongLinShiJiAgent.instance:sendPM_JiClgNormalStageReq(activityId, stageId, form)
end

function TongLinShiJiController:handlePM_Notify_JiClgNormalStageEndRes(msg)
	TongLinShiJiModel.instance:handlePM_Notify_JiClgNormalStageEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_JiClgNormalStageEndRes)
end

function TongLinShiJiController:sendPM_JiClgNormalBossReq(activityId, practice, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEndNorBoss, self, activityId, practice))
	TongLinShiJiAgent.instance:sendPM_JiClgNormalBossReq(activityId, practice, form)
end

function TongLinShiJiController:handlePM_Notify_JiClgNormalBossEndRes(msg)
	TongLinShiJiModel.instance:handlePM_Notify_JiClgNormalBossEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_JiClgNormalBossEndRes)
end

function TongLinShiJiController:sendPM_JiClgExtremeStageReq(activityId, raceType, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEndExt, self, activityId, raceType, stageId))
	TongLinShiJiAgent.instance:sendPM_JiClgExtremeStageReq(activityId, raceType, stageId, form)
end

function TongLinShiJiController:sendPM_JiClgConfirmExtremeScoreReq(activityId, raceType, stageId, confirm)
	TongLinShiJiAgent.instance:sendPM_JiClgConfirmExtremeScoreReq(activityId, raceType, stageId, confirm)
end

function TongLinShiJiController:handlePM_Notify_JiClgExtremeStageEndRes(msg)
	TongLinShiJiModel.instance:handlePM_Notify_JiClgExtremeStageEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_JiClgExtremeStageEndRes)
end

function TongLinShiJiController:handlePM_JiClgConfirmExtremeScoreRes(msg)
	TongLinShiJiModel.instance:handlePM_JiClgConfirmExtremeScoreRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_JiClgConfirmExtremeScoreRes)
end

function TongLinShiJiController:sendPM_JiClgGainPrizeReq(activityId, prizeType)
	TongLinShiJiAgent.instance:sendPM_JiClgGainPrizeReq(activityId, prizeType)
end

function TongLinShiJiController:handlePM_JiClgGainPrizeRes(msg)
	TongLinShiJiModel.instance:handlePM_JiClgGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_JiClgGainPrizeRes)
end

function TongLinShiJiController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function TongLinShiJiController:getSkinId(activityId)
	return TongLinShiJiConfig.instance:getCommonValue(activityId, "skinId")
end

function TongLinShiJiController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function TongLinShiJiController:getActivityType()
	return GameEnum.ActivityType.TongLinShiJi
end

function TongLinShiJiController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function TongLinShiJiController:GetNorBossHP(activityId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local curBossHp = curModel.normalInfo.bossLeftHp
	local bossCreepsMasterId = TongLinShiJiConfig.instance:getJiActivityData(activityId).normalBossId
	local cfg = TongLinShiJiConfig.instance:getJiCreepsData(bossCreepsMasterId)
	local totalHp = 0

	for creepsId, pet in ipairs(cfg) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(pet.extproperties) or {}
		local curPetHp = attrs[GameEnum.AttrType.Hp]

		totalHp = totalHp + curPetHp
	end

	if math.floor(curBossHp / totalHp * 10000) / 100 == 0 and checknumber(curBossHp) > 0 then
		return 0.01
	end

	return math.floor(curBossHp / totalHp * 10000) / 100
end

function TongLinShiJiController:bossLeftHP(activityId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local curBossHp = curModel.normalInfo.bossLeftHp

	return checknumber(curBossHp)
end

function TongLinShiJiController:GetNorBossProgress(activityId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local curBossHp = curModel.normalInfo.bossLeftHp
	local bossCreepsMasterId = TongLinShiJiConfig.instance:getJiActivityData(activityId).normalBossId
	local cfg = TongLinShiJiConfig.instance:getJiCreepsData(bossCreepsMasterId)
	local totalHp = 0

	for creepsId, pet in ipairs(cfg) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(pet.extproperties) or {}
		local curPetHp = attrs[GameEnum.AttrType.Hp]

		totalHp = totalHp + curPetHp
	end

	return curBossHp / totalHp
end

function TongLinShiJiController:_onResFightEndNor(activityId, stageId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)

	if curModel.normalInfo.todayPassedStageCount > 0 then
		local supportPetName = TongLinShiJiConfig.instance:GetCreepsName(activityId, stageId)
		local tipsContent = "BUFF解锁！\n" .. supportPetName .. "能够在斩妄挑战中助战啦！"

		local function func()
			BattleController.instance:endBattle()
		end

		TipsFacade.instance:openTipWindowNoX("挑战成功", tipsContent, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
	else
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	return true
end

function TongLinShiJiController:_onResFightEndNorBoss(activityId, practice)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local hurt = curModel.normalInfo.HurtBoss

	if practice or curModel.normalInfo.bossLeftHp > 0 then
		local tipsContent = "本次对BOSS造成伤害：" .. hurt .. "%"

		local function func()
			BattleController.instance:endBattle()
		end

		TipsFacade.instance:openTipWindow("挑战结束", tipsContent, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
	else
		UIStateManager.instance:push(ViewName.TongLinShiJiExtPassView, activityId, TongLinShiJiModel.NOR_PRIZE_TYPE)
	end

	return true
end

function TongLinShiJiController:_onResFightEndExt(activityId, raceType, stageId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local needConfirm = curModel.extremeInfo.needConfirm

	if needConfirm and curModel.extremeInfo.isWin then
		local oldScore = curModel.extremeInfo.showOldScore

		if oldScore ~= -1 then
			UIStateManager.instance:push(ViewName.TongLinShiJiExtCoverView, activityId, raceType, stageId)
		else
			UIStateManager.instance:push(ViewName.TongLinShiJiExtFinishView, activityId, raceType, stageId)
		end
	elseif needConfirm == nil and curModel.extremeInfo.isWin then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)

		return true
	elseif not curModel.extremeInfo.isWin then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	else
		UIStateManager.instance:push(ViewName.TongLinShiJiExtFinishView, activityId, raceType, stageId)
	end

	return true
end

function TongLinShiJiController:enterNorBattleClg(activityId, stageId)
	local customNorFmtMo = TongLinShiJiModel.instance:getNorFmtMo(activityId)

	customNorFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customNorFmtMo)
end

function TongLinShiJiController:enterNorBossBattleClg(activityId, practice)
	local customNorBossFmtMo = TongLinShiJiModel.instance:getNorBossFmtMo(activityId)

	customNorBossFmtMo:updateCfg(activityId, practice)
	CustomFmtController.instance:showMissionView(customNorBossFmtMo)
end

function TongLinShiJiController:enterExtBattleClg(activityId, raceType, stageId)
	local customExtFmtMo = TongLinShiJiModel.instance:getExtFmtMo(activityId)

	customExtFmtMo:updateCfg(activityId, raceType, stageId)
	CustomFmtController.instance:showMissionView(customExtFmtMo)
end

function TongLinShiJiController:CanGetNorReward(activityId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)

	return checknumber(curModel.normalInfo.bossLeftHp) <= 0 and not curModel.normalInfo.gainPrize
end

function TongLinShiJiController:CanGetExtReward(activityId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local scoreLimit = TongLinShiJiConfig.instance:getJiActivityData(activityId).extremeTotalScoreLimit
	local scoreRange = TongLinShiJiConfig.instance:getJiActivityData(activityId).extremeScoreRange
	local totalScore = TongLinShiJiModel.instance:GetCurExtTotalPower(activityId)
	local scores = TongLinShiJiModel.instance:GetCurExtPowers(activityId) or {}
	local notOutRange = true

	for k, v in pairs(scores) do
		if v > scoreRange[2] or v < scoreRange[1] then
			notOutRange = false
		end
	end

	return scoreLimit <= totalScore and notOutRange and not curModel.extremeInfo.gainPrize
end

function TongLinShiJiController:CoverCanGetExtReward(activityId, raceType, preScore, curScore)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local scoreLimit = TongLinShiJiConfig.instance:getJiActivityData(activityId).extremeTotalScoreLimit
	local scoreRange = TongLinShiJiConfig.instance:getJiActivityData(activityId).extremeScoreRange
	local totalScore = TongLinShiJiModel.instance:GetCurExtTotalPower(activityId)
	local scores = TongLinShiJiModel.instance:GetCurExtPowers(activityId) or {}
	local notOutRange = true

	for type, v in pairs(scores) do
		if type == raceType then
			v = v - preScore + curScore
		end

		if v > scoreRange[2] or v < scoreRange[1] then
			notOutRange = false
		end
	end

	return scoreLimit <= totalScore and notOutRange and not curModel.extremeInfo.gainPrize
end

function TongLinShiJiController:_hasFinishNorBuffChallenge(activityId)
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)
	local buffData = TongLinShiJiConfig.instance:getJiBuffData()

	if curModel.normalInfo.passedStageIds then
		if not #curModel.normalInfo.passedStageIds then
			local curPassBuffNum = 0

			return curPassBuffNum >= #buffData
		end
	end
end

function TongLinShiJiController:_updateDateClgTimesRed(activityId)
	local redId = RedPointModel.ID_TONG_LIN_SHI_JI_DAILY
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)

	if curModel.normalInfo then
		local norLeftTimes, _ = TongLinShiJiModel.instance:GetNorLeftTimes(activityId)
		local hasFinishAllBuff = self:_hasFinishNorBuffChallenge(activityId)
		local canGetNorPrize = TongLinShiJiController.instance:CanGetNorReward(activityId)

		if self:isInActivityTime(activityId) then
			if norLeftTimes > 0 and not curModel.normalInfo and not hasFinishAllBuff or canGetNorPrize then
				RedPointController.instance:setRedPointInfo(redId, true)
			else
				RedPointController.instance:setRedPointInfo(redId, false)
			end
		end
	end
end

function TongLinShiJiController:_updateNorRewardRed(activityId)
	local redId = RedPointModel.ID_TONG_LIN_SHI_JI_NOR_REWARD
	local curModel = TongLinShiJiModel.instance:GetModel(activityId)

	if curModel.normalInfo then
		local canGetReward = self:CanGetNorReward(activityId)

		if self:isInActivityTime(activityId) then
			if canGetReward and not curModel.normalInfo then
				RedPointController.instance:regUserOnceRedPoint(redId)
			else
				RedPointController.instance:saveUserOnceRedPoint(redId, true)
			end
		end
	end
end

function TongLinShiJiController:_updateExtRewardRed(activityId)
	local redId = RedPointModel.ID_TONG_LIN_SHI_JI_EXT_REWARD
	local canGetReward = self:CanGetExtReward(activityId)

	if self:isInActivityTime(activityId) then
		if canGetReward then
			RedPointController.instance:regUserDayRedPoint(redId)
		else
			RedPointController.instance:saveUserDayRedPoint(redId)
		end
	end
end

TongLinShiJiController.instance = TongLinShiJiController.New()

return TongLinShiJiController
