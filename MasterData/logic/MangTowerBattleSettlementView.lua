-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTowerBattleSettlementView.lua

module("logic.extensions.mangtower.view.MangTowerBattleSettlementView", package.seeall)

local MangTowerBattleSettlementView = class("MangTowerBattleSettlementView", TwoFormsBaseView)

function MangTowerBattleSettlementView:unbindEvents()
	MangTowerBattleSettlementView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MangTowerBattleSettlementView:bindEvents()
	MangTowerBattleSettlementView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function MangTowerBattleSettlementView:onExit()
	MangTowerBattleSettlementView.super.onExit(self)
	self._rewardTableview:dispose()
end

function MangTowerBattleSettlementView:buildUI()
	MangTowerBattleSettlementView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._win = self:getGo("win")
	self._fail = self:getGo("fail")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore")
	self._txtNewScore = goutil.findChildTextComponent(self.mainGO, "result/rankScore/txtNew")
	self._result = self:getGo("result")
	self._rewardTable = self:getGo("rewardList")
	self._rewardCell = self:getGo("rewardList/itemReward")
	self._rewardTableview = ScrollerList.create(self._rewardTable, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function MangTowerBattleSettlementView:onEnter()
	local params = self:getOpenParam()

	self._pointHeads = {}

	GameUtil.updateCells(self._twoForms, params[3], self._updateOneForms, self, true)

	local battleMsg = MangTowerController.instance:getBattleMsg()

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
	self._txtNewScore.text = battleMsg.gainScore

	local changeSetId = checknumber(params[1])
	local dataList = MaterialController.instance:getItemsByChangeSetId(changeSetId)

	self._rewardTableview:reloadData(dataList)
end

function MangTowerBattleSettlementView:_updateOneForms(cell, data)
	MangTowerBattleSettlementView.super._updateOneForms(self, cell, data)

	local imgResult = goutil.findChildComponent(cell, "imgResult", typeof(UIImageSpriteChange))
	local btnVideo = Framework.ButtonAdapter.GetFrom(cell, "btnVideo")

	btnVideo.gameObject:SetActive(false)
	print("data.isChallengerWin = " .. tostring(data.isChallengerWin))
	imgResult:SetState(data.isChallengerWin and 0 or 1)
end

function MangTowerBattleSettlementView:_onClickVideo(idx)
	self:close()
end

function MangTowerBattleSettlementView:_onClickClose()
	BattleController.instance:endBattle()
end

function MangTowerBattleSettlementView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "node")
	local str = langPara("%s:%s:%s", data.materialType, data.id, data.num)

	MaterialMgr.setCellByCfg(str, item)
end

function MangTowerBattleSettlementView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(item)
end

return MangTowerBattleSettlementView
