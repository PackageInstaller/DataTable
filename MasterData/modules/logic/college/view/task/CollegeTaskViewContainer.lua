-- chunkname: @modules/logic/college/view/task/CollegeTaskViewContainer.lua

module("modules.logic.college.view.task.CollegeTaskViewContainer", package.seeall)

local CollegeTaskViewContainer = class("CollegeTaskViewContainer", BaseViewContainer)

function CollegeTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, CollegeTaskView.New())
	table.insert(views, CollegeVisibleBaseView.New())

	local mixListParam = MixScrollParam.New()

	mixListParam.scrollGOPath = "#scroll_TaskList"
	mixListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	mixListParam.prefabUrl = "#scroll_TaskList/Viewport/Content/#go_TaskItem"
	mixListParam.cellClass = CollegeTaskListItem
	mixListParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(CollegeTaskListModel.instance, mixListParam))

	return views
end

function CollegeTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

return CollegeTaskViewContainer
