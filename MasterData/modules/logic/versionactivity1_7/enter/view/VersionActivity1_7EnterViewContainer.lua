-- chunkname: @modules/logic/versionactivity1_7/enter/view/VersionActivity1_7EnterViewContainer.lua

module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewContainer", package.seeall)

local VersionActivity1_7EnterViewContainer = class("VersionActivity1_7EnterViewContainer", BaseViewContainer)

function VersionActivity1_7EnterViewContainer:buildViews()
	return {
		VersionActivity1_7EnterView.New(),
		VersionActivity1_7EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity1_7EnterViewContainer:buildTabViews(tabContainerId)
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
			V1a7_DungeonEnterView.New(),
			V1a7_IsoldeEnterView.New(),
			V1a7_MarcusEnterView.New(),
			V1a6_BossRush_EnterView.New(),
			ReactivityEnterview.New(),
			RoleStoryEnterView.New(),
			V1a7_Season123EnterView.New()
		}
	end
end

function VersionActivity1_7EnterViewContainer:selectActTab(tabIndex, activityId)
	self.activityId = activityId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabIndex)
end

function VersionActivity1_7EnterViewContainer:onContainerInit()
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

function VersionActivity1_7EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity1_7EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity1_7EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity1_7EnterViewContainer
