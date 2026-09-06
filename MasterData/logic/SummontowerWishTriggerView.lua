-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerWishTriggerView.lua

module("logic.extensions.summontower.view.SummontowerWishTriggerView", package.seeall)

local SummontowerWishTriggerView = class("SummontowerWishTriggerView", ViewComponent)

function SummontowerWishTriggerView:buildUI()
	SummontowerWishTriggerView.super.buildUI(self)

	self._goNode = self:getGo("Node")
	self._btnClose = Framework.UIClickTrigger.Get(self:getGo("Node/viewBoxGo"))

	local tips = self:getTxt("Node/viewBgGo/txtBossTip")

	tips.text = "你集齐了7颗龙珠，可向神龙许下一个愿望"
end

function SummontowerWishTriggerView:bindEvents()
	SummontowerWishTriggerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SummontowerWishTriggerView:unbindEvents()
	SummontowerWishTriggerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SummontowerWishTriggerView:_playGameScreenEff()
	self._goNode:SetActive(false)

	if not self._screenEff then
		self._screenEff = UIEffectManager.instance:playEffectBrief(self, SummontowerWishTriggerViewPresentor.effPath, self.mainGO, true)

		self._screenEff:setParent(self.mainGO.transform)
		self._screenEff:setScale(1)
		self._screenEff:setLocalPos(0, 0, 0)
	end

	settimer(1, self._onDelayShowUi, self, false)
end

function SummontowerWishTriggerView:_stopGameScreenEff()
	if self._screenEff then
		UIEffectManager.instance:stopEffect(self._screenEff)

		self._screenEff = nil
	end
end

function SummontowerWishTriggerView:_onDelayShowUi()
	self._goNode:SetActive(true)
	removetimer(self._onDelayShowUi, self)
end

function SummontowerWishTriggerView:onEnter()
	SummontowerWishTriggerView.super.onEnter(self)
	self:_playGameScreenEff()
end

function SummontowerWishTriggerView:onExit()
	removetimer(self._onDelayShowUi, self)
	SummontowerWishTriggerView.super.onExit(self)
	self:_stopGameScreenEff()
end

function SummontowerWishTriggerView:_onClickClose()
	self:close()
	ViewMgr.instance:open(ViewName.SummontowerWishView)
end

return SummontowerWishTriggerView
