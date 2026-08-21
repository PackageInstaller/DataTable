-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryPlayVideoViewComponent.lua

module("logic.extensions.story.view.StoryPlayVideoViewComponent", package.seeall)

local M = class("StoryPlayVideoViewComponent", ViewComponent)
local longClickTriggerTime = 0.01
local FILLAMOUN_TIME = 2
local RewindTime = 0.3
local kStoryVedioKey = "StoryVedioKey"
local kCamClickMaskTime = 5

function M:buildUI()
	self._vedioPanel = self:getGo("story_main_view_949477232")
	self._videoImg1 = self:getImage("story_main_view_1646936247")
	self._videoMgr1 = CriWareVideoMgr.Get(self._videoImg1.gameObject)
	self._videoImg2 = self:getImage("story_main_view_-118065801")
	self._videoMgr2 = CriWareVideoMgr.Get(self._videoImg2.gameObject)
	self._imgContent = self:getImage("story_main_view_1646936247")
	self._btnClick = self:getBtn("story_main_view_-530785677")
	self._playVideo = 0
	self._videoPressGo = self:getGo("story_main_view_1322677211")
	self._btnPress = OnceLongPressTrigger.Get(self._videoPressGo)

	self._btnPress:SetTriggerTime(longClickTriggerTime)

	self._processImg = self:getImage("story_main_view_-1576779308")

	goutil.setActive(self._videoPressGo, false)

	self._btnSkipVideo = self:getBtn("story_main_view_-1574463937")
	self._goDownTextRoot = self:getGo("story_main_view_46341205")
	self._txtDownText = self:getUIComponent("story_main_view_2030943299", UIComponentType.TextMeshProUGUI)

	goutil.setActive(self._goDownTextRoot, false)
end

