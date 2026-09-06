-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/battlereport/PTBattlefieldReportAsMyView.lua

module("logic.extensions.peaktournament.view.common.battlereport.PTBattlefieldReportAsMyView", package.seeall)

local PTBattlefieldReportAsMyView = class("PTBattlefieldReportAsMyView", PTBattlefieldReportView)

function PTBattlefieldReportAsMyView:onEnter()
	PTBattlefieldReportAsMyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetMyBattleRecordsRes, self._handleBattleRecordsRes, self)
end

function PTBattlefieldReportAsMyView:onExit()
	PTBattlefieldReportAsMyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetMyBattleRecordsRes, self._handleBattleRecordsRes, self)
end

function PTBattlefieldReportAsMyView:_handleBattleRecordsRes()
	self._resultInfoMoList = PeakTournamentModel.instance:getResultInfoMoListInMyBtlRecord()

	self:_onUpdateUI()
end

function PTBattlefieldReportAsMyView:_getResultInfoMoList()
	return self._resultInfoMoList or {}
end

return PTBattlefieldReportAsMyView
