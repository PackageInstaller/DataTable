-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/controller/DivineTianShanClgController.lua

module("logic.extensions.divinetianshanclg.controller.DivineTianShanClgController", package.seeall)

local DivineTianShanClgController = class("DivineTianShanClgController", BaseController)

function DivineTianShanClgController:ctor()
	return
end

function DivineTianShanClgController:onInit()
	self:onReset()
end

function DivineTianShanClgController:onReset()
	self._clgExtremeFmtMoMap = {}
	self._clgNormalFmtMoMap = {}
	self.ciList = nil
	self._exBuffParam = nil
end

function DivineTianShanClgController:setExBuffParam(param)
	self._exBuffParam = param
end

function DivineTianShanClgController:getExBuffParam()
	return self._exBuffParam
end

function DivineTianShanClgController:openExtremeMissionView(activityId, stageId)
	local fmtMo = self._clgExtremeFmtMoMap[activityId]

	if not fmtMo then
		fmtMo = DivineTianShanExtremeFmtMo.New()
		self._clgExtremeFmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineTianShanClgController:openNormalMissionView(activityId, stageId, isPractice)
	local fmtMo = self._clgNormalFmtMoMap[activityId]

	if not fmtMo then
		fmtMo = DivineTianShanNormalFmtMo.New()
		self._clgNormalFmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, stageId, isPractice)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineTianShanClgController:getInfo(activityId)
	DivineTianShanClgAgent.instance:sendPM_DivineTianShanClgGetInfoReq(activityId)
end

function DivineTianShanClgController:handleGetInfo(msg)
	DivineTianShanClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineTianShanClgGetInfo)
end

function DivineTianShanClgController:startExtremeFight(activityId, stageId, form_pb)
	DivineTianShanClgAgent.instance:sendPM_DivineTianShanClgExtremeFightReq(activityId, stageId, form_pb)
end

function DivineTianShanClgController:resetExtremeFight(activityId, stageId)
	DivineTianShanClgAgent.instance:sendPM_DivineTianShanClgResetExtremeStageReq(activityId, stageId)
end

function DivineTianShanClgController:handleResetExtremeFight(msg)
	DivineTianShanClgModel.instance:onResetExtremeFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineTianShanClgResetExtremeFight)
end

function DivineTianShanClgController:startNormalFight(activityId, stageId, isPractice, form_pb)
	DivineTianShanClgAgent.instance:sendPM_DivineTianShanClgNormalFightReq(activityId, stageId, isPractice, form_pb)
end

function DivineTianShanClgController:gainNormalPrize(activityId, prizeId)
	DivineTianShanClgAgent.instance:sendPM_DivineTianShanClgGainPrizeReq(activityId, prizeId)
end

function DivineTianShanClgController:handleGainNormalPrize(msg)
	DivineTianShanClgModel.instance:onGainNormalPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineTianShanClgGainNormalPrize)
end

function DivineTianShanClgController:handleNotifyExtremeFight(msg)
	DivineTianShanClgModel.instance:onNotifyExtremeFight(msg)

	self.ciList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.ciList)

	if msg.isWin then
		BattleFacade.instance:registerResultHandler(nil, nil)
		BattleFacade.instance:registerResultHandler(function()
			ViewMgr.instance:open(ViewName.DivineTianShanClgResultView, msg.stageInfo)

			return true
		end)
	end
end

function DivineTianShanClgController:handleNotifyNormalFight(msg)
	DivineTianShanClgModel.instance:onNotifyNormalFight(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)
	BattleFacade.instance:registerResultHandler(function()
		ViewMgr.instance:open(ViewName.DivineTianShanNormalResultView, msg)

		return true
	end)
end

function DivineTianShanClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

DivineTianShanClgController.instance = DivineTianShanClgController.New()

return DivineTianShanClgController