function M:destroyUI()
	self._videoImg1 = nil

	if self._videoMgr1 then
		self._videoMgr1:DestroyMovie()
	end

	self._videoImg2 = nil

	if self._videoMgr2 then
		self._videoMgr2:DestroyMovie()
	end

	self._playVideo = 0
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickMask, self)
	self._btnPress:AddLongPressListener(self._onPressVideo, self)
	self._btnPress:AddLongPressExitListener(self._onExitPressVideo, self)
	self._btnSkipVideo:AddClickListener(self._onClickJump, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
	self._btnPress:RemoveLongPressExitListener()
	self._btnPress:RemoveLongPressListener()
	self._btnSkipVideo:RemoveClickListener()
end

function M:onEnter()
	self._canClickMask = false

	StoryDispatcher:addEventListener(StoryNotifyName.OnVideoEnter, self.OnVideoEnter, self)
	StoryDispatcher:addEventListener(StoryNotifyName.OnVideoExit, self.OnVideoExit, self)
end

function M:onExit()
	self._canClickMask = false

	removetimer(self._setCanClickMaskEvent, self)
	removetimer(self._delayShowPressGo, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.OnVideoEnter, self.OnVideoEnter, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.OnVideoExit, self.OnVideoExit, self)
end

function M:OnVideoEnter(evt, videoCode, isLoop, canJump, showJumpButton, timeArg, isJumpShot)
	if canJump and isJumpShot then
		if enableLog then
			printInfo("story .. has been skipped video:", videoCode, isLoop)
		end

		return
	end

	self._isExit = false
	self._startVideoTime = os.time()
	self._curVideoCode = videoCode
	self._showJumpButton = showJumpButton
	self._timeArg = timeArg

	self:_showVedioInfo(videoCode, isLoop, canJump)
end

function M:OnVideoExit()
	self._isExit = true
end

function M:_fadeOutVedio()
	local new = self._videoMgr

	if new == self._videoMgr1 then
		self._imgContent = self._videoImg1
	else
		self._imgContent = self._videoImg2
	end

	self._imgContent:DOKill()
	self._imgContent:DOFade(0, self._fadeOutTime):OnComplete(self._onVideoFadeOut, self):SetAutoKill(true)
end

function M:_onVideoFadeOut()
	self:_removeVedio()
end

function M:_setCanClickMaskEvent()
	self._canClickMask = true
end

function M:_showVedioInfo(videoCode, isLoop, canJump)
	if not FrameUpdate:hasListener(self) then
		FrameUpdate:addListener(self)
	end

	local isAuto = StoryController.instance:getAutoPlay()

	if not canJump and isAuto then
		StoryController.instance:setAutoPlay(false)
	end

	self._playVideo = self._playVideo + 1
	self._processImg.fillAmount = 0

	self:_setPressGoActive(false)
	self:setVisible(true)

	self._closeVideo = true
	self._fadeOutTime = 1
	self._fadeInTime = 0

	local vedioId = videoCode

	self._isPassVideo = true

	if vedioId == 0 then
		return
	end

	if self._showJumpButton then
		goutil.setActive(self._btnSkipVideo.gameObject, false)

		if self._timeArg == "None" then
			self._canClickMask = false

			removetimer(self._setCanClickMaskEvent, self)
			goutil.setActive(self._btnSkipVideo.gameObject, false)
		else
			local waitTime = tonumber(self._timeArg) or 0

			self._canClickMask = false

			removetimer(self._setCanClickMaskEvent, self)
			settimer(waitTime, self._setCanClickMaskEvent, self, false)
		end
	else
		goutil.setActive(self._btnSkipVideo.gameObject, true)
	end

	local nextPath = StoryMgr.instance:getNextVideoPath()
	local old = self._videoMgr

	if old == self._videoMgr1 then
		self._videoMgr = self._videoMgr2
		self._videoImg2.color = Color.New(1, 1, 1, 1)
		self._videoImg1.color = Color.New(1, 1, 1, 0)

		if nextPath then
			self._videoMgr1:ReayPlay(nextPath)
		end
	else
		self._videoMgr = self._videoMgr1
		self._videoImg1.color = Color.New(1, 1, 1, 1)
		self._videoImg2.color = Color.New(1, 1, 1, 0)

		if nextPath then
			self._videoMgr2:ReayPlay(nextPath)
		end
	end

	self._endFrame = 0
	self._startFrame = 0
	self._totalFrame = 0
	self._recordTotalFrame = false

	local videoPath = VideoConfig.instance:getVideoInfoCO(vedioId)

	self._needLoop = isLoop or false

	removetimer(self._delayShowPressGo, self)

	if self._needLoop then
		self._canClickMask = false

		settimer(1, self._delayShowPressGo, self)
	end

	self._nextPath = nextPath

	if videoPath then
		StoryFacde.instance:hideAll(StoryConst.DefaultStateKey)

		local fullVideoPath = GameUrl.getVideoUrl(videoPath.name)

		self._videoMgr:AddCuePointCallBack(self._onCuePointCallBack, self)

		if self._playVideo == 1 then
			if self._needLoop then
				self._videoMgr:PlayMovie(fullVideoPath, true, true)
			else
				self._videoMgr:PlayMovie(fullVideoPath, true, false, self._onPlayFinished, self)
			end
		elseif self._needLoop then
			self._videoMgr:PlayForStory(true, true)
		else
			self._videoMgr:PlayForStory(true, false, self._onPlayFinished, self)
		end

		local new = self._videoMgr

		if new == self._videoMgr1 then
			self._videoImg1.transform:SetAsLastSibling()
			self._videoMgr2:StopMovie()

			self._videoImg1.color = Color.New(1, 1, 1, 0)

			self._videoImg1:DOKill()
			self._videoImg1:DOFade(1, self._fadeInTime):SetAutoKill(true)
		else
			self._videoMgr1:StopMovie()
			self._videoImg2.transform:SetAsLastSibling()

			self._videoImg2.color = Color.New(1, 1, 1, 0)

			self._videoImg2:DOKill()
			self._videoImg2:DOFade(1, self._fadeInTime):SetAutoKill(true)
		end

		self._totalFrame = self._videoMgr:GetTotalFrame()
		self._isPlaying = true

		StoryModel.instance:setVideo(self._isPlaying)
	end
end

function M:_onCuePointCallBack(name, time, tunit, type, paramStr)
	print(string.format("name=%s, time= %s, unit=%s , type:=%s,paramStr = %s", name, time, tunit, type, paramStr))
end

function M:_onPlayFinished()
	local isAuto = StoryController.instance:getAutoPlay()

	self:_sendViewVideoRequest(false)

	if isAuto then
		self:_fadeOutVedio()
	else
		if not self._nextPath then
			goutil.setActive(self._vedioPanel, false)
		end

		self._isPlaying = false

		StoryModel.instance:setVideo(self._isPlaying)
	end
end

function M:luaUpdate(deltaTime)
	if not self._videoMgr then
		return
	end

	if self._isExit then
		return
	end

	if not self._isPlaying then
		return
	end

	if self._videoMgr1 and self._videoMgr1:GetMovePlayer() and self._videoMgr1:GetCurStatus() == CriMana.Player.Status.Stop then
		self._videoMgr1:GetMovePlayer():PrepareForRendering()
	end

	if self._videoMgr2 and self._videoMgr2:GetMovePlayer() and self._videoMgr2:GetCurStatus() == CriMana.Player.Status.Stop then
		self._videoMgr2:GetMovePlayer():PrepareForRendering()
	end
end

function M:_removeVedio()
	self._recordTotalFrame = false
	self._isPlaying = false

	StoryModel.instance:setVideo(self._isPlaying)
	FrameUpdate:removeListener(self)

	if self._videoMgr then
		self._videoMgr:RemoveCuePointCallBack()
		self._videoMgr:Reset()
	end

	self._videoMgr1:Reset()
	self._videoMgr2:Reset()

	self._videoImg2.color = Color.New(1, 1, 1, 0)
	self._videoImg1.color = Color.New(1, 1, 1, 0)

	goutil.setActive(self._vedioPanel, false)
end

function M:setVisible(visible)
	if not visible then
		self._canClickMask = false

		removetimer(self._canClickMask, self)
		removetimer(self._delayShowPressGo, self)
		self:_setPressGoActive(false)
		self:_removeVedio()
		self._imgContent:DOKill()

		self._playVideo = 0
	end

	goutil.setActive(self._vedioPanel, visible)
end

function M:_onClickMask()
	if not self._canClickMask then
		return
	end

	goutil.setActive(self._btnSkipVideo.gameObject, true)
end

function M:_onClickJump()
	local info = {}

	info.clickRightCallBackFunc = self._doJumpVedio
	info.clickRightCallBackHandler = self
	info.content = lang("tip_story_ep_skip_desc")
	info.leftTxt = lang("tip_story_ep_skip_ok")
	info.rightTxt = lang("tip_story_ep_skip_cancle")

	ViewMgr.instance:open(ViewName.CommonConfirmTips, info)
end

function M:_doJumpVedio()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	self:_sendViewVideoRequest(true)

	if not _storyEntry:IsEnd() then
		_storyEntry:GotoShotEnd()
		self:_onPlayFinished()
		_storyEntry:NextShot()
	else
		StoryController.instance:Close()
	end
end

function M:_sendViewVideoRequest(isSkip)
	if not self._startVideoTime then
		return
	end

	local curTime = os.time()
	local videoTime = curTime - self._startVideoTime
	local videoId = self._curVideoCode

	DungeonAgent.instance:sendViewVideoRequest(videoId, isSkip, videoTime)

	self._startVideoTime = nil
end

function M:_tryNextStoryNode()
	if self._needLoop and self._isPlaying then
		self:_doNextNode()
	end
end

function M:_doNextNode()
	self._isPlaying = false

	StoryModel.instance:setVideo(self._isPlaying)
	StoryFacde.instance:tryNextShot()
end

function M:_onPressVideo(isLongPressOn, posx, posy)
	if isLongPressOn then
		self._isLongPressOn = true
		self._beginTime = Time.time

		self:_doFillCircleAnim()
	end
end

function M:_doFillCircleAnim()
	if self._aniSequence then
		self._aniSequence:Kill()
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_juqing_rolerecord)

	self._aniSequence = DG.Tweening.DOTween.Sequence()

	self._aniSequence:Join(self._processImg:DOFillAmount(1, FILLAMOUN_TIME):SetEase(DG.Tweening.Ease.Linear))
	self._aniSequence:SetAutoKill(true)
	self._aniSequence:SetTarget(self._videoPressGo)
	self._aniSequence:AppendCallback(self._onSelectAnimFinis, self)
