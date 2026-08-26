-- chunkname: @modules/logic/activitywelfare/view/ActivityWelfareViewContainer.lua

module("modules.logic.activitywelfare.view.ActivityWelfareViewContainer", package.seeall)

local ActivityWelfareViewContainer = class("ActivityWelfareViewContainer", BaseViewContainer)

function ActivityWelfareViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_category/#scroll_categoryitem"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ActivityWelfareCategoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 405
	scrollParam.cellHeight = 125
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 9.8
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(ActivityWelfareListModel.instance, scrollParam))
	table.insert(views, ActivityWelfareView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActivityWelfareViewContainer:buildTabViews(tabContainerId)
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

function ActivityWelfareViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_common_pause)
end

local activityType2HelpID = {
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = HelpEnum.HelpId.ActivityWarmUp
}

function ActivityWelfareViewContainer:refreshHelp(actType)
	if self.navigationView then
		local helpId = activityType2HelpID[actType]

		if helpId then
			self.navigationView:setHelpId(helpId)
		else
			self.navigationView:hideHelpIcon()
		end
	end
end

function ActivityWelfareViewContainer:hideHelp()
	if self.navigationView then
		self.navigationView:hideHelpIcon()
	end
end

return ActivityWelfareViewContainer
