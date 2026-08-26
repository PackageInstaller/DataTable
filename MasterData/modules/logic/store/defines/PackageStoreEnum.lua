-- chunkname: @modules/logic/store/defines/PackageStoreEnum.lua

module("modules.logic.store.defines.PackageStoreEnum", package.seeall)

local PackageStoreEnum = _M

PackageStoreEnum.AnimHeadDict = {
	[6142802] = true
}
PackageStoreEnum.DecorateCombinationType = {
	[ItemEnum.SubType.FightCard] = true,
	[ItemEnum.SubType.FightFloatType] = true,
	[ItemEnum.SubType.PlayerBg] = true
}
PackageStoreEnum.DecorateCombinationIdDic = {
	[839021] = true
}

return PackageStoreEnum
