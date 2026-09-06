-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/controller/OriginZhengliController.lua

module("logic.extensions.originzhengli.controller.OriginZhengliController", package.seeall)

local OriginZhengliController = class("OriginZhengliController", BaseController)

function OriginZhengliController:onInit()
	self:onReset()
end

function OriginZhengliController:onReset()
	self.ciList = nil
	self._curFmtMo = nil
end

function OriginZhengliController:getInfo(activityId)
	OriginZhengliAgent.instance:sendPM_OriginZhengliInfoReq(activityId)
end

function OriginZhengliController:handlePM_OriginZhengliInfoRes(msg)
	OriginZhengliModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginJusticeClgGetInfoRes)
end

function OriginZhengliController:selectRoute(activityId, routeId)
	OriginZhengliAgent.instance:sendPM_OriginZhengliSelectRouteReq(activityId, routeId)
end

function OriginZhengliController:handlePM_OriginZhengliSelectRouteRes(msg)
	OriginZhengliModel.instance:onSelectRoute(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginZhengliSelectRouteRes)
end

function OriginZhengliController:challenge(activityId, form_pb, stageId, activateBuff)
	OriginZhengliModel.instance:clearLastFightInfo()
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEnd, self))
	OriginZhengliAgent.instance:sendPM_OriginZhengliClgReq(activityId, form_pb, stageId, activateBuff)
end

function OriginZhengliController:handlePM_OriginZhengliClgRes(msg)
	return
end

function OriginZhengliController:reset(activityId)
	OriginZhengliAgent.instance:sendPM_OriginZhengliResetReq(activityId)
end

function OriginZhengliController:handlePM_OriginZhengliResetRes(msg)
	OriginZhengliModel.instance:onResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginZhengliResetRes)
end

function OriginZhengliController:saveChallenge(activityId)
	OriginZhengliAgent.instance:sendPM_OriginZhengliSaveClgReq(activityId)
end

function OriginZhengliController:saveClg(activityId)
	self:saveChallenge(activityId)
end

function OriginZhengliController:handlePM_OriginZhengliSaveClgRes(msg)
	local info = GameUtil.pbToTable(msg)

	if info.activityId then
		self:getInfo(info.activityId)

		self.ciList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self.ciList)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginZhengliSaveClgRes)
end

function OriginZhengliController:notifyClgResult(msg)
	OriginZhengliModel.instance:onNotifyClgResult(msg)
end

function OriginZhengliController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function OriginZhengliController:getDefaultActivityId()
	return 587001
end

function OriginZhengliController:showMissionView(activityId, stageId, buffId)
	self._curFmtMo = self._curFmtMo or OriginZhengliFmtMo.New()

	local stageCfg = OriginZhengliConfig.instance:getStageCfgById(activityId, stageId)

	if not stageCfg then
		printError("源起正理挑战配置缺失，activityId: %d, stageId: %d", activityId, stageId)

		return
	end

	self._curFmtMo:initParams(activityId, stageCfg, buffId)
	CustomFmtController.instance:showMissionView(self._curFmtMo)
end

function OriginZhengliController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local lastFightInfo = OriginZhengliModel.instance:getLastFightInfo()

	if lastFightInfo then
		if lastFightInfo.isWin then
			UIStateManager.instance:push(ViewName.OriginzhengliResultView)
		else
			UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
		end
	else
		UIStateManager.instance:push(ViewName.BattleSettlementFailSimple)
	end

	return true
end

OriginZhengliController.instance = OriginZhengliController.New()

return OriginZhengliController
