-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_7Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_7Container", package.seeall)

local HandbookSkinSuitDetailView2_7Container = class("HandbookSkinSuitDetailView2_7Container", BaseViewContainer)

function HandbookSkinSuitDetailView2_7Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView2_7.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView2_7Container:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function HandbookSkinSuitDetailView2_7Container:onContainerInit()
	return
end

function HandbookSkinSuitDetailView2_7Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView2_7Container
