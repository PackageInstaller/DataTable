-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView1_8Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView1_8Container", package.seeall)

local HandbookSkinSuitDetailView1_8Container = class("HandbookSkinSuitDetailView1_8Container", BaseViewContainer)

function HandbookSkinSuitDetailView1_8Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView1_8.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView1_8Container:buildTabViews(tabContainerId)
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

function HandbookSkinSuitDetailView1_8Container:onContainerInit()
	return
end

function HandbookSkinSuitDetailView1_8Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView1_8Container
