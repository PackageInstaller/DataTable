-- chunkname: @modules/logic/act236/define/Act236Enum.lua

module("modules.logic.act236.define.Act236Enum", package.seeall)

local Act236Enum = _M

Act236Enum.TimeRefreshDuration = 1
Act236Enum.Color = {
	ProgressDesc = "#FFF283"
}
Act236Enum.RewardOffset = 1
Act236Enum.DisplayType = {
	Video = 2,
	Image = 1,
	Effect = 3
}
Act236Enum.TabType = {
	Item = 2,
	Point = 1
}
Act236Enum.DisplayType2Tab = {
	[Act236Enum.DisplayType.Image] = Act236Enum.TabType.Point,
	[Act236Enum.DisplayType.Video] = Act236Enum.TabType.Item,
	[Act236Enum.DisplayType.Effect] = Act236Enum.TabType.Item
}
Act236Enum.ItemId = {
	SelfSelectSkin = 713202,
	SelfSelectHero = 481011
}
Act236Enum.FirstShowIndex = 1
Act236Enum.MoveToNextTime = 2.5
Act236Enum.ForceEndLockScreenTime = 2
Act236Enum.VideoSwitchTime = 0.16
Act236Enum.ProgressMaxValue = 1
Act236Enum.ProgressValue = {
	1,
	0.95,
	0.83,
	0.75,
	0.55,
	0.42,
	0.12,
	0
}
Act236Enum.EffectOffsetParam = {
	[7] = {
		{
			x = -7,
			y = 42
		}
	},
	[9] = {
		{
			x = -35,
			y = 13
		},
		[3] = {
			x = -49,
			y = 30
		}
	}
}
Act236Enum.RewardStrColor = {
	HaveGet = "#828282",
	Normal = "#CE7F47"
}
Act236Enum.RewardTextAlpha = {
	HaveGet = 0.7,
	Normal = 1
}
Act236Enum.RewardBgColor = {
	HaveGet = "#808080",
	Normal = "#FFFFFF"
}
Act236Enum.VideoRotateZ = -10
Act236Enum.DefaultValue = 0

return Act236Enum
