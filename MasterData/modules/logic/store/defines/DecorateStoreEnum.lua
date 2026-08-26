-- chunkname: @modules/logic/store/defines/DecorateStoreEnum.lua

module("modules.logic.store.defines.DecorateStoreEnum", package.seeall)

local DecorateStoreEnum = _M

DecorateStoreEnum.DecorateViewType = {
	UnFold = 2,
	Fold = 1
}
DecorateStoreEnum.DecorateItemType = {
	Default = 0,
	SceneUIPackage = 7,
	SkinGift = 6,
	DecorateBundle = 9,
	MainScene = 3,
	Icon = 1,
	MainUISkin = 8,
	BuildingVideo = 4,
	SelfCard = 5,
	Skin = 2
}
DecorateStoreEnum.DecorateType = {
	Old = 802,
	New = 801
}
DecorateStoreEnum.MaxBuyTipType = {
	Owned = 1,
	SoldOut = 2
}
DecorateStoreEnum.TagType = {
	SpecialSell = 1
}
DecorateStoreEnum.LinkTagType = {
	Show = 1
}
DecorateStoreEnum.DiscountItemActId = {
	[V3a4GiftRecommendEnum.OffItemId] = ActivityEnum.Activity.V3a4_GiftRecommend
}
DecorateStoreEnum.DefaultViewShowTime = 1

return DecorateStoreEnum
