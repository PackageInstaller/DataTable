-- chunkname: @modules/logic/activity/view/ActivityBeginnerViewContainer.lua

module("modules.logic.activity.view.ActivityBeginnerViewContainer", package.seeall)

local ActivityBeginnerViewContainer = class("ActivityBeginnerViewContainer", BaseViewContainer)

function ActivityBeginnerViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_category/#scroll_categoryitem"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ActivityCategoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 405
	scrollParam.cellHeight = 125
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 9.8
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(ActivityBeginnerCategoryListModel.instance, scrollParam))
	table.insert(views, ActivityBeginnerView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActivityBeginnerViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigationView
	}
end

local activityType2HelpID = {
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = HelpEnum.HelpId.ActivityWarmUp
}

function ActivityBeginnerViewContainer:refreshHelp(actType)
	if self.navigationView then
		local helpId = activityType2HelpID[actType]

		if helpId then
			self.navigationView:setHelpId(helpId)
		else
			self.navigationView:hideHelpIcon()
		end
	end
end

function ActivityBeginnerViewContainer:hideHelp()
	if self.navigationView then
		self.navigationView:hideHelpIcon()
	end
end

function ActivityBeginnerViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_common_pause)
end

return ActivityBeginnerViewContainer
