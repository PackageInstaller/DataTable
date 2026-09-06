-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/controller/DivineDakinosClgController.lua

module("logic.extensions.divinedakinosclg.controller.DivineDakinosClgController", package.seeall)

local DivineDakinosClgController = class("DivineDakinosClgController", BaseController)

function DivineDakinosClgController:ctor()
	return
end

function DivineDakinosClgController:sendPM_DivineDakinosClgGetInfoReq(activityId)
	DivineDakinosClgAgent.instance:sendPM_DivineDakinosClgGetInfoReq(activityId)
end

function DivineDakinosClgController:handlePM_DivineDakinosClgGetInfoRes(msg)
	DivineDakinosClgModel.instance:_onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineDakinosClgGetInfo)
end

function DivineDakinosClgController:sendPM_DivineDakinosClgFightReq(activityId, phaseId, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResBossBattleEnd, self, activityId))
	DivineDakinosClgAgent.instance:sendPM_DivineDakinosClgFightReq(activityId, phaseId, stageId, form)
end

function DivineDakinosClgController:handlePM_DivineDakinosClgNotifyFightResultRes(msg)
	self._saveFightPb = GameUtil.pbToTable(msg)
end

function DivineDakinosClgController:_onResBossBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local params = self._saveFightPb

	self._saveFightPb = nil

	if params then
		local stageCfg = DivineDakinosClgConfig.instance:getStageCfg(params.activityId, params.phaseId, params.stageId) or {}
		local needSaveCount = checknumber(stageCfg.needSaveCount)
		local saveCount = checknumber(params.saveCount)
		local txtDesc, isReach = "", false
		local cfg = DivineDakinosClgConfig.instance:getActCfg(params.activityId) or {}

		if not cfg.lockDesc then
			local lockDesc = "特定精灵"

			if needSaveCount <= saveCount then
				txtDesc = string.format("至少拯救%d只%s  <color=#%s>(%d/%d)</color>", needSaveCount, lockDesc, SettlementTarget.Colors.Sucess, saveCount, needSaveCount)
				isReach = true
			else
				txtDesc = string.format("至少拯救%d只%s  <color=#%s>(%d/%d)</color>", needSaveCount, lockDesc, SettlementTarget.Colors.Fail, saveCount, needSaveCount)
				isReach = false
			end

			BattleSettlementController.instance:addConditionElement(txtDesc, isReach)

			if params.isWin then
				UIStateManager.instance:open(ViewName.BattleSettlementSuccess)
			else
				UIStateManager.instance:open(ViewName.BattleSettlementFail)
			end

			return true
		end
	end
end

DivineDakinosClgController.instance = DivineDakinosClgController.New()

return DivineDakinosClgController
