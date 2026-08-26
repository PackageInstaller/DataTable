-- chunkname: @modules/logic/store/defines/ChargePackageEnum.lua

module("modules.logic.store.defines.ChargePackageEnum", package.seeall)

local ChargePackageEnum = _M

ChargePackageEnum.ItemBg = {
	High = 3,
	Medium = 2,
	Low = 1
}
ChargePackageEnum.ItemBgPriceList = {
	[ChargePackageEnum.ItemBg.High] = 100,
	[ChargePackageEnum.ItemBg.Medium] = 50,
	[ChargePackageEnum.ItemBg.Low] = 0
}
ChargePackageEnum.OffTagType = {
	New = 1
}
ChargePackageEnum.PackageType = {
	SingleCurrencyPackage = 4
}
ChargePackageEnum.DefaultUnderlayParam = "1"

return ChargePackageEnum
