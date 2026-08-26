-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueLevelViewContainer.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueLevelViewContainer", package.seeall)

local LiangYueLevelViewContainer = class("LiangYueLevelViewContainer", BaseViewContainer)

function LiangYueLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, LiangYueLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function LiangYueLevelViewContainer:buildTabViews(tabContainerId)
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

return LiangYueLevelViewContainer
