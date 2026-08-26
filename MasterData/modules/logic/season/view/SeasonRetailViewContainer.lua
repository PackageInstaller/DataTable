-- chunkname: @modules/logic/season/view/SeasonRetailViewContainer.lua

module("modules.logic.season.view.SeasonRetailViewContainer", package.seeall)

local SeasonRetailViewContainer = class("SeasonRetailViewContainer", BaseViewContainer)

function SeasonRetailViewContainer:buildViews()
	local views = {}

	table.insert(views, SeasonRetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function SeasonRetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function SeasonRetailViewContainer:_closeCallback()
	self:closeThis()
end

function SeasonRetailViewContainer:_homeCallback()
	self:closeThis()
end

function SeasonRetailViewContainer:setVisibleInternal(isVisible)
	if isVisible then
		self:_setVisible(true)
		self:playAnim(UIAnimationName.Open)
	elseif ViewMgr.instance:isOpen(ViewName.SeasonMainView) then
		self:playAnim(UIAnimationName.Close)
	else
		self:_setVisible(false)
	end
end

function SeasonRetailViewContainer:playAnim(aniName, layer, normalizedTime)
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

return SeasonRetailViewContainer
