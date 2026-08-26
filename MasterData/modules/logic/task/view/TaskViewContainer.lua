-- chunkname: @modules/logic/task/view/TaskViewContainer.lua

module("modules.logic.task.view.TaskViewContainer", package.seeall)

local TaskViewContainer = class("TaskViewContainer", BaseViewContainer)

function TaskViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_container"),
		TaskView.New()
	}
end

function TaskViewContainer:buildTabViews(tabContainerId)
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
		return {
			TaskNoviceView.New(),
			TaskDailyView.New(),
			TaskWeeklyView.New()
		}
	end
end

function TaskViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

function TaskViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mission_close)
end

return TaskViewContainer
