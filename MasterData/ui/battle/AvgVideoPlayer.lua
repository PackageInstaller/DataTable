-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\AvgVideoPlayer.lua

local Player = typeof(Framework.UI.MaterialVideoPlayer)
local ResVideoTalk = require("ClientData/ResVideoTalk")
local AVGCommonMixin = require("UI/AVG/AVGCommonMixin")
local AvgVideoPlayer = Class("AvgVideoPlayer", UIControls.Window)

function AvgVideoPlayer:ctor(...)
	self:initUI()
end

function AvgVideoPlayer:initUI(...)
	self.videoPanel = UIControls.Panel(self, "VideoPlayer")

	local videoGO = self.videoPanel:getGameObject()

	if videoGO then
		self.videoPlayer = videoGO:GetComponent(Player)
	end

	self.funcPanel = UIControls.Panel(self, "FuncPanel")
	self.skipBtn = UIControls.Button(self, "FuncPanel/BtnSkip")

	self.skipBtn:addEventClick(self.onBtnSkipClick)
	self.funcPanel:setVisible(true)
	self:_preInitAVGBullet()
end

function AvgVideoPlayer:playVideoAvg(curSection, endCallback, avgDlgName)
	self.curSection = curSection

	local sectionData = ResVideoTalk[curSection]

	if not sectionData then
		self:setVisible(false)

		return
	end

	local url = sectionData.video_path

	self.endCallback = endCallback

	self:playVideo(url)

	if sectionData.action and sectionData.action_time then
		self:_stopVideoActionTimer()

		self.videoActionTimer = Timer.New(Functor(self._startVideoAction, self, sectionData.action), sectionData.action_time / 1000)

		self.videoActionTimer:Start()
	end

	if sectionData.talk_id and sectionData.avg_time then
		self:_stopAvgStartTimer()

		self.avgStartTimer = Timer.New(Functor(self._startAVG, self, sectionData.talk_id, avgDlgName), sectionData.avg_time / 1000)

		self.avgStartTimer:Start()
	end

	CueManager.stopBGM()

	if sectionData.bgm then
		self:_playBGM(sectionData.bgm)
	end

	self:displayBullet(1)
end

function AvgVideoPlayer:_endClear()
	self:_stopAvgStartTimer()
	self:_stopVideoActionTimer()
	self:_stopBGM()
	self:_clearAVGBullet()
end

function AvgVideoPlayer:_startAVG(talkId, avgDlgName)
	self.avgPlaying = true
	self.avgEnded = nil

	self.skipBtn:setVisible(false)
	self.funcPanelL:setVisible(false)
	self:_stopBulletTimer()

	local avgDlg = UIManager.getUI(avgDlgName, true)

	avgDlg:showSection(talkId, nil, Slot(self._onAvgEnd, self))
end

function AvgVideoPlayer:_onAvgEnd()
	self.avgPlaying = false
	self.avgEnded = true

	self.skipBtn:setVisible(true)
	self.funcPanelL:setVisible(true)

	if self.avgBulletOn then
		self:enableBullet()
		self:displayBullet(1)
	end

	if self.actionEnded then
		CueManager.stopBGM()
		self:resumeVideo()
	end
end

function AvgVideoPlayer:_stopAvgStartTimer()
	if self.avgStartTimer then
		self.avgStartTimer:Stop()

		self.avgStartTimer = nil
	end
end

function AvgVideoPlayer:_startVideoAction(actionType)
	if self.avgEnded then
		return
	end

	if actionType == 1 then
		self:pauseVideo()

		self.actionEnded = true
	end
end

function AvgVideoPlayer:_stopVideoActionTimer(...)
	if self.videoActionTimer then
		self.videoActionTimer:Stop()

		self.videoActionTimer = nil
	end
end

function AvgVideoPlayer:_onVideoEnd()
	self.videoPanel:setVisible(false)
	self:_endClear()
	self:setVisible(false)

	if self.endCallback then
		self.endCallback()
	end
end

function AvgVideoPlayer:_playBGM(bgmId)
	self.videoBgm = bgmId

	CueManager.playAvgBGM(bgmId)
end

function AvgVideoPlayer:_stopBGM()
	if self.videoBgm then
		CueManager.stopAvgBGM()

		self.videoBgm = nil
	end

	CueManager._revertBGM()
end

function AvgVideoPlayer:_realSkipClick()
	if not self.avgPlaying then
		self:stopVideo()

		if self.curSection then
			CurAvatar:sendAvgAnalyticsData(Const.OSS_TYPE_SKIP_MOVIE, self.curSection)
		end
	end
end

function AvgVideoPlayer:playVideo(url)
	self.videoPanel:setVisible(true)

	if self.videoPlayer then
		self.videoPlayer:PlayVideo(url, Slot(self._onVideoEnd, self))
	end
end

function AvgVideoPlayer:stopVideo()
	if self.videoPlayer then
		self.videoPlayer:StopVideo()
	end

	self:_onVideoEnd()
end

function AvgVideoPlayer:pauseVideo(...)
	if self.videoPlayer then
		self.videoPlayer:PauseVideo()
	end
end

function AvgVideoPlayer:resumeVideo(...)
	if self.videoPlayer then
		self.videoPlayer:ResumeVideo()

		if self.avgBulletOn then
			self:enableBullet()
		end
	end
end

function AvgVideoPlayer:mirrorVideo(isMirror)
	if self.videoPlayer then
		self.videoPlayer:MirrorVideo(isMirror)
	end
end

function AvgVideoPlayer:loopVideo(isLoop)
	if self.videoPlayer then
		self.videoPlayer:LoopVideo(isLoop)
	end
end

function AvgVideoPlayer:_resumeBulletVideoPlay()
	if self.inBulletPause then
		self:resumeVideo()

		if self.avgStartTimer then
			self.avgStartTimer:Resume()
		end

		if self.videoActionTimer then
			self.videoActionTimer:Resume()
		end

		self.inBulletPause = false
	end
end

function AvgVideoPlayer:_pauseBulletVideoPlay()
	self.inBulletPause = true

	self:pauseVideo()

	if self.avgStartTimer then
		self.avgStartTimer:Pause()
	end

	if self.videoActionTimer then
		self.videoActionTimer:Pause()
	end
end

MixinClass(AvgVideoPlayer, AVGCommonMixin)

return AvgVideoPlayer
