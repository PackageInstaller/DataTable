-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183ReportViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183ReportViewContainer", package.seeall)

local Act183ReportViewContainer = class("Act183ReportViewContainer", BaseViewContainer)

function Act183ReportViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, Act183ReportView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_report"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Act183ReportListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1636
	scrollParam.cellHeight = 248
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 20
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local animationDelayTimes = {}

	for i = 1, 4 do
		animationDelayTimes[i] = (i - 1) * 0.03
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(Act183ReportListModel.instance, scrollParam, animationDelayTimes))

	return views
end

function Act183ReportViewContainer:buildTabViews(tabContainerId)
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

return Act183ReportViewContainer
