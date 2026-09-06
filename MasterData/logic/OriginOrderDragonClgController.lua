-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/controller/OriginOrderDragonClgController.lua

module("logic.extensions.originorderdragonclg.controller.OriginOrderDragonClgController", package.seeall)

local OriginOrderDragonClgController = class("OriginOrderDragonClgController", BaseController)

function OriginOrderDragonClgController:onInit()
	self:onReset()
end

function OriginOrderDragonClgController:onReset()
	self._fmtMoMap = {}
end

function OriginOrderDragonClgController:showMissionView(activityId, stageId)
	if GodDailyRankController.instance:isGodRankClosed(activityId) then
		local startTimeStr, endTimeStr = GodDailyRankController.instance:getRankCloseTimeRange(activityId)
		local dateStart = GameUtil.string2date("0-0-0 " .. startTimeStr)
		local dateEnd = GameUtil.string2date("0-0-0 " .. endTimeStr)
		local tipsStr = string.format("每日%02d:%02d - %02d:%02d挑战关闭，不可挑战", dateStart.hour, dateStart.min, dateEnd.hour, dateEnd.min)

		FloatWordMgr.instance:show(tipsStr)

		return
	end

	local key = tostring(activityId) .. "_" .. tostring(stageId)

	self._fmtMoMap[key] = self._fmtMoMap[key] or OriginOrderDragonClgFmtMo.New()

	self._fmtMoMap[key]:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(self._fmtMoMap[key])
end

function OriginOrderDragonClgController:getInfo(activityId)
	OriginOrderDragonClgAgent.instance:sendPM_OriginOrderDragonClgGetInfoReq(activityId)
end

function OriginOrderDragonClgController:handlePM_OriginOrderDragonClgGetInfoRes(msg)
	OriginOrderDragonClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginOrderDragonClgGetInfoRes)
end

function OriginOrderDragonClgController:fight(activityId, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEnd, self))
	OriginOrderDragonClgAgent.instance:sendPM_OriginOrderDragonClgFightReq(activityId, stageId, form_pb)
end

function OriginOrderDragonClgController:reset(activityId)
	OriginOrderDragonClgAgent.instance:sendPM_OriginOrderDragonClgResetReq(activityId)
end

function OriginOrderDragonClgController:handlePM_OriginOrderDragonClgResetRes(msg)
	OriginOrderDragonClgModel.instance:onResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginOrderDragonClgResetRes)
end

function OriginOrderDragonClgController:confirm(activityId, stageId, save)
	OriginOrderDragonClgAgent.instance:sendPM_OriginOrderDragonClgConfirmReq(activityId, stageId, save)
end

function OriginOrderDragonClgController:handlePM_OriginOrderDragonClgConfirmRes(msg)
	OriginOrderDragonClgModel.instance:onConfirmInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginOrderDragonClgConfirmRes)
end

function OriginOrderDragonClgController:notifyFightResult(msg)
	OriginOrderDragonClgModel.instance:onNotifyFightResult(msg)
end

function OriginOrderDragonClgController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local lastFightInfo = OriginOrderDragonClgModel.instance:getLastFightInfo()

	if lastFightInfo then
		if lastFightInfo.isWin then
			UIStateManager.instance:push(ViewName.OriginOrderDragonClgResultView, lastFightInfo)
		else
			UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
		end
	else
		UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
	end

	return true
end

OriginOrderDragonClgController.instance = OriginOrderDragonClgController.New()

return OriginOrderDragonClgController
