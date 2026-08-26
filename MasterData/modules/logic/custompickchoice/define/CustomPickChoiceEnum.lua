-- chunkname: @modules/logic/custompickchoice/define/CustomPickChoiceEnum.lua

module("modules.logic.custompickchoice.define.CustomPickChoiceEnum", package.seeall)

local CustomPickChoiceEnum = _M

CustomPickChoiceEnum.style = {
	SummonCustomPick = 2,
	OptionalHeroGift = 1
}
CustomPickChoiceEnum.FixedText = {
	[CustomPickChoiceEnum.style.OptionalHeroGift] = {
		_txttitle = "herogift_custom_pick_title"
	}
}
CustomPickChoiceEnum.ComponentVisible = {
	[CustomPickChoiceEnum.style.OptionalHeroGift] = {
		_gomask = true,
		_gobg = true,
		_goTips = false
	}
}
CustomPickChoiceEnum.SelectHeroToastEnum = {
	[823853] = ToastEnum.NewCustomPickMoreSelect,
	[823854] = ToastEnum.NewCustomPickMoreSelect,
	[823855] = ToastEnum.NewCustomPickMoreSelect,
	[823856] = ToastEnum.NewCustomPickMoreSelect,
	[823857] = ToastEnum.NewCustomPickMoreSelect
}
CustomPickChoiceEnum.SelectHasHeroMsgBoxIdEnum = {
	[823853] = MessageBoxIdDefine.InspirationBoxHasHeroTip,
	[823854] = MessageBoxIdDefine.InspirationBoxHasHeroTip,
	[823855] = MessageBoxIdDefine.InspirationBoxHasHeroTip,
	[823856] = MessageBoxIdDefine.InspirationBoxHasHeroTip,
	[823857] = MessageBoxIdDefine.InspirationBoxHasHeroTip
}

return CustomPickChoiceEnum
