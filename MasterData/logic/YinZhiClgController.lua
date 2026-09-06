-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/controller/YinZhiClgController.lua

module("logic.extensions.yinzhiclg.controller.YinZhiClgController", package.seeall)

local YinZhiClgController = class("YinZhiClgController", BaseController)

function YinZhiClgController:onInit()
	self:onReset()
end

function YinZhiClgController:onReset()
	self._fmtMoMap = {}
	self.ciList = nil
	self._fightPbMap = {}
end

function YinZhiClgController:openMissionview(activityId, phaseId, stageId, resultViewName)
	local fmtMo = self._fmtMoMap[activityId]

	if not fmtMo then
		fmtMo = YinZhiClgFmtMo.New()
		self._fmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, phaseId, stageId, resultViewName)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function YinZhiClgController:getInfo(activityId)
	YinZhiClgAgent.instance:sendPM_YinZhiClgInfoReq(activityId)
end

function YinZhiClgController:handleGetInfo(msg)
	YinZhiClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YinZhiClgGetInfo)
end

function YinZhiClgController:startFight(activityId, phaseId, stageId, form_pb, resultViewName)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self, activityId, resultViewName))
	YinZhiClgAgent.instance:sendPM_YinZhiClgChallengeReq(activityId, phaseId, stageId, form_pb)
end

function YinZhiClgController:onBattleEnd(activityId, resultViewName)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local info = self._fightPbMap[activityId]

	if info and info.isWin then
		UIStateManager.instance:push(resultViewName, info)

		return true
	end

	return false
end

function YinZhiClgController:handleNotifyClgFinish(msg)
	local info = GameUtil.pbToTable(msg)

	self._fightPbMap[info.activityId] = info
end

function YinZhiClgController:confirmResult(activityId, save)
	YinZhiClgAgent.instance:sendPM_YinZhiClgConfirmReq(activityId, save)
end

function YinZhiClgController:handleConfirmResult(msg)
	local info = GameUtil.pbToTable(msg)

	self.ciList = info.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.ciList)
	GlobalDispatcher:dispatch(GlobalNotify.YinZhiClgConfirmResult)

	if info.finishPhase then
		local baseInfo = YinZhiClgModel.instance:getBaseInfo(info.activityId)
		local curPhaseId = baseInfo.phaseId + 1
		local userDataKey = string.format("yinzhiclg_first_pass_phase_%s", info.activityId)
		local keepValue = checknumber(GameUtil.getUserData(userDataKey))

		if keepValue < curPhaseId then
			GameUtil.saveUserData(userDataKey, curPhaseId)
		end
	end
end

function YinZhiClgController:getFirstPassPhaseId(activityId)
	local userDataKey = string.format("yinzhiclg_first_pass_phase_%s", activityId)

	return checknumber(GameUtil.getUserData(userDataKey))
end

function YinZhiClgController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

YinZhiClgController.instance = YinZhiClgController.New()

return YinZhiClgController
