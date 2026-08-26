-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterBuffViewContainer.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffViewContainer", package.seeall)

local RougeLimiterBuffViewContainer = class("RougeLimiterBuffViewContainer", BaseViewContainer)

function RougeLimiterBuffViewContainer:buildViews()
	local buffScrollParam = ListScrollParam.New()

	buffScrollParam.scrollGOPath = "#go_choosebuff/SmallBuffView"
	buffScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	buffScrollParam.prefabUrl = self._viewSetting.otherRes.BuffItem
	buffScrollParam.cellClass = RougeLimiterBuffListItem
	buffScrollParam.scrollDir = ScrollEnum.ScrollDirV
	buffScrollParam.lineCount = 3
	buffScrollParam.cellWidth = 160
	buffScrollParam.cellHeight = 160
	buffScrollParam.cellSpaceH = 0
	buffScrollParam.cellSpaceV = 0
	buffScrollParam.startSpace = 0
	buffScrollParam.endSpace = 0

	local views = {}

	table.insert(views, RougeLimiterBuffView.New())
	table.insert(views, RougeLimiterViewEmblemComp.New("#go_RightTop"))
	table.insert(views, LuaListScrollView.New(RougeLimiterBuffListModel.instance, buffScrollParam))

	return views
end

return RougeLimiterBuffViewContainer
