-- chunkname: @modules/logic/versionactivity2_4/music/model/VersionActivity2_4MusicFreeModel.lua

module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicFreeModel", package.seeall)

local VersionActivity2_4MusicFreeModel = class("VersionActivity2_4MusicFreeModel", BaseModel)

function VersionActivity2_4MusicFreeModel:onInit()
	self:reInit()
end

function VersionActivity2_4MusicFreeModel:reInit()
	self._trackList = {}
	self._recordIndex = nil
	self._selectedTrackIndex = nil
end

function VersionActivity2_4MusicFreeModel:getMaxTrackCount()
	return self._maxTrackCount
end

function VersionActivity2_4MusicFreeModel:getTrackLength()
	return self._trackLength
end

function VersionActivity2_4MusicFreeModel:timeout(time)
	return time >= self._trackLength
end

function VersionActivity2_4MusicFreeModel:getTrackList()
	return self._trackList
end

function VersionActivity2_4MusicFreeModel:getTrackMo()
	return self._trackList[self._selectedTrackIndex]
end

function VersionActivity2_4MusicFreeModel:anyOneHasRecorded()
	for _, track in pairs(self._trackList) do
		if track.recordTotalTime > 0 then
			return true
		end
	end

	return false
end

function VersionActivity2_4MusicFreeModel:getActionStatus()
	return self._actionStatus
end

function VersionActivity2_4MusicFreeModel:getAccompanyStatus()
	return self._accompanyStatus
end

function VersionActivity2_4MusicFreeModel:setActionStatus(actionStatus)
	self._actionStatus = actionStatus

	self:updateTrackListStatus()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ActionStatusChange)
end

function VersionActivity2_4MusicFreeModel:onEnd()
	TaskDispatcher.cancelTask(self._playBgm, self)
end

function VersionActivity2_4MusicFreeModel:onStart()
	VersionActivity2_4MusicController.instance:initBgm()

	self._maxTrackCount = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.MaxTrackCount)
	self._trackLength = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.TrackLength)
	self._actionStatus = VersionActivity2_4MusicEnum.ActionStatus.Record
	self._trackList = {}
	self._trackCount = 1

	self:_initTrackList()
	self:updateTrackListStatus()
	self:setInstrumentIndexList({
		1,
		2
	})

	local openValue = VersionActivity2_4MusicEnum.AccompanyStatus.Close

	self._accompanyStatus = self._accompanyStatus or {
		openValue,
		openValue,
		openValue
	}
	self._accompanyIcon = {
		"v2a4_bakaluoer_freeinstrument_icon_t_gu",
		"v2a4_bakaluoer_freeinstrument_icon_t_zhongyin",
		"v2a4_bakaluoer_freeinstrument_icon_t_gaoyin"
	}

	local hasOpen = false

	for i, v in ipairs(self._accompanyStatus) do
		AudioMgr.instance:setRTPCValue(VersionActivity2_4MusicEnum.AccompanyTypeName[i], v)

		if v == VersionActivity2_4MusicEnum.AccompanyStatus.Open then
			hasOpen = true
		end
	end

	if hasOpen then
		TaskDispatcher.cancelTask(self._playBgm, self)
		TaskDispatcher.runDelay(self._playBgm, self, 0.5)
	end
end

function VersionActivity2_4MusicFreeModel:_playBgm()
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function VersionActivity2_4MusicFreeModel:onAccompanyStatusChange()
	if self:isRecordingOrPlaying() then
		return
	end

	local hasOpen = false

	for i, v in ipairs(self._accompanyStatus) do
		if v == VersionActivity2_4MusicEnum.AccompanyStatus.Open then
			hasOpen = true
		end
	end

	if hasOpen then
		if VersionActivity2_4MusicController.instance:bgmIsStop() then
			VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
		end
	elseif VersionActivity2_4MusicController.instance:bgmIsPlay() then
		VersionActivity2_4MusicController.instance:stopBgm()
	end
end

function VersionActivity2_4MusicFreeModel:_initTrackList()
	for i = 1, self._maxTrackCount do
		self:_initTrack(i)
	end
end

function VersionActivity2_4MusicFreeModel:_initTrack(index)
	local ok, errmsg = pcall(self._safeInitTrack, self, index)

	if not ok then
		logError(string.format("VersionActivity2_4MusicFreeModel:_initTrack index:%s error:%s", index, errmsg))
	end
