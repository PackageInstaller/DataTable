-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/controller/DivineKunlunController.lua

module("logic.extensions.divinekunlun.controller.DivineKunlunController", package.seeall)

local DivineKunlunController = class("DivineKunlunController", BaseController)

function DivineKunlunController:onInit()
	self:onReset()
end

function DivineKunlunController:onReset()
	self._norFmtMo = DivineKunlunNorFmtMo.New()
	self._extFmtMo = DivineKunLunExtFmtMo.New()
end

function DivineKunlunController:getDefaultActivityId()
	return 464001
end

function DivineKunlunController:sendGetInfo(activityId)
	DivineKunLunClgAgent.instance:sendPM_DivineKunLunClgGetInfoReq(activityId)
end

function DivineKunlunController:onGetInfo(msg)
	DivineKunlunModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DIVINE_KUNLUN_INFO_UPDATE)
end

function DivineKunlunController:sendGetNorPrize(activityId, prizeId)
	DivineKunLunClgAgent.instance:sendPM_DivineKunLunClgGainNormalProgressPrizeReq(activityId, prizeId)
end

function DivineKunlunController:onGetNorPrize(msg)
	DivineKunlunModel.instance:onGetNorPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DIVINE_KUNLUN_INFO_UPDATE)
end

function DivineKunlunController:sendGetExtPrize(activityId)
	DivineKunLunClgAgent.instance:sendPM_DivineKunLunClgGainExtremePrizeReq(activityId)
end

function DivineKunlunController:onGetExtPrize(msg)
	DivineKunlunModel.instance:onGetExtPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DIVINE_KUNLUN_INFO_UPDATE)
end

function DivineKunlunController:sendConfirm(activityId, stageId, confirm)
	DivineKunLunClgAgent.instance:sendPM_DivineKunLunClgConfirmExtremeChallengeReq(activityId, stageId, confirm)
end

function DivineKunlunController:onConfirm(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DIVINE_KUNLUN_CLG_CONFIRM)
end

function DivineKunlunController:sendStartNorFight(activityId, stageArrIndex, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onNorBattleEnd, self, activityId))
	DivineKunLunClgAgent:sendPM_DivineKunLunClgNormalChallengeReq(activityId, stageArrIndex, form_pb)
end

function DivineKunlunController:handleNorFightRes(msg)
	DivineKunlunModel.instance:handleNorFightRes(msg)
end

function DivineKunlunController:_onNorBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = DivineKunlunModel.instance:getNorFightPb(activityId)

	if pb then
		if pb.win then
			UIStateManager.instance:push(ViewName.DivinekunlunnorresultView, activityId)

			return true
		else
			BattleSettlementController.instance:addDefaultConditions()
			BattleSettlementController.instance:addConditionElement(langPara("本次连击数：<color=#eb4642>%s</color>", 0))
			UIStateManager.instance:open(ViewName.BattleSettlementFail)

			return true
		end
	end

	return false
end

function DivineKunlunController:sendStartExtFight(activityId, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onExtBattleEnd, self, activityId))
	DivineKunLunClgAgent:sendPM_DivineKunLunClgExtremeChallengeReq(activityId, stageId, form_pb)
end

function DivineKunlunController:handleExtFightRes(msg)
	DivineKunlunModel.instance:handleExtFightRes(msg)
end

function DivineKunlunController:_onExtBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local pb = DivineKunlunModel.instance:getExtFightPb(activityId)

	if pb then
		if pb.win then
			UIStateManager.instance:push(ViewName.DivinekunlunmaxresultView, activityId)

			return true
		else
			BattleSettlementController.instance:addDefaultConditions()
			BattleSettlementController.instance:addConditionElement(langPara("本次连击数：<color=#eb4642>%s</color>", 0))
			UIStateManager.instance:open(ViewName.BattleSettlementFail)

			return true
		end
	end

	return false
end

function DivineKunlunController:openMissionView(activityId, idx, stageId)
	self._norFmtMo:initParams(activityId, idx, stageId)
	CustomFmtController.instance:showMissionView(self._norFmtMo)
end

function DivineKunlunController:openExtremeMissionView(activityId, stageId)
	self._extFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._extFmtMo)
end

DivineKunlunController.instance = DivineKunlunController.New()

return DivineKunlunController
