-- chunkname: @modules/logic/video/define/VideoEnum.lua

module("modules.logic.video.define.VideoEnum", package.seeall)

local VideoEnum = class("VideoEnum")

VideoEnum.PlayerStatus = {
	Stalled = 8,
	ReadyToPlay = 1,
	Unstalled = 9,
	Closing = 5,
	StartedBuffering = 13,
	Error = 6,
	PlaylistItemChanged = 16,
	PlaylistFinished = 17,
	FinishedBuffering = 14,
	TextTracksChanged = 18,
	ResolutionChanged = 10,
	Paused = 19,
	Unpaused = 20,
	MetaDataReady = 0,
	TextCueChanged = 7,
	SubtitleChange = 7,
	Started = 2,
	FinishedPlaying = 4,
	StartedSeeking = 11,
	PropertiesChanged = 15,
	FirstFrameReady = 3,
	FinishedSeeking = 12
}
VideoEnum.ErrorCode = {
	DecodeFailed = 200,
	LoadFailed = 100,
	None = 0
}

function VideoEnum.getPlayerStatusEnumName(status)
	if status == VideoEnum.PlayerStatus.MetaDataReady then
		return "MetaDataReady"
	end

	if status == VideoEnum.PlayerStatus.ReadyToPlay then
		return "ReadyToPlay"
	end

	if status == VideoEnum.PlayerStatus.Started then
		return "Started"
	end

	if status == VideoEnum.PlayerStatus.FirstFrameReady then
		return "FirstFrameReady"
	end

	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		return "FinishedPlaying"
	end

	if status == VideoEnum.PlayerStatus.Closing then
		return "Closing"
	end

	if status == VideoEnum.PlayerStatus.Error then
		return "Error"
	end

	if status == VideoEnum.PlayerStatus.SubtitleChange then
		return "SubtitleChange"
	end

	if status == VideoEnum.PlayerStatus.Stalled then
		return "Stalled"
	end

	if status == VideoEnum.PlayerStatus.Unstalled then
		return "Unstalled"
	end

	if status == VideoEnum.PlayerStatus.ResolutionChanged then
		return "ResolutionChanged"
	end

	if status == VideoEnum.PlayerStatus.StartedSeeking then
		return "StartedSeeking"
	end

	if status == VideoEnum.PlayerStatus.FinishedSeeking then
		return "FinishedSeeking"
	end

	if status == VideoEnum.PlayerStatus.StartedBuffering then
		return "StartedBuffering"
	end

	if status == VideoEnum.PlayerStatus.FinishedBuffering then
		return "FinishedBuffering"
	end

	if status == VideoEnum.PlayerStatus.PropertiesChanged then
		return "PropertiesChanged"
	end

	if status == VideoEnum.PlayerStatus.PlaylistItemChanged then
		return "PlaylistItemChanged"
	end

	if status == VideoEnum.PlayerStatus.PlaylistFinished then
		return "PlaylistFinished"
	end

	if status == VideoEnum.PlayerStatus.TextTracksChanged then
		return "TextTracksChanged"
	end

	if status == VideoEnum.PlayerStatus.TextCueChanged then
		return "TextCueChanged"
	end

	return "None"
end

function VideoEnum.getErrorCodeEnumName(errorCode)
	if errorCode == VideoEnum.ErrorCode.None then
		return "None"
	end

	if errorCode == VideoEnum.ErrorCode.LoadFailed then
		return "LoadFailed"
	end

	if errorCode == VideoEnum.ErrorCode.DecodeFailed then
		return "DecodeFailed"
	end

	return "UnKnown"
end

return VideoEnum
