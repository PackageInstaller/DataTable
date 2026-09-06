-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mingjing/MingjingDetailView.lua

module("logic.extensions.timelimitedchallenge.view.amier.MingjingDetailView", package.seeall)

local MingjingDetailView = class("MingjingDetailView", TimeLimitedDetailView)

function MingjingDetailView:buildUI()
	MingjingDetailView.super.buildUI(self)

	self._challengeId = 12
	self._imgNum = goutil.findChildComponent(self.mainGO, "imgNum", typeof(UIImgNumeralText))
	self._btnTip = self:getBtn("btnTip")
end

function MingjingDetailView:bindEvents()
	MingjingDetailView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function MingjingDetailView:unbindEvents()
	MingjingDetailView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
end

function MingjingDetailView:_onClickTip()
	TipsFacade.instance:openTipWindow(lang("tip"), lang("每次挑战都可与明镜战斗5轮，根据5轮累计总伤害结算奖励，并会重置进度。注意：挑战未进行结算的话，隔天也会自动重置进度，且不会获得奖励。"))
end

function MingjingDetailView:_updateUI()
	MingjingDetailView.super._updateUI(self)
	self._imgNum:SetText(self._info.hasChallengeCircle + 1)
end

function MingjingDetailView:_updateOneRoundCell(cell, data)
	local idx = 0

	for k, v in ipairs(self._cfgs) do
		if v == data then
			idx = k

			break
		end
	end

	local txtTitle = goutil.findChildTextComponent(cell, "txt")

	txtTitle.text = langPara("第%d轮\n战斗", idx)

	local imgSelect = goutil.findChild(cell, "imgSelect")

	imgSelect:SetActive(self._curRound == idx)

	local imgState = goutil.findChild(cell, "imgState")

	imgState:SetActive(idx < self._curRound)

	local txtBattleState = goutil.findChildTextComponent(cell, "txtBattleState")

	txtBattleState.text = lang("未战斗")

	local imgBattle = goutil.findChild(cell, "imgBattle")

	txtBattleState.gameObject:SetActive(false)
	imgBattle:SetActive(false)

	if self._curRound == idx then
		imgBattle:SetActive(true)
	elseif idx > self._curRound then
		txtBattleState.gameObject:SetActive(true)
	end
end

return MingjingDetailView
