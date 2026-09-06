-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/controller/HolyDragonTempleController.lua

module("logic.extensions.holydragontemple.controller.HolyDragonTempleController", package.seeall)

local HolyDragonTempleController = class("HolyDragonTempleController", BaseController)

function HolyDragonTempleController:onInit()
	self:onReset()
end

function HolyDragonTempleController:onReset()
	self._pendingPassPopWinFloorIds = {}
	self._pendingRewardChangeSetIds = {}
end

function HolyDragonTempleController:sendPM_HolyDragonTempleInfoReq(activityId)
	HolyDragonTempleAgent.instance:sendPM_HolyDragonTempleInfoReq(activityId)
end

function HolyDragonTempleController:handlePM_HolyDragonTempleInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HolyDragonTempleInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HolyDragonTempleInfoRes, msg)
end

function HolyDragonTempleController:sendPM_HolyDragonTempleChallengeReq(activityId, form, floorId, stageId)
	HolyDragonTempleAgent.instance:sendPM_HolyDragonTempleChallengeReq(activityId, form, floorId, stageId)
end

function HolyDragonTempleController:handlePM_HolyDragonTempleChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HolyDragonTempleChallengeRes, msg)
end

function HolyDragonTempleController:handlePM_HolyDragonTempleNotifyChallengeRes(msg)
	local subMo = self:getSubMo(msg.activityId)
	local wasAllPassed = self:_isFloorAllPassed(msg.activityId, msg.floorId, subMo)
	local isWin = checkbool(msg.isWin)
	local isPassed = checkbool(msg.isPassed)
	local isChallengePassed = isWin and isPassed

	subMo:handlePM_HolyDragonTempleNotifyChallengeRes(msg)

	local rewardChangeSetId = checknumber(msg.changeSetId)

	if isChallengePassed and rewardChangeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(rewardChangeSetId)
		BattleSettlementModel.instance:setChangeSetId(rewardChangeSetId)
		self:_setPendingRewardChangeSetId(msg.activityId, rewardChangeSetId)
	end

	if isChallengePassed and not wasAllPassed and self:_isFloorAllPassed(msg.activityId, msg.floorId, subMo) then
		self:_setPendingPassPopWinFloorId(msg.activityId, msg.floorId)
	end

	BattleFacade.instance:registerResultHandler(function()
		local stageData = HolyDragonTempleConfig.instance:getStageData(msg.activityId, msg.floorId, msg.stageId)

		if stageData then
			if not stageData.comboTimes then
				local comboTimes = 0

				if stageData then
					if not stageData.circleNum then
						local circleNum = 0
						local activityData = HolyDragonTempleConfig.instance:getActivityData(msg.activityId)
						local clgType = 0

						if circleNum > 0 then
							clgType = 2
						elseif comboTimes > 0 then
							clgType = 1
						end

						if clgType == 0 then
							BattleSettlementController.instance:addDefaultConditions()
						elseif clgType == 1 then
							BattleSettlementController.instance:addDefaultConditions()

							local decComboTimes = self:_getActiveDecComboTimes(msg.activityId, msg.floorId)
							local signInDesc = decComboTimes > 0 and langPara("（签到-%s连击）", decComboTimes) or ""
							local targetComboTimes = math.max(0, comboTimes - decComboTimes)
							local progressDesc = self:_formatTargetProgressDesc(self:_getNotifyChallengeExtParams(msg), targetComboTimes)
							local comboTimesDesc = string.format("%s%s", comboTimes, signInDesc)
							local conditionDesc = string.format(activityData.formatComboTimes, comboTimesDesc)

							BattleSettlementController.instance:addConditionElement(conditionDesc .. progressDesc, isPassed)
						elseif clgType == 2 then
							local decCircleTimes = self:_getActiveDecCircleTimes(msg.activityId, msg.floorId)
							local signInDesc = decCircleTimes > 0 and langPara("（签到-%s回合）", decCircleTimes) or ""
							local targetCircleNum = math.max(0, circleNum - decCircleTimes)
							local progressDesc = self:_formatTargetProgressDesc(self:_getNotifyChallengeExtParams(msg), targetCircleNum)
							local conditionDesc = string.format(activityData.formatCircle, circleNum, signInDesc)

							BattleSettlementController.instance:addConditionElement(conditionDesc .. progressDesc, isPassed)
						end

						if isChallengePassed then
							ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
						else
							BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Default, {
								isShowTeam = true,
								isHideRecommend = true
							})
							ViewMgr.instance:open(ViewName.BattleSettlementFail)
						end

						return true
					end
				end
			end
		end
	end)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HolyDragonTempleNotifyChallengeRes, msg)
end

