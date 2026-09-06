-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswEnum.lua

module("logic.extensions.godstatueswar.data.GswEnum", package.seeall)

local GswEnum = {}

GswEnum.StepType_Zone = 0
GswEnum.StepType_Space = 1
GswEnum.Steps_Zone = 1
GswEnum.Steps_64To16 = 2
GswEnum.Steps_16To4 = 3
GswEnum.Steps_Final = 4
GswEnum.StepInterval_RegPre = 1
GswEnum.StepInterval_Reg = 2
GswEnum.StepInterval_FmtPre = 3
GswEnum.StepInterval_Fmt = 4
GswEnum.StepInterval_AdjPre = 5
GswEnum.StepInterval_Adj = 6
GswEnum.StepInterval_BatPre = 7
GswEnum.StepInterval_Bat = 8
GswEnum.StepInterval_BatEnd = 9
GswEnum.StepIntervalList = {
	[GswEnum.StepType_Zone] = {
		GswEnum.StepInterval_RegPre,
		GswEnum.StepInterval_Reg,
		GswEnum.StepInterval_FmtPre,
		GswEnum.StepInterval_Fmt,
		GswEnum.StepInterval_AdjPre,
		GswEnum.StepInterval_Adj,
		GswEnum.StepInterval_BatPre,
		GswEnum.StepInterval_Bat,
		GswEnum.StepInterval_BatEnd
	},
	[GswEnum.StepType_Space] = {
		GswEnum.StepInterval_FmtPre,
		GswEnum.StepInterval_Fmt,
		GswEnum.StepInterval_AdjPre,
		GswEnum.StepInterval_Adj,
		GswEnum.StepInterval_BatPre,
		GswEnum.StepInterval_Bat,
		GswEnum.StepInterval_BatEnd
	}
}
GswEnum.StepIntervalTimeFields = {
	[GswEnum.StepType_Zone] = {
		{
			"registrationStartTime",
			"registrationEndTime"
		},
		{
			"formationStartTime",
			"formationEndTime"
		},
		{
			"adjustmentStartTime",
			"adjustmentEndTime"
		},
		{
			"battleStartTime",
			"battleEndTime"
		}
	},
	[GswEnum.StepType_Space] = {
		{
			"formationStartTime",
			"formationEndTime"
		},
		{
			"adjustmentStartTime",
			"adjustmentEndTime"
		},
		{
			"battleStartTime",
			"battleEndTime"
		}
	}
}
GswEnum.StepTypeNames = {
	[GswEnum.StepType_Zone] = "战区赛",
	[GswEnum.StepType_Space] = "全服赛"
}
GswEnum.StepIntervalNames = {
	[GswEnum.StepInterval_RegPre] = "报名阶段",
	[GswEnum.StepInterval_Reg] = "报名阶段",
	[GswEnum.StepInterval_FmtPre] = "布阵阶段",
	[GswEnum.StepInterval_Fmt] = "布阵阶段",
	[GswEnum.StepInterval_AdjPre] = "调整阶段",
	[GswEnum.StepInterval_Adj] = "调整阶段",
	[GswEnum.StepInterval_BatPre] = "开战阶段",
	[GswEnum.StepInterval_Bat] = "开战阶段",
	[GswEnum.StepInterval_BatEnd] = "开战阶段"
}
GswEnum.FightType_Normal = 1
GswEnum.FightType_Vieo = 2
GswEnum.SignType_Attack = 1
GswEnum.SignType_Defense = 2
GswEnum.FmtType_Empty = 1
GswEnum.FmtType_Player = 2
GswEnum.FmtType_System = 3
GswEnum.FullServiceId = -1
GswEnum.ParticipateCode_success = 0
GswEnum.ParticipateCode_NotInFamily = -1

return GswEnum
