-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/controller/DivineDarkKingDragonClgController.lua

module("logic.extensions.divinedarkkingdragonclg.controller.DivineDarkKingDragonClgController", package.seeall)

local DivineDarkKingDragonClgController = class("DivineDarkKingDragonClgController", BaseController)

function DivineDarkKingDragonClgController:onInit()
	self:onReset()
end

function DivineDarkKingDragonClgController:onReset()
	self.ciList = nil
	self._fmtMoMap = {}
	self._needPlayAni = false
end

function DivineDarkKingDragonClgController:getInfo(activityId)
	DivineDarkKingDragonClgAgent.instance:sendPM_DivineDarkKingDragonClgInfoReq(activityId)
end

function DivineDarkKingDragonClgController:handleGetInfo(msg)
	DivineDarkKingDragonClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineDarkKingDragonClgInfoRes)
end

function DivineDarkKingDragonClgController:startChallenge(activityId, phaseId, stageId, form_pb)
	DivineDarkKingDragonClgAgent.instance:sendPM_DivineDarkKingDragonClgChallengeReq(activityId, phaseId, stageId, form_pb)
end

function DivineDarkKingDragonClgController:handleNotifyClgFinish(msg)
	local info = GameUtil.pbToTable(msg)

	if info.isWin then
		DivineDarkKingDragonClgModel.instance:onClgFinish(msg)
		BattleFacade.instance:registerResultHandler(nil, nil)
		BattleFacade.instance:registerResultHandler(function()
			ViewMgr.instance:open(ViewName.DarkKingDragonResultView, info)

			return true
		end)
	end
end

function DivineDarkKingDragonClgController:resetNeedPlayAni()
	self._needPlayAni = false
end

function DivineDarkKingDragonClgController:getNeedPlayAni()
	return self._needPlayAni
end

function DivineDarkKingDragonClgController:confirm(activityId, phaseId, stageId, save)
	DivineDarkKingDragonClgAgent.instance:sendPM_DivineDarkKingDragonClgConfirmReq(activityId, phaseId, stageId, save)
end

function DivineDarkKingDragonClgController:handleConfirm(msg)
	self.ciList = msg.changeSetId

	if msg.save == true and msg.isFinishPhase == false then
		self._needPlayAni = true
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineDarkKingDragonClgConfirmRes)
end

function DivineDarkKingDragonClgController:resetClg(activityId, phaseId)
	DivineDarkKingDragonClgAgent.instance:sendPM_DivineDarkKingDragonClgResetReq(activityId, phaseId)
end

function DivineDarkKingDragonClgController:handleResetClg(msg)
	self:getInfo(msg.activityId)
end

function DivineDarkKingDragonClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function DivineDarkKingDragonClgController:_getFmtMo(activityId)
	local fmtMo = self._fmtMoMap[activityId]

	if not fmtMo then
		fmtMo = DivineDarkKingDragonClgFmtMo.New()
		self._fmtMoMap[activityId] = fmtMo
	end

	return fmtMo
end

function DivineDarkKingDragonClgController:showMissionView(activityId, periodId, stageId)
	local fmtMo = self:_getFmtMo(activityId)

	if fmtMo then
		fmtMo:initParams(activityId, periodId, stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

DivineDarkKingDragonClgController.instance = DivineDarkKingDragonClgController.New()

return DivineDarkKingDragonClgController
