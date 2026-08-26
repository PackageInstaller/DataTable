-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicBeatView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatView", package.seeall)

local VersionActivity2_4MusicBeatView = class("VersionActivity2_4MusicBeatView", BaseView)

function VersionActivity2_4MusicBeatView:onInitView()
	self._gotopleftbtn = gohelper.findChild(self.viewGO, "root/#go_topleftbtn")
	self._txtscore = gohelper.findChildText(self.viewGO, "root/scoregroup/#txt_score")
	self._txtmaxscore = gohelper.findChildText(self.viewGO, "root/scoregroup/#txt_maxscore")
	self._gocombo = gohelper.findChild(self.viewGO, "root/#go_combo")
	self._gostate1 = gohelper.findChild(self.viewGO, "root/#go_combo/#go_state1")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/#go_combo/#go_state1/#txt_num1")
	self._gostate2 = gohelper.findChild(self.viewGO, "root/#go_combo/#go_state2")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/#go_combo/#go_state2/#txt_num2")
	self._gostate3 = gohelper.findChild(self.viewGO, "root/#go_combo/#go_state3")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "root/#go_combo/#go_state3/#txt_num3")
	self._btnstop = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_stop")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_skip")
	self._btnaccompany = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#btn_accompany")
	self._txttime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_time")
	self._gomissclick = gohelper.findChild(self.viewGO, "root/#go_missclick")
	self._gobeatgrid = gohelper.findChild(self.viewGO, "root/#go_beatgrid")
	self._gobeatitem = gohelper.findChild(self.viewGO, "root/#go_beatgrid/#go_beatitem")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_start")
	self._gocountdown = gohelper.findChild(self.viewGO, "root/#go_countdown")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_countdown/#txt_num")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicBeatView:addEvents()
	self._btnstop:AddClickListener(self._btnstopOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnaccompany:AddClickListener(self._btnaccompanyOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function VersionActivity2_4MusicBeatView:removeEvents()
	self._btnstop:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._btnaccompany:RemoveClickListener()
	self._btnstart:RemoveClickListener()
end

function VersionActivity2_4MusicBeatView:_btnstopOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
		isPause = true
	})
end

function VersionActivity2_4MusicBeatView:_btnskipOnClick()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.Skip)
	StoryController.instance:playStory(self._episodeConfig.storyAfter, nil, self.closeThis, self)
end

function VersionActivity2_4MusicBeatView:_btnaccompanyOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function VersionActivity2_4MusicBeatView:_btnstartOnClick()
	self:_startCountDown(self._startGame)
end

function VersionActivity2_4MusicBeatView:_startCountDown(callback)
	self._countDownCallback = callback

	self:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.CountDown)

	self._countDownNum = 3

	TaskDispatcher.cancelTask(self._countDownHandler, self)
	TaskDispatcher.runRepeat(self._countDownHandler, self, 1)
	self:_countDownHandler()

	self._countDownId = AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_count_down)
end

function VersionActivity2_4MusicBeatView:_countDownHandler()
	if self._countDownNum == 0 then
		self._countDownId = nil

		TaskDispatcher.cancelTask(self._countDownHandler, self)
		self:_countDownCallback()

		return
	end

	self._txtnum.text = tostring(self._countDownNum)
	self._countDownNum = self._countDownNum - 1
end

function VersionActivity2_4MusicBeatView:_startGame()
	self:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Playing)

	self._startTime = Time.time
	self._progressTime = 0

	self._noteView:startGame()
	VersionActivity2_4MusicController.instance:playBgm(self._audio)
	TaskDispatcher.cancelTask(self._updateFrame, self)
	TaskDispatcher.runRepeat(self._updateFrame, self, 0)
end

function VersionActivity2_4MusicBeatView:_endGame()
	TaskDispatcher.cancelTask(self._updateFrame, self)
	self:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.End)
	self._noteView:endGame()
	VersionActivity2_4MusicController.instance:stopBgm()
end

function VersionActivity2_4MusicBeatView:_pauseGame()
	self._progressTime = self._progressTime + Time.time - self._startTime

	TaskDispatcher.cancelTask(self._updateFrame, self)
	VersionActivity2_4MusicController.instance:pauseBgm()
	self._noteView:refreshNoteGroupStatus(true)
end

function VersionActivity2_4MusicBeatView:_continueGame()
	self._startTime = Time.time

	TaskDispatcher.runRepeat(self._updateFrame, self, 0)
	VersionActivity2_4MusicController.instance:resumeBgm()
	self._noteView:refreshNoteGroupStatus(false)
