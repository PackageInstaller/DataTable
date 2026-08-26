-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaLevelViewContainer.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaLevelViewContainer", package.seeall)

local Activity201MaLiAnNaLevelViewContainer = class("Activity201MaLiAnNaLevelViewContainer", BaseViewContainer)

function Activity201MaLiAnNaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity201MaLiAnNaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity201MaLiAnNaLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._closeView, self)

		return {
			self.navigateView
		}
	end
end

function Activity201MaLiAnNaLevelViewContainer:_closeView()
	ViewMgr.instance:closeView(ViewName.Activity201MaLiAnNaLevelView)
	ViewMgr.instance:closeView(ViewName.Activity201MaLiAnNaGameMainView)
end

return Activity201MaLiAnNaLevelViewContainer
