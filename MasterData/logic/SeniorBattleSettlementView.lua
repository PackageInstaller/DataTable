-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorBattleSettlementView.lua

module("logic.extensions.seniorarena.view.SeniorBattleSettlementView", package.seeall)

local SeniorBattleSettlementView = class("SeniorBattleSettlementView", TwoFormsBaseView)

function SeniorBattleSettlementView:unbindEvents()
	SeniorBattleSettlementView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SeniorBattleSettlementView:bindEvents()
	SeniorBattleSettlementView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SeniorBattleSettlementView:onExit()
	SeniorBattleSettlementView.super.onExit(self)
end

function SeniorBattleSettlementView:buildUI()
	SeniorBattleSettlementView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._win = self:getGo("win")
	self._fail = self:getGo("fail")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore")
	self._txtOldRanking = goutil.findChildTextComponent(self.mainGO, "result/ranking/txtOld")
	self._txtNewRanking = goutil.findChildTextComponent(self.mainGO, "result/ranking/txtNew")
	self._txtOldScore = goutil.findChildTextComponent(self.mainGO, "result/rankScore/txtOld")
	self._txtNewScore = goutil.findChildTextComponent(self.mainGO, "result/rankScore/txtNew")
	self._result = self:getGo("result")
end

function SeniorBattleSettlementView:onEnter()
	SeniorBattleSettlementView.super.onEnter(self)

	local battleMsg = SeniorArenaController.instance:getBattleMsg()

	self._win:SetActive(battleMsg.isWin)
	self._fail:SetActive(not battleMsg.isWin)

	local leftScore, rightScore = 0, 0

	self._btlResults = battleMsg.battleResult

	for k, v in ipairs(battleMsg.battleResult) do
		if v.activityWinner == 0 then
			leftScore = leftScore + 1
		else
			rightScore = rightScore + 1
		end
	end

	self._txtScore.text = string.format("%s  :  %s", leftScore, rightScore)
	self._txtOldRanking.text = battleMsg.oldRank
	self._txtNewRanking.text = battleMsg.newRank
	self._txtOldScore.text = battleMsg.oldScore
	self._txtNewScore.text = battleMsg.newScore
end

function SeniorBattleSettlementView:_updateOneForms(cell, data)
	SeniorBattleSettlementView.super._updateOneForms(self, cell, data)

	local imgResult = goutil.findChildComponent(cell, "imgResult", typeof(UIImageSpriteChange))
	local btnVideo = Framework.ButtonAdapter.GetFrom(cell, "btnVideo")

	btnVideo.gameObject:SetActive(false)
	print("data.isChallengerWin = " .. tostring(data.isChallengerWin))
	imgResult:SetState(data.isChallengerWin and 0 or 1)
end

function SeniorBattleSettlementView:_onClickVideo(idx)
	self:close()
	SeniorArenaController.instance:replayBattle(idx)
end

function SeniorBattleSettlementView:_onClickClose()
	BattleController.instance:endBattle()
end

return SeniorBattleSettlementView