end

function VersionActivity2_4MusicBeatView:_updateFrame()
	local progressTime = self._progressTime + (Time.time - self._startTime)

	self:_updateTime(progressTime)
	self._noteView:updateNoteGroup(progressTime)

	if progressTime >= self._totalTime then
		self._noteView:openResult()
		self:_endGame()

		return
	end

	if SLFramework.FrameworkSettings.IsEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		self._noteView:openResult(true)
		self:_endGame()
	end
end

function VersionActivity2_4MusicBeatView:_editableInitView()
	return
end

function VersionActivity2_4MusicBeatView:onUpdateParam()
	return
end

function VersionActivity2_4MusicBeatView:onOpen()
	self._episodeId = self.viewParam

	VersionActivity2_4MusicBeatModel.instance:onStart(self._episodeId)
	VersionActivity2_4MusicController.instance:onEnterBeatView(self._episodeId)

	self._noteView = self.viewContainer:getNoteView()
	self._episodeConfig = Activity179Config.instance:getEpisodeConfig(self._episodeId)

	local beatId = self._episodeConfig.beatId

	self._beatConfig = Activity179Config.instance:getBeatConfig(beatId)
	self._txtmaxscore.text = "/" .. self._beatConfig.targetId
	self._audio = self._beatConfig.resouce
	self._totalTime = self._beatConfig.time
	self._progressTime = 0

	self:_updateTime(0)
	self:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.None)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.BeatModeEnd, self._onBeatModeEnd, self)
end

function VersionActivity2_4MusicBeatView:_onBeatModeEnd()
	self:_endGame()
end

function VersionActivity2_4MusicBeatView:_onOpenView(viewName)
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self._status == VersionActivity2_4MusicEnum.BeatStatus.Playing then
		self:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Pause)
		self:_pauseGame()

		return
	end

	if self._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown then
		TaskDispatcher.cancelTask(self._countDownHandler, self)
	end
end

function VersionActivity2_4MusicBeatView:_onCloseViewFinish(viewName)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	if self._status == VersionActivity2_4MusicEnum.BeatStatus.End then
		self:_updateTime(0)
		self:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.None)
		self._noteView:initNoneStatus()
	end

	if self._status == VersionActivity2_4MusicEnum.BeatStatus.Pause then
		self:_startCountDown(function()
			self:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Playing)
			self:_continueGame()
		end)

		return
	end

	if self._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown then
		TaskDispatcher.runRepeat(self._countDownHandler, self, 1)
	end
end

function VersionActivity2_4MusicBeatView:isCountDown()
	return self._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown
end

function VersionActivity2_4MusicBeatView:isPlaying()
	return self._status ~= VersionActivity2_4MusicEnum.BeatStatus.None
end

function VersionActivity2_4MusicBeatView:_updateStatus(status)
	self._status = status

	self:_updateBtnStatus()
end

function VersionActivity2_4MusicBeatView:_updateBtnStatus()
	self._hasFinished = Activity179Model.instance:episodeIsFinished(self._episodeId)

	local isNoneState = self._status == VersionActivity2_4MusicEnum.BeatStatus.None
	local isCountDownState = self._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown
	local isPlayingState = self._status == VersionActivity2_4MusicEnum.BeatStatus.Playing
	local isEndState = self._status == VersionActivity2_4MusicEnum.BeatStatus.End

	gohelper.setActive(self._btnstart, isNoneState)
	gohelper.setActive(self._btnaccompany, isNoneState or isPlayingState or isEndState)
	gohelper.setActive(self._btnskip, isNoneState and self._hasFinished)
	gohelper.setActive(self._btnstop, isPlayingState or isEndState)
	gohelper.setActive(self._gocountdown, isCountDownState)
	gohelper.setActive(self._goblock, isCountDownState)
end

function VersionActivity2_4MusicBeatView:_updateTime(progressTime)
	local deltaTime = self._totalTime - progressTime

	if deltaTime < 0 then
		deltaTime = 0
	end

	self._txttime.text = TimeUtil.second2TimeString(deltaTime)
end

function VersionActivity2_4MusicBeatView:onClose()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish)

	if self._countDownId then
		AudioMgr.instance:stopPlayingID(self._countDownId)

		self._countDownId = nil
	end
end

function VersionActivity2_4MusicBeatView:onDestroyView()
	TaskDispatcher.cancelTask(self._countDownHandler, self)
	TaskDispatcher.cancelTask(self._updateFrame, self)
end

return VersionActivity2_4MusicBeatView
