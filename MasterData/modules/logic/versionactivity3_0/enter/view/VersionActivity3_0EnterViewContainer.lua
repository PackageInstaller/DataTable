-- chunkname: @modules/logic/versionactivity3_0/enter/view/VersionActivity3_0EnterViewContainer.lua

module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterViewContainer", package.seeall)

local VersionActivity3_0EnterViewContainer = class("VersionActivity3_0EnterViewContainer", BaseViewContainer)

function VersionActivity3_0EnterViewContainer:buildViews()
	return {
		VersionActivity3_0EnterView.New(),
		VersionActivity3_0EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function VersionActivity3_0EnterViewContainer:buildTabViews(tabContainerId)
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

		multiView[#multiView + 1] = MultiView.New({
			VersionActivity3_0DungeonEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_bg")
		})
		multiView[#multiView + 1] = MultiView.New({
			V1a6_BossRush_EnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		multiView[#multiView + 1] = MultiView.New({
			RoleStoryEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		multiView[#multiView + 1] = MultiView.New({
			VersionActivity3_0MaLiAnNaEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		multiView[#multiView + 1] = MultiView.New({
			VersionActivity3_0KaRongEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		multiView[#multiView + 1] = MultiView.New({
			SeasonEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		multiView[#multiView + 1] = MultiView.New({
			VersionActivity3_0_v2a1_ReactivityEnterview.New(),
			VersionActivity3_0EnterDragView.New("#simage_bg")
		})
		multiView[#multiView + 1] = MultiView.New({
			ActivityWeekWalkDeepShowView.New(),
			VersionActivity3_0EnterDragView.New("bg")
		})
		multiView[#multiView + 1] = MultiView.New({
			TowerMainEntryView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		multiView[#multiView + 1] = MultiView.New({
			ActivityWeekWalkHeartShowView.New(),
			VersionActivity3_0EnterDragView.New("bg")
		})

		return multiView
	end
end

function VersionActivity3_0EnterViewContainer:selectActTab(jumpTabId, actId)
	self.activityId = actId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivity3_0EnterViewContainer:onContainerInit()
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

function VersionActivity3_0EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity3_0EnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity3_0EnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity3_0EnterViewContainer
