-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/controller/DivineKingOrderClgController.lua

module("logic.extensions.divinekingorderclg.controller.DivineKingOrderClgController", package.seeall)

local DivineKingOrderClgController = class("DivineKingOrderClgController", BaseController)

function DivineKingOrderClgController:ctor()
	return
end

function DivineKingOrderClgController:onReset()
	self.ciList = {}
end

function DivineKingOrderClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivinekingordermainview", self._enterEventOpenView, self)
end

function DivineKingOrderClgController:getActivityType()
	return GameEnum.ActivityType.DivineKingOrderClg
end

function DivineKingOrderClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineKingOrderClgController:getInfo(activityId)
	DivineKingOrderClgAgent.instance:sendPM_DivineKingOrderClgGetInfoReq(activityId)
end

function DivineKingOrderClgController:handleGetInfo(msg)
	DivineKingOrderClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineKingOrderClgGetInfo)
end

function DivineKingOrderClgController:fight(activityId, form)
	DivineKingOrderClgAgent:sendPM_DivineKingOrderClgFightReq(activityId, form)
end

function DivineKingOrderClgController:handleFight(msg)
	DivineKingOrderClgModel.instance:onFight(msg)
end

function DivineKingOrderClgController:handleNotifyFightResult(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
	DivineKingOrderClgModel.instance:onNotifyFightResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineKingOrderClgNotifyFight)
	DivineKingOrderClgController.instance:checkAoqiGodFinish(msg.activityId)
end

function DivineKingOrderClgController:_onResFightEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if msg.win then
		UIStateManager.instance:push(ViewName.DivineKingOrderResultView, msg.activityId)

		return true
	end

	return false
end

function DivineKingOrderClgController:confirmSave(save)
	local activityId = DivineKingOrderClgModel.instance:getActivityId()
	local confirmNum = DivineKingOrderClgModel.instance:getConfirmNum()

	DivineKingOrderClgModel.instance:saveFightResult(save)
	DivineKingOrderClgAgent.instance:sendPM_DivineKingOrderClgFightConfirmReq(activityId, confirmNum, save)
end

function DivineKingOrderClgController:handleConfirmSave(msg, status)
	if status == 0 then
		DivineKingOrderClgModel.instance:onConfirmSave(msg)

		local ci = msg.changeSetId

		if ci then
			MaterialController.instance:saveChangeSetToTemp(ci)

			self.ciList = ci
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineKingOrderClgConfirmSave, status)
end

function DivineKingOrderClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function DivineKingOrderClgController:resetFight(activityId)
	DivineKingOrderClgAgent.instance:sendPM_DivineKingOrderClgResetReq(activityId)
end

function DivineKingOrderClgController:handleResetFight(msg)
	DivineKingOrderClgModel.instance:onResetFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineKingOrderClgResetFight, msg.status)
end

function DivineKingOrderClgController:_onError(status)
	return
end

function DivineKingOrderClgController:openBattleResultView()
	UIStateManager.instance:push(ViewName.DivineKingOrderResultView)
end

function DivineKingOrderClgController:checkAoqiGodFinish(activityId)
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local isPass = DivineKingOrderClgModel.instance:isChallengePass(activityId)

		if isPass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DivineKingOrderClg, activityId)
		end
	end
end

function DivineKingOrderClgController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivineKingOrderMainView, actId)
end

DivineKingOrderClgController.instance = DivineKingOrderClgController.New()

return DivineKingOrderClgController
