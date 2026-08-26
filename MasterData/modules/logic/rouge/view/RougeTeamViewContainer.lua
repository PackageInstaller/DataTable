-- chunkname: @modules/logic/rouge/view/RougeTeamViewContainer.lua

module("modules.logic.rouge.view.RougeTeamViewContainer", package.seeall)

local RougeTeamViewContainer = class("RougeTeamViewContainer", BaseViewContainer)

function RougeTeamViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RougeTeamHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 250
	scrollParam.cellHeight = 555
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 56
	scrollParam.startSpace = 50

	local animationDelayTimes = {}

	for i = 1, 21 do
		animationDelayTimes[i] = math.ceil((i - 1) % 6) * 0.03
	end

	local views = {}

	table.insert(views, RougeTeamView.New())
	table.insert(views, LuaListScrollViewWithAnimator.New(RougeTeamListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function RougeTeamViewContainer:buildTabViews(tabContainerId)
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

return RougeTeamViewContainer