function HolyDragonTempleController:sendPM_HolyDragonTempleSignInReq(activityId, floorId)
	HolyDragonTempleAgent.instance:sendPM_HolyDragonTempleSignInReq(activityId, floorId)
end

function HolyDragonTempleController:handlePM_HolyDragonTempleSignInRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HolyDragonTempleSignInRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HolyDragonTempleSignInRes, msg)
end

function HolyDragonTempleController:getSubMo(activityId)
	return HolyDragonTempleModel.instance:getSubMo(activityId)
end

function HolyDragonTempleController:showGoldMissionView(activityId, floorId, stageId)
	local fmtMo = HolyDragonTempleModel.instance:getGoldFmtMo(activityId)

	fmtMo:initParams(activityId, floorId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function HolyDragonTempleController:showLightMissionView(activityId, floorId, stageId)
	local fmtMo = HolyDragonTempleModel.instance:getLightFmtMo(activityId)

	fmtMo:initParams(activityId, floorId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function HolyDragonTempleController:_getActiveDecCircleTimes(activityId, floorId)
	local subMo = self:getSubMo(activityId)
	local signInDays = subMo and checknumber(subMo:getSignInDays(floorId)) or 0

	if signInDays <= 0 then
		return 0
	end

	local buffData = HolyDragonTempleConfig.instance:getSignInBuffDataBySignInDays(activityId, floorId, signInDays)

	return buffData and checknumber(buffData.decCircleTimes) or 0
end

function HolyDragonTempleController:_getActiveDecComboTimes(activityId, floorId)
	local subMo = self:getSubMo(activityId)
	local signInDays = subMo and checknumber(subMo:getSignInDays(floorId)) or 0

	if signInDays <= 0 then
		return 0
	end

	local buffData = HolyDragonTempleConfig.instance:getSignInBuffDataBySignInDays(activityId, floorId, signInDays)

	return buffData and checknumber(buffData.decComboTimes) or 0
end

function HolyDragonTempleController:_formatTargetProgressDesc(actualTimes, targetTimes)
	actualTimes = checknumber(actualTimes)
	targetTimes = checknumber(targetTimes)

	local actualColor = targetTimes <= actualTimes and "#20b376" or "#eb4624"
	local actualDesc = string.format("<color=%s>%s</color>", actualColor, actualTimes)
	local targetDesc = string.format("<color=#20b376>%s</color>", targetTimes)

	return langPara("（%s/%s）", actualDesc, targetDesc)
end

function HolyDragonTempleController:_getNotifyChallengeExtParams(msg)
	if msg and msg.HasField and msg:HasField("extParams") then
		return checknumber(msg.extParams)
	end

	return 0
end

function HolyDragonTempleController:_isFloorAllPassed(activityId, floorId, subMo)
	activityId = checknumber(activityId)
	floorId = checknumber(floorId)
	subMo = subMo or self:getSubMo(activityId)

	local stageDatas = HolyDragonTempleConfig.instance:getStageDatas(activityId, floorId)
	local hasStage = false

	for stageId, _ in pairs(stageDatas or {}) do
		hasStage = true

		if not subMo:isStagePassed(floorId, stageId) then
			return false
		end
	end

	return hasStage
end

function HolyDragonTempleController:_setPendingPassPopWinFloorId(activityId, floorId)
	activityId = checknumber(activityId)
	floorId = checknumber(floorId)

	if activityId <= 0 or floorId <= 0 then
		return
	end

	self._pendingPassPopWinFloorIds[activityId] = floorId
end

function HolyDragonTempleController:consumePendingPassPopWinFloorId(activityId)
	activityId = checknumber(activityId)

	if not self._pendingPassPopWinFloorIds[activityId] then
		self._pendingPassPopWinFloorIds[activityId] = nil

		return self._pendingPassPopWinFloorIds[activityId]
	end
end

function HolyDragonTempleController:_setPendingRewardChangeSetId(activityId, changeSetId)
	activityId = checknumber(activityId)
	changeSetId = checknumber(changeSetId)

	if activityId <= 0 or changeSetId <= 0 then
		return
	end

	self._pendingRewardChangeSetIds[activityId] = changeSetId
end

function HolyDragonTempleController:consumePendingRewardChangeSetId(activityId)
	activityId = checknumber(activityId)

	if not self._pendingRewardChangeSetIds[activityId] then
		self._pendingRewardChangeSetIds[activityId] = nil

		return self._pendingRewardChangeSetIds[activityId]
	end
end

function HolyDragonTempleController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function HolyDragonTempleController:getActivityType()
	return GameEnum.ActivityType.HolyDragonTemple
end

HolyDragonTempleController.instance = HolyDragonTempleController.New()

return HolyDragonTempleController
