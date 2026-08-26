-- chunkname: @modules/logic/versionactivity1_2/trade/define/Activity117Enum.lua

module("modules.logic.versionactivity1_2.trade.define.Activity117Enum", package.seeall)

local Activity117Enum = _M

Activity117Enum.OpenTab = {
	Reward = 2,
	Daily = 1
}
Activity117Enum.Status = {
	NotEnough = 2,
	CanGet = 1,
	AlreadyGot = 3
}
Activity117Enum.PriceType = {
	Bad = 4,
	LastFail = 5,
	Talk = 6,
	Common = 3,
	Best = 1,
	Better = 2
}
Activity117Enum.BossSkinId = 300601
Activity117Enum.MaxBargainTimes = 3
Activity117Enum.OrderRoundState = {
	Quoting = 2,
	Old = 1,
	Quoted = 3
}

return Activity117Enum
