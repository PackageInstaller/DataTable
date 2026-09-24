-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterTaskViewContainer.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterTaskViewContainer", package.seeall)

local SonnetInterchapterTaskViewContainer = class("SonnetInterchapterTaskViewContainer", BaseViewContainer)

function SonnetInterchapterTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SonnetInterchapterTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1300
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local times = {}

	for i = 1, 6 do
		times[i] = (i - 1) * 0.06
	end

	self._scrollview = LuaListScrollViewWithAnimator.New(SonnetInterchapterTaskListModel.instance, scrollParam, times)

	table.insert(views, self._scrollview)
	table.insert(views, SonnetInterchapterTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function SonnetInterchapterTaskViewContainer:buildTabViews(tabContainerId)
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

function SonnetInterchapterTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._scrollview)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return SonnetInterchapterTaskViewContainer
