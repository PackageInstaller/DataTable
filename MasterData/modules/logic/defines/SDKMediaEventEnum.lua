-- chunkname: @modules/logic/defines/SDKMediaEventEnum.lua

module("modules.logic.defines.SDKMediaEventEnum", package.seeall)

local SDKMediaEventEnum = _M

SDKMediaEventEnum.GoodsIdMediaEvent = {
	[6100012] = SDKDataTrackMgr.MediaEvent.purchase_level5pack,
	[6100002] = SDKDataTrackMgr.MediaEvent.purchase_level10pack
}
SDKMediaEventEnum.HeroGetEvent = {
	[3023] = SDKDataTrackMgr.MediaEvent.game_summon_01
}
SDKMediaEventEnum.PurchaseIdMediaEvent = {
	[811314] = "purchase_furniture",
	[811324] = "purchase_v1.1_01_15.99pack",
	[811316] = "purchase_v1.1_49.99pack",
	[811319] = "purchase_v1.1_02_4.99pack",
	[811304] = "purchase_ResonatePack",
	[811325] = "purchase_v1.1_02_15.99pack",
	[811317] = "purchase_v1.1_29.99pack",
	[811313] = "purchase_newplayer90off",
	[811321] = "purchase_v1.1_02_1.99pack",
	[811322] = "purchase_v1.1_01_7.99pack",
	[710003] = "purchase_bp_middle",
	[811327] = "purchase_v1.1_0.99pack",
	[811318] = "purchase_v1.1_01_4.99pack",
	[811323] = "purchase_v1.1_02_7.99pack",
	[811315] = "purchase_Gacha10Pack",
	[811320] = "purchase_v1.1_01_1.99pack",
	[610001] = SDKDataTrackMgr.MediaEvent.purchase_mothlyCard,
	[710001] = SDKDataTrackMgr.MediaEvent.purchase_bp_small,
	[710002] = SDKDataTrackMgr.MediaEvent.purchase_bp_large,
	[610002] = SDKDataTrackMgr.MediaEvent.purchase_firstChargePack,
	[811461] = SDKDataTrackMgr.MediaEvent.purchase_firstChargePack,
	[610003] = SDKDataTrackMgr.MediaEvent.purchase_firstResourcePack,
	[610004] = SDKDataTrackMgr.MediaEvent.purchase_firstGachaPack,
	[610006] = SDKDataTrackMgr.MediaEvent.purchase_monthlyGachaPack
}
SDKMediaEventEnum.TotalChargeAmount = {
	[9999] = "purchase_re100",
	[99] = "purchase_re1",
	[2999] = "purchase_re30"
}
SDKMediaEventEnum.JP_TotalChargeAmount = {
	[15000] = "purchase_re150",
	[450000] = "purchase_re4500",
	[1500000] = "purchase_re15000"
}
SDKMediaEventEnum.TrackEpisodePassMediaEvent = {
	[10101] = SDKDataTrackMgr.MediaEvent.plot_progress_1_1,
	[10103] = SDKDataTrackMgr.MediaEvent.plot_progress_1_4,
	[10108] = SDKDataTrackMgr.MediaEvent.plot_progress_1_9,
	[10110] = SDKDataTrackMgr.MediaEvent.plot_progress_1_11,
	[10314] = SDKDataTrackMgr.MediaEvent.plot_progress_3_14,
	[10315] = SDKDataTrackMgr.MediaEvent.plot_progress_3_15,
	[10115] = SDKDataTrackMgr.MediaEvent.chapter_progress_1,
	[10215] = SDKDataTrackMgr.MediaEvent.chapter_progress_2,
	[10316] = SDKDataTrackMgr.MediaEvent.chapter_progress_3
}
SDKMediaEventEnum.PlayerLevelUpMediaEvent = {
	[5] = SDKDataTrackMgr.MediaEvent.roleLevel_5_achieve,
	[10] = SDKDataTrackMgr.MediaEvent.roleLevel_10_achieve,
	[15] = SDKDataTrackMgr.MediaEvent.roleLevel_15_achieve,
	[20] = SDKDataTrackMgr.MediaEvent.roleLevel_20_achieve
}
SDKMediaEventEnum.FirstStoryId = 100101

return SDKMediaEventEnum
