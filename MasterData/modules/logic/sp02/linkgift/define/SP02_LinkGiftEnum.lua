-- chunkname: @modules/logic/sp02/linkgift/define/SP02_LinkGiftEnum.lua

module("modules.logic.sp02.linkgift.define.SP02_LinkGiftEnum", package.seeall)

local SP02_LinkGiftEnum = _M

SP02_LinkGiftEnum.DelayTime = {
	Switch = 0.01,
	BuyAnimDelay = 1.5,
	HasGetDelay = 0.15,
	UnlockAnimDelay = 0.03
}
SP02_LinkGiftEnum.LineProgress = {
	{
		0.88,
		0.76,
		0.48,
		0.34,
		0.25,
		0
	},
	{
		0.76,
		0.53,
		0.28,
		0.25,
		0
	},
	{
		0.75,
		0.48,
		0.35,
		0.26,
		0.15,
		0
	}
}
SP02_LinkGiftEnum.PopPauseKey = "SP02_LinkGiftView_PopPause"
SP02_LinkGiftEnum.UI_Block_Key = "SP02_LinkGiftBaseView_UI_Block"

return SP02_LinkGiftEnum
