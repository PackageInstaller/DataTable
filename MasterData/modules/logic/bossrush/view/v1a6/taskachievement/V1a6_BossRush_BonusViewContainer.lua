-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_BonusViewContainer.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusViewContainer", package.seeall)

local V1a6_BossRush_BonusViewContainer = class("V1a6_BossRush_BonusViewContainer", BaseViewContainer)

function V1a6_BossRush_BonusViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, V1a6_BossRush_TabViewGroup.New(2, "#go_bonus"))
	table.insert(views, V1a6_BossRush_BonusView.New())

	return views
end

function V1a6_BossRush_BonusViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	elseif tabContainerId == 2 then
		local delayTimes = {}

		for i = 1, 10 do
			delayTimes[i] = (i - 1) * 0.07
		end

		local achievementScrollParam = ListScrollParam.New()

		achievementScrollParam.cellClass = V1a6_BossRush_AchievementItem
		achievementScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		achievementScrollParam.prefabUrl = self._viewSetting.otherRes[1]
		achievementScrollParam.scrollGOPath = "Right/#scroll_ScoreList"
		achievementScrollParam.scrollDir = ScrollEnum.ScrollDirV
		achievementScrollParam.lineCount = 1
		achievementScrollParam.cellWidth = 964
		achievementScrollParam.cellHeight = 162
		achievementScrollParam.cellSpaceH = 0
		achievementScrollParam.cellSpaceV = 0
		achievementScrollParam.startSpace = 0
		achievementScrollParam.sortMode = ScrollEnum.ScrollSortDown
		self._achievementScrollView = LuaListScrollViewWithAnimator.New(V1a4_BossRush_ScoreTaskAchievementListModel.instance, achievementScrollParam, delayTimes)
		self._achievementView = V1a6_BossRush_AchievementView.New()

		local scheduleScrollParam = ListScrollParam.New()

		scheduleScrollParam.cellClass = V1a6_BossRush_ScheduleItem
		scheduleScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		scheduleScrollParam.prefabUrl = self._viewSetting.otherRes[2]
		scheduleScrollParam.scrollGOPath = "Right/#scroll_ScoreList"
		scheduleScrollParam.scrollDir = ScrollEnum.ScrollDirV
		scheduleScrollParam.lineCount = 1
		scheduleScrollParam.cellWidth = 964
		scheduleScrollParam.cellHeight = 162
		scheduleScrollParam.cellSpaceH = 0
		scheduleScrollParam.cellSpaceV = 0
		scheduleScrollParam.startSpace = 0
		scheduleScrollParam.sortMode = ScrollEnum.ScrollSortDown
		self._scheduleScrollView = LuaListScrollViewWithAnimator.New(V1a4_BossRush_ScheduleViewListModel.instance, scheduleScrollParam, delayTimes)
		self._scheduleView = V1a6_BossRush_ScheduleView.New()

		return {
			MultiView.New({
				self._achievementView,
				self._achievementScrollView
			}),
			MultiView.New({
				self._scheduleView,
				self._scheduleScrollView
			})
		}
	end
end

function V1a6_BossRush_BonusViewContainer:getScrollAnimRemoveItem(tab)
	if tab == 1 then
		if not self._achievementScrollView then
			local scrollView = self._scheduleScrollView

			return ListScrollAnimRemoveItem.Get(scrollView)
		end
	end
end

function V1a6_BossRush_BonusViewContainer:getTabView(tab)
	if tab == 1 then
		if not self._achievementView then
			return self._scheduleView
		end
	end
end

function V1a6_BossRush_BonusViewContainer:selectTabView(selectId)
	V1a6_BossRush_BonusModel.instance:setTab(selectId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, selectId)
end

return V1a6_BossRush_BonusViewContainer
