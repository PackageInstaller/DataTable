-- chunkname: @modules/logic/versionactivity1_8/enter/view/VersionActivity1_8EnterViewContainer.lua

module("modules.logic.versionactivity1_8.enter.view.VersionActivity1_8EnterViewContainer", package.seeall)

local VersionActivity1_8EnterViewContainer = class("VersionActivity1_8EnterViewContainer", BaseViewContainer)

function VersionActivity1_8EnterViewContainer:buildViews()
	return {
		VersionActivity1_8EnterView.New(),
		VersionActivity1_8EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity1_8EnterViewContainer:buildTabViews(tabContainerId)
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

		multiView[#multiView + 1] = V1a8_DungeonEnterView.New()
		multiView[#multiView + 1] = ReactivityEnterview.New()
		multiView[#multiView + 1] = V1a8_WeilaEnterView.New()
		multiView[#multiView + 1] = V1a6_BossRush_EnterView.New()
		multiView[#multiView + 1] = RoleStoryEnterView.New()
		multiView[#multiView + 1] = V1a8_WindSongEnterView.New()
		multiView[#multiView + 1] = V1a8_Season123EnterView.New()

		return multiView
	end
end

function VersionActivity1_8EnterViewContainer:selectActTab(jumpTabId, actId)
	self.activityId = actId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivity1_8EnterViewContainer:onContainerInit()
	if not self.viewParam then
		return
	end

	self.isFirstPlaySubViewAnim = true

	if not self.viewParam.activityIdList then
		ActivityStageHelper.recordActivityStage(self.viewParam.activityIdList)

		if not self.viewParam.activitySettingList then
			local activitySettingList = {}
			local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)

			if defaultIndex ~= 1 then
				self.viewParam.defaultTabIds = {}
				self.viewParam.defaultTabIds[2] = defaultIndex
			elseif not self.viewParam.isDirectOpen then
				self.viewParam.playVideo = true
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

function VersionActivity1_8EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity1_8EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity1_8EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity1_8EnterViewContainer
