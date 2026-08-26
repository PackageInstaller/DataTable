-- chunkname: @modules/logic/season/view1_5/Season1_5RetailViewContainer.lua

module("modules.logic.season.view1_5.Season1_5RetailViewContainer", package.seeall)

local Season1_5RetailViewContainer = class("Season1_5RetailViewContainer", BaseViewContainer)

function Season1_5RetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_5RetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season1_5RetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season1_5RetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season1_5RetailViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_5RetailViewContainer:setVisibleInternal(isVisible)
	if isVisible then
		self:_setVisible(true)
		self:playAnim(UIAnimationName.Open)
	elseif ViewMgr.instance:isOpen(ViewName.Season1_5MainView) then
		self:playAnim(UIAnimationName.Close)
	else
		self:_setVisible(false)
	end
end

function Season1_5RetailViewContainer:playAnim(aniName, layer, normalizedTime)
	if not self._anim and self.viewGO then
		self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if self._anim then
		if layer and normalizedTime then
			self._anim:Play(aniName, layer, normalizedTime)
		else
			self._anim:Play(aniName)
		end
	end
end

return Season1_5RetailViewContainer
