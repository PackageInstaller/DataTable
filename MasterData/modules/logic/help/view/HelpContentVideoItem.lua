-- chunkname: @modules/logic/help/view/HelpContentVideoItem.lua

module("modules.logic.help.view.HelpContentVideoItem", package.seeall)

local HelpContentVideoItem = class("HelpContentVideoItem", ListScrollCellExtend)

function HelpContentVideoItem:onInitView()
	self._gocenter = gohelper.findChild(self.viewGO, "#go_center")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_center/ScrollView/Viewport/Content/#txt_desc")
	self._btnstoryPlay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_center/#btn_storyPlay")
	self._btnvideoplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_center/#btn_videoplay")
	self._gocontentvideo = gohelper.findChild(self.viewGO, "#go_contentvideo")
	self._govideo = gohelper.findChild(self.viewGO, "#go_contentvideo/#go_video")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_contentvideo/#btn_start")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_contentvideo/#go_bottom")
	self._btnpaused = gohelper.findChildButtonWithAudio(self.viewGO, "#go_contentvideo/#go_bottom/#btn_paused")
	self._btnfullScreen = gohelper.findChildButtonWithAudio(self.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen")
	self._goiconFull = gohelper.findChild(self.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen/#go_iconFull")
	self._goiconSmall = gohelper.findChild(self.viewGO, "#go_contentvideo/#go_bottom/#btn_fullScreen/#go_iconSmall")
	self._slidertime = gohelper.findChildSlider(self.viewGO, "#go_contentvideo/#go_bottom/#slider_time")
	self._txtvideoTime = gohelper.findChildText(self.viewGO, "#go_contentvideo/#go_bottom/#txt_videoTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HelpContentVideoItem:addEvents()
	self._btnstoryPlay:AddClickListener(self._btnstoryPlayOnClick, self)
	self._btnvideoplay:AddClickListener(self._btnvideoplayOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnpaused:AddClickListener(self._btnpausedOnClick, self)
	self._btnfullScreen:AddClickListener(self._btnfullScreenOnClick, self)
end

function HelpContentVideoItem:removeEvents()
	self._btnstoryPlay:RemoveClickListener()
	self._btnvideoplay:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnpaused:RemoveClickListener()
	self._btnfullScreen:RemoveClickListener()
end

function HelpContentVideoItem:_btnstoryPlayOnClick()
	if self._helpVideoCfg and self._helpVideoCfg.storyId ~= 0 then
		StoryController.instance:playStory(self._helpVideoCfg.storyId)
	end
end

function HelpContentVideoItem:_btnfullScreenOnClick()
	self:_showFullScreen(self._isLastIsFullScreen ~= true)
end

function HelpContentVideoItem:_btnpausedOnClick()
	if self._videoPlayer and self._videoPlayer:isPlaying() then
		self._videoPlayer:pause()
		self:_stopSlideTimeTween()
		self:_showPlayIcon(true)
	end
end

function HelpContentVideoItem:_btnvideoplayOnClick()
	self:play()
end

function HelpContentVideoItem:_slidertimeOnValueChange(value)
	if self._isDotweenSet then
		return
	end

	if self._videoPlayer:isPlaying() then
		self._videoPlayer:pause()
		self:_showPlayIcon(true)
	end

	self:_stopSlideTimeTween()

	local value = self._slidertime:GetValue()

	self._curTime = self._startTime + self._duration * value

	self._videoPlayer:seek(self._curTime)
	self:_setVoideTime(self._curTime, self._duration)
end

function HelpContentVideoItem:_btnstartOnClick()
	if self._videoPlayer then
		if self._lastVideoId == nil then
			logNormal(":_btnstartOnClick() isnew")
			self:play()
		elseif self._videoPlayer:isPaused() then
			logNormal(":_btnstartOnClick() isPaused")
			self._videoPlayer:play()
		elseif self._videoPlayer:isPlaying() then
			logNormal(":_btnstartOnClick() IsPlaying")
			self._videoPlayer:pause()
			self:_stopSlideTimeTween()
			self:_showPlayIcon(true)
		elseif self._videoPlayer:isFinished() then
			logNormal(":_btnstartOnClick() IsFinished")
			self._videoPlayer:play()
		end
	else
		self:play()
		logNormal(":_btnstartOnClick() play")
	end
end

function HelpContentVideoItem:_editableInitView()
	self._govideoTrs = self._govideo.transform
	self._gocontentvideoTrs = self._gocontentvideo.transform

	gohelper.setActive(self._btnpaused, false)

	self._goplayIcon = gohelper.findChild(self.viewGO, "#go_contentvideo/#btn_start/image")
	self._isDotweenSet = false
	self._isLastIsFullScreen = false

	gohelper.setActive(self._goiconSmall, false)

	local width = recthelper.getWidth(self._gocontentvideoTrs)
	local height = recthelper.getHeight(self._gocontentvideoTrs)
	local anchorX, anchorY = recthelper.getAnchor(self._gocontentvideoTrs)

	self._curRectParam = {
		width = width,
		height = height,
		anchorX = anchorX,
		anchorY = anchorY
	}
end

function HelpContentVideoItem:_editableAddEvents()
	self._slidertime:AddOnValueChanged(self._slidertimeOnValueChange, self)
end

function HelpContentVideoItem:_editableRemoveEvents()
	self._slidertime:RemoveOnValueChanged()
end

function HelpContentVideoItem:onUpdateMO(mo)
	self._helpVideoCfg = mo
	self._startTime = 0
	self._duration = 0
	self._curTime = 0

	self:_refreshUI()

	if self._videoPlayer then
		self._lastVideoId = nil

		self._videoPlayer:stop()
		self:_stopSlideTimeTween()
		gohelper.setActive(self._gocontentvideo, false)
	end
end

function HelpContentVideoItem:onSelect(isSelect)
	return
end

function HelpContentVideoItem:onDestroyView()
	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	self:_stopSlideTimeTween()
end

function HelpContentVideoItem:_refreshUI()
	if self._helpVideoCfg then
		self._txtdesc.text = self._helpVideoCfg.text
	end

	gohelper.setActive(self._btnstoryPlay, self._helpVideoCfg and self._helpVideoCfg.storyId and self._helpVideoCfg.storyId ~= 0)
end

function HelpContentVideoItem:getIsFullScreen()
	return self._isLastIsFullScreen
end

function HelpContentVideoItem:_showFullScreen(isfull)
	local istemp = not not isfull

	if self._isLastIsFullScreen == istemp then
		return
	end

	self._isLastIsFullScreen = istemp

	local width = self._curRectParam.width
	local height = self._curRectParam.height
	local anchorX = self._curRectParam.anchorX
	local anchorY = self._curRectParam.anchorY

	if istemp then
		anchorX = 0
		anchorY = 0
		width = UnityEngine.Screen.width
		height = UnityEngine.Screen.height
	end

	recthelper.setSize(self._gocontentvideoTrs, width, height)
	recthelper.setAnchor(self._gocontentvideoTrs, anchorX, anchorY)

	if self._isInitVideoPlayer then
		recthelper.setSize(self._videoPlayerGOTrs, width, height)
	end

	gohelper.setActive(self._goiconFull, not istemp)
	gohelper.setActive(self._goiconSmall, istemp)

	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(HelpEvent.UIVoideFullScreenChange, istemp)
	end
end

function HelpContentVideoItem:_showPlayIcon(show)
	gohelper.setActive(self._goplayIcon, show)
end

function HelpContentVideoItem:_initVideoPlayer()
	if not self._isInitVideoPlayer then
		self._isInitVideoPlayer = true
		self._videoPlayer, self._videoPlayerGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._govideo)

		self._videoPlayer:setScaleMode(UnityEngine.ScaleMode.ScaleToFit)

		self._videoPlayerGOTrs = self._videoPlayerGO.transform

		self:_updateVideoSize()
	end
end

function HelpContentVideoItem:_updateVideoSize()
	self:_initVideoPlayer()

	local width = recthelper.getWidth(self._gocontentvideoTrs)
	local height = recthelper.getHeight(self._gocontentvideoTrs)

	recthelper.setSize(self._videoPlayerGOTrs, width, height)
end

function HelpContentVideoItem:play()
	self:_initVideoPlayer()

	self._lastVideoId = self._helpVideoCfg.id

	self._videoPlayer:play(self._helpVideoCfg.videopath, false, self._videoStatusUpdate, self)
	gohelper.setActive(self._gocontentvideo, true)
end

function HelpContentVideoItem:stop()
	if self._videoPlayer then
		self._videoPlayer:stop()
	end
end

function HelpContentVideoItem:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		self:_showPlayIcon(true)
	elseif status == VideoEnum.PlayerStatus.FirstFrameReady then
		-- block empty
	elseif status == VideoEnum.PlayerStatus.Started then
		self:_showPlayIcon(false)
	elseif status == VideoEnum.PlayerStatus.StartedSeeking then
		-- block empty
	end

	self._startTime, self._duration, self._curTime = self._videoPlayer:getTimeRange(0, 0, 0)

	if self._videoPlayer:isPlaying() then
		self:_startSlideTimeTween()
	else
		self:_stopSlideTimeTween()
	end

	logNormal(string.format("status:%s name:%s timeRange(%s,%s,%s) ", status, VideoEnum.getPlayerStatusEnumName(status), self._startTime, self._duration, self._curTime))
end

function HelpContentVideoItem:_stopSlideTimeTween()
	if self._slideTimeTweenId then
		ZProj.TweenHelper.KillById(self._slideTimeTweenId)

		self._slideTimeTweenId = nil
	end
end

function HelpContentVideoItem:_startSlideTimeTween()
	self:_stopSlideTimeTween()

	local runTime = math.max(0, self._curTime - self._startTime)
	local duration = math.max(0, self._duration - runTime)
	local start = 1

	if duration ~= 0 then
		start = runTime / self._duration
	end

	logNormal(string.format("time:(%s,%s) ftd(%s,%s,%s) ", runTime, self._duration, start, 1, duration))

	self._slideTimeTweenId = ZProj.TweenHelper.DOTweenFloat(start, 1, duration, self._onSlideTimeframeCallback, self._onOpenTweenFinishCallback, self, nil, EaseType.Linear)
end

function HelpContentVideoItem:_onSlideTimeframeCallback(value)
	self._isDotweenSet = true

	self._slidertime:SetValue(value)

	self._isDotweenSet = false

	self:_setVoideTime(self._duration * value, self._duration)
end

function HelpContentVideoItem:_setVoideTime(pRunTime, pDuration)
	local runTime = math.floor(pRunTime)
	local duration = math.floor(pDuration)

	if self._lastRunTime_ ~= runTime or self._lastDuration_ ~= duration then
		self._lastRunTime_ = runTime
		self._lastDuration_ = duration
		self._txtvideoTime.text = self:_formatTime(runTime) .. "/" .. self:_formatTime(duration)
	end
end

function HelpContentVideoItem:_formatTime(sec)
	local hour, minute, second = TimeUtil.secondToHMS(sec)

	return string.format("%s:%s:%s", self:_formatNum(hour), self:_formatNum(minute), self:_formatNum(second))
end

function HelpContentVideoItem:_formatNum(num)
	if num >= 10 then
		return num
	end

	return "0" .. num
end

return HelpContentVideoItem
