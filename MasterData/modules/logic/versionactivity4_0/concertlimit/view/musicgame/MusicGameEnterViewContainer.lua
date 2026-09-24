-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameEnterViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameEnterViewContainer", package.seeall)

local MusicGameEnterViewContainer = class("MusicGameEnterViewContainer", BaseViewContainer)

function MusicGameEnterViewContainer:buildViews()
	local views = {}

	self._view = MusicGameEnterView.New()

	table.insert(views, self._view)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function MusicGameEnterViewContainer:buildTabViews(tabContainerId)
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

return MusicGameEnterViewContainer
