-- chunkname: @modules/logic/versionactivity3_9/bird/view/main/V3a9BirdMainViewContainer.lua

module("modules.logic.versionactivity3_9.bird.view.main.V3a9BirdMainViewContainer", package.seeall)

local V3a9BirdMainViewContainer = class("V3a9BirdMainViewContainer", BaseViewContainer)

function V3a9BirdMainViewContainer:buildViews()
	local views = {}

	self._mainView = V3a9BirdMainView.New()

	table.insert(views, self._mainView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3a9BirdMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function V3a9BirdMainViewContainer:_overrideClose()
	self._mainView:exitGame()
end

return V3a9BirdMainViewContainer
