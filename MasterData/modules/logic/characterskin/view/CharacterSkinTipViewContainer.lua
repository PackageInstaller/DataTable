-- chunkname: @modules/logic/characterskin/view/CharacterSkinTipViewContainer.lua

module("modules.logic.characterskin.view.CharacterSkinTipViewContainer", package.seeall)

local CharacterSkinTipViewContainer = class("CharacterSkinTipViewContainer", BaseViewContainer)

function CharacterSkinTipViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSkinTipRightView.New())
	table.insert(views, CharacterSkinLeftView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btntopleft"))

	return views
end

function CharacterSkinTipViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

function CharacterSkinTipViewContainer:setHomeBtnVisible(isVisible)
	if self.navigateView then
		self.navigateView:setParam({
			true,
			isVisible,
			false
		})
	end
end

function CharacterSkinTipViewContainer:onPlayOpenTransitionFinish()
	CharacterSkinTipViewContainer.super.onPlayOpenTransitionFinish(self)

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator.enabled = true
end

return CharacterSkinTipViewContainer
