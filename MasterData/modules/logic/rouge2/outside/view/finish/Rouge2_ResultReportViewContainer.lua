-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultReportViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultReportViewContainer", package.seeall)

local Rouge2_ResultReportViewContainer = class("Rouge2_ResultReportViewContainer", BaseViewContainer)

function Rouge2_ResultReportViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ResultReportView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_recordlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellClass = Rouge2_ResultReportItem
	scrollParam.cellWidth = 2000
	scrollParam.cellHeight = 272
	scrollParam.startSpace = 10
	scrollParam.cellSpaceV = 8

	local animTime = {}

	for i = 1, 6 do
		animTime[i] = i * 0.03
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(Rouge2_ResultReportListModel.instance, scrollParam, animTime))

	return views
end

function Rouge2_ResultReportViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_ResultReportViewContainer
