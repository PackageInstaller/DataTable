-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleRoundReportViewFacade.lua

module("logic.extensions.battle.facade.BattleRoundReportViewFacade", package.seeall)

local BattleRoundReportViewFacade = class("BattleRoundReportViewFacade", BaseFacade)

function BattleRoundReportViewFacade:ctor()
	self._reportView = false
end

function BattleRoundReportViewFacade:registerView(roundView)
	self._reportView = roundView
end

function BattleRoundReportViewFacade:unregisterView()
	self._reportView = false
end

function BattleRoundReportViewFacade:resetReportView()
	if not self:checkView() then
		return
	end

	self._reportView:resetReportView()
end

function BattleRoundReportViewFacade:playOperateCampStartReport(callback, callbackSelf)
	if not self:checkView() then
		Handler:executeCallback(callback, callbackSelf)

		return
	end

	self._reportView:playOperateCampStartReport(callback, callbackSelf)
end

function BattleRoundReportViewFacade:playOtherCampStartReport(campId, callback, callbackSelf)
	if not self:checkView() then
		Handler:executeCallback(callback, callbackSelf)

		return
	end

	self._reportView:playOtherCampStartReport(campId, callback, callbackSelf)
end

function BattleRoundReportViewFacade:hideOtherCampStartReport()
	if not self:checkView() then
		return
	end

	self._reportView:hideOtherCampStartReport()
end

function BattleRoundReportViewFacade:setVisible(visible)
	if not self:checkView() then
		return
	end

	self._reportView:setVisible(visible)
end

function BattleRoundReportViewFacade:checkView(withoutLog)
	if not self._reportView then
		if not withoutLog and enableErrorLog then
			printError("BattleRoundReportViewFacade::need to register view first!")
		end

		return false
	end

	return true
end

BattleRoundReportViewFacade.instance = BattleRoundReportViewFacade.New()

return BattleRoundReportViewFacade
