-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_2Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_2Container", package.seeall)

local HandbookSkinSuitDetailView2_2Container = class("HandbookSkinSuitDetailView2_2Container", BaseViewContainer)

function HandbookSkinSuitDetailView2_2Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView2_2.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView2_2Container:buildTabViews(tabContainerId)
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

function HandbookSkinSuitDetailView2_2Container:onContainerInit()
	return
end

function HandbookSkinSuitDetailView2_2Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView2_2Container
