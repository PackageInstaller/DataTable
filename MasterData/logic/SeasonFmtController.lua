-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonFmtController.lua

module("logic.extensions.season.controller.SeasonFmtController", package.seeall)

local SeasonFmtController = class("SeasonFmtController", BaseController)

function SeasonFmtController:ctor()
	SeasonFmtController.super.ctor(self)
end

function SeasonFmtController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtHolyStripesInfo, self.updateFmtMoPetList, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtCutePetInfo, self.updateFmtMoPetList, self)
end

function SeasonFmtController:onReset()
	self:removeAllListener()

	self.seasonFmtMo = SeasonPveFmtMo.New()
	self.curSelectTrainTeamId = nil
end

function SeasonFmtController:removeAllListener()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._onOpenFormationView, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._onOpenMissionView, self)
end

function SeasonFmtController:showFormationView(selectTeamId)
	self:removeAllListener()

	self.curSelectId = selectTeamId

	local teamMo = SeasonTeamsModel.instance:getTeam(self.curSelectId)

	if teamMo and teamMo:isInitPetData() then
		self:_onOpenFormationView()
	else
		GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._onOpenFormationView, self)
		SeasonController.instance:sendGetAllTeamInfo()
	end
end

function SeasonFmtController:updateFmtMoPetList()
	if self.seasonFmtMo then
		self.seasonFmtMo:updatePetList()
		GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
	end
end

function SeasonFmtController:_onOpenFormationView()
	self:removeAllListener()
	self.seasonFmtMo:initParams(self.curSelectId)
	UIStateManager.instance:popByName(ViewName.CustomMissionView)
	CustomFmtController.instance:showMissionFormationView(self.seasonFmtMo)
end

function SeasonFmtController:showFightView(selectTeamId, eventType, eventId, gridId)
	self.curSelectId = selectTeamId
	self.curEventType = eventType
	self.curEventId = eventId
	self.curGridId = gridId

	self:removeAllListener()

	local teamMo = SeasonTeamsModel.instance:getTeam(self.curSelectId)

	if teamMo and teamMo:isInitPetData() then
		self:_onOpenMissionView()
	else
		GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._onOpenMissionView, self)
		SeasonController.instance:sendGetAllTeamInfo()
	end
end

function SeasonFmtController:_onOpenMissionView()
	self:removeAllListener()
	self.seasonFmtMo:initParams(self.curSelectId, self.curEventType, self.curEventId, self.curGridId)
	CustomFmtController.instance:showMissionView(self.seasonFmtMo)
end

function SeasonFmtController:regFightEnd(resultParamObj)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self, resultParamObj))
end

function SeasonFmtController:onBattleEnd(resultParamObj)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if resultParamObj and not resultParamObj.isWin then
		UIStateManager.instance:push(ViewName.SeasonbattlesettlementfailView)
		SeasonAutoFightController.instance:stopAutoFight()

		return true
	end
end

function SeasonFmtController:sendFightRightNow(selectTeamId, eventType, eventId, gridId)
	self.curSelectId = selectTeamId
	self.curEventType = eventType
	self.curEventId = eventId
	self.curGridId = gridId

	self:removeAllListener()

	local teamMo = SeasonTeamsModel.instance:getTeam(self.curSelectId)

	if teamMo and teamMo:isInitPetData() then
		self:_onSendToFight()
	else
		GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._onSendToFight, self)
		SeasonController.instance:sendGetAllTeamInfo()
	end
end

function SeasonFmtController:_onSendToFight()
	self:removeAllListener()
	self.seasonFmtMo:initParams(self.curSelectId, self.curEventType, self.curEventId, self.curGridId)
	self.seasonFmtMo:updateData()
	self.seasonFmtMo:initFightHandler()

	local fmtMo = self.seasonFmtMo:getCurFormation()

	if not fmtMo:isEmpty() then
		self.seasonFmtMo:sendFightMsg()
	else
		TipsFacade.instance:openCommonTips(lang("当前阵型是空阵，请先布阵~"))
		self:showFormationView(self.curSelectId)
	end
end

SeasonFmtController.instance = SeasonFmtController.New()

return SeasonFmtController
