-- chunkname: @modules/logic/udimo/define/UdimoEnum.lua

module("modules.logic.udimo.define.UdimoEnum", package.seeall)

local UdimoEnum = _M

UdimoEnum.ConstId = {
	AirPointOrLandWeight = 12,
	MoveSpeed = 9,
	WalkDurationTime = 2,
	PlayCatch2WalkAnimHeight = 11,
	UdimoPickedUpOrderLayer = 16,
	InteractPointSize = 17,
	FallDownSpeed = 10,
	AirPointZRange = 14,
	AirNeedXValue = 13,
	WalkYTranslationTime = 15,
	IdleWaitTime = 1,
	InteractWaitTime = 8,
	RandomWeatherIntervalTime = 4,
	MaxShowUdimoCount = 5,
	OverseasRandomTemperatureRange = 18,
	EmojiIntervalTime = 3
}
UdimoEnum.Const = {
	SceneId = 801,
	DefaultDecorationPos = 1,
	InteractPointRes = "v3a2_m_s19_ytm/prefabs/v3a2_ytm_point_1",
	CamTraceDecorationTime = 0.6,
	EmojiDefaultPlayTime = 3,
	UdimoPickedUpTime = 0.5,
	UdimoUIOutlineEff = "roleeffects/roleeffect_outline_ytm_ui"
}
UdimoEnum.PlayerCacheDataKey = {
	UdimoHasPlayedUnlockAnim = "UDIMO_HAS_PLAYED_UNLOCK_ANIM",
	UdimoHasClicked = "UDIMO_HAS_CLICKED"
}
UdimoEnum.UdimoItemSubType = {
	[ItemEnum.SubType.UdimoItem] = true,
	[ItemEnum.SubType.UdimoBgItem] = true,
	[ItemEnum.SubType.UdimoDecorationItem] = true
}
UdimoEnum.SceneGOName = {
	Decoration = "decoration",
	DecorationSiteGO = "decorationSiteGO",
	UdimoRoot = "udimoRoot",
	Weather = "weather",
	Interact = "interact",
	InteractPointRoot = "InteractPointRoot",
	InteractPointGO = "InteractPointGO",
	DecorationRoot = "decorationRoot"
}
UdimoEnum.UdimoType = {
	Land = 2,
	Air = 3,
	InWater = 4,
	Water = 1
}
UdimoEnum.UdimoState = {
	WaitInteract = "waitInteract",
	Idle = "idle",
	PickedUp = "pickedUp",
	Interact = "interact",
	Walk = "walk"
}
UdimoEnum.SpineAnim = {
	Idle2Walk = "iwchange",
	Catch = "catch",
	Idle = "idle",
	Walk2Idle = "wichange",
	Catch2Walk = "cwchange",
	Walk = "walk"
}
UdimoEnum.MoveDir = {
	Left = -1,
	Right = 1
}
UdimoEnum.StateParamType = {
	ChangeArea = 1
}
UdimoEnum.WaitEnterUdimoLockModeSceneType = {
	[SceneType.Main] = true,
	[SceneType.Udimo] = true
}
UdimoEnum.WaitEnterUdimoLockModeView = {
	[ViewName.UdimoMainView] = true,
	[ViewName.MainView] = true,
	[ViewName.MailView] = true,
	[ViewName.TaskView] = true,
	[ViewName.BackpackView] = true,
	[ViewName.StoreView] = true,
	[ViewName.MainThumbnailView] = true,
	[ViewName.DungeonView] = true,
	[ViewName.SignInView] = true,
	[ViewName.SettingsView] = true,
	[ViewName.NoticeView] = true,
	[ViewName.PlayerView] = true,
	[ViewName.CharacterBackpackView] = true,
	[ViewName.SummonADView] = true,
	[ViewName.BpView] = true,
	[ViewName.PowerView] = true
}

return UdimoEnum
