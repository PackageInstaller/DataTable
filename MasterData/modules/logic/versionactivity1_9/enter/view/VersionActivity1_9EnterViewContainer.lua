-- chunkname: @modules/logic/versionactivity1_9/enter/view/VersionActivity1_9EnterViewContainer.lua

module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewContainer", package.seeall)

local VersionActivity1_9EnterViewContainer = class("VersionActivity1_9EnterViewContainer", BaseViewContainer)

function VersionActivity1_9EnterViewContainer:buildViews()
	return {
		VersionActivity1_9EnterView.New(),
		VersionActivity1_9EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity1_9EnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif tabContainerId == 2 then
		return {
			V1a9_DungeonEnterView.New(),
			V1a6_BossRush_EnterView.New(),
			RoleStoryEnterView.New(),
			V1a9_Season123EnterView.New(),
			V1a9_LucyEnterView.New(),
			V1a9_KaKaNiaEnterView.New(),
			V1a9_RougeEnterView.New(),
			V1a9_ExploreEnterView.New()
		}
	end
end

function VersionActivity1_9EnterViewContainer:selectActTab(tabIndex, activityId)
	self.activityId = activityId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabIndex)
end

function VersionActivity1_9EnterViewContainer:onContainerInit()
	self.isFirstPlaySubViewAnim = true
	self.activityIdList = self.viewParam.activityIdList

	for _, actMo in ipairs(self.activityIdList) do
		local actId = VersionActivityEnterHelper.getActId(actMo)

		ActivityStageHelper.recordOneActivityStage(actId)
	end

	local defaultIndex = VersionActivityEnterHelper.getTabIndex(self.activityIdList, self.viewParam.jumpActId)

	if defaultIndex ~= 1 then
		self.viewParam.defaultTabIds = {}
		self.viewParam.defaultTabIds[2] = defaultIndex
	else
		self.viewParam.playVideo = true
	end

	local actId = VersionActivityEnterHelper.getActId(self.activityIdList[defaultIndex])

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

function VersionActivity1_9EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity1_9EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity1_9EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity1_9EnterViewContainer
