-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeView.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeView", package.seeall)

local VersionActivity2_4MusicFreeView = class("VersionActivity2_4MusicFreeView", BaseView)

function VersionActivity2_4MusicFreeView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_FullBG")
	self._gotopleftbtn = gohelper.findChild(self.viewGO, "root/#go_topleftbtn")
	self._btnremove1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/Title/#btn_remove1")
	self._btnremove2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/Title/#btn_remove2")
	self._gotranscribelist = gohelper.findChild(self.viewGO, "root/left/scroll_transcribelist/viewport/#go_transcribe_list")
	self._txtstatetext = gohelper.findChildText(self.viewGO, "root/left/bottom_btn/#txt_statetext")
	self._btntranscribebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#btn_transcribebtn")
	self._btntranscribeagainbtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#btn_transcribe_againbtn")
	self._btnplaybtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#btn_playbtn")
	self._gobtngroup1 = gohelper.findChild(self.viewGO, "root/left/bottom_btn/#go_btngroup1")
	self._btnpause = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_pause")
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_continue")
	self._btndone = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_done")
	self._gobtngroup2 = gohelper.findChild(self.viewGO, "root/left/bottom_btn/#go_btngroup2")
	self._btnpause2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_pause2")
	self._btncontinue2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_continue2")
	self._btnstop = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_stop")
	self._gobtngroup3 = gohelper.findChild(self.viewGO, "root/left/bottom_btn/#go_btngroup3")
	self._btncanel = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup3/#btn_canel")
	self._btndel = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/bottom_btn/#go_btngroup3/#btn_del")
	self._btnaccompany = gohelper.findChildButtonWithAudio(self.viewGO, "root/toprightbtn/#btn_accompany")
	self._btncalibration = gohelper.findChildButtonWithAudio(self.viewGO, "root/toprightbtn/#btn_calibration")
	self._btnimmerse = gohelper.findChildButtonWithAudio(self.viewGO, "root/toprightbtn/#btn_immerse")
	self._gomusic1 = gohelper.findChild(self.viewGO, "root/right/#go_music1")
	self._gomusic2 = gohelper.findChild(self.viewGO, "root/right/#go_music2")
	self._goinstruments = gohelper.findChild(self.viewGO, "root/right/bottom/#go_instruments")
	self._gocountdown = gohelper.findChild(self.viewGO, "#go_countdown")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_countdown/#txt_num")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeView:addEvents()
	self._btnremove1:AddClickListener(self._btnremove1OnClick, self)
	self._btnremove2:AddClickListener(self._btnremove2OnClick, self)
	self._btntranscribebtn:AddClickListener(self._btntranscribebtnOnClick, self)
	self._btntranscribeagainbtn:AddClickListener(self._btntranscribeagainbtnOnClick, self)
	self._btnplaybtn:AddClickListener(self._btnplaybtnOnClick, self)
	self._btnpause:AddClickListener(self._btnpauseOnClick, self)
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
	self._btndone:AddClickListener(self._btndoneOnClick, self)
	self._btnpause2:AddClickListener(self._btnpause2OnClick, self)
	self._btncontinue2:AddClickListener(self._btncontinue2OnClick, self)
	self._btnstop:AddClickListener(self._btnstopOnClick, self)
	self._btncanel:AddClickListener(self._btncanelOnClick, self)
	self._btndel:AddClickListener(self._btndelOnClick, self)
	self._btnaccompany:AddClickListener(self._btnaccompanyOnClick, self)
	self._btncalibration:AddClickListener(self._btncalibrationOnClick, self)
	self._btnimmerse:AddClickListener(self._btnimmerseOnClick, self)
end

function VersionActivity2_4MusicFreeView:removeEvents()
	self._btnremove1:RemoveClickListener()
	self._btnremove2:RemoveClickListener()
	self._btntranscribebtn:RemoveClickListener()
	self._btntranscribeagainbtn:RemoveClickListener()
	self._btnplaybtn:RemoveClickListener()
	self._btnpause:RemoveClickListener()
	self._btncontinue:RemoveClickListener()
	self._btndone:RemoveClickListener()
	self._btnpause2:RemoveClickListener()
	self._btncontinue2:RemoveClickListener()
	self._btnstop:RemoveClickListener()
	self._btncanel:RemoveClickListener()
	self._btndel:RemoveClickListener()
	self._btnaccompany:RemoveClickListener()
	self._btncalibration:RemoveClickListener()
	self._btnimmerse:RemoveClickListener()
