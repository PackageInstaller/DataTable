-- chunkname: @modules/logic/versionactivity2_4/enter/view/VersionActivity2_4EnterViewContainer.lua

module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterViewContainer", package.seeall)

local VersionActivity2_4EnterViewContainer = class("VersionActivity2_4EnterViewContainer", BaseViewContainer)

function VersionActivity2_4EnterViewContainer:buildViews()
	return {
		VersionActivity2_4EnterView.New(),
		VersionActivity2_4EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity2_4EnterViewContainer:buildTabViews(tabContainerId)
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

		multiView[#multiView + 1] = VersionActivity2_4DungeonEnterView.New()
		multiView[#multiView + 1] = V2a4_PinballEnterView.New()
		multiView[#multiView + 1] = VersionActivity2_4MusicEnterView.New()
		multiView[#multiView + 1] = VersionActivity2_4WuErLiXiEnterView.New()
		multiView[#multiView + 1] = ReactivityEnterview.New()
		multiView[#multiView + 1] = VersionActivity2_4RougeEnterView.New()
		multiView[#multiView + 1] = V2a4_Season166EnterView.New()
		multiView[#multiView + 1] = RoleStoryEnterView.New()
		multiView[#multiView + 1] = V1a6_BossRush_EnterView.New()
		multiView[#multiView + 1] = ActivityWeekWalkDeepShowView.New()
		multiView[#multiView + 1] = TowerMainEntryView.New()

		return multiView
	end
end

function VersionActivity2_4EnterViewContainer:selectActTab(jumpTabId, actId)
	self.activityId = actId

	if self.activityId == VersionActivity2_4Enum.ActivityId.Dungeon then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.enterview_tab_switch)
	end

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivity2_4EnterViewContainer:onContainerInit()
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
			local actSetting = activitySettingList[defaultIndex]
			local actId = VersionActivityEnterHelper.getActId(actSetting)

			if defaultIndex ~= 1 then
				self.viewParam.defaultTabIds = {}
				self.viewParam.defaultTabIds[2] = defaultIndex
			elseif not self.viewParam.isDirectOpen and actId == VersionActivity2_4Enum.ActivityId.Dungeon then
				AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_diqiu_open)
			end

			ActivityEnterMgr.instance:enterActivity(actId)
			ActivityRpc.instance:sendActivityNewStageReadRequest({
				actId
			})
		end
	end
end

function VersionActivity2_4EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity2_4EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity2_4EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity2_4EnterViewContainer
