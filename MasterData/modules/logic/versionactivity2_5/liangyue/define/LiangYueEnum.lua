-- chunkname: @modules/logic/versionactivity2_5/liangyue/define/LiangYueEnum.lua

module("modules.logic.versionactivity2_5.liangyue.define.LiangYueEnum", package.seeall)

local LiangYueEnum = _M

LiangYueEnum.MeshItemColor = {
	Common = "#FFFFFF",
	Disable = "#FF1800",
	Enable = "#65B96F"
}
LiangYueEnum.ScrollItemColor = {
	Enough = "FFFFFF",
	NotEnought = "C8C8C8"
}
LiangYueEnum.CalculateType = {
	Minus = 2,
	Divide = 4,
	Add = 1,
	Multiply = 3
}
LiangYueEnum.CalculateSymbol = {
	"+",
	"-",
	"×",
	"÷"
}
LiangYueEnum.MonthEn = {
	"January",
	"February",
	"March",
	"April",
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December"
}
LiangYueEnum.TweenDuration = 0.2
LiangYueEnum.DragAlpha = 0.5
LiangYueEnum.NormalAlpha = 1
LiangYueEnum.MeshAlpha = 0.5
LiangYueEnum.AttributeType = {
	TwoColumn = 2,
	OneRow = 3,
	OneColumn = 1
}
LiangYueEnum.StatGameState = {
	Finish = "成功",
	Restart = "重新开始",
	Exit = "中断"
}
LiangYueEnum.UnlimitedSign = "∞"
LiangYueEnum.AttributeOffset = 35
LiangYueEnum.EpisodeAnim = {
	Finish = "finish",
	FinishIdle = "finish_idle",
	Unlock = "unlock",
	Empty = "empty"
}
LiangYueEnum.EpisodeGameAnim = {
	FinishIdle = "finish_idle",
	Idle = "idle",
	Open = "open"
}
LiangYueEnum.EpisodeGameFinishAnim = {
	Idle = "idle",
	Open = "open"
}
LiangYueEnum.AttributeAnim = {
	Down = "down",
	Up = "up",
	Empty = "empty"
}
LiangYueEnum.AttributeColor = {
	"#4B8964",
	"#508FB3",
	"#BF6639"
}
LiangYueEnum.AttributeNotEnoughColor = "#B2B2B2"
LiangYueEnum.AttributeDownColor = "#B7493C"
LiangYueEnum.AttributeAnimRevertTime = 0.5
LiangYueEnum.FinishStoryAnimDelayTime = 1.5
LiangYueEnum.FinishGameAnimDelayTime = 1.5
LiangYueEnum.PathAnimDelayTime = 0.5
LiangYueEnum.UnlockAnimDelayTime = 1.7
LiangYueEnum.FocusItemMoveDuration = 0.26
LiangYueEnum.FinishAnimDelayTime = 0.6
LiangYueEnum.FinishAnimDelayTimeEnd = 1.2

return LiangYueEnum
