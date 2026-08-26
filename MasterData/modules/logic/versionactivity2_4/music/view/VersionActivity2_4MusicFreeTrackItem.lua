-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicFreeTrackItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeTrackItem", package.seeall)

local VersionActivity2_4MusicFreeTrackItem = class("VersionActivity2_4MusicFreeTrackItem", ListScrollCellExtend)

function VersionActivity2_4MusicFreeTrackItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._imageslider = gohelper.findChildImage(self.viewGO, "#go_normal/#image_slider")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "#go_normal/#txt_num1")
	self._txttime1 = gohelper.findChildText(self.viewGO, "#go_normal/#txt_time1")
	self._godelstate = gohelper.findChild(self.viewGO, "#go_delstate")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "#go_delstate/#txt_num3")
	self._txttime3 = gohelper.findChildText(self.viewGO, "#go_delstate/#txt_time3")
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._gorecorded = gohelper.findChild(self.viewGO, "#go_recorded")
	self._imagerecordbg = gohelper.findChildImage(self.viewGO, "#go_recorded/#image_recordbg")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "#go_recorded/#txt_num2")
	self._txttime2 = gohelper.findChildText(self.viewGO, "#go_recorded/#txt_time2")
	self._btnmute = gohelper.findChildButtonWithAudio(self.viewGO, "#go_recorded/rightbtn/#btn_mute")
	self._btnunmute = gohelper.findChildButtonWithAudio(self.viewGO, "#go_recorded/rightbtn/#btn__unmute")
	self._goselectframe = gohelper.findChild(self.viewGO, "#go_selectframe")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicFreeTrackItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnmute:AddClickListener(self._btnmuteOnClick, self)
	self._btnunmute:AddClickListener(self._btnunmuteOnClick, self)
end

function VersionActivity2_4MusicFreeTrackItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnmute:RemoveClickListener()
	self._btnunmute:RemoveClickListener()
end

function VersionActivity2_4MusicFreeTrackItem:_btnmuteOnClick()
	self:_updateMuteStatus(true)
end

function VersionActivity2_4MusicFreeTrackItem:_btnunmuteOnClick()
	self:_updateMuteStatus(false)
end

function VersionActivity2_4MusicFreeTrackItem:_btnclickOnClick()
	if self._isRecord or self._isPlay then
		return
	end

	if self._isDelStatus then
		self._mo:setDelSelected(not self._mo.isDelSelected)
		self:updateSelected()
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.TrackDelSelectedChange)

		return
	end

	if self._isAddStatus then
		VersionActivity2_4MusicFreeModel.instance:addTrack()
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateTrackList)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ClickTrackItem, self._index)
end

function VersionActivity2_4MusicFreeTrackItem:_editableInitView()
	gohelper.setActive(self._goselectframe, false)
end

function VersionActivity2_4MusicFreeTrackItem:_editableAddEvents()
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartRecord, self._onStartRecord, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndRecord, self._onEndRecord, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordPause, self._onRecordPause, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordContinue, self._onRecordContinue, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartPlay, self._onStartPlay, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndPlay, self._onEndPlay, self, LuaEventSystem.Low)
end

function VersionActivity2_4MusicFreeTrackItem:_onStartPlay()
	self._isPlay = true

	self:_updateStatus()

	if self._mo.recordTotalTime > 0 then
		self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, self._onPlayFrame, self)
	end
end

function VersionActivity2_4MusicFreeTrackItem:_onEndPlay()
	self._isPlay = false

	self:_updateStatus()
	self.removeEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, self._onPlayFrame, self)
end

function VersionActivity2_4MusicFreeTrackItem:_onPlayFrame(playTotalTime)
	local recordTotalTime = self._mo.recordTotalTime

	if recordTotalTime <= playTotalTime then
		self.removeEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, self._onPlayFrame, self)
	end

	self._imagerecordbg.fillAmount = playTotalTime / recordTotalTime

	local remainTime = math.ceil(recordTotalTime - playTotalTime)

	if recordTotalTime < remainTime then
		remainTime = math.floor(recordTotalTime)
	end

	if remainTime <= 0 then
		remainTime = 0
	end

	self._txttime2.text = string.format("%s", TimeUtil.second2TimeString(remainTime))
end

function VersionActivity2_4MusicFreeTrackItem:_onStartRecord()
	self._isRecord = true

	self:_updateStatus()

	if self._isSelected then
		self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, self._onRecordFrame, self)

		return
	end

	if self._mo.recordTotalTime > 0 then
		self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, self._onPlayFrame, self)
	end
