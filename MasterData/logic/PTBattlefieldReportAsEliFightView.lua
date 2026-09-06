-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/battlereport/PTBattlefieldReportAsEliFightView.lua

module("logic.extensions.peaktournament.view.common.battlereport.PTBattlefieldReportAsEliFightView", package.seeall)

local PTBattlefieldReportAsEliFightView = class("PTBattlefieldReportAsEliFightView", PTBattlefieldReportView)

function PTBattlefieldReportAsEliFightView:onEnter()
	PTBattlefieldReportAsEliFightView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._resultInfoMoList = params[1]
	self._activityId = checknumber(params[2])
	self._eliRoundId = checknumber(params[3])

	self:_onUpdateUI()
end

function PTBattlefieldReportAsEliFightView:onExit()
	PTBattlefieldReportAsEliFightView.super.onExit(self)
end

function PTBattlefieldReportAsEliFightView:_getResultInfoMoList()
	return self._resultInfoMoList or {}
end

function PTBattlefieldReportAsEliFightView:_toDoReportBehavior()
	SurveyController.instance:reportBehavior(201464, self._activityId, self._eliRoundId)
end

return PTBattlefieldReportAsEliFightView
