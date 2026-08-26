-- chunkname: @modules/logic/notice/define/NoticeEnum.lua

module("modules.logic.notice.define.NoticeEnum", package.seeall)

local NoticeEnum = _M

NoticeEnum.NoticeType = {
	Game = 2,
	Activity = 1
}
NoticeEnum.NoticePositionType = {
	InGame = 4,
	BeforeLogin = 5
}
NoticeEnum.NoticeLabelType = {
	Hot = 1,
	Welfare = 4,
	Activity = 3,
	Important = 5,
	New = 2
}
NoticeEnum.FirstSplitChar = ":"
NoticeEnum.SecondSplitChar = ";"
NoticeEnum.IMGDefaultWidth = 300
NoticeEnum.IMGDefaultHeight = 300
NoticeEnum.IMGMaxWidth = 1240
NoticeEnum.IMGMaxHeight = 2000
NoticeEnum.FindTimePattern = "(%[time:UTC([%+%-]%d+)#(.-)%])"
NoticeEnum.FindTimeType = {
	MDH = 5,
	YMD_HMS = 1,
	YMD_HM = 3,
	MD_HM = 4,
	YMD_W_HM = 2
}
NoticeEnum.TimeFormatType = {
	[NoticeEnum.FindTimeType.YMD_HMS] = {
		"(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)",
		"(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*(%d+)点(%d+)分(%d+)秒",
		"(%d+)年(%d+)月(%d+)日%s*(%d+)點(%d+)分(%d+)秒"
	},
	[NoticeEnum.FindTimeType.MD_HM] = {
		"(%d+)/(%d+)%s*(%d+):(%d+)",
		"(%d+)-(%d+)%s*(%d+):(%d+)"
	},
	[NoticeEnum.FindTimeType.YMD_HM] = {
		"(%d+)/(%d+)/(%d+)%s*(%d+):(%d+)",
		"(%d+)년%s*(%d+)월%s*(%d+)일%s*(%d+):(%d+)"
	},
	[NoticeEnum.FindTimeType.MDH] = {
		"(%d+)月(%d+)日(%d+)点",
		"(%d+)月(%d+)日(%d+)點"
	},
	[NoticeEnum.FindTimeType.YMD_W_HM] = {
		"(%d+)/(%d+)/(%d+)%s*%((.-)%)%s*(%d+):(%d+)",
		"(%d+)/(%d+)/(%d+)%s*（(.-)）%s*(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*%((.-)%)%s*(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*（(.-)）%s*(%d+):(%d+)"
	}
}
NoticeEnum.Time = {
	Day = "{day}",
	Hour = "{hour}",
	Month = "{month}",
	Year = "{year}",
	Week = "{week}",
	Second = "{sec}",
	Minute = "{min}"
}

local Year = NoticeEnum.Time.Year
local Month = NoticeEnum.Time.Month
local Day = NoticeEnum.Time.Day
local Hour = NoticeEnum.Time.Hour
local Minute = NoticeEnum.Time.Minute
local Second = NoticeEnum.Time.Second
local Week = NoticeEnum.Time.Week

NoticeEnum.TimeFormat = {
	[NoticeEnum.FindTimeType.YMD_HMS] = {
		string.format("%s-%s-%s %s:%s:%s", Year, Month, Day, Hour, Minute, Second),
		string.format("%s/%s/%s %s:%s:%s", Year, Month, Day, Hour, Minute, Second),
		string.format("%s年%s月%s日 %s点%s分%s秒", Year, Month, Day, Hour, Minute, Second),
		string.format("%s年%s月%s日 %s點%s分%s秒", Year, Month, Day, Hour, Minute, Second)
	},
	[NoticeEnum.FindTimeType.MD_HM] = {
		string.format("%s/%s %s:%s", Month, Day, Hour, Minute),
		string.format("%s-%s %s:%s", Month, Day, Hour, Minute)
	},
	[NoticeEnum.FindTimeType.YMD_HM] = {
		string.format("%s/%s/%s %s:%s", Year, Month, Day, Hour, Minute),
		string.format("%s년 %s월 %s일 %s:%s", Year, Month, Day, Hour, Minute)
	},
	[NoticeEnum.FindTimeType.MDH] = {
		string.format("%s月%s日%s点", Month, Day, Hour),
		string.format("%s月%s日%s點", Month, Day, Hour)
	},
	[NoticeEnum.FindTimeType.YMD_W_HM] = {
		string.format("%s/%s/%s (%s) %s:%s", Year, Month, Day, Week, Hour, Minute),
		string.format("%s/%s/%s （%s） %s:%s", Year, Month, Day, Week, Hour, Minute),
		string.format("%s年%s月%s日 (%s) %s:%s", Year, Month, Day, Week, Hour, Minute),
		string.format("%s年%s月%s日 （%s） %s:%s", Year, Month, Day, Week, Hour, Minute)
	}
}
NoticeEnum.WeekDayToChar = {
	"月",
	"火",
	"水",
	"木",
	"金",
	"土",
	"日"
}
NoticeEnum.IMGMaxWidth = 1240

return NoticeEnum
