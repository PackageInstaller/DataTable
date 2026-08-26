-- chunkname: @modules/logic/versionactivity2_4/music/define/VersionActivity2_4MusicEnum.lua

module("modules.logic.versionactivity2_4.music.define.VersionActivity2_4MusicEnum", package.seeall)

local VersionActivity2_4MusicEnum = _M

VersionActivity2_4MusicEnum.RecordStatus = {
	NormalAfterRecord = 2,
	RecordPause = 5,
	RecordReady = 3,
	Playing = 7,
	PlayPause = 6,
	Recording = 4,
	Del = 8,
	Normal = 1
}
VersionActivity2_4MusicEnum.TrackStatus = {
	UnRecorded = 2,
	Del = 5,
	Add = 1,
	Inactive = 0
}
VersionActivity2_4MusicEnum.ActionStatus = {
	Record = 2,
	Del = 1
}
VersionActivity2_4MusicEnum.MuteStatus = {
	Close = 0,
	Open = 1
}
VersionActivity2_4MusicEnum.Const = {
	Score = 4,
	MaxTrackCount = 1,
	TrackLength = 2,
	ScoreTime = 5
}
VersionActivity2_4MusicEnum.AccompanyStatus = {
	Close = 0,
	Open = 1
}
VersionActivity2_4MusicEnum.AccompanyType = {
	High = 1,
	Low = 2,
	Drum = 3
}
VersionActivity2_4MusicEnum.AccompanyTypeName = {
	"bakaluoer_rhythm",
	"bakaluoer_mid",
	"bakaluoer_high"
}
VersionActivity2_4MusicEnum.NoteIcon = {
	"do",
	"re",
	"mi",
	"fa",
	"sol",
	"la",
	"si"
}
VersionActivity2_4MusicEnum.SelectInstrumentNum = 2
VersionActivity2_4MusicEnum.BgmPlay = 20240006
VersionActivity2_4MusicEnum.BgmPause = 20240039
VersionActivity2_4MusicEnum.BgmResume = 20240040
VersionActivity2_4MusicEnum.BgmStop = 20240042
VersionActivity2_4MusicEnum.BgmStatus = {
	Resume = 4,
	Play = 1,
	Stop = 3,
	Pause = 2
}
VersionActivity2_4MusicEnum.BeatStatus = {
	Pause = 3,
	End = 4,
	Playing = 2,
	CountDown = 1,
	None = 0
}
VersionActivity2_4MusicEnum.BeatGrade = {
	Miss = 4,
	Cool = 3,
	Great = 2,
	Perfect = 1
}
VersionActivity2_4MusicEnum.BeatGradeStatName = {
	[VersionActivity2_4MusicEnum.BeatGrade.Perfect] = "perfect_num",
	[VersionActivity2_4MusicEnum.BeatGrade.Great] = "great_num",
	[VersionActivity2_4MusicEnum.BeatGrade.Cool] = "cool_num",
	[VersionActivity2_4MusicEnum.BeatGrade.Miss] = "miss_num"
}
VersionActivity2_4MusicEnum.BeatResult = {
	Abort = 3,
	Restart = 4,
	Fail = 2,
	Success = 1
}
VersionActivity2_4MusicEnum.BeatResultStatName = {
	"成功",
	"失败",
	"中断",
	"重新开始"
}
VersionActivity2_4MusicEnum.EpisodeType = {
	Free = 3,
	Story = 1,
	Beat = 2
}
VersionActivity2_4MusicEnum.EpisodeStatus = {
	PlayEndStory = 2,
	Unlock = 0,
	PlayStartStory = 1
}
VersionActivity2_4MusicEnum.EpisodeItemWidth = 475
VersionActivity2_4MusicEnum.ProgressBgWidth = 470
VersionActivity2_4MusicEnum.ProgressLightPos = -1425
VersionActivity2_4MusicEnum.FirstEpisodeId = 1240501
VersionActivity2_4MusicEnum.times_sign = "×"

return VersionActivity2_4MusicEnum
