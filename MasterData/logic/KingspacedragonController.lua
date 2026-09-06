-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/controller/KingspacedragonController.lua

module("logic.extensions.kingspacedragon.controller.KingspacedragonController", package.seeall)

local KingspacedragonController = class("KingspacedragonController", BaseController)

KingspacedragonController.RedPointKeyPre = "KingspacedragonController.RedPointKeyPre"
KingspacedragonController.DailyEnterKey = "KingspacedragonController.DailyEnterKey"

function KingspacedragonController:ctor()
	return
end

function KingspacedragonController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterkingspacedragonmainview", self._enterEventOpenView, self)
end

function KingspacedragonController:onReset()
	self._needConfirm = false
	self._cacheFightMsg = nil
end

function KingspacedragonController:getActivityType()
	return GameEnum.ActivityType.KingSpaceDragon
end

function KingspacedragonController:isChallengePass(activityId)
	local stageId = KingspacedragonModel.instance:getPassedStageId(activityId)
	local cfgs = KingspacedragonConfig.instance:getStageCfgs(activityId)

	return stageId >= #cfgs
end

function KingspacedragonController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(KingspacedragonConfig.instance:getSkinId(activityId))
end

function KingspacedragonController:enterMission(activityId, clgType, creepsMasterId)
	local customFmtMo = KingspacedragonModel.instance:getCustomFmtMo()

	customFmtMo:initParams(activityId, clgType, creepsMasterId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KingspacedragonController:handlePM_KingSpaceDragonClgNotifyFightResultRes(msg)
	if self._clgReqActivityId then
		self:calRedpoint(self._clgReqActivityId)
	end

	self._needConfirm = false
	self._cacheFightMsg = nil

	local win = msg.win

	if not win then
		return
	end

	self._needConfirm = msg.confirmNum > 0

	if msg.confirmNum <= 0 then
		local maxsStage = #KingspacedragonConfig.instance:getStageCfgs(msg.activityId)

		if maxsStage < msg.curStageId then
			local activityId = msg.activityId
			local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

			if isAoqiGodProcessType then
				local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

				AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
			end
		end

		KingspacedragonModel.instance:fightWinRes(msg)
	end

	self._cacheFightMsg = msg
end

function KingspacedragonController:needConfirm()
	return self._needConfirm
end

function KingspacedragonController:resetNeedConfirm()
	self._needConfirm = false
end

function KingspacedragonController:getCacheClgFightResult()
	return self._cacheFightMsg
end

function KingspacedragonController:calRedpoint(activityId)
	local isOpen = GameUtil.getUserDayData(KingspacedragonController.DailyEnterKey)

	if isOpen then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_KingSpaceDragon_Daily, false)

		return
	end

	local isActivated = false

	activityId = checknumber(activityId)

	if activityId <= 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_KingSpaceDragon_Daily, false)

		return
	end

	local key = string.format("%s%s", KingspacedragonController.RedPointKeyPre, activityId)
	local isPass = GameUtil.getUserData(key)

	if not isPass then
		local curStageId = KingspacedragonModel.instance:getCurrStageId(activityId)
		local stageCfgs = KingspacedragonConfig.instance:getStageCfgs(activityId)

		if curStageId <= #stageCfgs then
			isActivated = true
		else
			GameUtil.saveUserData(key, true)
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_KingSpaceDragon_Daily, isActivated)
end

function KingspacedragonController:recordDailyEnter()
	GameUtil.saveUserDayData(KingspacedragonController.DailyEnterKey, true)
	self:calRedpoint()
end

function KingspacedragonController:sendPM_KingSpaceDragonClgFightReq(activityId, monsterType, form)
	self._clgReqActivityId = activityId

	KingSpaceDragonClgAgent.instance:sendPM_KingSpaceDragonClgFightReq(activityId, monsterType, form)
end

function KingspacedragonController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.KingspacedragonmainView, actId)
end

KingspacedragonController.instance = KingspacedragonController.New()

return KingspacedragonController
