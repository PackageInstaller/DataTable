-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/nuoya/NuoyaDetailView.lua

module("logic.extensions.timelimitedchallenge.view.nuoya.NuoyaDetailView", package.seeall)

local NuoyaDetailView = class("NuoyaDetailView", TimeLimitedDetailView)

function NuoyaDetailView:unbindEvents()
	NuoyaDetailView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
end

function NuoyaDetailView:bindEvents()
	NuoyaDetailView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function NuoyaDetailView:onExit()
	NuoyaDetailView.super.onExit(self)
end

function NuoyaDetailView:buildUI()
	NuoyaDetailView.super.buildUI(self)

	self._challengeId = 22
	self._btnTip = self:getBtn("btnTip")
end

function NuoyaDetailView:onEnter()
	NuoyaDetailView.super.onEnter(self)
end

function NuoyaDetailView:_onClickTip()
	TipsFacade.instance:openTipWindow(lang("tip"), lang("每次挑战都可与诺雅战斗5轮，根据5轮累计总伤害结算奖励，并会重置进度。注意：挑战未进行结算的话，隔天也会自动重置进度，且不会获得奖励。"))
end

function NuoyaDetailView:_updateUI()
	NuoyaDetailView.super._updateUI(self)

	self._txtTitle.text = string.format("第%s次挑战", self._info.hasChallengeCircle + 1)
end

function NuoyaDetailView:_updateOneRoundCell(cell, data)
	local idx = 0

	for k, v in ipairs(self._cfgs) do
		if v == data then
			idx = checkint(k)

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
	txtBattleState.text = self._curRound == idx and lang("正在战斗") or idx > self._curRound and lang("未战斗") or ""
end

return NuoyaDetailView
