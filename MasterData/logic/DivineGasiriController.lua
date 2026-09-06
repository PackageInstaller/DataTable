-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/controller/DivineGasiriController.lua

module("logic.extensions.divinegasiri.controller.DivineGasiriController", package.seeall)

local DivineGasiriController = class("DivineGasiriController", BaseController)

function DivineGasiriController:ctor()
	return
end

function DivineGasiriController:onReset()
	self._lastBattleResult = false
end

function DivineGasiriController:sendPM_DivineAresMomGetInfoReq(activityId)
	DivineAresMomAgent.instance:sendPM_DivineAresMomGetInfoReq(activityId)
end

function DivineGasiriController:handlePM_DivineAresMomGetInfoRes(msg)
	DivineGasiriModel.instance:_onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineAresMomGetInfoRes)
end

function DivineGasiriController:sendPM_DivineAresMomChallengeReq(activityId, form)
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.DivineGasiriMainView, nil, activityId)
	UIJumper.instance:pushOneStack(ViewName.DivineGasiriStageView, nil, activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	DivineAresMomAgent.instance:sendPM_DivineAresMomChallengeReq(activityId, form)
end

function DivineGasiriController:handlePM_Notify_DivineAresMomChallengeEndRes(msg)
	DivineGasiriModel.instance:_onGetBattleResult(msg)

	local info = GameUtil.pbToTable(msg)

	self._lastBattleResult = info.win

	local params = info

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DivineGasiri, params)
end

function DivineGasiriController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._lastBattleResult then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	else
		ViewMgr.instance:open(ViewName.BattleSettlementFail)
	end

	self._lastBattleResult = false

	return true
end

DivineGasiriController.instance = DivineGasiriController.New()

return DivineGasiriController
