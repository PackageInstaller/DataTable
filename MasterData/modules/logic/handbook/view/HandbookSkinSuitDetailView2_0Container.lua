-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_0Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_0Container", package.seeall)

local HandbookSkinSuitDetailView2_0Container = class("HandbookSkinSuitDetailView2_0Container", BaseViewContainer)

function HandbookSkinSuitDetailView2_0Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView2_0.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView2_0Container:buildTabViews(tabContainerId)
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

function HandbookSkinSuitDetailView2_0Container:onContainerInit()
	return
end

function HandbookSkinSuitDetailView2_0Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView2_0Container
