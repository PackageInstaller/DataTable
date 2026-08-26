-- chunkname: @modules/logic/sp01/act208/define/Act208Enum.lua

module("modules.logic.sp01.act208.define.Act208Enum", package.seeall)

local Act208Enum = _M

Act208Enum.RewardType = {
	Common = 0,
	Final = 1
}
Act208Enum.ChannelId = {
	Mobile = 1,
	PC = 2
}
Act208Enum.BonusState = {
	HaveGet = 2,
	CanGet = 1,
	NotGet = 0
}

return Act208Enum
