-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/controller/DoloresController.lua

module("logic.extensions.doloresclg.controller.DoloresController", package.seeall)

local DoloresController = class("DoloresController", BaseController)

function DoloresController:onInit()
	self:onReset()
end

function DoloresController:onReset()
	self._fmtMoMap = {}
	self._fightPb = nil
	self._resultViewName = nil
	self._lvlViewName = nil
end

function DoloresController:getDefaultActivity()
	return 524001
end

function DoloresController:sendGetInfo(activityId)
	DoloresClgAgent.instance:sendPM_DoloresClgGetInfoReq(activityId)
end

function DoloresController:onGetInfo(msg)
	DoloresModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DOLORES_INFO_UPDATE)
end

function DoloresController:sendResetInfo(activityId, phaseId, stageId)
	DoloresClgAgent.instance:sendPM_DoloresClgResetReq(activityId, phaseId, stageId)
end

function DoloresController:onResetInfo(msg)
	DoloresModel.instance:onResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DOLORES_INFO_UPDATE)
end

function DoloresController:openFmtView(activityId, phaseId, stageId, resultViewName, lvlViewName)
	self._resultViewName = resultViewName
	self._lvlViewName = lvlViewName

	local fanTianFmtMo = self._fmtMoMap[activityId]

	if not fanTianFmtMo then
		fanTianFmtMo = DoloresFmtMo.New()
		self._fmtMoMap[activityId] = fanTianFmtMo
	end

	fanTianFmtMo:initParams(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(fanTianFmtMo)
end

function DoloresController:sendStartFight(activityId, phaseId, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self))
	DoloresClgAgent.instance:sendPM_DoloresClgChallengeReq(activityId, phaseId, stageId, form_pb)
end

function DoloresController:onGetFighMsg(msg)
	DoloresModel.instance:onGetFighMsg(msg)

	self._fightPb = GameUtil.pbToTable(msg)

	local info = DoloresModel.instance:getInfo(msg.activityId) or {}
	local passedPhaseId = checknumber(info.passedPhaseId)
	local phaseCfgList = DoloresConfig.instance:getPhaseListById(msg.activityId) or {}
	local maxLvl = #phaseCfgList

	if maxLvl <= passedPhaseId then
		UIJumper.instance:removeTopState(self._lvlViewName)
	end
end

function DoloresController:onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	if checkbool(self._fightPb.win) == false then
		return false
	end

	UIStateManager.instance:push(self._resultViewName, self._fightPb)

	return true
end

DoloresController.instance = DoloresController.New()

return DoloresController
