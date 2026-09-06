-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestScoreResultView.lua

module("logic.extensions.martialcontest.view.MartialContestScoreResultView", package.seeall)

local MartialContestScoreResultView = class("MartialContestScoreResultView", TwoFormsBaseView)

function MartialContestScoreResultView:buildUI()
	MartialContestScoreResultView.super.buildUI(self)

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

function MartialContestScoreResultView:bindEvents()
	MartialContestScoreResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function MartialContestScoreResultView:unbindEvents()
	MartialContestScoreResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MartialContestScoreResultView:onEnter()
	MartialContestScoreResultView.super.onEnter(self)
	GameUtil.SetActive(self._ranking, false)

	local oldScore, newScore = MartialContestModel.instance:getBattleScoreWithOldAndNew()

	self._txtTitleInRank.text = "积分:"
	self._txtOldRanking.text = string.format("<color=#eb4624>%s</color>", oldScore)
	self._txtNewRanking.text = string.format("<color=#20b376>%s</color>", newScore)

	GameUtil.SetActive(self._ranking, true)

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

function MartialContestScoreResultView:onExit()
	MartialContestScoreResultView.super.onExit(self)
end

function MartialContestScoreResultView:_updateOneForm(cell, formId, petDatas, isWin, power)
	local txtTotalForce = goutil.findChildTextComponent(cell, "txtTotalForce")
	local txtTeam = goutil.findChildTextComponent(cell, "txtTeam")
	local pets = goutil.findChild(cell, "tableview/viewport/formations")
	local txtWin = goutil.findChild(cell, "txtWin")
	local txtFail = goutil.findChild(cell, "txtFail")

	goutil.setActive(txtWin, isWin)
	goutil.setActive(txtFail, not isWin)

	txtTeam.text = "队伍" .. formId
	txtTotalForce.text = power

	GameUtil.updateCells(pets, petDatas, self._updateOnePet, self)
end

function MartialContestScoreResultView:_updateOneForms(cell, data)
	MartialContestScoreResultView.super._updateOneForms(self, cell, data)

	local imgResult = goutil.findChildComponent(cell, "imgResult", ComponentType.UIImageSpriteChange)
	local btnVideo = goutil.findChild(cell, "btnVideo")

	GameUtil.SetActive(btnVideo, false)
	imgResult:SetState(data.isChallengerWin and 0 or 1)
end

function MartialContestScoreResultView:_onClickClose()
	BattleFacade.instance:endBattle()
end

return MartialContestScoreResultView