end

function M:_delayShowPressGo()
	self:_setPressGoActive(true)
end

function M:_setPressGoActive(active)
	goutil.setActive(self._videoPressGo, active)
	goutil.setActive(self._goDownTextRoot, active)
end

function M:_onSelectAnimFinis()
	self:_setPressGoActive(false)
	self:_sendViewVideoRequest(false)
	self:_tryNextStoryNode()
end

function M:_onExitPressVideo(isExit)
	if isExit then
		self._isLongPressOn = false

		if self._aniSequence then
			self._aniSequence:Kill()
		end

		CriwareAudioFacade.instance:stopSoundById(CriwareAudioEnum.ui_juqing_rolerecord)

		if self._beginTime then
			if Time.time - self._beginTime < FILLAMOUN_TIME then
				self._aniSequence = DG.Tweening.DOTween.Sequence()

				self._aniSequence:Join(self._processImg:DOFillAmount(0, RewindTime))
				self._aniSequence:SetAutoKill(true)
				self._aniSequence:SetTarget(self._videoPressGo)
				self._aniSequence:AppendCallback(function()
					self:_doFillUnlock()
				end)
			end
		else
			self:_doFillUnlock()
		end
	end
end

function M:_doFillUnlock()
	self._processImg.fillAmount = 0
end

return M
