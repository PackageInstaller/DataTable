-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeViewContainer", package.seeall)

local VersionActivity2_4MusicFreeViewContainer = class("VersionActivity2_4MusicFreeViewContainer", BaseViewContainer)

function VersionActivity2_4MusicFreeViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4MusicFreeView.New())
	table.insert(views, VersionActivity2_4MusicFreeNoteView.New())
	table.insert(views, VersionActivity2_4MusicFreeTrackView.New())
	table.insert(views, TabViewGroup.New(1, "#go_left"))

	return views
end

function VersionActivity2_4MusicFreeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.MusicGameFreeHelp)

		self.navigateView:setHomeCheck(self._closeHomeCheckFunc, self)
		self.navigateView:setCloseCheck(self._closeThisCheckFunc, self)

		return {
			self.navigateView
		}
	end
end

function VersionActivity2_4MusicFreeViewContainer:_closeHomeCheckFunc()
	if VersionActivity2_4MusicFreeModel.instance:isRecordStatus() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicFreeQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			self.navigateView:_reallyHome()
		end)

		return false
	end

	return true
end

function VersionActivity2_4MusicFreeViewContainer:_closeThisCheckFunc()
	if VersionActivity2_4MusicFreeModel.instance:isRecordStatus() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicFreeQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			self:closeThis()
		end)

		return false
	end

	return true
end

function VersionActivity2_4MusicFreeViewContainer:onContainerInit()
	VersionActivity2_4MultiTouchController.instance:startMultiTouch(self.viewName)
end

function VersionActivity2_4MusicFreeViewContainer:onContainerDestroy()
	VersionActivity2_4MultiTouchController.instance:endMultiTouch()
end

return VersionActivity2_4MusicFreeViewContainer
