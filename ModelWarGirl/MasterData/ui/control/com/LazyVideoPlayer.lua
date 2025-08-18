-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\LazyVideoPlayer.lua

local UIVideoPlayer = typeof(Framework.UI.UIVideoPlayer)
local strClassName = "LazyVideoPlayer"
local LazyVideoPlayer = Class(strClassName, UIControls.Child)

function LazyVideoPlayer:ctor()
	self:initUI()
end

function LazyVideoPlayer:initUI()
	local rootGO = self:getController().gameObject

	if rootGO then
		self.videoPlayer = rootGO:GetComponent(UIVideoPlayer)
	end

	self.videoBgPanel = UIControls.Panel(self, "Block")
end

function LazyVideoPlayer:playVideo(url, endCallback, mirror, muteBGM, needBg, isLoop, pauseOnEnd)
	self.url = url
	self.pauseOnEnd = pauseOnEnd

	if needBg then
		self.videoBgPanel:setVisible(true)
	else
		self.videoBgPanel:setVisible(false)
	end

	if self.videoPlayer then
		if muteBGM then
			CueManager.stopBGM()

			self.bgmIsMute = true
		end

		self.isLoop = isLoop or false
		self.videoPlayer.playLoop = self.isLoop
		self.videoCallback = endCallback

		self.videoPlayer:MirrorVideo(mirror)
		self.videoPlayer:PlayVideo(url, Slot(self._videoEndCallback, self))
	end
end

function LazyVideoPlayer:onBtnEnd()
	if self.urlList then
		self:checkNextVideo()
	else
		self:stopVideo()
		self:_videoEndCallback()
	end

	if self.url and CurAvatar then
		CurAvatar:sendAvgAnalyticsData(Const.OSS_TYPE_SKIP_MOVIE, self.url)
	end
end

function LazyVideoPlayer:stopVideo(...)
	if self.videoPlayer then
		self.videoPlayer:StopVideo()
	end

	self:setVisible(false)
end

function LazyVideoPlayer:pauseVideo(...)
	if self.videoPlayer then
		self.videoPlayer:PauseVideo()
	end
end

function LazyVideoPlayer:resumeVideo(...)
	if self.videoPlayer then
		self.videoPlayer:ResumeVideo()
	end
end

function LazyVideoPlayer:_videoEndCallback()
	if not self.isLoop then
		self.url = nil
		self.urlList = nil

		if self.bgmIsMute then
			CueManager._revertBGM()

			self.bgmIsMute = nil
		end

		if self.pauseOnEnd then
			local rootGO = self:getController().gameObject.transform:Find("RawImage").gameObject
			local coms = rootGO:GetComponents(typeof(UnityEngine.MonoBehaviour))

			if coms then
				local len = coms.Length

				for i = 1, len - 1 do
					local com = coms[i]

					com.enabled = true
				end
			end
		else
			self:setVisible(false)
		end
	end

	if self.videoCallback then
		self.videoCallback()

		self.videoCallback = nil
	end
end

function LazyVideoPlayer:playVideoToCamera(url, endCallback)
	if self.videoPlayer then
		self.videoPlayer:PlayVideoToCam(url, endCallback)
	end
end

function LazyVideoPlayer:playVideoToMaterial(url, endCallback)
	if self.videoPlayer then
		self.videoPlayer:PlayVideoToMaterial(url, endCallback)
	end
end

function LazyVideoPlayer:playVideoWithClip(url, endCallback)
	if self.videoPlayer then
		self.videoPlayer:PlayVideoWithVideoClip(url, endCallback)
	end
end

function LazyVideoPlayer:playVideoList(urlList, endCallback, mirror, muteBGM, needBg)
	if not urlList or #urlList < 1 then
		logrror(Lang.get(30154), debug.traceback())

		return
	end

	if needBg then
		self.videoBgPanel:setVisible(true)
	else
		self.videoBgPanel:setVisible(false)
	end

	self.urlList = urlList
	self.curPlayIdx = 1

	if self.videoPlayer then
		if muteBGM then
			CueManager.stopBGM()

			self.bgmIsMute = true
		end

		self.videoCallback = endCallback

		self.videoPlayer:MirrorVideo(mirror)
		self:checkNextVideo()
	end
end

function LazyVideoPlayer:checkNextVideo()
	if self.curPlayIdx and self.urlList and #self.urlList >= self.curPlayIdx then
		self.videoPlayer:PlayVideo(self.urlList[self.curPlayIdx], Slot(self.playNextVideo, self))

		self.curPlayIdx = self.curPlayIdx + 1
	else
		self:stopVideo()
		self:_videoEndCallback()
	end
end

function LazyVideoPlayer:playNextVideo(...)
	self.videoPlayer:StopVideo()
	coroutine.start(self._nextFramePlay, self)
end

function LazyVideoPlayer:_nextFramePlay()
	coroutine.step()
	self:checkNextVideo()
end

return LazyVideoPlayer
