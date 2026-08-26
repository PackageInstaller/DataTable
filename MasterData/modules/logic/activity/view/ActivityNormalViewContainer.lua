-- chunkname: @modules/logic/activity/view/ActivityNormalViewContainer.lua

module("modules.logic.activity.view.ActivityNormalViewContainer", package.seeall)

local ActivityNormalViewContainer = class("ActivityNormalViewContainer", BaseViewContainer)

function ActivityNormalViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ActivityCategoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 125
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 9.8
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(ActivityNormalCategoryListModel.instance, scrollParam))
	table.insert(views, ActivityNormalView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActivityNormalViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	end
end

function ActivityNormalViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Activity_close)
end

return ActivityNormalViewContainer
