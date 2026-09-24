-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/ConcertLimitMainViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.ConcertLimitMainViewContainer", package.seeall)

local ConcertLimitMainViewContainer = class("ConcertLimitMainViewContainer", BaseViewContainer)

function ConcertLimitMainViewContainer:buildViews()
	local views = {}

	self._view = ConcertLimitMainView.New()

	table.insert(views, self._view)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function ConcertLimitMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return ConcertLimitMainViewContainer
