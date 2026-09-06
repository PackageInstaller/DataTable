-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/controller/DivineYuHuiController.lua

module("logic.extensions.divineyuhui.controller.DivineYuHuiController", package.seeall)

local DivineYuHuiController = class("DivineYuHuiController", BaseController)

function DivineYuHuiController:onInit()
	self:onReset()
end

function DivineYuHuiController:onReset()
	self._chooseStageId = nil
end

function DivineYuHuiController:sendPM_DivineYuHuiClgInfoReq(activityId)
	DivineYuHuiAgent.instance:sendPM_DivineYuHuiClgInfoReq(activityId)
end

function DivineYuHuiController:handlePM_DivineYuHuiClgInfoRes(msg)
	DivineYuHuiModel.instance:handlePM_DivineYuHuiClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineYuHuiClgInfoRes)
end

function DivineYuHuiController:sendPM_DivineYuHuiClgResetReq(activityId, stageId)
	DivineYuHuiAgent.instance:sendPM_DivineYuHuiClgResetReq(activityId, stageId)
end

function DivineYuHuiController:handlePM_DivineYuHuiClgResetRes(msg)
	DivineYuHuiModel.instance:handlePM_DivineYuHuiClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineYuHuiClgResetRes, msg.stageId)
end

function DivineYuHuiController:sendPM_DivineYuHuiClgChallengeReq(activityId, stageId, form)
	DivineYuHuiAgent.instance:sendPM_DivineYuHuiClgChallengeReq(activityId, stageId, form)
end

function DivineYuHuiController:handlePM_NotifyDivineYuHuiClgFinishRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
	DivineYuHuiModel.instance:handlePM_NotifyDivineYuHuiClgFinishRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyDivineYuHuiClgFinishRes)
end

function DivineYuHuiController:_onResFightEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if msg.isWin then
		UIStateManager.instance:push(ViewName.DivineYuHuiFightEndView, msg.activityId, msg.raceIds)

		return true
	end

	return false
end

function DivineYuHuiController:enterBattleClg(activityId, stageId)
	local customFmtMo = DivineYuHuiModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineYuHuiController:allStageHasPass(activityId)
	local info = DivineYuHuiModel.instance:getInfo(activityId)
	local stageCfgs = DivineYuHuiConfig.instance:getStageCfg(activityId)
	local totalStageNums = #stageCfgs
	local allPass = true

	if info.stages then
		for i = 1, totalStageNums do
			if info.stages[i] == nil then
				allPass = false
			end
		end
	end

	return allPass
end

function DivineYuHuiController:getNextChooseStageId(activityId)
	local chooseId = 1
	local info = DivineYuHuiModel.instance:getInfo(activityId)
	local stageCfgs = DivineYuHuiConfig.instance:getStageCfg(activityId)

	for i, cfg in ipairs(stageCfgs) do
		local stageId = cfg.stageId
		local stageInfo

		if ((info.stages or nil) and info.stages[stageId]) == nil then
			return stageId
		end
	end

	return chooseId
end

function DivineYuHuiController:getCurChooseStageId(activityId)
	if self._chooseStageId == nil then
		self._chooseStageId = self:getNextChooseStageId(activityId)
	end

	return self._chooseStageId
end

function DivineYuHuiController:setCurChooseStageId(activityId, stageId)
	self._chooseStageId = stageId
end

DivineYuHuiController.instance = DivineYuHuiController.New()

return DivineYuHuiController
