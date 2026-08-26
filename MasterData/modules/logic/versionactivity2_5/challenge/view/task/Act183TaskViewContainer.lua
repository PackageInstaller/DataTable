-- chunkname: @modules/logic/versionactivity2_5/challenge/view/task/Act183TaskViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskViewContainer", package.seeall)

local Act183TaskViewContainer = class("Act183TaskViewContainer", BaseViewContainer)

function Act183TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, Act183TaskView.New())

	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "root/right/#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Act183TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0
	self._scrollView = LuaMixScrollView.New(Act183TaskListModel.instance, scrollParam)

	self._scrollView:setDynamicGetItem(self._dynamicGetItem, self)
	table.insert(views, self._scrollView)

	return views
end

function Act183TaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function Act183TaskViewContainer:_dynamicGetItem(mo)
	if not mo then
		return
	end

	if mo.type == Act183Enum.TaskListItemType.Head then
		return "taskheader", Act183TaskHeadItem, self._viewSetting.otherRes[2]
	elseif mo.type == Act183Enum.TaskListItemType.OneKey then
		return "onekey", Act183TaskOneKeyItem, self._viewSetting.otherRes[3]
	end
end

function Act183TaskViewContainer:getTaskScrollView()
	return self._scrollView
end

return Act183TaskViewContainer
