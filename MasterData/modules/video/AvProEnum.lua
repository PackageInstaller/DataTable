-- chunkname: @modules/video/AvProEnum.lua

module("modules.video.AvProEnum", package.seeall)

local AvProEnum = class("AvProEnum")

AvProEnum.PlayerStatus = {
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
	TextCueChanged = 7,
	MetaDataReady = 0,
	SubtitleChange = 7,
	Started = 2,
	FinishedPlaying = 4,
	StartedSeeking = 11,
	PropertiesChanged = 15,
	FirstFrameReady = 3,
	FinishedSeeking = 12
}

function AvProEnum.getPlayerStatusEnumName(status)
	if status == AvProEnum.PlayerStatus.MetaDataReady then
		return "MetaDataReady"
	end

	if status == AvProEnum.PlayerStatus.ReadyToPlay then
		return "ReadyToPlay"
	end

	if status == AvProEnum.PlayerStatus.Started then
		return "Started"
	end

	if status == AvProEnum.PlayerStatus.FirstFrameReady then
		return "FirstFrameReady"
	end

	if status == AvProEnum.PlayerStatus.FinishedPlaying then
		return "FinishedPlaying"
	end

	if status == AvProEnum.PlayerStatus.Closing then
		return "Closing"
	end

	if status == AvProEnum.PlayerStatus.Error then
		return "Error"
	end

	if status == AvProEnum.PlayerStatus.SubtitleChange then
		return "SubtitleChange"
	end

	if status == AvProEnum.PlayerStatus.Stalled then
		return "Stalled"
	end

	if status == AvProEnum.PlayerStatus.Unstalled then
		return "Unstalled"
	end

	if status == AvProEnum.PlayerStatus.ResolutionChanged then
		return "ResolutionChanged"
	end

	if status == AvProEnum.PlayerStatus.StartedSeeking then
		return "StartedSeeking"
	end

	if status == AvProEnum.PlayerStatus.FinishedSeeking then
		return "FinishedSeeking"
	end

	if status == AvProEnum.PlayerStatus.StartedBuffering then
		return "StartedBuffering"
	end

	if status == AvProEnum.PlayerStatus.FinishedBuffering then
		return "FinishedBuffering"
	end

	if status == AvProEnum.PlayerStatus.PropertiesChanged then
		return "PropertiesChanged"
	end

	if status == AvProEnum.PlayerStatus.PlaylistItemChanged then
		return "PlaylistItemChanged"
	end

	if status == AvProEnum.PlayerStatus.PlaylistFinished then
		return "PlaylistFinished"
	end

	if status == AvProEnum.PlayerStatus.TextTracksChanged then
		return "TextTracksChanged"
	end

	if status == AvProEnum.PlayerStatus.TextCueChanged then
		return "TextCueChanged"
	end

	return "None"
end

AvProEnum.ErrorCode = {
	DecodeFailed = 200,
	LoadFailed = 100,
	None = 0
}

function AvProEnum.getErrorCodeEnumName(errorCode)
	if errorCode == AvProEnum.ErrorCode.None then
		return "None"
	end

	if errorCode == AvProEnum.ErrorCode.LoadFailed then
		return "LoadFailed"
	end

	if errorCode == AvProEnum.ErrorCode.DecodeFailed then
		return "DecodeFailed"
	end

	return "UnKnown"
end

return AvProEnum