end

function VersionActivity2_4MusicFreeView:_btnremove1OnClick()
	local status = VersionActivity2_4MusicFreeModel.instance:getActionStatus()
	local isDel = status == VersionActivity2_4MusicEnum.ActionStatus.Del

	if isDel then
		return
	end

	if not VersionActivity2_4MusicFreeModel.instance:isNormalStatus() then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Del)
end

function VersionActivity2_4MusicFreeView:_btnremove2OnClick()
	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
end

function VersionActivity2_4MusicFreeView:_btndelOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.MusicDelConfirm, MsgBoxEnum.BoxType.Yes_No, function()
		VersionActivity2_4MusicFreeModel.instance:delTrackSelected()
	end)
end

function VersionActivity2_4MusicFreeView:_btntranscribebtnOnClick()
	self:_checkStartRecord()
end

function VersionActivity2_4MusicFreeView:_btntranscribeagainbtnOnClick()
	self:_checkStartRecord()
end

function VersionActivity2_4MusicFreeView:_checkStartRecord()
	local mo = VersionActivity2_4MusicFreeModel.instance:getTrackMo()

	if mo and mo.recordTotalTime > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicReplaceConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			VersionActivity2_4MusicController.instance:stopBgm()
			self:_startCountDown(self._startRecord, VersionActivity2_4MusicEnum.RecordStatus.Recording)
		end)

		return
	end

	VersionActivity2_4MusicController.instance:stopBgm()
	self:_startCountDown(self._startRecord, VersionActivity2_4MusicEnum.RecordStatus.Recording)
end

function VersionActivity2_4MusicFreeView:_startRecord()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.StartRecord)
end

function VersionActivity2_4MusicFreeView:_btnplaybtnOnClick()
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.StartPlay)
end

function VersionActivity2_4MusicFreeView:_btnpauseOnClick()
	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordPause)
end

function VersionActivity2_4MusicFreeView:_btncontinueOnClick()
	self:_onContinue()
end

function VersionActivity2_4MusicFreeView:_onContinue()
	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Recording)
	VersionActivity2_4MusicController.instance:resumeBgm()
end

function VersionActivity2_4MusicFreeView:_startCountDown(callback, nextStatus)
	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordReady, nextStatus)

	self._countDownCallback = callback
	self._countDownNum = 3

	TaskDispatcher.cancelTask(self._countDownHandler, self)
	TaskDispatcher.runRepeat(self._countDownHandler, self, 1)
	self:_countDownHandler()

	self._countDownId = AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_count_down)
end

function VersionActivity2_4MusicFreeView:_countDownHandler()
	if self._countDownNum == 0 then
		self._countDownId = nil

		TaskDispatcher.cancelTask(self._countDownHandler, self)
		self:_countDownCallback()

		return
	end

	self._txtnum.text = tostring(self._countDownNum)
	self._countDownNum = self._countDownNum - 1
end

function VersionActivity2_4MusicFreeView:_btndoneOnClick()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndRecord)
end

function VersionActivity2_4MusicFreeView:_btnpause2OnClick()
	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.PlayPause)
end

function VersionActivity2_4MusicFreeView:_btncontinue2OnClick()
	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Playing)
	VersionActivity2_4MusicController.instance:resumeBgm()
end

function VersionActivity2_4MusicFreeView:_btncanelOnClick()
	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
end

function VersionActivity2_4MusicFreeView:_btnaccompanyOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function VersionActivity2_4MusicFreeView:_btncalibrationOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeCalibrationView()
end

function VersionActivity2_4MusicFreeView:_btnimmerseOnClick()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeImmerseView()
end

function VersionActivity2_4MusicFreeView:_btninstrument1OnClick()
	return
end

function VersionActivity2_4MusicFreeView:_btnstopOnClick()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndPlay)
end

function VersionActivity2_4MusicFreeView:_editableInitView()
	gohelper.setActive(self._btnaccompany, false)
	VersionActivity2_4MusicFreeModel.instance:onStart()
	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Normal)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartRecord, self._onStartRecord, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndRecord, self._onEndRecord, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartPlay, self._onStartPlay, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndPlay, self._onEndPlay, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ActionStatusChange, self._onActionStatusChange, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.TrackDelSelectedChange, self._onTrackDelSelectedChange, self)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.UpdateSelectedTrackIndex, self._onUpdateSelectedTrackIndex, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewCallBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	self._recordStartTime = 0
	self._recordTotalTime = 0
	self._txtstatetext.text = ""
