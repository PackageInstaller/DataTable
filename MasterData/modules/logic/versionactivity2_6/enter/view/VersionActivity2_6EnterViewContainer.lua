-- chunkname: @modules/logic/versionactivity2_6/enter/view/VersionActivity2_6EnterViewContainer.lua

module("modules.logic.versionactivity2_6.enter.view.VersionActivity2_6EnterViewContainer", package.seeall)

local VersionActivity2_6EnterViewContainer = class("VersionActivity2_6EnterViewContainer", BaseViewContainer)

function VersionActivity2_6EnterViewContainer:buildViews()
	return {
		VersionActivity2_6EnterView.New(),
		VersionActivity2_6EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity2_6EnterViewContainer:buildTabViews(tabContainerId)
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

		multiView[#multiView + 1] = VersionActivity2_6DungeonEnterView.New()
		multiView[#multiView + 1] = DiceHeroEnterView.New()
		multiView[#multiView + 1] = V2a6_XugoujiEnterView.New()
		multiView[#multiView + 1] = VersionActivity2_6RougeEnterView.New()
		multiView[#multiView + 1] = V1a6_BossRush_EnterView.New()
		multiView[#multiView + 1] = RoleStoryEnterView.New()
		multiView[#multiView + 1] = V2a6_Season166EnterView.New()
		multiView[#multiView + 1] = ActivityWeekWalkDeepShowView.New()
		multiView[#multiView + 1] = TowerMainEntryView.New()
		multiView[#multiView + 1] = ActivityWeekWalkHeartShowView.New()

		return multiView
	end
end

function VersionActivity2_6EnterViewContainer:selectActTab(jumpTabId, actId)
	self.activityId = actId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivity2_6EnterViewContainer:onContainerInit()
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

function VersionActivity2_6EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity2_6EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity2_6EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity2_6EnterViewContainer
