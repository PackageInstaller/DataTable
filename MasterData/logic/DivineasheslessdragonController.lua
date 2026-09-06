-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/controller/DivineasheslessdragonController.lua

module("logic.extensions.divineasheslessdragon.controller.DivineasheslessdragonController", package.seeall)

local DivineasheslessdragonController = class("DivineasheslessdragonController", BaseController)

DivineasheslessdragonController.RedPointKeyPre = "DivineasheslessdragonController.RedPointKeyPre"
DivineasheslessdragonController.DailyEnterKey = "DivineasheslessdragonController.DailyEnterKey"

function DivineasheslessdragonController:ctor()
	return
end

function DivineasheslessdragonController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivineasheslessdragonmainview", self._enterEventOpenView, self)
end

function DivineasheslessdragonController:onReset()
	return
end

function DivineasheslessdragonController:sendPM_DivineAsheslessDragonChallengeReq(activityId, stageId, form)
	self._tempStageId = stageId

	DivineAsheslessDragonAgent.instance:sendPM_DivineAsheslessDragonChallengeReq(activityId, stageId, form)
end

function DivineasheslessdragonController:handlePM_Notify_DivineAsheslessDragonChallengeRes(msg)
	local win = msg.win

	if win then
		local activityId = DivineasheslessdragonModel.instance:getActivityId()
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local cfgs = DivineasheslessdragonConfig.instance:getStageCfgs(activityId)

			if checknumber(self._tempStageId) >= #cfgs then
				local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

				AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
				BattleController.instance:endBattle()
			else
				DivineAsheslessDragonAgent.instance:sendPM_DivineAsheslessDragonGetInfoReq(activityId)
			end
		else
			DivineAsheslessDragonAgent.instance:sendPM_DivineAsheslessDragonGetInfoReq(activityId)
		end
	end

	self._tempStageId = nil

	GlobalDispatcher:dispatch(GlobalNotify.Notify_DivineAsheslessDragonChallengeRes)
end

function DivineasheslessdragonController:getActivityType()
	return GameEnum.ActivityType.DivineAsheslessDragon
end

function DivineasheslessdragonController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineasheslessdragonController:isChallengePass(activityId)
	local stageId = DivineasheslessdragonModel.instance:getPassedStageId(activityId)
	local cfgs = DivineasheslessdragonConfig.instance:getStageCfgs(activityId)

	return stageId >= #cfgs
end

function DivineasheslessdragonController:isCurStagePass(activityId, stage)
	local stageId = DivineasheslessdragonModel.instance:getPassedStageId(activityId)

	return stage <= stageId
end

function DivineasheslessdragonController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(DivineasheslessdragonConfig.instance:getSkinId(activityId))
end

function DivineasheslessdragonController:loadBaseData()
	local activityId = self:getActivityId()

	if activityId > 0 then
		local cfg = ActivityDefineConfig.instance:getCfgById(self:getActivityType(), activityId)

		if cfg.processType ~= 5 then
			DivineAsheslessDragonAgent.instance:sendPM_DivineAsheslessDragonGetInfoReq(activityId)
		end
	end
end

function DivineasheslessdragonController:calRedpoint()
	local isOpen = GameUtil.getUserDayData(DivineasheslessdragonController.DailyEnterKey)

	if isOpen then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_DivineasheslessDragon_Daily, false)

		return
	end

	local isActivated = false
	local activityId = self:getActivityId()

	if activityId <= 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_DivineasheslessDragon_Daily, false)

		return
	end

	local key = string.format("%s%s", DivineasheslessdragonController.RedPointKeyPre, activityId)
	local isPass = GameUtil.getUserData(key)

	if not isPass then
		local curStageId = DivineasheslessdragonModel.instance:getPassedStageId(activityId)
		local stageCfgs = DivineasheslessdragonConfig.instance:getStageCfgs(activityId)

		if curStageId < #stageCfgs then
			isActivated = true
		else
			GameUtil.saveUserData(key, true)
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DivineasheslessDragon_Daily, isActivated)
end

function DivineasheslessdragonController:recordDailyEnter()
	GameUtil.saveUserDayData(DivineasheslessdragonController.DailyEnterKey, true)
	self:calRedpoint()
end

function DivineasheslessdragonController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivineasheslessdragonmainView, actId)
end

DivineasheslessdragonController.instance = DivineasheslessdragonController.New()

return DivineasheslessdragonController
