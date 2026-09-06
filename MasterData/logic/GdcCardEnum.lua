-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/data/GdcCardEnum.lua

module("logic.extensions.goddesscontest.data.GdcCardEnum", package.seeall)

local GdcCardEnum = {}

GdcCardEnum.CardType_Empty = "Empty"
GdcCardEnum.CardType_Normal = "Normal"
GdcCardEnum.CardType_Random = "Random"
GdcCardEnum.ActStepType_Empty = "Empty"
GdcCardEnum.ActStepType_Collect = "Collect"
GdcCardEnum.ActStepType_Contest = "Contest"
GdcCardEnum.ActStepTypeList = {
	GdcCardEnum.ActStepType_Collect,
	GdcCardEnum.ActStepType_Contest
}
GdcCardEnum.ActStepTimeFields = {
	[GdcCardEnum.ActStepType_Collect] = {
		"collectOpenTime",
		"collectEndTime"
	},
	[GdcCardEnum.ActStepType_Contest] = {
		"contestOpenTime",
		"contestEndTime"
	}
}
GdcCardEnum.ConInterval_OpenPre = 1
GdcCardEnum.ConInterval_Open = 2
GdcCardEnum.ConInterval_SetPre = 3
GdcCardEnum.ConInterval_Set = 4
GdcCardEnum.ConInterval_AutoShowPre = 5
GdcCardEnum.ConInterval_AutoShow = 6
GdcCardEnum.ConInterval_PublicPre = 7
GdcCardEnum.ConInterval_Public = 8
GdcCardEnum.ConIntervalList = {
	GdcCardEnum.ConInterval_OpenPre,
	GdcCardEnum.ConInterval_Open,
	GdcCardEnum.ConInterval_SetPre,
	GdcCardEnum.ConInterval_Set,
	GdcCardEnum.ConInterval_AutoShowPre,
	GdcCardEnum.ConInterval_AutoShow,
	GdcCardEnum.ConInterval_PublicPre,
	GdcCardEnum.ConInterval_Public
}
GdcCardEnum.ConIntervalTimeFields = {
	"openCardTime",
	"setCardStartTime",
	"autoShowCardTime",
	"publicationTime"
}
GdcCardEnum.DelayNotifyStepChangeTime = 5
GdcCardEnum.CardGroupNames = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F"
}

return GdcCardEnum
