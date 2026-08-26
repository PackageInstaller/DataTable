-- chunkname: @modules/logic/versionactivity3_7/travelgo/define/TravelGoEnum.lua

module("modules.logic.versionactivity3_7.travelgo.define.TravelGoEnum", package.seeall)

local TravelGoEnum = _M

TravelGoEnum.EventType = {
	Luck = 2,
	Story = 1,
	Battle = 0
}
TravelGoEnum.LuckEventType = {
	VeryLuck = 3,
	LittleLuck = 2,
	UnLuck = 1
}
TravelGoEnum.RewardType = {
	Exp = 1,
	Skill = 2,
	Attr = 3
}

return TravelGoEnum
