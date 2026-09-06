-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleStageResultView.lua

module("logic.extensions.starbattle.view.StarBattleStageResultView", package.seeall)

local StarBattleStageResultView = class("StarBattleStageResultView", ViewComponent)

function StarBattleStageResultView:ctor()
	StarBattleStageResultView.super.ctor(self)
end

function StarBattleStageResultView:unbindEvents()
	StarBattleStageResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function StarBattleStageResultView:bindEvents()
	StarBattleStageResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function StarBattleStageResultView:buildUI()
	StarBattleStageResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtCur = self:getTxt("txtCur")
	self._txtMax = self:getTxt("txtMax")
end

function StarBattleStageResultView:onExit()
	StarBattleStageResultView.super.onExit(self)
end

function StarBattleStageResultView:onEnter()
	StarBattleStageResultView.super.onEnter(self)

	local info = self:getFirstParam()
	local score = 0
	local maxScore = 0

	if info then
		score = info.score
		maxScore = info.maxScore
	end

	self._txtCur.text = score
	self._txtMax.text = maxScore
end

function StarBattleStageResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return StarBattleStageResultView
