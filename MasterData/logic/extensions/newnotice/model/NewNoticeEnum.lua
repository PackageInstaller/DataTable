-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newnotice/model/NewNoticeEnum.lua

module("logic.extensions.newnotice.model.NewNoticeEnum", package.seeall)

local NewNoticeEnum = {}

NewNoticeEnum.Type = {
	ActivityNotice = 1,
	GameNotice = 2
}
NewNoticeEnum.FlagType = {
	WELFARE = 4,
	Activity = 3,
	NOTICE = 2,
	IMPORTANT = 5,
	URGENT = 1
}
NewNoticeEnum.Color = {
	Gray = 2,
	Red = 1
}
NewNoticeEnum.FlagText = {
	[NewNoticeEnum.FlagType.URGENT] = "hot",
	[NewNoticeEnum.FlagType.NOTICE] = "new",
	[NewNoticeEnum.FlagType.Activity] = "活动",
	[NewNoticeEnum.FlagType.WELFARE] = "福利",
	[NewNoticeEnum.FlagType.IMPORTANT] = "重要"
}
NewNoticeEnum.FlagColor = {
	[NewNoticeEnum.FlagType.URGENT] = NewNoticeEnum.Color.Red,
	[NewNoticeEnum.FlagType.NOTICE] = NewNoticeEnum.Color.Gray,
	[NewNoticeEnum.FlagType.Activity] = NewNoticeEnum.Color.Gray,
	[NewNoticeEnum.FlagType.WELFARE] = NewNoticeEnum.Color.Red,
	[NewNoticeEnum.FlagType.IMPORTANT] = NewNoticeEnum.Color.Gray
}
NewNoticeEnum.FlagActive = {
	[NewNoticeEnum.FlagType.URGENT] = true,
	[NewNoticeEnum.FlagType.NOTICE] = false,
	[NewNoticeEnum.FlagType.Activity] = true,
	[NewNoticeEnum.FlagType.WELFARE] = true,
	[NewNoticeEnum.FlagType.IMPORTANT] = true
}

return NewNoticeEnum
