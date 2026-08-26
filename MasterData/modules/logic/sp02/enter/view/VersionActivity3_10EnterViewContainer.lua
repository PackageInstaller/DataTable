-- chunkname: @modules/logic/sp02/enter/view/VersionActivity3_10EnterViewContainer.lua

module("modules.logic.sp02.enter.view.VersionActivity3_10EnterViewContainer", package.seeall)

local VersionActivity3_10EnterViewContainer = class("VersionActivity3_10EnterViewContainer", BaseViewContainer)

function VersionActivity3_10EnterViewContainer:buildViews()
	local views = {}
	local param = {}

	param.videoGOContainerPath = "BG/videoRoot"
	param.episodeId = 38510115
	param.loopVideoNameList = {
		"s02_kv_loop01",
		"s02_kv_loop"
	}
	param.enterVideoNameList = {
		"s02_kv_open01",
		"s02_kv_open"
	}
	param.enterVideoTime = 5
	param.audioId = AudioEnum3_10.Enter.play_ui_langchao_open_1
	param.noVideoAudioId = AudioEnum3_10.LinkGift.play_ui_qiutu_revelation_open
	param.bgmLayer = AudioBgmEnum.Layer.VersionActivity3_10Main

	local videoView = VersionActivityEnterVideoView2.New(param)

	self._videoView = videoView

	table.insert(views, videoView)
	table.insert(views, VersionActivity3_10EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity3_10EnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity3_10EnterViewContainer:playOpenTransition()
	UIBlockMgrExtend.setNeedCircleMv(false)
	self:startViewOpenBlock()

	local needPlayFullScreenVideo = self._videoView:needPlayFullScreenVideo()

	if not needPlayFullScreenVideo then
		self:onPlayOpenTransitionFinish()
	else
		local time = self._videoView:getFullScreenPlayTime()

		TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, time)
	end
end

function VersionActivity3_10EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return VersionActivity3_10EnterViewContainer
