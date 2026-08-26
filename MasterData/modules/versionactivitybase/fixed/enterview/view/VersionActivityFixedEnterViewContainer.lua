-- chunkname: @modules/versionactivitybase/fixed/enterview/view/VersionActivityFixedEnterViewContainer.lua

module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewContainer", package.seeall)

local VersionActivityFixedEnterViewContainer = class("VersionActivityFixedEnterViewContainer", BaseViewContainer)

function VersionActivityFixedEnterViewContainer:buildViews()
	local tabViewGroupFix = TabViewGroup.New(2, "#go_subview")
	local finishFunc = tabViewGroupFix.onOpenFinish

	function tabViewGroupFix:onOpenFinish()
		if self.viewParam.jumpActId and self.viewParam.jumpActId ~= VersionActivityFixedHelper.getVersionActivityEnum().Dungeon then
			self.viewContainer:markPlayedSubViewAnim()
		end

		self._hasOpenFinish = true

		finishFunc(self)
	end

	local views = self:getViews()

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, tabViewGroupFix)

	return views
end

function VersionActivityFixedEnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self:initNavigateButtonsView({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		local multiView = self:getMultiViews()

		multiView[#multiView + 1] = ActivityWeekWalkDeepShowView.New()
		multiView[#multiView + 1] = TowerMainEntryView.New()
		multiView[#multiView + 1] = ActivityWeekWalkHeartShowView.New()
		multiView[#multiView + 1] = AbyssEnterView.New()

		return multiView
	end
end

function VersionActivityFixedEnterViewContainer:selectActTab(jumpTabId, actId)
	self.activityId = actId

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivityFixedEnterViewContainer:onContainerInit()
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

			self._firstOpenActId = actId
		end
	end
end

function VersionActivityFixedEnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivityFixedEnterViewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivityFixedEnterViewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

function VersionActivityFixedEnterViewContainer:getFirstOpenActId()
	return self._firstOpenActId
end

function VersionActivityFixedEnterViewContainer:getViews()
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivityFixedHelper.getVersionActivityEnterBgmView().New()
	}
end

function VersionActivityFixedEnterViewContainer:initNavigateButtonsView(param)
	self._navigateButtonView = NavigateButtonsView.New(param)
end

function VersionActivityFixedEnterViewContainer:getMultiViews()
	return {
		VersionActivityFixedHelper.getVersionActivityDungeonEnterView().New()
	}
end

return VersionActivityFixedEnterViewContainer
