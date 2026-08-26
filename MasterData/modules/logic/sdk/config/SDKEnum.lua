-- chunkname: @modules/logic/sdk/config/SDKEnum.lua

module("modules.logic.sdk.config.SDKEnum", package.seeall)

local SDKEnum = _M

SDKEnum.AccountType = {
	JpExtend = 14,
	Twitter = 12,
	Apple = 5,
	EMail = 10,
	Google = 13,
	FaceBook = 11,
	Guest = 1
}
SDKEnum.RewardType = {
	Claim = 1,
	Got = 2,
	None = 0
}

return SDKEnum
