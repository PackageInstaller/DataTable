-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/controller/CiyuanlonghuangnuoyaController.lua

module("logic.extensions.ciyuanlonghuangnuoya.controller.CiyuanlonghuangnuoyaController", package.seeall)

local CiyuanlonghuangnuoyaController = class("CiyuanlonghuangnuoyaController", BaseController)

CiyuanlonghuangnuoyaController.SPECIAL_PHASE_ID = 3

function CiyuanlonghuangnuoyaController:onInit()
	self:onReset()
end

function CiyuanlonghuangnuoyaController:onReset()
	self._fmtMo = CiyuanlonghuangnuoyaFmtMo.New()
end

function CiyuanlonghuangnuoyaController:getActivityId()
	return 408001
end

function CiyuanlonghuangnuoyaController:sendGetInfo(activityId)
	CiYuanDragonNuoYaClgAgent.instance:sendPM_CiYuanDragonNuoYaClgGetInfoReq(activityId)
end

function CiyuanlonghuangnuoyaController:onGetInfo(msg)
	CiyuanlonghuangnuoyaModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CIYUANLONGHUANG_NUOYA_INFO_UPDATE)
end

function CiyuanlonghuangnuoyaController:openFmtView(activityId, phaseId, stageId)
	self._fmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function CiyuanlonghuangnuoyaController:sendResetStage(activityId, phaseId, stageId)
	CiYuanDragonNuoYaClgAgent.instance:sendPM_CiYuanDragonNuoYaClgResetStageReq(activityId, stageId)
end

function CiyuanlonghuangnuoyaController:onResetStage(msg)
	CiyuanlonghuangnuoyaModel.instance:onResetStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CIYUANLONGHUANG_NUOYA_INFO_UPDATE)
end

function CiyuanlonghuangnuoyaController:sendConfirm(activityId, confirmNum, save)
	CiYuanDragonNuoYaClgAgent.instance:sendPM_CiYuanDragonNuoYaClgConfirmReq(activityId, confirmNum, save)
end

function CiyuanlonghuangnuoyaController:onConfirm(msg)
	CiyuanlonghuangnuoyaModel.instance:onConfirm(msg)

	local info = CiyuanlonghuangnuoyaModel.instance:getInfo(msg.activityId) or {}
	local curPhaseId = checknumber(info.curPhaseId)
	local list = CiyuanlonghuangnuoyaConfig.instance:getPhaseListById(msg.activityId) or {}

	if curPhaseId > #list then
		UIJumper.instance:removeTopState(ViewName.CiyuanlonghuangnuoyalevelView)
	end

	GlobalDispatcher:dispatch(GlobalNotify.CIYUANLONGHUANG_NUOYA_INFO_UPDATE)
end

function CiyuanlonghuangnuoyaController:sendStartFight(activityId, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId))
	CiYuanDragonNuoYaClgAgent.instance:sendPM_CiYuanDragonNuoYaClgFightReq(activityId, stageId, form_pb)
end

function CiyuanlonghuangnuoyaController:handleFightRes(msg)
	CiyuanlonghuangnuoyaModel.instance:handleFightRes(msg)
end

function CiyuanlonghuangnuoyaController:_onNorBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = CiyuanlonghuangnuoyaModel.instance:getFightPb(activityId)

	if pb and pb.win then
		local info = CiyuanlonghuangnuoyaModel.instance:getInfo(activityId) or {}
		local curPhaseId = checknumber(info.curPhaseId)
		local list = CiyuanlonghuangnuoyaConfig.instance:getPhaseListById(activityId) or {}

		if curPhaseId > #list then
			UIJumper.instance:removeTopState(ViewName.CiyuanlonghuangnuoyalevelView)
		end

		if pb.curFightPhaseId == CiyuanlonghuangnuoyaController.SPECIAL_PHASE_ID then
			UIStateManager.instance:push(ViewName.CiyuanlonghuangnuoyaresultlView, pb)

			return true
		else
			UIStateManager.instance:push(ViewName.CiyuanlonghuangnuoyanorresultlView, pb)

			return true
		end
	end

	return false
end

CiyuanlonghuangnuoyaController.instance = CiyuanlonghuangnuoyaController.New()

return CiyuanlonghuangnuoyaController
