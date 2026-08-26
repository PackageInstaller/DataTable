-- chunkname: @modules/logic/abyss/view/AbyssTaskViewContainer.lua

module("modules.logic.abyss.view.AbyssTaskViewContainer", package.seeall)

local AbyssTaskViewContainer = class("AbyssTaskViewContainer", BaseViewContainer)

function AbyssTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = AbyssTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1500
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 1
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.07
	end

	table.insert(views, AbyssTaskView.New())
	table.insert(views, LuaListScrollViewWithAnimator.New(AbyssTaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AbyssTaskViewContainer:buildTabViews(tabContainerId)
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

return AbyssTaskViewContainer
