-- chunkname: @modules/logic/chargepush/define/ChargePushEnum.lua

module("modules.logic.chargepush.define.ChargePushEnum", package.seeall)

local ChargePushEnum = _M

ChargePushEnum.PushViewType = {
	MonthCard = 1,
	LevelGoods = 2,
	CommonGift = 3
}
ChargePushEnum.ListenerType = {
	MonthCardAfter = 2,
	LevelAfter = 3,
	MonthCardBefore = 1
}

return ChargePushEnum
