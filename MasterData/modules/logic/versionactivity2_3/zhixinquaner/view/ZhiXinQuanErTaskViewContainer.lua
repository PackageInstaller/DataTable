-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/view/ZhiXinQuanErTaskViewContainer.lua

module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErTaskViewContainer", package.seeall)

local ZhiXinQuanErTaskViewContainer = class("ZhiXinQuanErTaskViewContainer", BaseViewContainer)

function ZhiXinQuanErTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ZhiXinQuanErTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 6 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	local scrollView = LuaListScrollViewWithAnimator.New(RoleActivityTaskListModel.instance, scrollParam, animationDelayTimes)

	scrollView.dontPlayCloseAnimation = true

	table.insert(views, scrollView)
	table.insert(views, ZhiXinQuanErTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function ZhiXinQuanErTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return ZhiXinQuanErTaskViewContainer
