-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/PTBattleSettlementView.lua

module("logic.extensions.peaktournament.view.common.PTBattleSettlementView", package.seeall)

local PTBattleSettlementView = class("PTBattleSettlementView", TwoFormsBaseView)

function PTBattleSettlementView:buildUI()
	PTBattleSettlementView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._win = self:getGo("win")
	self._fail = self:getGo("fail")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore")
	self._ranking = goutil.findChild(self.mainGO, "result/ranking")
	self._txtTitleInRank = goutil.findChildTextComponent(self.mainGO, "result/ranking/title")
	self._txtOldRanking = goutil.findChildTextComponent(self.mainGO, "result/ranking/txtOld")
	self._txtNewRanking = goutil.findChildTextComponent(self.mainGO, "result/ranking/txtNew")
	self._rankScore = goutil.findChild(self.mainGO, "result/rankScore")

	GameUtil.SetActive(self._rankScore, false)

	self._result = self:getGo("result")
end

function PTBattleSettlementView:bindEvents()
	PTBattleSettlementView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function PTBattleSettlementView:unbindEvents()
	PTBattleSettlementView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PTBattleSettlementView:onEnter()
	PTBattleSettlementView.super.onEnter(self)
	GameUtil.SetActive(self._ranking, false)

	local fightType = BattleModel.instance.PeakTournamentFightType

	if fightType == PeakTournamentController.FightType.QuaFight then
		local oldScore = PeakTournamentModel.instance:getRankScoreAsQua()
		local newScore = PeakTournamentModel.instance:getNewRankScoreAsQua()

		self._txtTitleInRank.text = "积分:"
		self._txtOldRanking.text = string.format("<color=#eb4624>%s</color>", oldScore)
		self._txtNewRanking.text = string.format("<color=#20b376>%s</color>", newScore)

		GameUtil.SetActive(self._ranking, true)
	elseif fightType == PeakTournamentController.FightType.EliFight then
		-- block empty
	elseif fightType == PeakTournamentController.FightType.FightVieo then
		-- block empty
	end

	local params = self:getOpenParam()
	local leftScore, rightScore = 0, 0

	for _, v in ipairs(params[3]) do
		if v.isChallengerWin then
			leftScore = leftScore + 1
		else
			rightScore = rightScore + 1
		end
	end

	self._txtScore.text = string.format("%s  :  %s", leftScore, rightScore)

	GameUtil.SetActive(self._win, rightScore < leftScore)
	GameUtil.SetActive(self._fail, not GameUtil.GetActive(self._win))
end

function PTBattleSettlementView:onExit()
	PTBattleSettlementView.super.onExit(self)
end

function PTBattleSettlementView:_updateOneForms(cell, data)
	PTBattleSettlementView.super._updateOneForms(self, cell, data)

	local imgResult = goutil.findChildComponent(cell, "imgResult", ComponentType.UIImageSpriteChange)
	local btnVideo = goutil.findChild(cell, "btnVideo")

	GameUtil.SetActive(btnVideo, false)
	imgResult:SetState(data.isChallengerWin and 0 or 1)
end

function PTBattleSettlementView:_onClickClose()
	BattleController.instance:endBattle()
end

return PTBattleSettlementView
