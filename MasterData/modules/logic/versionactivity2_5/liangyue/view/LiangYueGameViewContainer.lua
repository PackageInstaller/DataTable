-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueGameViewContainer.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueGameViewContainer", package.seeall)

local LiangYueGameViewContainer = class("LiangYueGameViewContainer", BaseViewContainer)

function LiangYueGameViewContainer:buildViews()
	local views = {}

	table.insert(views, LiangYueGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function LiangYueGameViewContainer:buildTabViews(tabContainerId)
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

function LiangYueGameViewContainer:onContainerClose()
	local view = self._views[1]

	if view._isDrag then
		return
	end

	if view._isFinish == false then
		view:statData(LiangYueEnum.StatGameState.Exit)
	end
end

return LiangYueGameViewContainer
