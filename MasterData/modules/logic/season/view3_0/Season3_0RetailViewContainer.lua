-- chunkname: @modules/logic/season/view3_0/Season3_0RetailViewContainer.lua

module("modules.logic.season.view3_0.Season3_0RetailViewContainer", package.seeall)

local Season3_0RetailViewContainer = class("Season3_0RetailViewContainer", BaseViewContainer)

function Season3_0RetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season3_0RetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season3_0RetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season3_0RetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season3_0RetailViewContainer:_homeCallback()
	self:closeThis()
end

function Season3_0RetailViewContainer:setVisibleInternal(isVisible)
	if isVisible then
		self:_setVisible(true)
		self:playAnim(UIAnimationName.Open)
	elseif ViewMgr.instance:isOpen(ViewName.Season3_0MainView) then
		self:playAnim(UIAnimationName.Close)
	else
		self:_setVisible(false)
	end
end

function Season3_0RetailViewContainer:playAnim(aniName, layer, normalizedTime)
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

return Season3_0RetailViewContainer