end

function VersionActivity2_4MusicFreeView:_onOpenViewCallBack(viewName)
	if viewName == ViewName.VersionActivity2_4MusicFreeImmerseView or viewName == ViewName.VersionActivity2_4MusicFreeCalibrationView then
		return
	end

	if self._isRecord then
		self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordPause)
	end

	if self._isPlay then
		self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.PlayPause)
	end
end

function VersionActivity2_4MusicFreeView:_onCloseViewFinish(viewName)
	return
end

function VersionActivity2_4MusicFreeView:_onUpdateSelectedTrackIndex()
	self:_updateRecordBtnStatus()
end

function VersionActivity2_4MusicFreeView:_onTrackDelSelectedChange()
	self._btndel.button.interactable = VersionActivity2_4MusicFreeModel.instance:getTrackSelectedNum() > 0
end

function VersionActivity2_4MusicFreeView:_onActionStatusChange()
	local status = VersionActivity2_4MusicFreeModel.instance:getActionStatus()
	local isDel = status == VersionActivity2_4MusicEnum.ActionStatus.Del

	self:_updateBtnStatus((isDel or nil) and (VersionActivity2_4MusicEnum.RecordStatus.Del or VersionActivity2_4MusicEnum.RecordStatus.Normal))
end

function VersionActivity2_4MusicFreeView:_onStartPlay()
	self._isPlay = true
	self._recordStartTime = Time.time
	self._recordTotalTime = 0

	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Playing)
	VersionActivity2_4MusicFreeModel.instance:startPlay()
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function VersionActivity2_4MusicFreeView:_onEndPlay()
	self._isPlay = false

	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Normal)
	VersionActivity2_4MusicFreeModel.instance:endPlay()
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicFreeModel.instance:onAccompanyStatusChange()
end

function VersionActivity2_4MusicFreeView:_onStartRecord()
	self._isRecord = true
	self._recordStartTime = Time.time
	self._recordTotalTime = 0
	self._skipTrackMap = {}
	self._skipTrackMap[VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()] = true

	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Recording)
	VersionActivity2_4MusicFreeModel.instance:startRecord()
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function VersionActivity2_4MusicFreeView:_onEndRecord()
	self._isRecord = false

	VersionActivity2_4MusicFreeModel.instance:endRecord()
	self:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord)
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicFreeModel.instance:onAccompanyStatusChange()

	local episodeId = Activity179Config.instance:getFreeEpisodeId()

	Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), episodeId, 0)
end

function VersionActivity2_4MusicFreeView:_updateRecordBtnStatus()
	local status = VersionActivity2_4MusicFreeModel.instance:getStatus()
	local isNormal = status == VersionActivity2_4MusicEnum.RecordStatus.Normal
	local isNormalAfterRecord = status == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
	local isNormalStatus = isNormal or isNormalAfterRecord
	local mo = VersionActivity2_4MusicFreeModel.instance:getTrackMo()

	gohelper.setActive(self._btntranscribebtn, isNormalStatus and mo and mo.recordTotalTime <= 0)
	gohelper.setActive(self._btntranscribeagainbtn, isNormalStatus and mo and mo.recordTotalTime > 0)
end

