-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/controller/DivineEternalDragonClgController.lua

module("logic.extensions.divineeternaldragonclg.controller.DivineEternalDragonClgController", package.seeall)

local DivineEternalDragonClgController = class("DivineEternalDragonClgController", BaseController)

function DivineEternalDragonClgController:ctor()
	return
end

function DivineEternalDragonClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivineeternaldragonclgmainview", self._enterEventOpenView, self)
end

function DivineEternalDragonClgController:onReset()
	self._clgFmtMo = DivineEternalDragonClgFmtMo.New()
	self.ciList = nil
end

function DivineEternalDragonClgController:getInfo(activityId)
	DivineEternalDragonClgAgent.instance:sendPM_DivineEternalDragonClgGetInfoReq(activityId)
end

function DivineEternalDragonClgController:handleGetInfo(msg)
	DivineEternalDragonClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineEternalDragonClgUpdateInfo)
end

function DivineEternalDragonClgController:openMissionView(activityId, stageId, teamId)
	self._clgFmtMo:initParams(activityId, stageId, teamId)
	CustomFmtController.instance:showMissionView(self._clgFmtMo)
end

function DivineEternalDragonClgController:startClgChanllenge(activityId, stageId, teamId, form_pb)
	DivineEternalDragonClgAgent.instance:sendPM_DivineEternalDragonClgChallengeReq(activityId, stageId, teamId, form_pb)
end

function DivineEternalDragonClgController:resetStage(activityId, stageId)
	DivineEternalDragonClgAgent.instance:sendPM_DivineEternalDragonClgResetStageReq(activityId, stageId)
end

function DivineEternalDragonClgController:handleResetStage(msg)
	DivineEternalDragonClgModel.instance:onResetStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineEternalDragonClgUpdateInfo)
end

function DivineEternalDragonClgController:handleChallengeEnd(msg)
	DivineEternalDragonClgModel.instance:onChallengeEnd(msg)

	local info = GameUtil.pbToTable(msg)

	self.ciList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleFacade.instance:registerResultHandler(function()
		if info.win then
			ViewMgr.instance:open(ViewName.DivineEternalDragonClgResultView)

			local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

			if isAoqiGodProcessType then
				local allPass = self:_isAllPass(msg.activityId)

				if allPass then
					AoqiGodController.instance:doHandleChallengeFinishReady(445, msg.activityId)
				end
			end
		else
			ViewMgr.instance:open(ViewName.BattleSettlementFail)
		end

		return true
	end)
end

function DivineEternalDragonClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function DivineEternalDragonClgController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivineEternalDragonClgMainView, actId)
end

function DivineEternalDragonClgController:_isAllPass(activityId)
	local baseInfo = DivineEternalDragonClgModel.instance:getBaseInfoByActId(activityId)
	local lastFightResultInfo = DivineEternalDragonClgModel.instance:getLastFightResultInfo(activityId)
	local stageCfgs = DivineEternalDragonClgConfig.instance:getStageCfgs(activityId)

	return lastFightResultInfo.stageId >= #stageCfgs and lastFightResultInfo.lockRaceIds == nil
end

DivineEternalDragonClgController.instance = DivineEternalDragonClgController.New()

return DivineEternalDragonClgController
