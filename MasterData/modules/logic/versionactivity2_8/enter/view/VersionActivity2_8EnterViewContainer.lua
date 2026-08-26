-- chunkname: @modules/logic/versionactivity2_8/enter/view/VersionActivity2_8EnterViewContainer.lua

module("modules.logic.versionactivity2_8.enter.view.VersionActivity2_8EnterViewContainer", package.seeall)

local VersionActivity2_8EnterViewContainer = class("VersionActivity2_8EnterViewContainer", BaseViewContainer)

function VersionActivity2_8EnterViewContainer:buildViews()
	return {
		VersionActivity2_8EnterView.New(),
		VersionActivity2_8EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity2_8EnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		local multiView = {}

		multiView[#multiView + 1] = VersionActivity2_8DungeonEnterView.New()
		multiView[#multiView + 1] = SurvivalEnterView.New()
		multiView[#multiView + 1] = RoleStoryEnterView.New()
		multiView[#multiView + 1] = VersionActivity2_8MoLiDeErEnterView.New()
		multiView[#multiView + 1] = VersionActivity2_8NuoDiKaEnterView.New()
		multiView[#multiView + 1] = VersionActivity2_8AutoChessEnterView.New()
		multiView[#multiView + 1] = Act183VersionActivityEnterView.New()
		multiView[#multiView + 1] = ActivityWeekWalkDeepShowView.New()
		multiView[#multiView + 1] = TowerMainEntryView.New()
		multiView[#multiView + 1] = ActivityWeekWalkHeartShowView.New()

		return multiView
	end
end

function VersionActivity2_8EnterViewContainer:selectActTab(jumpTabId, actId)
	self.activityId = actId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivity2_8EnterViewContainer:onContainerInit()
	if not self.viewParam then
		return
	end

	self.isFirstPlaySubViewAnim = true

	if not self.viewParam.activityIdList then
		ActivityStageHelper.recordActivityStage(self.viewParam.activityIdList)

		self.activityId = self.viewParam.jumpActId

		if not self.viewParam.activitySettingList then
			local activitySettingList = {}
			local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.activityId)

			if defaultIndex ~= 1 then
				self.viewParam.defaultTabIds = {}
				self.viewParam.defaultTabIds[2] = defaultIndex
			end

			local actSetting = activitySettingList[defaultIndex]
			local actId = VersionActivityEnterHelper.getActId(actSetting)

			ActivityEnterMgr.instance:enterActivity(actId)
			ActivityRpc.instance:sendActivityNewStageReadRequest({
				actId
			})
		end
	end
end

function VersionActivity2_8EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity2_8EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity2_8EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity2_8EnterViewContainer
