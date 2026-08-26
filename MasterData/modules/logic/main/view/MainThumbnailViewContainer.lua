-- chunkname: @modules/logic/main/view/MainThumbnailViewContainer.lua

module("modules.logic.main.view.MainThumbnailViewContainer", package.seeall)

local MainThumbnailViewContainer = class("MainThumbnailViewContainer", BaseViewContainer)

function MainThumbnailViewContainer:buildViews()
	self._heroView = MainThumbnailHeroView.New()

	return {
		MainThumbnailView.New(),
		self._heroView,
		MainThumbnailRecommendView.New(),
		MainThumbnailBtnView.New(),
		MainThumbnailBgmView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function MainThumbnailViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	}, 101)

	return {
		self.navigationView
	}
end

function MainThumbnailViewContainer:getThumbnailNav()
	return self.navigationView
end

function MainThumbnailViewContainer:playCloseTransition()
	MainThumbnailViewContainer.super.playCloseTransition(self, {
		duration = 1
	})
end

function MainThumbnailViewContainer:getLightSpineGo()
	return self._heroView:getLightSpineGo()
end

return MainThumbnailViewContainer
