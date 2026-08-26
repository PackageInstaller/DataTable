-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/defines/HuiDiaoLanEnum.lua

module("modules.logic.versionactivity3_2.huidiaolan.defines.HuiDiaoLanEnum", package.seeall)

local HuiDiaoLanEnum = _M

HuiDiaoLanEnum.SpEpisodeType = 1
HuiDiaoLanEnum.PlaneWidth = 164
HuiDiaoLanEnum.PlaneHeight = 164
HuiDiaoLanEnum.PlaneSpace = 0
HuiDiaoLanEnum.ElementNormalMoveTime = 0.2
HuiDiaoLanEnum.ElementRotateMoveTime = 0.2
HuiDiaoLanEnum.WaitLevelUpElementTime = 0.25
HuiDiaoLanEnum.DiamondFlyoutMoveTime = 0.4
HuiDiaoLanEnum.WaitDiamondFlyoutTime = 0.6
HuiDiaoLanEnum.WaitBornToCombineTime = 0.15
HuiDiaoLanEnum.ExchangePosSkillMoveTime = 0.7
HuiDiaoLanEnum.ExchangePosSkillRadHeight = 0.3
HuiDiaoLanEnum.ElementDragMoveDis = 100
HuiDiaoLanEnum.MaxElementLevel = 3
HuiDiaoLanEnum.StartCombineNum = 2
HuiDiaoLanEnum.CheckRandomCountOffset = 3
HuiDiaoLanEnum.PlaneSize = 820
HuiDiaoLanEnum.RemainStepTipNum = 5
HuiDiaoLanEnum.DefaultMapId = 101
HuiDiaoLanEnum.PlaneType = {
	Water = 2,
	Gravity = 3,
	Normal = 1
}
HuiDiaoLanEnum.ElementColor = {
	Blue = 3,
	Green = 2,
	Red = 1,
	None = 0
}
HuiDiaoLanEnum.ElementGoName = {
	[HuiDiaoLanEnum.ElementColor.Red] = "red",
	[HuiDiaoLanEnum.ElementColor.Green] = "green",
	[HuiDiaoLanEnum.ElementColor.Blue] = "blue"
}
HuiDiaoLanEnum.ConstId = {
	OneLevelFourMergeRecover = 1322905,
	OneLevelTreeMergeRecover = 1322904,
	TwoLevelFourMergeRecover = 1322909,
	ChangeColorSkillInfo = 1322910,
	ExchangePosSkillInfo = 1322911,
	OriginEnergy = 1322901,
	TwoLevelTreeMergeRecover = 1322908,
	OneLevelFiveMergeRecover = 1322906,
	MaxEnergy = 1322902,
	OneLevelSixMergeRecover = 1322907,
	MoveRecoverEnergy = 1322903
}
HuiDiaoLanEnum.EpisodeItemState = {
	Finish = 3,
	Locked = 2,
	Normal = 1
}
HuiDiaoLanEnum.EpisodeItemStateGOName = {
	[HuiDiaoLanEnum.EpisodeItemState.Normal] = "Normal",
	[HuiDiaoLanEnum.EpisodeItemState.Locked] = "Locked",
	[HuiDiaoLanEnum.EpisodeItemState.Finish] = "Finish"
}

return HuiDiaoLanEnum
