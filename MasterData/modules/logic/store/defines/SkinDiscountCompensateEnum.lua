-- chunkname: @modules/logic/store/defines/SkinDiscountCompensateEnum.lua

module("modules.logic.store.defines.SkinDiscountCompensateEnum", package.seeall)

local SkinDiscountCompensateEnum = _M

SkinDiscountCompensateEnum.SelectDisplayType = {
	Select = 1,
	DisplayOnly = 2
}
SkinDiscountCompensateEnum.ItemType = {
	Skin = 1,
	ExchangeItem = 2
}

return SkinDiscountCompensateEnum
