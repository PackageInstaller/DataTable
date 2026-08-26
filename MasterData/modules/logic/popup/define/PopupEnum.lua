-- chunkname: @modules/logic/popup/define/PopupEnum.lua

module("modules.logic.popup.define.PopupEnum", package.seeall)

local PopupEnum = _M

PopupEnum.PriorityType = {
	CommonPropView = 300,
	RoomBuildingGetView = 700,
	DungeonFragmentInfoView = 200,
	SpecialEquipOpenTip = 1,
	GainSkinView = 400,
	SummonResultView = 500,
	NuoDiKaUnitTip = 100003,
	RoomGetCritterView = 801,
	SigninPropView = 1001,
	AdventureCompleteView = 100,
	CollectionGet = 100002,
	RoomBlockPackageGetView = 701,
	CommonPropConvertView = 299,
	CachotTips = 100001,
	GainCharacterView = 600,
	SkinCouponTipView = 901,
	ChargeStoreQuickUseTip = 2
}
PopupEnum.CacheType = {
	Fight = 1,
	Summon = 3,
	Guide = 2
}
PopupEnum.CheckCacheHandler = {
	[PopupEnum.CacheType.Fight] = PopupHelper.checkInFight,
	[PopupEnum.CacheType.Guide] = PopupHelper.checkInGuide,
	[PopupEnum.CacheType.Summon] = PopupHelper.checkInSummonDrawing
}
PopupEnum.CheckCacheGetApproach = {
	[MaterialEnum.GetApproach.Charge] = {
		PopupEnum.CacheType.Fight,
		PopupEnum.CacheType.Guide
	},
	[MaterialEnum.GetApproach.MonthCard] = {
		PopupEnum.CacheType.Fight,
		PopupEnum.CacheType.Guide,
		PopupEnum.CacheType.Summon
	}
}

return PopupEnum