end

function VersionActivity2_4MusicFreeTrackItem:_onEndRecord()
	self._isRecord = false

	self:_updateStatus()
	self.removeEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, self._onRecordFrame, self)
	self.removeEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, self._onPlayFrame, self)
end

function VersionActivity2_4MusicFreeTrackItem:_onRecordPause()
	return
end

function VersionActivity2_4MusicFreeTrackItem:_onRecordContinue()
	return
end

function VersionActivity2_4MusicFreeTrackItem:_onRecordFrame(recordTotalTime)
	self._imageslider.fillAmount = recordTotalTime / self._trackLengthConst
	self._txttime1.text = string.format("%s/%s", TimeUtil.second2TimeString(recordTotalTime), self._trackLengthConstStr)
end

function VersionActivity2_4MusicFreeTrackItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicFreeTrackItem:onUpdateMO(mo)
	self._mo = mo
	self._index = self._mo.index
	self._trackLengthConst = VersionActivity2_4MusicFreeModel.instance:getTrackLength()
	self._trackLengthConstStr = TimeUtil.second2TimeString(self._trackLengthConst)

	self:_updateStatus()
	self:_updateName(GameUtil.getRomanNums(self._index))
end

function VersionActivity2_4MusicFreeTrackItem:_updateStatus()
	local status = self._mo.status
	local isInactive = status == VersionActivity2_4MusicEnum.TrackStatus.Inactive

	if isInactive then
		gohelper.setActive(self.viewGO, false)

		return
	end

	self._isAddStatus = status == VersionActivity2_4MusicEnum.TrackStatus.Add

	if self._isRecord and self._isAddStatus then
		gohelper.setActive(self.viewGO, false)

		return
	end

	local isSelected = self._index == VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()

	gohelper.setActive(self.viewGO, true)

	self._isUnRecorded = status == VersionActivity2_4MusicEnum.TrackStatus.UnRecorded
	self._isDelStatus = status == VersionActivity2_4MusicEnum.TrackStatus.Del
	self._isFinishedStatus = self._mo.recordTotalTime > 0

	if isSelected and self._isRecord and self._isUnRecorded then
		self._isFinishedStatus = false
	end

	if self._isDelStatus then
		self._isFinishedStatus = false
	end

	if self._isFinishedStatus then
		self._isUnRecorded = false
	end

	gohelper.setActive(self._goadd, self._isAddStatus)
	gohelper.setActive(self._godelstate, self._isDelStatus)
	gohelper.setActive(self._gonormal, self._isUnRecorded)
	gohelper.setActive(self._gorecorded, self._isFinishedStatus)

	if self._isUnRecorded then
		self._imageslider.fillAmount = self._mo.recordTotalTime / self._trackLengthConst
		self._txttime1.text = string.format("%s/%s", TimeUtil.second2TimeString(self._mo.recordTotalTime), self._trackLengthConstStr)
	end

	self._mo:setDelSelected(false)

	if self._isDelStatus then
		self._txttime3.text = string.format("%s/%s", TimeUtil.second2TimeString(self._mo.recordTotalTime), self._trackLengthConstStr)
	end

	if self._isFinishedStatus then
		self._imagerecordbg.fillAmount = 1
		self._txttime2.text = TimeUtil.second2TimeString(self._mo.recordTotalTime)

		self:_updateMuteStatus(self._mo.mute == VersionActivity2_4MusicEnum.MuteStatus.Open)
	end

	self:updateSelected()
end

function VersionActivity2_4MusicFreeTrackItem:_updateMuteStatus(value)
	gohelper.setActive(self._btnmute, not value)
	gohelper.setActive(self._btnunmute, value)
	self._mo:setMute(value)
end

function VersionActivity2_4MusicFreeTrackItem:_updateName(name)
	self._txtnum1.text = name
	self._txtnum2.text = name
	self._txtnum3.text = name
end

function VersionActivity2_4MusicFreeTrackItem:updateSelected()
	if self._isDelStatus then
		self._isSelected = nil

		gohelper.setActive(self._goselectframe, self._mo.isDelSelected)

		return
	end

	self._isSelected = self._index == VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()

	if self._isPlay then
		self._isSelected = false
	end

	gohelper.setActive(self._goselectframe, self._isSelected)
end

function VersionActivity2_4MusicFreeTrackItem:onDestroyView()
	return
end

return VersionActivity2_4MusicFreeTrackItem