end

function VersionActivity2_4MusicFreeModel:_safeInitTrack(i)
	local key = self:_getTrackKey(i)
	local trackStr = PlayerPrefsHelper.getString(key)

	if string.nilorempty(trackStr) then
		return
	end

	local t = cjson.decode(trackStr)

	if not t or not t.recordTotalTime or not t.mute or not t.timeline then
		return
	end

	local mo = VersionActivity2_4MusicTrackMo.New()

	mo.recordTotalTime = t.recordTotalTime
	mo.mute = t.mute
	mo.timeline = t.timeline
	mo.index = i
	self._trackList[i] = mo
	self._trackCount = i
end

function VersionActivity2_4MusicFreeModel:setAccompany(id, value)
	self._accompanyStatus[id] = value

	self:onAccompanyStatusChange()
end

function VersionActivity2_4MusicFreeModel:getAccompany(id)
	return self._accompanyStatus[id]
end

function VersionActivity2_4MusicFreeModel:getAccompanyIcon(id)
	return self._accompanyIcon[id]
end

function VersionActivity2_4MusicFreeModel:setInstrumentIndexList(list)
	self._instrumentIndexList = list
end

function VersionActivity2_4MusicFreeModel:getInstrumentIndexList()
	return self._instrumentIndexList
end

function VersionActivity2_4MusicFreeModel:addTrack()
	if self._trackCount >= self._maxTrackCount then
		return
	end

	self._trackCount = self._trackCount + 1

	self:setSelectedTrackIndex(self._trackCount)
	self:updateTrackListStatus()
end

function VersionActivity2_4MusicFreeModel:updateTrackListStatus()
	for i = 1, self._maxTrackCount do
		if not self._trackList[i] then
			local mo = VersionActivity2_4MusicTrackMo.New()

			mo.index = i
			mo.status = i <= self._trackCount and VersionActivity2_4MusicEnum.TrackStatus.UnRecorded or i == self._trackCount + 1 and VersionActivity2_4MusicEnum.TrackStatus.Add or VersionActivity2_4MusicEnum.TrackStatus.Inactive

			if self._actionStatus == VersionActivity2_4MusicEnum.ActionStatus.Del then
				if mo.status == VersionActivity2_4MusicEnum.TrackStatus.Add then
					mo.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
				elseif mo.status == VersionActivity2_4MusicEnum.TrackStatus.UnRecorded then
					mo.status = VersionActivity2_4MusicEnum.TrackStatus.Del
				end
			end

			self._trackList[i] = mo
		end
	end
end

function VersionActivity2_4MusicFreeModel:delTrackSelected()
	local removeIndex

	for i = #self._trackList, 1, -1 do
		local mo = self._trackList[i]

		if mo.isDelSelected then
			removeIndex = i

			table.remove(self._trackList, i)

			self._trackCount = self._trackCount - 1
		end
	end

	if self._trackCount <= 0 then
		self._trackCount = 1
	end

	if removeIndex then
		if removeIndex <= self._selectedTrackIndex then
			self:setSelectedTrackIndex(1)
		end

		for i = 1, self._maxTrackCount do
			if removeIndex <= i then
				local mo = self._trackList[i]

				if mo then
					mo.index = i
				end

				self:_saveTrack(i)
			end
		end
	end

	self:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateTrackList)
end

function VersionActivity2_4MusicFreeModel:getTrackSelectedNum()
	local num = 0

	for i, v in ipairs(self._trackList) do
		if v.isDelSelected then
			num = num + 1
		end
	end

	return num
end

function VersionActivity2_4MusicFreeModel:setSelectedTrackIndex(index)
	self._selectedTrackIndex = index

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateSelectedTrackIndex)
end

function VersionActivity2_4MusicFreeModel:getSelectedTrackIndex()
	return self._selectedTrackIndex
end

function VersionActivity2_4MusicFreeModel:startRecord()
	self._recordIndex = self._selectedTrackIndex
	self._recordTimeline = {}
	self._recordProgressTime = 0
	self._playProgressIndex = {}
end

