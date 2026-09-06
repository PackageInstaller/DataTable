-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/controller/MiracleNuoyaController.lua

module("logic.extensions.miraclenuoya.controller.MiracleNuoyaController", package.seeall)

local MiracleNuoyaController = class("MiracleNuoyaController", BaseController)

function MiracleNuoyaController:onInit()
	GlobalDispatcher:addListener("entermiraclenuoyachallenge", self._enterMiracleNuoyaChallenge, self)
	self:onReset()
end

function MiracleNuoyaController:onReset()
	self._extFmtMo = MiracleNuoyaExtFmtMo.New()
	self._norFmtMo = MiracleNuoyaNormalFmtMo.New()
end

function MiracleNuoyaController:getActivityId()
	return 382001
end

function MiracleNuoyaController:sendGetInfo(activityId)
	MiracleNuoYaClgAgent.instance:sendPM_MiracleNuoYaClgGetInfoReq(activityId)
end

function MiracleNuoyaController:onGetInfo(msg)
	MiracleNuoyaModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleNuoYaInfoUpdate)
end

function MiracleNuoyaController:sendGetProgressPrize(activityId, dataBitId)
	MiracleNuoYaClgAgent.instance:sendPM_MiracleNuoYaGainNormalClgProgressPrizeReq(activityId, dataBitId)
end

function MiracleNuoyaController:onGetProgressPrize(msg)
	MiracleNuoyaModel.instance:onGetProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleNuoYaInfoUpdate)
end

function MiracleNuoyaController:sendExtStartFight(activityId, blockId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onExtBattleEnd, self, activityId))
	MiracleNuoYaClgAgent.instance:sendPM_MiracleNuoYaExtremeClgReq(activityId, blockId, form_pb)
end

function MiracleNuoyaController:onStartFight(msg)
	return
end

function MiracleNuoyaController:sendNormalStartFight(activityId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId))
	MiracleNuoYaClgAgent.instance:sendPM_MiracleNuoYaNormalClgReq(activityId, form_pb)
end

function MiracleNuoyaController:onStartFight(msg)
	return
end

function MiracleNuoyaController:_onExtBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local activityType = self:getActivityType()

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
	end

	local pb = MiracleNuoyaModel.instance.extFightEndPb

	if pb and pb.win then
		UIStateManager.instance:push(ViewName.MiraclenuoyaresulttipsextView, activityId)

		return true
	else
		return false
	end
end

function MiracleNuoyaController:_onNorBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.MiraclenuoyaresulttipsnorView, activityId)

	return true
end

function MiracleNuoyaController:sendConfirmExtre(activityId, confirmNum, save)
	MiracleNuoYaClgAgent.instance:sendPM_MiracleNuoYaExtremeClgConfirmReq(activityId, confirmNum, save)
end

function MiracleNuoyaController:onConfirmExtre(status, msg)
	if status == 0 then
		MiracleNuoyaModel.instance:onConfirmExtre(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.MiracleNuoYaConfirmExtre, status)
end

function MiracleNuoyaController:sendResetExtre(activityId)
	MiracleNuoYaClgAgent.instance:sendPM_MiracleNuoYaResetExtremeClgReq(activityId)
end

function MiracleNuoyaController:onResetExtre(msg)
	MiracleNuoyaModel.instance:onResetExtre(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleNuoYaInfoUpdate)
end

function MiracleNuoyaController:openExtFmtView(activityId, blockId)
	self._extFmtMo:initParams(activityId, blockId)
	CustomFmtController.instance:showMissionView(self._extFmtMo)
end

function MiracleNuoyaController:openNorFmtView(activityId, gruopId)
	self._norFmtMo:initParams(activityId, gruopId)
	CustomFmtController.instance:showMissionView(self._norFmtMo)
end

function MiracleNuoyaController:getMySupportPetIdWithGender(activityId)
	local petId = 0
	local data = MiracleNuoyaConfig.instance:getActivityCfgById(activityId)

	if data then
		local gender = RoleModel.instance:getGender()

		petId = gender == GameEnum.Gender.Female and data.supportPetId4FemalePlayer or data.supportPetId4MalePlayer
	end

	return checknumber(petId)
end

function MiracleNuoyaController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function MiracleNuoyaController:getActivityType()
	return GameEnum.ActivityType.MiracleNuoyaChallenge
end

function MiracleNuoyaController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function MiracleNuoyaController:_enterMiracleNuoyaChallenge(params)
	self:enterMiracleNuoyaChallenge(checknumber(params[1]))
end

function MiracleNuoyaController:enterMiracleNuoyaChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.MiraclenuoyamainView, activityId)
end

MiracleNuoyaController.instance = MiracleNuoyaController.New()

return MiracleNuoyaController
