-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_4Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_4Container", package.seeall)

local HandbookSkinSuitDetailView3_4Container = class("HandbookSkinSuitDetailView3_4Container", BaseViewContainer)

function HandbookSkinSuitDetailView3_4Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView3_4.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView3_4Container:buildTabViews(tabContainerId)
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

function HandbookSkinSuitDetailView3_4Container:onContainerInit()
	return
end

function HandbookSkinSuitDetailView3_4Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView3_4Container
