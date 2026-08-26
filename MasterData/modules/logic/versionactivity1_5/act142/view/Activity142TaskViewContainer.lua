-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142TaskViewContainer.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142TaskViewContainer", package.seeall)

local Activity142TaskViewContainer = class("Activity142TaskViewContainer", BaseViewContainer)

function Activity142TaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Activity142TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(Activity142TaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, Activity142TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function Activity142TaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

function Activity142TaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Activity142TaskViewContainer
