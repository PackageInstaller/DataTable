-- chunkname: @modules/logic/gm/controller/GMEvent.lua

module("modules.logic.gm.controller.GMEvent", package.seeall)

local GMEvent = _M
local uid = 1

local function E(name)
	assert(GMEvent[name] == nil, "[GMEvent] error redefined GMEvent." .. name)

	GMEvent[name] = uid
	uid = uid + 1
end

E("RecommendStore_ShowAllBannerUpdate")
E("RecommendStore_ShowAllTabIdUpdate")
E("RecommendStore_StopBannerLoopAnimUpdate")
E("GMLog_Trigger")
E("GMLog_UpdateCount")
E("GMLogView_Select")
E("SummonMainView_ShowAllTabIdUpdate")
E("DungeonMapView_ShowAllTabIdUpdate")
E("CharacterDataVoiceView_ShowAllTabIdUpdate")
E("MainThumbnailRecommendView_ShowAllBannerUpdate")
E("MainThumbnailRecommendView_ShowAllTabIdUpdate")
E("MainThumbnailRecommendView_StopBannerLoopAnimUpdate")
E("VersionActivity_DungeonMapView_ShowAllTabIdUpdate")
E("PackageStoreView_ShowAllTabIdUpdate")
E("PackageStoreView_ShowAllItemIdUpdate")
E("ClothesStoreView_ShowAllTabIdUpdate")
E("VersionActivity_EnterView_ShowAllTabIdUpdate")
E("CharacterBackpackView_ShowAllTabIdUpdate")
E("CharacterBackpackView_EnableCheckFaceOnSelect")
E("CharacterBackpackView_EnableCheckMouthOnSelect")
E("CharacterBackpackView_EnableCheckContentOnSelect")
E("CharacterBackpackView_EnableCheckMotionOnSelect")
E("CharacterView_ShowAllTabIdUpdate")
E("CharacterView_OnClickCheckFace")
E("CharacterView_OnClickCheckMouth")
E("CharacterView_OnClickCheckContent")
E("CharacterView_OnClickCheckMotion")
E("StoreView_ShowAllTabIdUpdate")
E("NormalStoreView_ShowAllTabIdUpdate")
E("NormalStoreView_ShowAllGoodsIdUpdate")
E("SummonPoolHistoryView_ShowAllTabIdUpdate")
E("SummonHeroDetailView_ShowAllTabIdUpdate")
E("MailView_ShowAllTabIdUpdate")
E("ActivityBeginnerView_ShowAllTabIdUpdate")
E("ActivityWelfareView_ShowAllTabIdUpdate")
E("V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate")
E("V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect")
E("V3a1_GaoSiNiao_GameView_ShowAllTabIdUpdate")
E("V3a1_GaoSiNiao_GameView_OnClickSwitchMode")

return GMEvent
