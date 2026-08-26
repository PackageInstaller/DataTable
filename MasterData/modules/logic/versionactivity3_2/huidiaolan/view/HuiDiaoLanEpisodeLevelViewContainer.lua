-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanEpisodeLevelViewContainer.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanEpisodeLevelViewContainer", package.seeall)

local HuiDiaoLanEpisodeLevelViewContainer = class("HuiDiaoLanEpisodeLevelViewContainer", BaseViewContainer)

function HuiDiaoLanEpisodeLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, HuiDiaoLanEpisodeLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HuiDiaoLanEpisodeLevelViewContainer:buildTabViews(tabContainerId)
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

return HuiDiaoLanEpisodeLevelViewContainer