function VersionActivity2_4MusicFreeView:_updateBtnStatus(status, nextStatus)
	VersionActivity2_4MusicFreeModel.instance:setStatus(status)

	local isNormal = status == VersionActivity2_4MusicEnum.RecordStatus.Normal
	local isNormalAfterRecord = status == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
	local isNormalStatus = isNormal or isNormalAfterRecord
	local isCountDownState = status == VersionActivity2_4MusicEnum.RecordStatus.RecordReady
	local isRecording = status == VersionActivity2_4MusicEnum.RecordStatus.Recording or nextStatus == VersionActivity2_4MusicEnum.RecordStatus.Recording
	local isRecordingPause = status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause
	local isRecordingStatus = isRecording or isRecordingPause
	local isPlaying = status == VersionActivity2_4MusicEnum.RecordStatus.Playing
	local isPlayingPause = status == VersionActivity2_4MusicEnum.RecordStatus.PlayPause
	local isPlayingStatus = isPlaying or isPlayingPause
	local isDel = status == VersionActivity2_4MusicEnum.RecordStatus.Del

	self:_updateRecordBtnStatus()
	gohelper.setActive(self._btnplaybtn, isNormalStatus)
	gohelper.setActive(self._gobtngroup1, isRecordingStatus)
	gohelper.setActive(self._gobtngroup2, isPlayingStatus)
	gohelper.setActive(self._gobtngroup3, isDel)
	gohelper.setActive(self._gocountdown, isCountDownState)
	gohelper.setActive(self._btnremove2, isDel)
	gohelper.setActive(self._btnremove1, not isDel)
	gohelper.setActive(self._btndel, isDel)

	if isNormalStatus then
		self._btnplaybtn.button.interactable = VersionActivity2_4MusicFreeModel.instance:anyOneHasRecorded()
	end

	self._txtstatetext.text = ""

	if isCountDownState then
		self._txtstatetext.text = luaLang("MusicRecordReady")
	end

	if status == VersionActivity2_4MusicEnum.RecordStatus.Recording then
		self._txtstatetext.text = luaLang("MusicRecording")
	end

	if isRecordingPause then
		self._txtstatetext.text = luaLang("MusicRecordPause")
	end

	if isPlaying then
		self._txtstatetext.text = luaLang("MusicPlaying")
	end

	if isPlayingPause then
		self._txtstatetext.text = luaLang("MusicPlayPause")
	end

	if isDel then
		self:_onTrackDelSelectedChange()
	end

	if isRecordingStatus then
		gohelper.setActive(self._btnpause, isRecording)
		gohelper.setActive(self._btncontinue, isRecordingPause)
	end

	if isPlayingStatus then
		gohelper.setActive(self._btnpause2, isPlaying)
		gohelper.setActive(self._btncontinue2, isPlayingPause)
	end

	self:_recordOnStatusChange(status)
	self:_bgmOnStatusChange(status)
end

function VersionActivity2_4MusicFreeView:_bgmOnStatusChange(status)
	if status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause or status == VersionActivity2_4MusicEnum.RecordStatus.PlayPause then
		VersionActivity2_4MusicController.instance:pauseBgm()
	end
end

function VersionActivity2_4MusicFreeView:_recordOnStatusChange(status)
	TaskDispatcher.cancelTask(self._onRecordingFrame, self)
	TaskDispatcher.cancelTask(self._playFrame, self)

	if status == VersionActivity2_4MusicEnum.RecordStatus.Recording then
		self._recordStartTime = Time.time

		TaskDispatcher.runRepeat(self._onRecordingFrame, self, 0)
	elseif status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause then
		self._recordTotalTime = self._recordTotalTime + (Time.time - self._recordStartTime)
	end

	if status == VersionActivity2_4MusicEnum.RecordStatus.Playing then
		self._recordStartTime = Time.time

		TaskDispatcher.runRepeat(self._playFrame, self, 0)
	elseif status == VersionActivity2_4MusicEnum.RecordStatus.PlayPause then
		self._recordTotalTime = self._recordTotalTime + (Time.time - self._recordStartTime)
	end
end

function VersionActivity2_4MusicFreeView:_onRecordingFrame()
	local time = Time.time - self._recordStartTime
	local tempTotalTime = self._recordTotalTime + time

	VersionActivity2_4MusicFreeModel.instance:setRecordProgressTime(tempTotalTime)

	if VersionActivity2_4MusicFreeModel.instance:timeout(tempTotalTime) then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndRecord)

		return
	end

	VersionActivity2_4MusicFreeModel.instance:playTrackList(self._skipTrackMap)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.RecordFrame, tempTotalTime)
end

function VersionActivity2_4MusicFreeView:_playFrame()
	local time = Time.time - self._recordStartTime
	local tempTotalTime = self._recordTotalTime + time

	VersionActivity2_4MusicFreeModel.instance:setRecordProgressTime(tempTotalTime)

	local isFinished = VersionActivity2_4MusicFreeModel.instance:playTrackList()

	if isFinished then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndPlay)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.PlayFrame, tempTotalTime)
end

function VersionActivity2_4MusicFreeView:onUpdateParam()
	return
end

function VersionActivity2_4MusicFreeView:onOpen()
	return
end

function VersionActivity2_4MusicFreeView:onClose()
	if self._countDownId then
		AudioMgr.instance:stopPlayingID(self._countDownId)

		self._countDownId = nil
	end

	TaskDispatcher.cancelTask(self._onRecordingFrame, self)
	TaskDispatcher.cancelTask(self._playFrame, self)
	TaskDispatcher.cancelTask(self._countDownHandler, self)
	VersionActivity2_4MusicFreeModel.instance:onEnd()
end

function VersionActivity2_4MusicFreeView:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeView
