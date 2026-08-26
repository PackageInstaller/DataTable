-- chunkname: @modules/logic/versionactivity1_6/enter/view/VersionActivity1_6EnterVideoView.lua

module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterVideoView", package.seeall)

local VersionActivity1_6EnterVideoView = class("VersionActivity1_6EnterVideoView", BaseView)
local videoOverTime = 3
local videoPath = "videos/1_6_enter.mp4"

function VersionActivity1_6EnterVideoView:onInitView()
	self._videoRoot = gohelper.findChild(self.viewGO, "#go_video")
end

function VersionActivity1_6EnterVideoView:onOpen()
	self._videoPlayer, self._videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._videoRoot)

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6EnterViewVideo)
	self._videoPlayer:play(videoPath, false, self._videoStatusUpdate, self)

	local bgAdapter = self._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

	bgAdapter.enabled = false

	TaskDispatcher.runDelay(self.handleVideoOverTime, self, videoOverTime)
end

function VersionActivity1_6EnterVideoView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying or status == VideoEnum.PlayerStatus.Error then
		self:_stopVideoOverTimeAction()
		self:closeThis()
		VersionActivity1_6EnterController.instance:dispatchEvent(VersionActivity1_6EnterEvent.OnEnterVideoFinished)
	end
end

function VersionActivity1_6EnterVideoView:handleVideoOverTime()
	self:_stopVideoOverTimeAction()
	self:closeThis()
	VersionActivity1_6EnterController.instance:dispatchEvent(VersionActivity1_6EnterEvent.OnEnterVideoFinished)
end

function VersionActivity1_6EnterVideoView:_stopVideoOverTimeAction()
	TaskDispatcher.cancelTask(self.handleVideoOverTime, self)
end

function VersionActivity1_6EnterVideoView:onDestroyView()
	self:_stopVideoOverTimeAction()

	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end
end

return VersionActivity1_6EnterVideoView
