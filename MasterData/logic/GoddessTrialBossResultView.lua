-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialBossResultView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialBossResultView", package.seeall)

local GoddessTrialBossResultView = class("GoddessTrialBossResultView", ViewComponent)

function GoddessTrialBossResultView:ctor()
	GoddessTrialBossResultView.super.ctor(self)
end

function GoddessTrialBossResultView:unbindEvents()
	GoddessTrialBossResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function GoddessTrialBossResultView:bindEvents()
	GoddessTrialBossResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function GoddessTrialBossResultView:buildUI()
	GoddessTrialBossResultView.super.buildUI(self)

	self._score = self:getGo("resultInfo/score")
	self._damage = self:getGo("resultInfo/damage")
	self._txtDamage = self:getTxt("resultInfo/damage/txtDamage")
	self._txtScore = self:getTxt("resultInfo/score/txtScore")
	self._btnSure = self:getGo("btnSure")
end

function GoddessTrialBossResultView:onExit()
	GoddessTrialBossResultView.super.onExit(self)
end

function GoddessTrialBossResultView:onEnter()
	GoddessTrialBossResultView.super.onEnter(self)

	local battleInfo = GoddessTrialModel.instance:getTempBossBattleResult()
	local isPractice = battleInfo.option.isPractice

	if not isPractice then
		self._txtScore.text = battleInfo.damageScore
	end

	GameUtil.SetActive(self._score, not isPractice)

	self._txtDamage.text = battleInfo.curDamage
end

function GoddessTrialBossResultView:_onClickSure()
	GoddessTrialModel.instance:clearTempBossBattleResult()
	BattleController.instance:endBattle()
end

return GoddessTrialBossResultView
