-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/controller/OriginInfiniteFutureClgController.lua

module("logic.extensions.origininfinitefutureclg.controller.OriginInfiniteFutureClgController", package.seeall)

local OriginInfiniteFutureClgController = class("OriginInfiniteFutureClgController", BaseController)

function OriginInfiniteFutureClgController:onInit()
	self:onReset()
end

function OriginInfiniteFutureClgController:onReset()
	return
end

function OriginInfiniteFutureClgController:sendPM_OriginInfiniteFutureClgGetInfoReq(activityId)
	OriginInfiniteFutureClgAgent.instance:sendPM_OriginInfiniteFutureClgGetInfoReq(activityId)
end

function OriginInfiniteFutureClgController:handlePM_OriginInfiniteFutureClgGetInfoRes(msg)
	OriginInfiniteFutureClgModel.instance:handlePM_OriginInfiniteFutureClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginInfiniteFutureClgGetInfoRes)
end

function OriginInfiniteFutureClgController:sendPM_OriginInfiniteFutureClgFightReq(activityId, stageId, form)
	OriginInfiniteFutureClgAgent.instance:sendPM_OriginInfiniteFutureClgFightReq(activityId, stageId, form)
end

function OriginInfiniteFutureClgController:sendPM_OriginInfiniteFutureClgResetReq(activityId, stageId)
	OriginInfiniteFutureClgAgent.instance:sendPM_OriginInfiniteFutureClgResetReq(activityId, stageId)
end

function OriginInfiniteFutureClgController:handlePM_OriginInfiniteFutureClgResetRes(msg)
	OriginInfiniteFutureClgModel.instance:handlePM_OriginInfiniteFutureClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginInfiniteFutureClgResetRes)
end

function OriginInfiniteFutureClgController:handlePM_OriginInfiniteFutureClgNotifyFightRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
	OriginInfiniteFutureClgModel.instance:handlePM_OriginInfiniteFutureClgNotifyFightRes(msg)

	if checknumber(msg.changeSetId) > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		OriginInfiniteFutureClgModel.instance:pushChangeSetId(msg.activityId, msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginInfiniteFutureClgNotifyFightRes)
end

function OriginInfiniteFutureClgController:_onResFightEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.OriginInfiniteFutureClgFightEndView, msg)

	return true
end

function OriginInfiniteFutureClgController:enterBattleClg(activityId, stageId)
	local customFmtMo = OriginInfiniteFutureClgModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OriginInfiniteFutureClgController:stageHasPass(activityId, stageId)
	return OriginInfiniteFutureClgModel.instance:stageHasPass(activityId, stageId)
end

function OriginInfiniteFutureClgController:hasAllPass(activityId)
	local stageCfgs = OriginInfiniteFutureClgConfig.instance:getStageCfgs(activityId) or {}

	for stageId, _ in pairs(stageCfgs) do
		if not OriginInfiniteFutureClgModel.instance:stageHasPass(activityId, stageId) then
			return false
		end
	end

	return true
end

function OriginInfiniteFutureClgController:getLockRaceIdMap(activityId)
	return OriginInfiniteFutureClgModel.instance:getLockRaceIdMap(activityId)
end

function OriginInfiniteFutureClgController:getStageValueWanPercent(activityId, stageId, valueType)
	local count = OriginInfiniteFutureClgModel.instance:getStageValue(activityId, stageId, valueType)
	local valueCfg = OriginInfiniteFutureClgConfig.instance:getValueCfgByType(activityId, valueType) or {}

	return count * checknumber(valueCfg.valueWanPercent)
end

function OriginInfiniteFutureClgController:getStageTotalValueWanPercent(activityId, stageId)
	local totalValue = 0
	local valueCfgs = OriginInfiniteFutureClgConfig.instance:getValueCfgs(activityId) or {}

	for valueType, _ in pairs(valueCfgs) do
		totalValue = totalValue + self:getStageValueWanPercent(activityId, stageId, valueType)
	end

	return totalValue
end

OriginInfiniteFutureClgController.instance = OriginInfiniteFutureClgController.New()

return OriginInfiniteFutureClgController
