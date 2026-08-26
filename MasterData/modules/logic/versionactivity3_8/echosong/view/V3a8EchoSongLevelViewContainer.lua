-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongLevelViewContainer.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongLevelViewContainer", package.seeall)

local V3a8EchoSongLevelViewContainer = class("V3a8EchoSongLevelViewContainer", BaseViewContainer)

function V3a8EchoSongLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a8EchoSongLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3a8EchoSongLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function V3a8EchoSongLevelViewContainer:onContainerInit()
	local actId = V3a8EchoSongModel.instance:getActId()

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return V3a8EchoSongLevelViewContainer
