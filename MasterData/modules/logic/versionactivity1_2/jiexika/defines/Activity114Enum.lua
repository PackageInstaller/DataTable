-- chunkname: @modules/logic/versionactivity1_2/jiexika/defines/Activity114Enum.lua

module("modules.logic.versionactivity1_2.jiexika.defines.Activity114Enum", package.seeall)

local Activity114Enum = _M

Activity114Enum.Attr = {
	Social = 4,
	End = 6,
	Physical = 3,
	Moral = 1,
	Secret = 5,
	Cognition = 2
}
Activity114Enum.AddAttrType = {
	Feature = 6,
	KeyDayScore = 10,
	UnLockTravel = 8,
	Attention = 7,
	LastKeyDayScore = 11,
	UnLockMeet = 9
}
Activity114Enum.TaskStatu = {
	NoFinish = 2,
	Finish = 1,
	GetBonus = 3
}
Activity114Enum.EventType = {
	Meet = 3,
	Rest = 4,
	KeyDay = 5,
	Travel = 2,
	Edu = 1
}
Activity114Enum.EventContentType = {
	Check = 2,
	Check_Once = 3,
	Normal = 1
}
Activity114Enum.ConstId = {
	ScoreA = 30,
	Rest1 = 8,
	WeekEndGuideId = 31,
	ScoreC = 28,
	Rest2 = 9,
	FirstCheckEventGuideId = 32,
	ScoreE = 27,
	ScoreB = 29,
	Rest3 = 10
}
Activity114Enum.Result = {
	NoFinish = -1,
	Success = 2,
	Fail = 1,
	BigSuccess = 3,
	FightSucess = 999,
	None = 0
}
Activity114Enum.StoryType = {
	RoundEnd = 4,
	Result = 3,
	Event = 2,
	RoundStart = 1
}
Activity114Enum.MotionType = {
	Rest = 4,
	Time = 1,
	KeyDay = 5,
	Click = 2,
	Edu = 3
}
Activity114Enum.PlayStartRoundType = {
	Story = 2,
	Guide = 1
}
Activity114Enum.TravelStatus = {
	EventLock = 2,
	EventBlock = 3,
	EventEnd = 5,
	TravelLock = 4,
	Normal = 1
}
Activity114Enum.RoundType = {
	Free = 3,
	Edu = 2,
	KeyDay = 1
}
Activity114Enum.RateColor = {
	"#ff4c4c",
	"#ff934b",
	"#db95e5",
	"#9dbaf2",
	"#84cb84"
}
Activity114Enum.TabIndex = {
	EnterView = 1,
	MainView = 3,
	TaskView = 2
}
Activity114Enum.episodeId = 1250101

return Activity114Enum
