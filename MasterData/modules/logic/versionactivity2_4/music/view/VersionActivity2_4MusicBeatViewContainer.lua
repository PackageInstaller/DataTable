-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatViewContainer", package.seeall)

local VersionActivity2_4MusicBeatViewContainer = class("VersionActivity2_4MusicBeatViewContainer", BaseViewContainer)

function VersionActivity2_4MusicBeatViewContainer:buildViews()
	self._noteView = VersionActivity2_4MusicBeatNoteView.New()
	self._beatView = VersionActivity2_4MusicBeatView.New()

	local views = {}

	table.insert(views, self._noteView)
	table.insert(views, self._beatView)
	table.insert(views, TabViewGroup.New(1, "#go_left"))

	return views
end

function VersionActivity2_4MusicBeatViewContainer:getNoteView()
	return self._noteView
end

function VersionActivity2_4MusicBeatViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.MusicGameBeatHelp)

		self.navigateView:setHomeCheck(self._closeHomeCheckFunc, self)
		self.navigateView:setCloseCheck(self._closeThisCheckFunc, self)

		return {
			self.navigateView
		}
	end
end

function VersionActivity2_4MusicBeatViewContainer:_closeHomeCheckFunc()
	if self._beatView:isCountDown() then
		return false
	end

	if self._beatView:isPlaying() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicBeatQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			self.navigateView:_reallyHome()
		end)

		return false
	end

	return true
end

function VersionActivity2_4MusicBeatViewContainer:_closeThisCheckFunc()
	if self._beatView:isCountDown() then
		return false
	end

	if self._beatView:isPlaying() then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicBeatQuitConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			self:closeThis()
		end)

		return false
	end

	return true
end

function VersionActivity2_4MusicBeatViewContainer:onContainerInit()
	VersionActivity2_4MultiTouchController.instance:startMultiTouch(self.viewName)
end

function VersionActivity2_4MusicBeatViewContainer:onContainerDestroy()
	VersionActivity2_4MultiTouchController.instance:endMultiTouch()
end

return VersionActivity2_4MusicBeatViewContainer
