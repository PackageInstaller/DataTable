-- chunkname: @modules/logic/rouge/view/RougeResultReportViewContainer.lua

module("modules.logic.rouge.view.RougeResultReportViewContainer", package.seeall)

local RougeResultReportViewContainer = class("RougeResultReportViewContainer", BaseViewContainer)

function RougeResultReportViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeResultReportView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_recordlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RougeResultReportItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1480
	scrollParam.cellHeight = 254
	scrollParam.cellSpaceH = 8
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 10
	scrollParam.endSpace = 0

	table.insert(views, LuaListScrollView.New(RougeResultReportListModel.instance, scrollParam))

	return views
end

function RougeResultReportViewContainer:buildTabViews(tabContainerId)
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

return RougeResultReportViewContainer
