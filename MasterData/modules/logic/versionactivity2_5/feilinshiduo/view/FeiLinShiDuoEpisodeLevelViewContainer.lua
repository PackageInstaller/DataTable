-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoEpisodeLevelViewContainer.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeLevelViewContainer", package.seeall)

local FeiLinShiDuoEpisodeLevelViewContainer = class("FeiLinShiDuoEpisodeLevelViewContainer", BaseViewContainer)

function FeiLinShiDuoEpisodeLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, FeiLinShiDuoEpisodeLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function FeiLinShiDuoEpisodeLevelViewContainer:buildTabViews(tabContainerId)
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

return FeiLinShiDuoEpisodeLevelViewContainer