function VersionActivity2_4MusicFreeModel:endRecord()
	local mo = self._trackList[self._recordIndex]

	mo.recordTotalTime = self._recordProgressTime
	mo.timeline = self._recordTimeline

	self:_saveTrack(self._recordIndex)
	VersionActivity2_4MusicController.instance:trackFreeView(self._recordProgressTime)

	self._recordProgressTime = 0
	self._recordIndex = nil
	self._recordTimeline = nil
end

function VersionActivity2_4MusicFreeModel:_saveTrack(index)
	local ok, errmsg = pcall(self._safeSaveTrack, self, index)

	if not ok then
		logError(string.format("VersionActivity2_4MusicFreeModel:_saveTrack index:%s error:%s", index, errmsg))
	end
end

function VersionActivity2_4MusicFreeModel:_safeSaveTrack(index)
	local key = self:_getTrackKey(index)
	local mo = self._trackList[index]

	if not mo then
		PlayerPrefsHelper.deleteKey(key)

		return
	end

	if not mo:canSave() then
		PlayerPrefsHelper.deleteKey(key)
	else
		local str = mo:encode()

		PlayerPrefsHelper.setString(key, str)

		if SLFramework.FrameworkSettings.IsEditor then
			logNormal(string.format("VersionActivity2_4MusicFreeModel:_saveTrack index:%s str:%s", index, str))
		end
	end
end

function VersionActivity2_4MusicFreeModel:_getTrackKey(index)
	local key = string.format("%s_track_%d#", PlayerPrefsKey.Activity179FreeView, index)

	return PlayerModel.instance:getPlayerPrefsKey(key)
end

function VersionActivity2_4MusicFreeModel:startPlay()
	self._recordProgressTime = 0
	self._playProgressIndex = {}
end

function VersionActivity2_4MusicFreeModel:endPlay()
	self._recordProgressTime = 0
end

function VersionActivity2_4MusicFreeModel:playTrackList(skipTrackMap)
	local deltaTime = self._recordProgressTime
	local playAllFinished = true

	for k, mo in pairs(self._trackList) do
		if not skipTrackMap or not skipTrackMap[k] then
			if not self._playProgressIndex[k] then
				local index = 1
				local list = mo.timeline
				local maxIndex = #list

				if deltaTime <= mo.recordTotalTime then
					playAllFinished = false
				end

				if index <= maxIndex then
					for i = index, maxIndex do
						local item = list[i]

						if deltaTime >= item[1] then
							self._playProgressIndex[k] = index + 1

							if mo.mute == VersionActivity2_4MusicEnum.MuteStatus.Close then
								AudioMgr.instance:trigger(item[2])
							end
						else
							break
						end
					end
				end
			end
		end
	end

	return playAllFinished
end

function VersionActivity2_4MusicFreeModel:setStatus(status)
	self._status = status
end

function VersionActivity2_4MusicFreeModel:getStatus()
	return self._status
end

function VersionActivity2_4MusicFreeModel:isRecordingOrPlaying()
	return self._status == VersionActivity2_4MusicEnum.RecordStatus.Recording or self._status == VersionActivity2_4MusicEnum.RecordStatus.RecordReady or self._status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause or self._status == VersionActivity2_4MusicEnum.RecordStatus.PlayPause or self._status == VersionActivity2_4MusicEnum.RecordStatus.Playing
end

function VersionActivity2_4MusicFreeModel:isRecordStatus()
	return self._status == VersionActivity2_4MusicEnum.RecordStatus.Recording or self._status == VersionActivity2_4MusicEnum.RecordStatus.RecordReady or self._status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause
end

function VersionActivity2_4MusicFreeModel:isRecording()
	return self._status == VersionActivity2_4MusicEnum.RecordStatus.Recording
end

function VersionActivity2_4MusicFreeModel:isNormalStatus()
	return self._status == VersionActivity2_4MusicEnum.RecordStatus.Normal or self._status == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
end

function VersionActivity2_4MusicFreeModel:setRecordProgressTime(time)
	time = math.floor(time * 100) / 100
	self._recordProgressTime = math.min(time, self._trackLength)
end

function VersionActivity2_4MusicFreeModel:addNote(audioId)
	if not self._recordTimeline then
		return
	end

	table.insert(self._recordTimeline, {
		self._recordProgressTime,
		audioId
	})
end

VersionActivity2_4MusicFreeModel.instance = VersionActivity2_4MusicFreeModel.New()

return VersionActivity2_4MusicFreeModel
