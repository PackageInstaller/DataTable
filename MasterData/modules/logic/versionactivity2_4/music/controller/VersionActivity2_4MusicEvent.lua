-- chunkname: @modules/logic/versionactivity2_4/music/controller/VersionActivity2_4MusicEvent.lua

module("modules.logic.versionactivity2_4.music.controller.VersionActivity2_4MusicEvent", package.seeall)

local VersionActivity2_4MusicEvent = _M
local _get = GameUtil.getUniqueTb()

VersionActivity2_4MusicEvent.ClickChapterItem = _get()
VersionActivity2_4MusicEvent.ClickTrackItem = _get()
VersionActivity2_4MusicEvent.UpdateSelectedTrackIndex = _get()
VersionActivity2_4MusicEvent.UpdateTrackList = _get()
VersionActivity2_4MusicEvent.ActionStatusChange = _get()
VersionActivity2_4MusicEvent.TrackDelSelectedChange = _get()
VersionActivity2_4MusicEvent.InstrumentSelectChange = _get()
VersionActivity2_4MusicEvent.StartRecord = _get()
VersionActivity2_4MusicEvent.RecordPause = _get()
VersionActivity2_4MusicEvent.RecordContinue = _get()
VersionActivity2_4MusicEvent.RecordFrame = _get()
VersionActivity2_4MusicEvent.EndRecord = _get()
VersionActivity2_4MusicEvent.StartPlay = _get()
VersionActivity2_4MusicEvent.EndPlay = _get()
VersionActivity2_4MusicEvent.PlayFrame = _get()
VersionActivity2_4MusicEvent.EpisodeStoryBeforeFinished = _get()
VersionActivity2_4MusicEvent.BeatModeEnd = _get()
VersionActivity2_4MusicEvent.Skip = _get()

return VersionActivity2_4MusicEvent
