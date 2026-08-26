-- chunkname: @modules/logic/versionactivity2_4/music/model/VersionActivity2_4MusicTrackMo.lua

module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicTrackMo", package.seeall)

local VersionActivity2_4MusicTrackMo = class("VersionActivity2_4MusicTrackMo")

function VersionActivity2_4MusicTrackMo:ctor()
	self.index = nil
	self.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
	self.recordTotalTime = 0
	self.mute = VersionActivity2_4MusicEnum.MuteStatus.Close
	self.timeline = {}
end

function VersionActivity2_4MusicTrackMo:canSave()
	return self.recordTotalTime > 0
end

function VersionActivity2_4MusicTrackMo:encode()
	local t = {
		index = self.index,
		recordTotalTime = self.recordTotalTime,
		mute = self.mute,
		timeline = self.timeline
	}

	return cjson.encode(t)
end

function VersionActivity2_4MusicTrackMo:setMute(value)
	if not value then
		self.mute = VersionActivity2_4MusicEnum.MuteStatus.Close or VersionActivity2_4MusicEnum.MuteStatus.Open
	end
end

function VersionActivity2_4MusicTrackMo:setDelSelected(value)
	self.isDelSelected = value
end

return VersionActivity2_4MusicTrackMo
