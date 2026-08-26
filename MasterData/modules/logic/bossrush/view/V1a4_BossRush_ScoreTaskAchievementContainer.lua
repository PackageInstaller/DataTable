-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ScoreTaskAchievementContainer.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievementContainer", package.seeall)

local V1a4_BossRush_ScoreTaskAchievementContainer = class("V1a4_BossRush_ScoreTaskAchievementContainer", BaseViewContainer)

function V1a4_BossRush_ScoreTaskAchievementContainer:buildViews()
	local scrollModel = V1a4_BossRush_ScoreTaskAchievementListModel.instance
	local listScrollParam = ListScrollParam.New()

	listScrollParam.cellClass = V1a4_BossRush_ScoreTaskAchievementItem
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	listScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	listScrollParam.scrollGOPath = "#scroll_ScoreList"
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 964
	listScrollParam.cellHeight = 162
	listScrollParam.cellSpaceH = 0
	listScrollParam.cellSpaceV = 0
	listScrollParam.startSpace = 0
	listScrollParam.sortMode = ScrollEnum.ScrollSortDown
	self._scoreTaskAchievement = V1a4_BossRush_ScoreTaskAchievement.New()
	self._taskScrollView = LuaListScrollView.New(scrollModel, listScrollParam)

	return {
		self._scoreTaskAchievement,
		self._taskScrollView,
		(TabViewGroup.New(1, "top_left"))
	}
end

function V1a4_BossRush_ScoreTaskAchievementContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonView
		}
	end
end

function V1a4_BossRush_ScoreTaskAchievementContainer:setActiveBlock(isActive, isOnce)
	if not self._scoreTaskAchievement then
		return
	end

	self._scoreTaskAchievement:setActiveBlock(isActive, isOnce)
end

function V1a4_BossRush_ScoreTaskAchievementContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return V1a4_BossRush_ScoreTaskAchievementContainer
