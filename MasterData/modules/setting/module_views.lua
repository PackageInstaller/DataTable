-- chunkname: @modules/setting/module_views.lua

local module_views = {}

module_views.SimulateLoginView = {
	destroy = 3,
	container = "SimulateLoginViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/login/simulateloginview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.LoginView = {
	destroy = 0,
	container = "LoginViewContainer",
	mainRes = "ui/viewres/login/loginview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/login/loginbgtype.prefab",
		[2] = ResUrl.getLoginBg("bg_denglubeijing_b01")
	}
}
module_views.FixResTipView = {
	destroy = 0,
	container = "FixResTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/login/fixrestipview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/messagebox/messageboxview.prefab"
	}
}
module_views.SDKLoginVerifyView = {
	destroy = 0,
	container = "SDKLoginVerifyViewContainer",
	mainRes = "ui/viewres/sdk/sdkloginverifyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKLoginRealNameView = {
	destroy = 0,
	container = "SDKLoginRealNameViewContainer",
	mainRes = "ui/viewres/sdk/sdkloginrealnameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKLoginRealNameResultView = {
	destroy = 0,
	container = "SDKLoginRealNameResultViewContainer",
	mainRes = "ui/viewres/sdk/sdkloginrealnameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKLoginAddPwdView = {
	destroy = 0,
	container = "SDKLoginAddPwdViewContainer",
	mainRes = "ui/viewres/sdk/sdkloginaddpwdview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKCommonTipView = {
	destroy = 0,
	container = "SDKCommonTipViewContainer",
	mainRes = "ui/viewres/sdk/sdkcommontipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKWelcomeView = {
	destroy = 0,
	container = "SDKWelcomeViewContainer",
	mainRes = "ui/viewres/sdk/sdkwelcomeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKExitGameView = {
	bgBlur = 1,
	container = "SDKExitGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/sdk/sdkexitgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKLoginUsualView = {
	destroy = 0,
	container = "SDKLoginUsualViewContainer",
	mainRes = "ui/viewres/sdk/sdkloginusualview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.SDKSandboxPayView = {
	destroy = 0,
	container = "SDKSandboxPayViewContainer",
	mainRes = "ui/viewres/sdk/sdksandboxpayview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.NicknameView = {
	destroy = 0,
	container = "NicknameViewContainer",
	mainRes = "ui/viewres/login/nicknameview.prefab",
	layer = "HUD",
	viewType = ViewType.Full,
	otherRes = {
		AvProMgrConfig.UrlNicknameVideo,
		AvProMgrConfig.UrlNicknameVideoCompatible
	}
}
module_views.NicknameConfirmView = {
	bgBlur = 3,
	container = "NicknameConfirmViewContainer",
	mainRes = "ui/viewres/login/nicknameconfirmview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.5,
	layer = "MESSAGE",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x1
}
module_views.ServerListView = {
	destroy = 3,
	container = "ServerListViewContainer",
	mainRes = "ui/viewres/login/serverlistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/login/serverlistitem.prefab"
	}
}
module_views.SkinOffsetAdjustView = {
	destroy = 0,
	container = "SkinOffsetAdjustViewContainer",
	mainRes = "ui/viewres/skin/skinoffsetadjustview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/skin/skinoffsetskinitem.prefab"
	}
}
module_views.FightFocusCameraAdjustView = {
	destroy = 0,
	container = "FightFocusCameraAdjustViewContainer",
	mainRes = "ui/viewres/fight/fightfocuscameraadjustview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal
}
module_views.FightRouge2Check362View = {
	destroy = 0,
	container = "FightRouge2Check362ViewContainer",
	mainRes = "ui/viewres/fight/fight_rouge2/fight_rouge2_treasureview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.FightLorentzCardCopyView = {
	destroy = 0,
	container = "FightLorentzCardCopyViewContainer",
	mainRes = "ui/viewres/fight/fight_lorentz_cardcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.FightDeviceSwitchView = {
	destroy = 0,
	container = "FightDeviceSwitchViewContainer",
	mainRes = "ui/viewres/fight/fight3_7deviceswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.MainSceneSkinMaterialTipView = {
	container = "MainSceneSkinMaterialTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/mainsceneswitch/mainsceneskinmaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.MainSceneSkinMaterialTipView2 = {
	container = "MainSceneSkinMaterialTipView2Container",
	bgBlur = 1,
	mainRes = "ui/viewres/mainsceneswitch/mainsceneskinmaterialtipview2.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.SceneUIPackageGoodsTipView = {
	container = "SceneUIPackageGoodsTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/mainsceneswitch/sceneuipackagegoodstipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.FightUISkinMaterialTipView = {
	container = "FightUISkinMaterialTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/mainsceneswitch/mainsceneskinmaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.MainUISkinMaterialTipView = {
	container = "MainUISkinMaterialTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/mainsceneswitch/mainsceneskinmaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.SummonUISkinMaterialTipView = {
	container = "SummonUISkinMaterialTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/mainsceneswitch/mainsceneskinmaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.FightUISwitchSceneView = {
	bgBlur = 1,
	container = "FightUISwitchSceneViewContainer",
	mainRes = "ui/viewres/mainsceneswitch/fightuiswitchsceneview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.FightUISwitchEquipView = {
	bgBlur = 1,
	container = "FightUISwitchEquipViewContainer",
	mainRes = "ui/viewres/mainsceneswitch/fightuiswitchequipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.MainSwitchView = {
	destroy = 0,
	container = "MainSwitchViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/main/mainswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/main/mainswitchcategoryitem.prefab",
		CurrencyView.prefabPath,
		"ui/viewres/mainsceneswitch/classifyitem.prefab",
		"ui/viewres/mainsceneswitch/mainuiswitchblurmask.prefab"
	},
	tabRes = {
		{
			{
				"ui/viewres/character/characterswitchview.prefab",
				"ui/viewres/character/characterswitchitem.prefab"
			},
			{
				"ui/viewres/mainsceneswitch/mainswitchclassifyview.prefab",
				"ui/viewres/mainsceneswitch/mainsceneswitchitem.prefab"
			},
			{
				"ui/viewres/mainsceneswitch/fightuiswitchview.prefab",
				"ui/viewres/mainsceneswitch/mainsceneswitchitem.prefab"
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/mainsceneswitch/mainsceneswitchnewview.prefab"
			},
			{
				"ui/viewres/mainsceneswitch/mainuiswitchview.prefab"
			},
			{
				"ui/viewres/mainsceneswitch/clickuiswitchview.prefab"
			},
			{
				"ui/viewres/mainsceneswitch/summonuiswitchview.prefab"
			}
		},
		{
			{
				"ui/viewres/main/mainview.prefab"
			}
		}
	}
}
module_views.MainSceneSwitchInfoView = {
	destroy = 0,
	container = "MainSceneSwitchInfoViewContainer",
	mainRes = "ui/viewres/mainsceneswitch/mainsceneswitchinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.MainUISwitchInfoView = {
	bgBlur = 4,
	container = "MainUISwitchInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/mainsceneswitch/mainsuiswitchinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		CurrencyView.prefabPath,
		[2] = "ui/viewres/mainsceneswitch/mainuiswitchblurmask.prefab"
	},
	tabRes = {
		{
			{
				"ui/viewres/main/mainview.prefab"
			}
		}
	},
	preloader = module_views_preloader
}
module_views.SceneUIPackageInfoView = {
	bgBlur = 4,
	container = "SceneUIPackageInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/mainsceneswitch/mainuioverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		CurrencyView.prefabPath
	},
	tabRes = {
		{
			{
				"ui/viewres/main/mainview.prefab"
			}
		}
	},
	preloader = module_views_preloader
}
module_views.MainUISwitchInfoBlurMaskView = {
	destroy = 0,
	container = "MainUISwitchInfoBlurMaskViewContainer",
	mainRes = "ui/viewres/mainsceneswitch/mainuiswitchblurmaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	preloader = module_views_preloader
}
module_views.ClickUISwitchInfoView = {
	destroy = 0,
	container = "ClickUISwitchInfoViewContainer",
	mainRes = "ui/viewres/mainsceneswitch/clickuiswitchinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.SummonUISwitchInfoView = {
	destroy = 0,
	container = "SummonUISwitchInfoViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/mainsceneswitch/summonuiswitchinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.MainSceneStoreShowView = {
	destroy = 0,
	container = "MainSceneStoreShowViewContainer",
	mainRes = "ui/viewres/mainsceneswitch/mainscenestoreshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.MainView = {
	destroy = 0,
	container = "MainViewContainer",
	mainRes = "ui/viewres/main/mainview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/spriteassets/main.asset",
		[2] = "ui/animations/dynamic/maincamera.controller"
	}
}
module_views.XRAnSkinInteractionView = {
	destroy = 0,
	container = "XRAnSkinInteractionViewContainer",
	mainRes = "ui/viewres/story/v3a7_leimeierview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.MainThumbnailView = {
	destroy = 0,
	container = "MainThumbnailViewContainer",
	mainRes = "ui/viewres/main/mainthumbnailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/main/mainthumbnailselectitem.prefab",
		"ui/viewres/main/mainthumbnailbanneritem.prefab",
		"ui/animations/dynamic/mainthumbnailview_camera.controller",
		"ui/animations/dynamic/captureview.controller"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.FeedBackView = {
	destroy = 0,
	container = "FeedBackViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/main/feedbackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.MessageBoxView = {
	bgBlur = 1,
	container = "MessageBoxViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/messagebox/messageboxview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_tipbg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.MessageOptionBoxView = {
	destroy = 0,
	container = "MessageOptionBoxViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/messagebox/messageoptionboxview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_tipbg"
	}
}
module_views.TopMessageBoxView = {
	destroy = 0,
	container = "TopMessageBoxViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/messagebox/messageboxview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_tipbg"
	}
}
module_views.FightQuitTipView = {
	destroy = 0,
	container = "FightQuitTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightquittipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
module_views.ToastView = {
	destroy = 0,
	container = "ToastViewContainer",
	mainRes = "ui/viewres/toast/toastview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal
}
module_views.ToastTopView = {
	destroy = 0,
	container = "ToastViewContainer",
	mainRes = "ui/viewres/toast/toastview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.PowerView = {
	bgBlur = 1,
	container = "PowerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/power/powerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PowerActChangeView = {
	destroy = 0,
	container = "PowerActChangeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/power/poweractchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.PowerBuyTipView = {
	bgBlur = 1,
	container = "PowerBuyTipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/power/powerbuytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_tipbg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.PowerMakerPatFaceView = {
	destroy = 0,
	container = "PowerMakerPatFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/power/powermakerpatfaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_tipbg"
	}
}
module_views.ExploreView = {
	destroy = 0,
	container = "ExploreViewContainer",
	mainRes = "ui/viewres/explore/exploreview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ExploreGuideView = {
	destroy = 0,
	container = "ExploreGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/exploreguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.ExploreEnterView = {
	destroy = 0,
	container = "ExploreEnterViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/exploreloadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ExploreArchivesDetailView = {
	destroy = 0,
	container = "ExploreArchivesDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/explorestoryeastereggview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ExploreBonusSceneRecordView = {
	destroy = 0,
	container = "ExploreBonusSceneRecordViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/explorestoryeastereggtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ExploreFinishView = {
	destroy = 0,
	container = "ExploreFinishViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/explorefinishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ExploreMapView = {
	destroy = 0,
	container = "ExploreMapViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/exploremapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.ExploreBlackView = {
	destroy = 1,
	container = "ExploreBlackViewContainer",
	mainRes = "ui/viewres/explore/exploreblackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.ExploreArchivesView = {
	bgBlur = 1,
	container = "ExploreArchivesViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/explore/explorearchivesview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.ExploreInteractView = {
	destroy = 0,
	container = "ExploreInteractViewContainer",
	mainRes = "ui/viewres/explore/exploreinteractview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {}
}
module_views.ExploreBonusSceneView = {
	destroy = 0,
	container = "ExploreBonusSceneViewContainer",
	mainRes = "ui/viewres/explore/exploreinteracteastereggview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ExploreInteractOptionView = {
	destroy = 0,
	container = "ExploreInteractOptionViewContainer",
	mainRes = "ui/viewres/explore/exploreinteractoptionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {}
}
module_views.ExploreGetItemView = {
	destroy = 0,
	container = "ExploreGetItemViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/exploregetitemview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.ExploreBackpackView = {
	destroy = 0,
	container = "ExploreBackpackViewContainer",
	mainRes = "ui/viewres/explore/explorebackpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/explore/explorebackpackpropitem.prefab"
	}
}
module_views.ExploreRewardView = {
	destroy = 0,
	container = "ExploreRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/explorerewardview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ExploreBonusRewardView = {
	destroy = 0,
	container = "ExploreBonusRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/explore/explorerewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ExploreGuideDialogueView = {
	destroy = 0,
	container = "ExploreGuideDialogueViewContainer",
	mainRes = "ui/viewres/explore/exploreinteractview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightView = {
	destroy = 0,
	container = "FightViewContainer",
	mainRes = "ui/viewres/fight/fightview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/fight/fightcarditem.prefab",
		"ui/viewres/fight/clothskill.prefab",
		"ui/viewres/fight/fightcarddeckbtnview.prefab",
		"ui/viewres/fight/fighttower/fightcardremoveview.prefab",
		"ui/viewres/fight/fighttower/fighttowerbosshplock.prefab"
	}
}
module_views.FightSuccView = {
	destroy = 0,
	container = "FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
module_views.FightFailTipsView = {
	destroy = 0,
	container = "FightFailTipsViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightfailtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightBloodPoolTipView = {
	destroy = 0,
	container = "FightBloodPoolTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightbloodpooltipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightCommonTipView = {
	destroy = 0,
	container = "FightCommonTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightcommontipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightDeviceCardTipView = {
	destroy = 0,
	container = "FightDeviceCardTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightdevicecardtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightSpecialTipView = {
	destroy = 0,
	container = "FightSpecialTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightspecialtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.FightTechniqueView = {
	destroy = 0,
	container = "FightTechniqueViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fighttechniqueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.FightCardPreDisPlayView = {
	destroy = 0,
	container = "FightCardPreDisPlayViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightcardpredisplay.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightCardDeckView = {
	destroy = 0,
	container = "FightCardDeckViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightcarddeckview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightAiJiAoQteSelectView = {
	destroy = 0,
	container = "FightAiJiAoQteSelectViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightaijiaoselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightAiJiAoQteView = {
	destroy = 0,
	container = "FightAiJiAoQteViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightprefabcontainer.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightItemSkillInfosView = {
	destroy = 0,
	container = "FightItemSkillInfosViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightassassinwheelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.GMFightNuoDiKaXianJieCeShi = {
	destroy = 0,
	container = "GMFightNuoDiKaXianJieCeShiContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/gm/gmfightnuodikaxianjieceshi.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.GMFightNuoDiKaXianJieAnNiu = {
	destroy = 0,
	container = "GMFightNuoDiKaXianJieAnNiuContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/gm/gmfightnuodikaxianjieanniu.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightNuoDiKaQteView = {
	destroy = 0,
	container = "FightNuoDiKaQteViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fight_nuodika_interactview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightPlayChoiceCardView = {
	destroy = 0,
	container = "FightPlayChoiceCardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/skillcopingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightWeekWalkEnemyTipsView = {
	destroy = 0,
	container = "FightWeekWalkEnemyTipsViewContainer",
	mainRes = "ui/viewres/fight/fightweekwalkenemytipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightGMDouQuQuTest = {
	destroy = 0,
	container = "FightGMDouQuQuTestContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/gm/fightgmdouququtest.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightGmCustomFightView = {
	destroy = 0,
	container = "FightGmCustomFightViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/gm/fightgmcustomfightview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightCardDeckGMView = {
	destroy = 0,
	container = "FightCardDeckGMViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightcarddeckview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightSkillStrengthenView = {
	destroy = 0,
	container = "FightSkillStrengthenViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/skillstrengthenview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightChangeHeroSelectSkillTargetView = {
	destroy = 0,
	container = "FightChangeHeroSelectSkillTargetViewContainer",
	mainRes = "ui/viewres/fight/fightchangeheroselectskilltargetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightSeasonChangeHeroSelectView = {
	destroy = 0,
	container = "FightSeasonChangeHeroSelectViewContainer",
	mainRes = "ui/viewres/fight/fightseasonchangeheroselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightTechniqueTipsView = {
	destroy = 0,
	container = "FightTechniqueTipsViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fighttechniquetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/help/helpselectitem.prefab"
	}
}
module_views.FightFailView = {
	destroy = 0,
	container = "FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.FightStatView = {
	destroy = 0,
	container = "FightStatViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightstatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"imgBg",
		"Image"
	}
}
module_views.FightSkillTargetView = {
	destroy = 0,
	container = "FightSkillTargetViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fightskilltargetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/fight/fightskilltargetitem.prefab"
	}
}
module_views.FightNaNaTargetView = {
	destroy = 0,
	container = "FightNaNaTargetViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fight_tianshinana_targetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/fight/fight_tianshinana_targetitem.prefab"
	}
}
module_views.FightBLESelectCrystalView = {
	destroy = 0,
	container = "FightBLESelectCrystalViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/beilier_selectcrystalview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightS02SSWLSelectCardView = {
	destroy = 0,
	container = "FightS02SSWLSelectCardViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fight_s02_sswl_selectcardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/fight/fightcarditem.prefab"
	}
}
module_views.FightSupportEventView = {
	destroy = 0,
	container = "FightSupportEventViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fightsupporteventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Fight3_5BaiFuZhangWheelView = {
	destroy = 0,
	container = "Fight3_5BaiFuZhangWheelViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fight_baifuzhang_wheelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Fight3_5BaiFuZhangWheelSelectCardView = {
	destroy = 0,
	container = "Fight3_5BaiFuZhangWheelSelectCardViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fight_baifuzhang_cardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Fight3_7QteView = {
	destroy = 0,
	container = "Fight3_7QteViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/fight/fight3_7qteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightSystemFightNoticeView = {
	destroy = 0,
	container = "FightSystemFightNoticeViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/teaching/teachingtargetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightRoundView = {
	destroy = 0,
	container = "FightRoundViewContainer",
	mainRes = "ui/viewres/fight/fightroundview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {}
}
module_views.FightEditorStateView = {
	destroy = 0,
	container = "FightEditorStateViewContainer",
	mainRes = "ui/viewres/fight/fighteditorstateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightCardIntroduceView = {
	destroy = 0,
	container = "FightCardIntroduceViewContainer",
	mainRes = "ui/viewres/fight/fightcardintroduceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightCardMixIntroduceView = {
	destroy = 0,
	container = "FightCardMixIntroduceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightcardmixintroduceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightCardDescView = {
	bgBlur = 1,
	container = "FightCardDescViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/fight/fightcarddescview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/fight/fightcarddescitem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.FightCareerIntroduceView = {
	destroy = 0,
	container = "FightCareerIntroduceViewContainer",
	mainRes = "ui/viewres/fight/fightcareerintroduceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_blackbg"
	}
}
module_views.FightInspirationView = {
	destroy = 0,
	container = "FightInspirationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightinspirationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FightGuideView = {
	destroy = 0,
	container = "FightGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightguideview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/help/helpselectitem.prefab",
		[2] = "ui/viewres/fight/fightguideitem.prefab"
	}
}
module_views.FightFocusView = {
	bgBlur = 4,
	container = "FightFocusViewContainer",
	mainRes = "ui/viewres/fight/fightfocusview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.65,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	desampleRate = PostProcessingMgr.DesamplingRate.x1,
	reduceRate = PostProcessingMgr.DesamplingRate.x2,
	tabRes = {
		{
			{
				"ui/viewres/tips/skilltipview.prefab"
			}
		}
	},
	otherRes = {
		FightEntityResistanceComp.FightResistancePath
	}
}
module_views.FightActionBarPopView = {
	destroy = 0,
	container = "FightActionBarPopViewContainer",
	mainRes = "ui/viewres/fight/fightactionbarpopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.FightTechniqueGuideView = {
	bgBlur = 4,
	container = "FightTechniqueGuideViewContainer",
	mainRes = "ui/viewres/fight/fighttechniqueguideview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.65,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	desampleRate = PostProcessingMgr.DesamplingRate.x1,
	reduceRate = PostProcessingMgr.DesamplingRate.x2
}
module_views.FightLoadingView = {
	bgBlur = 1,
	container = "FightLoadingViewContainer",
	mainRes = "ui/viewres/fight/fightloadingview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		0,
		0
	},
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x4
}
module_views.FightBuffTipsView = {
	destroy = 0,
	container = "FightBuffTipsViewContainer",
	mainRes = "ui/viewres/fight/fightbufftipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.FightResistanceTipView = {
	destroy = 0,
	container = "FightResistanceTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightresistancetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.FightSkillSelectView = {
	destroy = 0,
	container = "FightSkillSelectViewContainer",
	mainRes = "ui/viewres/fight/fightskillselectview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal
}
module_views.FightDiceView = {
	destroy = 0,
	container = "FightDiceViewContainer",
	mainRes = "ui/viewres/fight/fightluckycasinoview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal
}
module_views.FightSeasonDiceView = {
	destroy = 0,
	container = "FightSeasonDiceViewContainer",
	mainRes = "ui/viewres/fight/seasondiceview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal
}
module_views.FightSkipTimelineView = {
	destroy = 0,
	container = "FightSkipTimelineViewContainer",
	mainRes = "ui/viewres/fight/fightskiptimelineview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SkillEffectStatView = {
	destroy = 0,
	container = "SkillEffectStatViewContainer",
	mainRes = "ui/viewres/fight/skilleffectstatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SkillEditorView = {
	destroy = 0,
	container = "SkillEditorViewContainer",
	mainRes = "ui/viewres/fight/skilleditorview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.BackpackView = {
	container = "BackpackViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/backpack/backpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/backpack/backpackpropitem.prefab",
		"ui/viewres/backpack/backpackcategoryitem.prefab",
		"ui/viewres/common/item/commonequipicon.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/backpack/backpackpropview.prefab"
			},
			{
				"ui/viewres/character/characterbackpackequipview.prefab"
			},
			{
				"ui/viewres/antique/antiquebackpackview.prefab"
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.CurrencyExchangeView = {
	destroy = 0,
	container = "CurrencyExchangeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/currency/currencyexchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	customAnimBg = {
		"#simage_tipbg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.CurrencyDiamondExchangeView = {
	bgBlur = 1,
	container = "CurrencyDiamondExchangeViewContainer",
	mainRes = "ui/viewres/currency/currencydiamondexchangeview.prefab",
	destroy = 0,
	blurFactor = 0.6,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.CommonExchangeView = {
	bgBlur = 1,
	container = "CommonExchangeViewContainer",
	mainRes = "ui/viewres/common/commomexchangeview.prefab",
	destroy = 0,
	blurFactor = 0.6,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.SummonView = {
	destroy = 0,
	container = "SummonViewContainer",
	mainRes = "ui/viewres/summon/summonview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				"ui/viewres/summon/summoncharview.prefab"
			},
			{
				"ui/viewres/summon/summonequipview.prefab"
			}
		}
	}
}
module_views.SummonADView = {
	bgBlur = 0,
	container = "SummonMainViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/summon/summonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	preloader = module_views_preloader,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				"ui/viewres/summon/summonmaincharacterview.prefab"
			},
			{
				"ui/viewres/summon/summonmainequipview.prefab"
			},
			{
				"ui/viewres/summon/summonmaincharacternewbie.prefab"
			},
			{
				"ui/viewres/summon/summonmaincharacterprobup.prefab"
			},
			{
				"ui/viewres/summon/summonmainequipprobup.prefab"
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/summon/summonmaincategoryitem.prefab"
	}
}
module_views.SummonEquipGainView = {
	destroy = 0,
	container = "SummonEquipGainViewContainer",
	mainRes = "ui/viewres/equip/equipgetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimBg = {
		"#go_bg"
	}
}
module_views.SummonResultView = {
	bgBlur = 1,
	container = "SummonResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/summon/summonresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/summonresultview/r.prefab",
		"ui/viewres/summonresultview/sr.prefab",
		"ui/viewres/summonresultview/ssr.prefab"
	}
}
module_views.SummonHeroDetailView = {
	destroy = 0,
	container = "SummonHeroDetailViewContainer",
	mainRes = "ui/viewres/summon/summonherodetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SummonPoolDetailView = {
	container = "SummonPoolDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/summonpooldetailview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/summon/summonpooldetailcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				"ui/viewres/summon/summonpooldetaildescview.prefab"
			},
			{
				"ui/viewres/summon/summonpooldetailprobabilityview.prefab"
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.SummonPoolHistoryView = {
	container = "SummonPoolHistoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/summonpoolhistoryview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default
}
module_views.SummonConfirmView = {
	bgBlur = 1,
	container = "SummonConfirmViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/summon/summonconfirmview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.SummonPoolPogressRewardView = {
	destroy = 0,
	container = "SummonPoolPogressRewardViewContainer",
	maskAlpha = 0,
	bgBlur = 1,
	mainRes = "ui/viewres/summon/version_2_9/v2a9_kashandelapanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonGetLuckyBag = {
	destroy = 0,
	container = "SummonGetLuckyBagViewContainer",
	mainRes = "ui/viewres/summon/luckybag/summongetluckybag.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonLuckyBagChoice = {
	destroy = 0,
	container = "SummonLuckyBagChoiceContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/luckybag/summonluckybagchoice.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonLuckyBagDetailView = {
	container = "SummonLuckyBagDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/summonpooldetailview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/summon/summonpooldetailcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				"ui/viewres/summon/luckybag/summonluckybagdescview.prefab"
			},
			{
				"ui/viewres/summon/luckybag/summonluckybagdetailview.prefab"
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.SummonCustomPickChoice = {
	destroy = 0,
	container = "SummonCustomPickChoiceContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/custompick/summoncustompickchoice.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonCustomPickDetailView = {
	container = "SummonCustomPickDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/summonpooldetailview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/summon/summonpooldetailcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				"ui/viewres/summon/custompick/summoncustompickdescview.prefab"
			},
			{
				"ui/viewres/summon/custompick/summoncustompickdetailview.prefab"
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.SummonThreeCustomPickView = {
	destroy = 0,
	container = "SummonThreeCustomPickViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/version_2_2/v2a2_versionsummonselfselectsixhalfview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonNewCustomPickView = {
	destroy = 0,
	container = "SummonNewCustomPickViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharacterfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonNewCustomPickFullView = {
	destroy = 0,
	container = "SummonNewCustomPickFullViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharacterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonNewCustomPickChoiceView = {
	destroy = 0,
	container = "SummonNewCustomPickChoiceViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharacterchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonNewCustomPickTipsView = {
	destroy = 0,
	container = "SummonNewCustomPickTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectcharacter/v2a2_selfselectcharactertipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SummonSimulationResultView = {
	bgBlur = 1,
	container = "SummonSimulationResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/summonpick/summonpickresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bg"
	},
	otherRes = {
		"ui/viewres/summonresultview/r.prefab",
		"ui/viewres/summonresultview/sr.prefab",
		"ui/viewres/summonresultview/ssr.prefab"
	}
}
module_views.SummonSimulationPickView = {
	destroy = 0,
	container = "SummonSimulationPickViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summonpick/summonpickview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.WeekWalkCharacterView = {
	container = "WeekWalkCharacterViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/weekwalk/weekwalkcharacterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalkcharacteritem.prefab",
		[2] = "ui/viewres/character/charactercategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.WeekWalkTarotView = {
	bgBlur = 1,
	container = "WeekWalkTarotViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/weekwalk/weekwalktarotview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalktarotitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg"
	}
}
module_views.WeekWalkSelectTarotView = {
	destroy = 0,
	container = "WeekWalkSelectTarotViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/weekwalk/weekwalkselecttarotview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	customAnimBg = {}
}
module_views.WeekWalkBuffBindingView = {
	container = "WeekWalkBuffBindingViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/weekwalk/weekwalkbuffbindingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalkbuffbindingheroitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.WeekWalkRespawnView = {
	bgBlur = 1,
	container = "WeekWalkRespawnViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/weekwalk/weekwalkrespawnview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/herogroup/herogroupedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.WeekWalkView = {
	destroy = 0,
	container = "WeekWalkViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WeekWalkReviveView = {
	destroy = 0,
	container = "WeekWalkReviveViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkreviveview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.WeekWalkShallowSettlementView = {
	destroy = 0,
	container = "WeekWalkShallowSettlementViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkshallowsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.WeekWalkDeepLayerNoticeView = {
	destroy = 0,
	container = "WeekWalkDeepLayerNoticeViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkdeeplayernoticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.WeekWalkRuleView = {
	destroy = 0,
	container = "WeekWalkRuleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/weekwalk/weekwalkruleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.WeekWalkDegradeView = {
	destroy = 0,
	container = "WeekWalkDegradeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/weekwalk/weekwalkdegradeview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.WeekWalkRewardView = {
	bgBlur = 1,
	container = "WeekWalkRewardViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkrewardview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalkrewarditem.prefab",
		[2] = "ui/materials/dynamic/edgfade.mat"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WeekWalkLayerRewardView = {
	bgBlur = 1,
	container = "WeekWalkLayerRewardViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalklayerrewardview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalklayerrewarditem.prefab"
	}
}
module_views.WeekWalkEnemyInfoView = {
	bgBlur = 1,
	container = "WeekWalkEnemyInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/weekwalk/weekwalkenemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg",
		"#simage_rightbg"
	}
}
module_views.WeekWalkGuideView = {
	destroy = 0,
	container = "WeekWalkGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/weekwalk/weekwalkguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.WeekWalkQuestionView = {
	destroy = 0,
	container = "WeekWalkQuestionViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkquestionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WeekWalkResetView = {
	bgBlur = 1,
	container = "WeekWalkResetViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkresetview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalkresetbattleitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WeekWalkLayerView = {
	destroy = 0,
	container = "WeekWalkLayerViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalklayerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalklayerpage.prefab",
		[2] = "ui/viewres/weekwalk/weekwalklayerpageitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WeekWalkDialogView = {
	destroy = 0,
	container = "WeekWalkDialogViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkdialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WeekWalk_2HeartLayerView = {
	destroy = 0,
	container = "WeekWalk_2HeartLayerViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheartlayerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/weekwalk/weekwalkheart/weekwalkheartlayerpage.prefab",
		"ui/viewres/weekwalk/weekwalkheart/weekwalkheartlayerpageitem.prefab",
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
module_views.WeekWalk_2HeartView = {
	destroy = 0,
	container = "WeekWalk_2HeartViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheartview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
module_views.WeekWalk_2HeartBuffView = {
	destroy = 0,
	container = "WeekWalk_2HeartBuffViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_buffview.prefab",
	blurFactor = 0.5,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_buffitem.prefab"
	}
}
module_views.WeekWalk_2HeartResultView = {
	destroy = 0,
	container = "WeekWalk_2HeartResultViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
module_views.WeekWalk_2ResetView = {
	bgBlur = 1,
	container = "WeekWalk_2ResetViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_resetview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_resetbattleitem.prefab",
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WeekWalk_2LayerRewardView = {
	bgBlur = 1,
	container = "WeekWalk_2LayerRewardViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_layerrewardview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_layerrewarditem.prefab",
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
module_views.WeekWalk_2RuleView = {
	destroy = 0,
	container = "WeekWalk_2RuleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_ruleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.WeekWalk_2DeepLayerNoticeView = {
	destroy = 0,
	container = "WeekWalk_2DeepLayerNoticeViewContainer",
	mainRes = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_deeplayernoticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.MeilanniView = {
	destroy = 0,
	container = "MeilanniViewContainer",
	mainRes = "ui/viewres/meilanni/meilanniview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/meilanni/meilannieventitem.prefab",
		[2] = "ui/viewres/meilanni/meilannidialogitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.MeilanniEntrustView = {
	destroy = 0,
	container = "MeilanniEntrustViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/meilanni/meilannientrustview.prefab",
	blurFactor = 0.5,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.MeilanniBossInfoView = {
	destroy = 0,
	container = "MeilanniBossInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/meilanni/meilannibossinfoview.prefab",
	blurFactor = 0.5,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.MeilanniSettlementView = {
	destroy = 0,
	container = "MeilanniSettlementViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/meilanni/meilannisettlementview.prefab",
	blurFactor = 0.5,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.MeilanniMainView = {
	destroy = 0,
	container = "MeilanniMainViewContainer",
	mainRes = "ui/viewres/meilanni/meilannimainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.MeilanniTaskView = {
	destroy = 0,
	container = "MeilanniTaskViewContainer",
	mainRes = "ui/viewres/meilanni/meilannitaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/meilanni/meilannitaskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonEquipGuideView = {
	destroy = 0,
	container = "DungeonEquipGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonequipguideview.prefab",
	blurFactor = 0.5,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.GuideTransitionBlackView = {
	destroy = 0,
	container = "LoadingBlackViewContainer",
	mainRes = "ui/viewres/scene/loadingblackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.DungeonView = {
	container = "DungeonViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/dungeonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/dungeon/dungeonchapteritem.prefab",
		"ui/viewres/dungeon/dungeonreschapteritem.prefab",
		"ui/viewres/dungeon/reappear/reappearitem.prefab",
		RoleStoryTank.prefabPath,
		mini_item = "ui/viewres/dungeon/dungeonchapterminiitem.prefab",
		section_item = "ui/viewres/dungeon/dungeonsectionitem.prefab",
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				DungeonEnum.dungeonweekwalkviewPath
			},
			{
				DungeonEnum.dungeonexploreviewPath
			},
			{
				"ui/viewres/dungeon/reappear/reappearview.prefab"
			},
			{
				DungeonEnum.dungeonweekwalk_2viewPath
			},
			{
				"ui/viewres/dungeon/advplay/dungeonadvplayview.prefab"
			},
			{
				"ui/viewres/dungeon/rouge/dungeonrougeview.prefab",
				"ui/viewres/rouge/rougeactivityview.prefab",
				"ui/viewres/rouge2/rouge2_activityview.prefab"
			}
		}
	},
	preloader = module_views_preloader,
	customAnimBg = {
		"#go_story/#simage_bg",
		"#go_resource/#simage_resourcebg",
		"#go_resource/#simage_drawbg"
	}
}
module_views.DungeonMapView = {
	container = "DungeonMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/dungeon/chaptermap/chaptermapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab",
		"ui/viewres/dungeon/chaptermap/map_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.DungeonHuaRongView = {
	destroy = 0,
	container = "DungeonHuaRongViewContainer",
	mainRes = "ui/viewres/dungeon/dungeonhuarongview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonMapTaskView = {
	destroy = 0,
	container = "DungeonMapTaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonmaptaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.DungeonMapLevelView = {
	destroy = 1,
	container = "DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/dungeon/dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonChangeMapStatusView = {
	destroy = 0,
	container = "DungeonChangeMapStatusViewContainer",
	mainRes = "ui/viewres/dungeon/dungeonchangemapstatusview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.DungeonRewardTipView = {
	destroy = 0,
	container = "DungeonRewardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonrewardtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.DungeonEquipEntryView = {
	destroy = 0,
	container = "DungeonEquipEntryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonequipentryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/help/helpselectitem.prefab",
		[2] = "ui/viewres/dungeon/dungeonequipentryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonCumulativeRewardsView = {
	destroy = 0,
	container = "DungeonCumulativeRewardsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeoncumulativerewardsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/dungeon/dungeoncumulativerewardsitem.prefab"
	}
}
module_views.DungeonCumulativeRewardsTipsView = {
	destroy = 0,
	container = "DungeonCumulativeRewardsTipsViewContainer",
	mainRes = "ui/viewres/dungeon/dungeoncumulativerewardstipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.DungeonCumulativeRewardPackView = {
	destroy = 0,
	container = "DungeonCumulativeRewardPackViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeoncumulativerewardpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.DungeonFragmentInfoView = {
	destroy = 0,
	container = "DungeonFragmentInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.DungeonMonsterView = {
	bgBlur = 1,
	container = "DungeonMonsterViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/dungeonmonsterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.DungeonRewardView = {
	destroy = 0,
	container = "DungeonRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bg"
	}
}
module_views.DungeonElementRewardView = {
	bgBlur = 1,
	container = "DungeonElementRewardViewContainer",
	mainRes = "ui/viewres/dungeon/dungeonelementrewardview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bg"
	}
}
module_views.DungeonStoryView = {
	destroy = 0,
	container = "DungeonStoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonstoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.DungeonStoryEntranceView = {
	destroy = 0,
	container = "DungeonStoryEntranceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonstoryentranceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.ShareTipView = {
	destroy = 0,
	container = "ShareTipViewContainer",
	mainRes = "ui/viewres/share/sharetipview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LoadingHeadsetView = {
	destroy = 0,
	container = "LoadingHeadsetViewContainer",
	mainRes = "ui/viewres/scene/loadingheadsetview.prefab",
	layer = "TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.ShareEditorView = {
	destroy = 0,
	container = "ShareEditorViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/share/shareeditorview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.EquipView = {
	bgBlur = 0,
	container = "EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/equip/equipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		"ui/viewres/equip/equipcategoryitem.prefab",
		"ui/viewres/equip/equipstrengthencostitem.prefab",
		"ui/viewres/equip/equipenchantattritem.prefab",
		"ui/viewres/equip/equipchooseitem.prefab",
		"ui/viewres/equip/equipselecteditem.prefab",
		"ui/viewres/equip/equipbreakcostitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/equip/equipinfoview.prefab"
			},
			{
				"ui/viewres/equip/equipstrengthenview.prefab"
			},
			{
				"ui/viewres/equip/equiprefineview.prefab"
			},
			{
				"ui/viewres/equip/equipstoryview.prefab"
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.AntiqueView = {
	destroy = 0,
	container = "AntiqueViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/antique/antiqueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.EquipInfoTeamShowView = {
	bgBlur = 1,
	container = "EquipInfoTeamShowViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/equip/equipinfoteamshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/equip/equipinfoteamshowitem.prefab"
	}
}
module_views.EquipTeamView = {
	bgBlur = 4,
	container = "EquipTeamViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/equip/equipteamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/common/item/commonequipicon.prefab",
		"ui/viewres/equip/equipteamitem.prefab",
		"ui/viewres/equip/equipteamattritem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.EquipTeamShowView = {
	destroy = 0,
	container = "EquipTeamShowViewContainer",
	mainRes = "ui/viewres/equip/equipteamshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/equip/equipteamshowitem.prefab",
		[2] = "ui/viewres/equip/equipteamshowattritem.prefab"
	},
	customAnimBg = {
		"item1/#go_container/frame",
		"item2/#go_container/frame",
		"item3/#go_container/frame"
	}
}
module_views.EquipInfoTipsView = {
	destroy = 0,
	container = "EquipInfoTipsViewContainer",
	mainRes = "ui/viewres/equip/equipinfotipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.EquipChooseView = {
	destroy = 0,
	container = "EquipChooseViewContainer",
	mainRes = "ui/viewres/equip/equipchooseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/item/commonequipicon.prefab"
	},
	customAnimBg = {
		"Image"
	}
}
module_views.EquipBreakResultView = {
	destroy = 0,
	container = "EquipBreakResultViewContainer",
	mainRes = "ui/viewres/equip/equipbreakresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.EquipSkillLevelUpView = {
	destroy = 0,
	container = "EquipSkillLevelUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/equip/equipskilllevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.EquipComposeView = {
	bgBlur = 1,
	container = "EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/equip/equipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/equip/equipcomposeitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg/Image",
		"bg/frame"
	}
}
module_views.EquipSkillTipView = {
	bgBlur = 0,
	container = "EquipSkillTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/equip/equipskilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/equip/equipskillcharacteritem.prefab"
	},
	customAnimBg = {
		"#go_skill/bg",
		"#go_character/bg"
	}
}
module_views.EquipEnchantResultView = {
	bgBlur = 1,
	container = "EquipEnchantResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/equip/equipenchantresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/equip/equipenchantresultattritem.prefab"
	},
	customAnimBg = {
		"Image",
		"frame"
	}
}
module_views.EquipEnchantLookView = {
	bgBlur = 1,
	container = "EquipEnchantLookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/equip/equipenchantlookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/equip/equipenchantattritem.prefab"
	},
	customAnimBg = {
		"#btn_close",
		"frame"
	}
}
module_views.EquipStrengthenAlertView = {
	destroy = 0,
	container = "EquipStrengthenAlertViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/equip/equipstrengthenalertview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg1",
		"bg2"
	}
}
module_views.EquipDecomposeView = {
	destroy = 0,
	container = "EquipDecomposeViewContainer",
	mainRes = "ui/viewres/equip/equipdecomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/equip/equipcomposeitem.prefab"
	}
}
module_views.TestUIView = {
	destroy = 0,
	container = "TestUIViewContainer",
	mainRes = "ui/viewres/test/testuiview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterView = {
	destroy = 0,
	container = "CharacterViewContainer",
	mainRes = "ui/viewres/character/characterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/spriteassets/characterget.asset"
	},
	customAnimBg = {
		"bgcanvas/bg"
	}
}
module_views.CharacterEquipSettingView = {
	destroy = 0,
	container = "CharacterEquipSettingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/character/characterequipsettingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/character/characterequipsettingitem.prefab"
	}
}
module_views.CharacterSkinView = {
	destroy = 0,
	container = "CharacterSkinViewContainer",
	mainRes = "ui/viewres/character/characterskinview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterSkinTipView = {
	destroy = 0,
	container = "CharacterSkinTipViewContainer",
	mainRes = "ui/viewres/character/characterskinview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterSkinTagView = {
	bgBlur = 4,
	container = "CharacterSkinTagViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/character/characterskintagview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.CharacterSwitchView = {
	destroy = 0,
	container = "CharacterSwitchViewContainer",
	mainRes = "ui/viewres/character/characterswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/character/characterswitchitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterSkinFullScreenView = {
	destroy = 0,
	container = "CharacterSkinFullScreenViewContainer",
	mainRes = "ui/viewres/character/characterskinfullscreenview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterSkinGainView = {
	destroy = 0,
	container = "CharacterSkinGainViewContainer",
	mainRes = "ui/viewres/character/characterskingainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.CharacterGetView = {
	destroy = 0,
	container = "CharacterGetViewContainer",
	mainRes = "ui/viewres/character/charactergetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimBg = {
		"#go_bg"
	}
}
module_views.CharacterSkinGetDetailView = {
	destroy = 0,
	container = "CharacterSkinGetDetailViewContainer",
	mainRes = "ui/viewres/character/characterskingetdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterTipView = {
	bgBlur = 2,
	container = "CharacterTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/character/charactertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_attributetip/bg",
		"#go_careertip/bg",
		"#go_skilltip/skilltip1/skillbg",
		"#go_skilltip/skilltip2/skillbg/bg",
		"#go_passiveskilltip/talentbg"
	}
}
module_views.CharacterBackpackView = {
	container = "CharacterBackpackViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/character/characterbackpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/common/item/commonheroitemnew.prefab",
		"ui/viewres/character/charactercategoryitem.prefab",
		"ui/viewres/common/item/commonequipicon.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/character/characterbackpackheroview.prefab"
			},
			{
				"ui/viewres/character/characterbackpackequipview.prefab"
			}
		}
	},
	preloader = module_views_preloader,
	customAnimBg = {
		"bg"
	}
}
module_views.CharacterBackpackSearchFilterView = {
	destroy = 0,
	container = "CharacterBackpackSearchFilterViewContainer",
	mainRes = "ui/viewres/character/characterbackpacksearchfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.CharacterRankUpView = {
	destroy = 0,
	container = "CharacterRankUpViewContainer",
	mainRes = "ui/viewres/character/characterrankupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/character/characterrankupitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.CharacterRankUpResultView = {
	destroy = 0,
	container = "CharacterRankUpResultViewContainer",
	mainRes = "ui/viewres/character/characterrankupresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterExSkillView = {
	container = "CharacterExSkillViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/character/characterexskillview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/character/characterskilldescripte.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.CharacterLevelUpView = {
	bgBlur = 2,
	container = "CharacterLevelUpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/character/characterlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.CharacterTalentView = {
	destroy = 0,
	container = "CharacterTalentViewContainer",
	mainRes = "ui/viewres/character/charactertalentup/charactertalentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/spriteassets/charactertalentup.asset"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterGuideTalentView = {
	destroy = 0,
	container = "CharacterGuideTalentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/character/characterguidetalentview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.CharacterTalentChessView = {
	destroy = 0,
	container = "CharacterTalentChessViewContainer",
	mainRes = "ui/viewres/character/charactertalentup/charactertalentchessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterTalentModifyNameView = {
	bgBlur = 3,
	container = "CharacterTalentModifyNameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/character/charactertalentup/charactertalentmodifynameview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.CharacterTalentLevelUpView = {
	destroy = 0,
	container = "CharacterTalentLevelUpViewContainer",
	mainRes = "ui/viewres/character/charactertalentup/charactertalentlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.CharacterTalentLevelUpPreview = {
	destroy = 0,
	container = "CharacterTalentLevelUpPreviewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/character/charactertalentup/charactertalentleveluppreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterTalentLevelUpResultView = {
	destroy = 0,
	container = "CharacterTalentLevelUpResultViewContainer",
	mainRes = "ui/viewres/character/charactertalentup/charactertalentlevelupresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterTalentTipView = {
	bgBlur = 2,
	container = "CharacterTalentTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/character/charactertalentup/charactertalenttipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		0.2,
		0.25
	}
}
module_views.CharacterTalentStyleView = {
	destroy = 0,
	container = "CharacterTalentStyleViewContainer",
	mainRes = "ui/viewres/character/charactertalentup/charactertalentstyleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.CharacterTalentStatView = {
	destroy = 0,
	container = "CharacterTalentStatViewContainer",
	mainRes = "ui/viewres/character/charactertalentup/charactertalentstatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.CharacterTalentChessFilterView = {
	destroy = 0,
	container = "CharacterTalentChessFilterViewContainer",
	mainRes = "ui/viewres/character/charactertalentup/charactertalentchessfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.CharacterTalentChessCopyView = {
	destroy = 0,
	container = "CharacterTalentChessCopyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.CharacterTalentUseLayoutView = {
	destroy = 0,
	container = "CharacterTalentUseLayoutViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/character/charactertalentup/charactertalentuselayoutview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.CharacterDestinySlotView = {
	destroy = 0,
	container = "CharacterDestinySlotViewContainer",
	mainRes = "ui/viewres/character/characterdestiny/characterdestinyslotview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Nomal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CharacterDestinyStoneView = {
	destroy = 0,
	container = "CharacterDestinyStoneViewContainer",
	mainRes = "ui/viewres/character/characterdestiny/characterdestinystoneview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Nomal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.GMToolView = {
	destroy = 0,
	container = "GMToolViewContainer",
	mainRes = "ui/viewres/gm/gmtoolview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.GMToolView2 = {
	destroy = 0,
	container = "GMToolViewContainer",
	mainRes = "ui/viewres/gm/gmtoolview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
module_views.GMToolFastAddHeroView = {
	destroy = 0,
	container = "GMToolFastAddHeroViewContainer",
	mainRes = "ui/viewres/gm/gmtoolfastaddheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.GMPostProcessView = {
	destroy = 0,
	container = "GMPostProcessViewContainer",
	mainRes = "ui/viewres/gm/gmpostprocess.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.GMFightSimulateView = {
	destroy = 0,
	container = "GMFightSimulateViewContainer",
	mainRes = "ui/viewres/gm/gmfightsimulateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.GMFightStandardEpisodeForTestServerView = {
	destroy = 0,
	container = "GMFightStandardEpisodeForTestServerViewContainer",
	mainRes = "ui/viewres/fight/gmfightstandardepisodefortestserverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.GMGuideStatusView = {
	destroy = 0,
	container = "GMGuideStatusViewContainer",
	mainRes = "ui/viewres/gm/gmguidestatusview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.GMHelpViewBrowseView = {
	destroy = 0,
	container = "GMHelpViewBrowseViewContainer",
	mainRes = "ui/viewres/gm/gmhelpviewbrowseview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.GMResetCardsView = {
	destroy = 0,
	container = "GMResetCardsViewContainer",
	mainRes = "ui/viewres/gm/gmresetcardsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/fight/fightcarditem.prefab"
	}
}
module_views.GMSummonView = {
	destroy = 0,
	container = "GMSummonViewContainer",
	mainRes = "ui/viewres/gm/gmsummonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.GMVideoList = {
	destroy = 0,
	container = "GMVideoListContainer",
	mainRes = "ui/viewres/gm/gmfightsimulateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.GMVideoPlayView = {
	destroy = 0,
	container = "GMVideoPlayViewContainer",
	mainRes = "ui/viewres/main/limitedroleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.GMLangTxtView = {
	destroy = 0,
	container = "GMLangTxtViewContainer",
	mainRes = "ui/viewres/gm/gmlangtxtview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.HierarchyView = {
	destroy = 0,
	container = "HierarchyViewContainer",
	mainRes = "ui/viewres/gm/runtimehierarchy.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.CommonPropView = {
	container = "CommonPropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/common/commonpropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	customAnimBg = {
		"blackbg"
	},
	tabRes = {
		[2] = {
			{
				"ui/viewres/common/commonrighttipsview.prefab"
			}
		}
	}
}
module_views.CommonPropConvertView = {
	destroy = 0,
	container = "CommonPropConvertViewContainer",
	mainRes = "ui/viewres/summon/summonmaincharacterpropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	customAnimBg = {
		"blackbg"
	}
}
module_views.GiftMultipleChoiceView = {
	bgBlur = 1,
	container = "GiftMultipleChoiceViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/gift/giftmultiplechoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/gift/giftmultiplechoiceitem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.OptionalGiftMultipleChoiceView = {
	bgBlur = 1,
	container = "OptionalGiftMultipleChoiceViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/gift/giftmultiplechoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/gift/giftmultiplechoiceitem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.CustomPickChoiceView = {
	destroy = 0,
	container = "CustomPickChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/custompick/summoncustompickchoice.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.NewbieCustomPickView = {
	destroy = 0,
	container = "NewbieCustomPickViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/storenewbiechoosepickchoice.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SignInView = {
	bgBlur = 1,
	container = "SignInViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/signin/signinview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/signin/signinitem.prefab",
		[2] = SignInEnum.ResPath.lifecirclesignview,
		[3] = SignInEnum.ResPath.lifecirclesignrewardsitem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SignInDetailView = {
	destroy = 0,
	container = "SignInDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/signin/signindetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SigninPropView = {
	container = "SigninPropViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/signin/signinpropview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/signin/signinpropitem.prefab",
		[2] = "ui/viewres/common/commonpropitem.prefab"
	}
}
module_views.ActivityNormalView = {
	bgBlur = 1,
	container = "ActivityNormalViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/activity/activitynormalview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {}
}
module_views.ActivityNorSignView = {
	bgBlur = 0,
	container = "ActivityNorSignViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/activity/activitynorsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitynorsignitem.prefab"
	},
	customAnimBg = {}
}
module_views.ActivityBeginnerView = {
	bgBlur = 1,
	container = "ActivityBeginnerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/activity/activitybeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {}
}
module_views.ActivityNoviceInsightView = {
	destroy = 0,
	container = "ActivityNoviceInsightViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitynoviceinsightview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {}
}
module_views.ActivityTipView = {
	destroy = 0,
	container = "ActivityTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.MaterialTipView = {
	bgBlur = 1,
	container = "MaterialTipViewContainer",
	mainRes = "ui/viewres/tips/materialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	customAnimBg = {
		"bg"
	},
	otherRes = {
		IconMgrConfig.UrlItemIcon
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.PackageRewardDetailView = {
	destroy = 0,
	container = "PackageRewardDetailViewContainer",
	mainRes = "ui/viewres/tips/packagerewarddetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.MaterialPackageTipView = {
	container = "MaterialPackageTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tips/materialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.RoomManufactureMaterialTipView = {
	destroy = 0,
	container = "RoomManufactureMaterialTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcrittermaterialtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.HelpView = {
	bgBlur = 1,
	container = "HelpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/help/helpview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/help/helpselectitem.prefab",
		"ui/viewres/help/helpcontentitem.prefab",
		"ui/viewres/help/vahelpcontentitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {}
}
module_views.HelpPageTabView = {
	bgBlur = 1,
	container = "HelpPageTabViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/help/helppagetabview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/help/helpselectitem.prefab",
		"ui/viewres/help/helpcontentitem.prefab",
		"ui/viewres/help/vahelpcontentitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/help/helpview.prefab"
			}
		},
		{
			{
				"ui/viewres/help/helpcontentvideoitem.prefab"
			}
		}
	},
	customAnimBg = {}
}
module_views.LoadingView = {
	destroy = 999999,
	container = "LoadingViewContainer",
	mainRes = "ui/viewres/scene/loadingview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.LoadingBlackView = {
	destroy = 1,
	container = "LoadingBlackViewContainer",
	mainRes = "ui/viewres/scene/loadingblackview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LoadingBlackView2 = {
	destroy = 1,
	container = "LoadingBlackViewContainer",
	mainRes = "ui/viewres/scene/loadingblackview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		0.3,
		0.2
	}
}
module_views.LoadingRoomView = {
	destroy = 1,
	container = "LoadingRoomViewContainer",
	mainRes = "ui/viewres/scene/loadingroomview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		2,
		1.5
	}
}
module_views.LoadingDownloadView = {
	destroy = 1,
	container = "LoadingDownloadViewContainer",
	mainRes = "ui/viewres/scene/loadingdownloadview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "singlebg/loading/full/originbg.png"
	}
}
module_views.HeroGroupPresetTeamView = {
	destroy = 0,
	container = "HeroGroupPresetTeamViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/herogroup/herogrouppreteamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/herogroup/herogrouppreteamtabitem.prefab",
		"ui/viewres/herogroup/herogrouppreteamitem.prefab",
		"ui/viewres/herogroup/herogrouppreteamheroitem.prefab"
	}
}
module_views.HeroGroupFightView = {
	bgBlur = 4,
	container = "HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.HeroGroupFightRuleDescView = {
	destroy = 0,
	container = "HeroGroupFightRuleDescViewContainer",
	mainRes = "ui/viewres/herogroup/herogroupruledescview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a2_HeroGroupFightView = tabletool.copy(module_views.HeroGroupFightView)
module_views.V1a2_HeroGroupFightView.container = "V1a2_HeroGroupFightViewContainer"
module_views.V1a2_HeroGroupFightView.mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_herogroupview.prefab"
module_views.V1a3_HeroGroupFightView = tabletool.copy(module_views.HeroGroupFightView)
module_views.V1a3_HeroGroupFightView.container = "V1a3_HeroGroupFightViewContainer"
module_views.V1a5_HeroGroupFightView = tabletool.copy(module_views.HeroGroupFightView)
module_views.V1a5_HeroGroupFightView.container = "V1a5_HeroGroupFightViewContainer"
module_views.V1a6_HeroGroupFightView = tabletool.copy(module_views.HeroGroupFightView)
module_views.V1a6_HeroGroupFightView.container = "V1a6_HeroGroupFightViewContainer"
module_views.HeroGroupFightWeekwalkView = tabletool.copy(module_views.HeroGroupFightView)
module_views.HeroGroupFightWeekwalkView.container = "HeroGroupFightWeekwalkViewContainer"
module_views.VersionActivity2_8HeroGroupBossView = tabletool.copy(module_views.HeroGroupFightView)
module_views.VersionActivity2_8HeroGroupBossView.container = "VersionActivity2_8HeroGroupBossViewContainer"
module_views.Rouge2_BossHeroGroupFightView = tabletool.copy(module_views.HeroGroupFightView)
module_views.Rouge2_BossHeroGroupFightView.container = "Rouge2_BossHeroGroupFightViewContainer"
module_views.HeroGroupFightFiveHeroView = tabletool.copy(module_views.HeroGroupFightView)
module_views.HeroGroupFightFiveHeroView.container = "HeroGroupFightFiveHeroViewContainer"
module_views.HeroGroupFightFiveHeroView.mainRes = "ui/viewres/herogroup/herogroupfiveheroview.prefab"
module_views.HeroGroupFightWeekwalk_2View = tabletool.copy(module_views.HeroGroupFightView)
module_views.HeroGroupFightWeekwalk_2View.otherRes.weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
module_views.HeroGroupFightWeekwalk_2View.container = "HeroGroupFightWeekwalk_2ViewContainer"
module_views.HeroGroupBalanceTipView = {
	destroy = 0,
	container = "HeroGroupBalanceTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/herogroup/herogroupbalancetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.HeroGroupModifyNameView = {
	bgBlur = 3,
	container = "HeroGroupModifyNameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herogroupmodifynameview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.HeroGroupPresetModifyNameView = {
	destroy = 0,
	container = "HeroGroupPresetModifyNameViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/herogroup/herogrouppremodifynameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.HeroGroupRecommendView = {
	bgBlur = 1,
	container = "HeroGroupRecommendViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herogrouprecomendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogrouprecommendcharacter.prefab",
		[2] = "ui/viewres/herogroup/herogrouprecommendgroup.prefab"
	}
}
module_views.HeroGroupEditView = {
	container = "HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/herogroup/herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.HeroGroupPresetEditView = {
	container = "HeroGroupPresetEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/herogroup/herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.HeroGroupCareerTipView = {
	destroy = 0,
	container = "HeroGroupCareerTipViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/herogroup/herogroupcareertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_bg/bg"
	}
}
module_views.BaseEnemyInfoView = {
	bgBlur = 1,
	container = "BaseEnemyInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/enemyinfo/baseenemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg_container/#simage_bg",
		"bg_container/#simage_rightbg"
	},
	otherRes = {
		FightEntityResistanceComp.FightResistancePath
	}
}
module_views.WeekWalk_2EnemyInfoView = {
	bgBlur = 1,
	container = "BaseEnemyInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/enemyinfo/baseenemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg_container/#simage_bg",
		"bg_container/#simage_rightbg"
	},
	otherRes = {
		FightEntityResistanceComp.FightResistancePath,
		weekwalkheart_star = "ui/viewres/weekwalk/weekwalkheart/weekwalkheart_star.prefab"
	}
}
module_views.FightAttributeTipView = {
	destroy = 0,
	container = "FightAttributeTipViewContainer",
	mainRes = "ui/viewres/fight/fightattributetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SkillTipView = {
	destroy = 0,
	container = "SkillTipViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/tips/skilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_newskilltip/skillbg"
	}
}
module_views.SkillTipView3 = {
	bgBlur = 1,
	container = "SkillTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/tips/skilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_newskilltip/skillbg"
	}
}
module_views.CommonBuffTipView = {
	destroy = 10,
	container = "CommonBuffTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/commonbufftipview/commonbufftipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.PlayerClothView = {
	bgBlur = 1,
	container = "PlayerClothViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/playerclothview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"frame/imgBg",
		"titlebg"
	}
}
module_views.PlayerClothGuideView = {
	destroy = 0,
	container = "PlayerClothGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/playerclothguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.MailView = {
	bgBlur = 1,
	container = "MailViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/mail/mailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/mail/mailcategoryitem.prefab",
		[2] = "ui/viewres/mail/mailrewarditem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"mailtipview/bg/#simage_mailBg",
		"bg"
	}
}
module_views.ProtoTestView = {
	destroy = 0,
	container = "ProtoTestViewContainer",
	mainRes = "ui/viewres/gm/prototestview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ProtoModifyView = {
	destroy = 0,
	container = "ProtoModifyViewContainer",
	mainRes = "ui/viewres/gm/protomodifyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.DungeonPuzzleChangeColorView = {
	destroy = 0,
	container = "DungeonPuzzleChangeColorViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlechangecolorview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PlayerView = {
	destroy = 0,
	container = "PlayerViewContainer",
	mainRes = "ui/viewres/player/playerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	},
	otherRes = {
		[1] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
module_views.PlayerChangeBgView = {
	destroy = 0,
	container = "PlayerChangeBgViewContainer",
	mainRes = "ui/viewres/player/playerchangebgview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PlayerChangeBgListView = {
	destroy = 0,
	container = "PlayerChangeBgListViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/player/playerchangebglistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.ShowCharacterView = {
	container = "ShowCharacterViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/showcharacterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/player/showcharactercarditem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.IconTipView = {
	bgBlur = 1,
	container = "IconTipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/icontipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/player/iconitem.prefab"
	},
	customAnimBg = {
		"window/FrameBg",
		"window/leftBg",
		"window/#simage_titleBg"
	}
}
module_views.CharacterDataView = {
	container = "CharacterDataViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/character/characterdata/characterdataview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/character/characterdata/characterdatatitleview.prefab"
			},
			{
				"ui/viewres/character/characterdata/characterdatavoiceview.prefab"
			},
			{
				"ui/viewres/character/characterdata/characterdataitemview.prefab"
			},
			{
				"ui/viewres/character/characterdata/characterdatacultureview.prefab"
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/character/characterdata/charactervoiceitem.prefab"
	},
	customAnimBg = {
		"bottom/#go_bottombg",
		"content1/1view/CharacterDataTitleView/bg"
	}
}
module_views.CharacterDataUttuView = {
	destroy = 0,
	container = "CharacterDataUttuViewContainer",
	mainRes = "ui/viewres/character/characterdata/characterdatauttuview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg"
	}
}
module_views.CommonInputView = {
	destroy = 0,
	container = "CommonInputViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/common/commoninputview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"imgBg",
		"imgBg2"
	}
}
module_views.TaskView = {
	bgBlur = 1,
	container = "TaskViewContainer",
	mainRes = "ui/viewres/task/taskview.prefab",
	destroy = 0,
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/task/taskcommonitem.prefab",
		"ui/viewres/task/tasknovicenormalitem.prefab",
		"ui/viewres/task/tasknovicegrowitem.prefab",
		"ui/viewres/task/tasknovicespitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/task/tasknoviceview.prefab"
			},
			{
				"ui/viewres/task/taskdailyview.prefab"
			},
			{
				"ui/viewres/task/taskweeklyview.prefab"
			}
		}
	},
	preloader = module_views_preloader
}
module_views.SettingsView = {
	container = "SettingsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/settings/settingsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		0,
		0.14
	},
	otherRes = {
		[1] = "ui/viewres/settings/settingscategorylistitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/settings/settingspcview.prefab"
			},
			{
				"ui/viewres/settings/settingsaccountview.prefab"
			},
			{
				"ui/viewres/settings/settingsgraphicsview.prefab"
			},
			{
				"ui/viewres/settings/settingssoundview.prefab"
			},
			{
				"ui/viewres/settings/settingspushview.prefab"
			},
			{
				"ui/viewres/settings/settingslanguageview.prefab"
			},
			{
				"ui/viewres/settings/settingsgameview.prefab"
			},
			{
				"ui/viewres/settings/settingsfightview.prefab"
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.SettingsVoicePackageView = {
	bgBlur = 1,
	container = "SettingsVoicePackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/settings/settingsvoicepackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/settings/settingsvoicepackagelistitem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.SettingsVoiceDownloadView = {
	destroy = 0,
	container = "SettingsVoiceDownloadViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/settings/settingsvoicedownloadview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.SettingsVoicePackageTopView = {
	destroy = 0,
	container = "SettingsVoicePackageViewContainer",
	mainRes = "ui/viewres/settings/settingsvoicepackageview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/settings/settingsvoicepackagelistitem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.SettingsCdkeyView = {
	destroy = 0,
	container = "SettingsCdkeyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/settings/settingscdkeyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.KeyMapAlertView = {
	destroy = 0,
	container = "KeyMapAlertViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/pc/pcbuttonconfirmview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SettingsRoleVoiceView = {
	container = "SettingsRoleVoiceViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herovoiceeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/common/item/commonheroitemnew.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.GuideView = {
	destroy = 100,
	container = "GuideViewContainer",
	mainRes = "ui/viewres/guide/guideview.prefab",
	layer = "GUIDE",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/effect/edge/ui_edge_square_red.prefab",
		[2] = "ui/viewres/effect/edge/ui_edge_square_yellow.prefab"
	}
}
module_views.GuideView2 = {
	destroy = 0,
	container = "GuideViewContainer",
	mainRes = "ui/viewres/guide/guideview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/effect/edge/ui_edge_square_red.prefab",
		[2] = "ui/viewres/effect/edge/ui_edge_square_yellow.prefab"
	}
}
module_views.GuideStepEditor = {
	destroy = 0,
	container = "GuideStepEditorContainer",
	mainRes = "ui/viewres/guide/guidestepeditor.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/effect/edge/ui_edge_square_red.prefab",
		[2] = "ui/viewres/effect/edge/ui_edge_square_red.prefab"
	}
}
module_views.StoreView = {
	container = "StoreViewContainer",
	monthCardRes = "ui/viewres/store/storemonthcardview.prefab",
	destroy = 0,
	mainRes = "ui/viewres/store/storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				"ui/viewres/store/normalstoreview.prefab"
			},
			{
				"ui/viewres/store/chargestoreview.prefab"
			},
			{
				"ui/viewres/store/storeskinview2.prefab"
			},
			{
				"ui/viewres/store/packagestoreview.prefab"
			},
			{
				"ui/viewres/store/recommendstoreview.prefab"
			},
			{
				"ui/viewres/store/roomstoreview.prefab"
			},
			{
				"ui/viewres/store/decoratestoreview.prefab"
			},
			{
				"ui/viewres/store/monthandseasoncardview.prefab"
			}
		},
		{
			{
				"ui/viewres/store/storemonthcardview.prefab"
			},
			{
				"ui/viewres/store/giftpacksview.prefab"
			},
			{
				"ui/viewres/battlepass/bpenterview.prefab"
			},
			{
				"ui/viewres/store/storenewbiechooseview.prefab"
			},
			{
				"ui/viewres/store/storeroleskinview.prefab"
			},
			{
				"ui/viewres/store/storeblockpackageview.prefab"
			},
			[8] = {
				"ui/viewres/store/v1a4_giftrecommendview2.prefab"
			},
			[9] = {
				"ui/viewres/store/storeseasoncardview.prefab"
			},
			[10] = {
				"ui/viewres/store/storeskinbagview.prefab"
			}
		},
		{
			{
				"ui/viewres/store/roomcritterstoreview.prefab"
			}
		},
		{
			{
				"ui/viewres/store/storesummonview.prefab"
			}
		},
		{
			{
				"ui/viewres/store/storemonthcardview.prefab"
			},
			{
				"ui/viewres/store/storeseasoncardview.prefab"
			}
		}
	},
	otherRes = {
		"ui/viewres/store/normalstoregoodsitem.prefab",
		"ui/viewres/store/chargestoregoodsitem.prefab",
		"ui/viewres/store/storeskingoodsitem3.prefab",
		"ui/viewres/store/packagestoregoodsitem.prefab",
		"ui/viewres/store/summonstoregoodsitem.prefab",
		"ui/viewres/store/decoratestoreitem.prefab",
		misihaiitem = "ui/viewres/player/playercard/playercardachieve_misihai.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab"
	},
	customAnimBg = {
		"#go_store/bg"
	}
}
module_views.StoreSkinConfirmView = {
	bgBlur = 1,
	container = "StoreSkinConfirmViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/store/storeskinconfirmview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.DecorateStoreDefaultShowView = {
	destroy = 0,
	container = "DecorateStoreDefaultShowViewContainer",
	mainRes = "ui/viewres/store/decoratestoredefaultshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.DecorateMultiGoodsTipsView = {
	destroy = 0,
	container = "DecorateMultiGoodsTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/decoratemultigoodstipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.StoreSkinDefaultShowView = {
	destroy = 0,
	container = "StoreSkinDefaultShowViewContainer",
	mainRes = "ui/viewres/store/decoratestoredefaultshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.StoreTipView = {
	bgBlur = 1,
	container = "StoreTipViewContainer",
	maskAlpha = 0.5,
	mainRes = "ui/viewres/store/storetipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default
}
module_views.StoreSkinPreviewView = {
	destroy = 0,
	container = "StoreSkinPreviewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/character/characterskinview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.StoreSkinGoodsView = {
	bgBlur = 1,
	container = "StoreSkinGoodsViewContainer",
	mainRes = "ui/viewres/store/storeskingoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.StoreSkinGoodsView2 = {
	bgBlur = 1,
	container = "StoreSkinGoodsView2Container",
	mainRes = "ui/viewres/store/storeskingoodsview2.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.NormalStoreGoodsView = {
	container = "NormalStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.SurvivalStoreGoodsView = {
	container = "SurvivalStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.ChargeStoreGoodsView = {
	destroy = 0,
	container = "ChargeStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/chargestoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.DecorateStoreGoodsView = {
	bgBlur = 1,
	container = "DecorateStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/decoratestoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.DecorateStoreGoodsTipView = {
	bgBlur = 1,
	container = "DecorateStoreGoodsTipViewContainer",
	mainRes = "ui/viewres/room/roommaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.DecorateStoreGoodsBuyView = {
	bgBlur = 1,
	container = "DecorateStoreGoodsBuyViewContainer",
	mainRes = "ui/viewres/room/roommaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.PackageStoreGoodsView = {
	container = "PackageStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/packagestoregoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.StoreLinkGiftGoodsView = {
	container = "StoreLinkGiftGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/storelinkgiftgoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.SummonStoreGoodsView = {
	container = "SummonStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/summonstoregoodsview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.SocialView = {
	bgBlur = 1,
	container = "SocialViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/social/socialview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/social/socialfrienditem.prefab",
		"ui/viewres/social/socialrequestitem.prefab",
		"ui/viewres/social/socialsearchitem.prefab",
		"ui/viewres/social/socialblacklistitem.prefab",
		"ui/viewres/social/socialmessageitem.prefab",
		"ui/viewres/social/socialheroitem.prefab",
		"ui/viewres/social/socialcontentitem.prefab",
		"ui/viewres/achievement/achievementmainicon.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/social/socialfriendsview.prefab"
			},
			{
				"ui/viewres/social/socialsearchview.prefab"
			},
			{
				"ui/viewres/social/socialrequestview.prefab"
			},
			{
				"ui/viewres/social/socialblacklistview.prefab"
			}
		}
	},
	customAnimBg = {
		"hasbg"
	}
}
module_views.SocialRemarkTipView = {
	destroy = 0,
	container = "SocialRemarkTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/social/socialremarktipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.InformPlayerTipView = {
	destroy = 0,
	container = "InformPlayerTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tips/informplayertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.PlayerInfoView = {
	destroy = 0,
	container = "PlayerInfoViewContainer",
	mainRes = "ui/viewres/social/playerinfoview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	}
}
module_views.NoticeView = {
	destroy = 0,
	container = "NoticeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/notice/noticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bg"
	}
}
module_views.EffectStatView = {
	destroy = 0,
	container = "EffectStatViewContainer",
	mainRes = "ui/viewres/effect/effectstatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.PlayerLevelUpView = {
	destroy = 0,
	container = "PlayerLevelUpViewContainer",
	maskAlpha = 0.5,
	mainRes = "ui/viewres/player/playerlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_bgbar"
	}
}
module_views.Signature = {
	destroy = 0,
	container = "SignatureContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/signature.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"window"
	}
}
module_views.PlayerModifyNameView = {
	destroy = 0,
	container = "PlayerModifyNameViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/playermodifynameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"window"
	}
}
module_views.RoomView = {
	destroy = 0,
	container = "RoomViewContainer",
	mainRes = "ui/viewres/room/roomview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/roombackblockview.prefab"
			},
			{
				"ui/viewres/room/roomwaterreformview.prefab"
			}
		},
		{
			{
				RoomViewConfirm.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/layout/roomlayoutvisitplan.prefab"
			}
		},
		{
			{
				"ui/viewres/room/fish/roomfishview.prefab"
			}
		}
	},
	otherRes = {
		"ui/viewres/room/debug/roomdebugbuildingitem.prefab",
		"ppassets/uixiaowumask.prefab",
		"ui/viewres/room/roomtopright.prefab",
		"ui/viewres/room/mainview/roomviewtaskitem.prefab",
		"ui/viewres/room/mainview/roomnavigatebubbleitem.prefab",
		"ui/viewres/room/debug/roomdebugplaceitem.prefab",
		"ui/viewres/room/debug/roomdebugpackageitem.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterinteractionui.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterui.prefab",
		"ui/viewres/room/sceneui/roomsceneproductionlineui.prefab",
		"ui/viewres/room/sceneui/roomscenemanufactureui.prefab",
		RoomViewUITransportSiteItem.prefabPath,
		RoomViewUICritterEventItem.prefabPath,
		RoomViewUIFishingItem.prefabPath,
		RoomViewUIFishingFriendItem.prefabPath
	}
}
module_views.RoomDebugView = {
	destroy = 0,
	container = "RoomDebugViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/room/debug/roomdebugbuildingitem.prefab",
		"ppassets/uixiaowumask.prefab",
		"ui/viewres/room/roomtopright.prefab",
		"ui/viewres/room/mainview/roomviewtaskitem.prefab",
		"ui/viewres/room/mainview/roomnavigatebubbleitem.prefab",
		"ui/viewres/room/debug/roomdebugplaceitem.prefab",
		"ui/viewres/room/debug/roomdebugpackageitem.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterinteractionui.prefab",
		"ui/viewres/room/sceneui/roomscenecharacterui.prefab",
		"ui/viewres/room/sceneui/roomsceneproductionlineui.prefab"
	}
}
module_views.RoomDebugBuildingAreaView = {
	destroy = 0,
	container = "RoomDebugBuildingAreaViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugbuildingareaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {}
}
module_views.RoomDebugBuildingCameraView = {
	destroy = 0,
	container = "RoomDebugBuildingCameraViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugbuildingcameraview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {}
}
module_views.RoomDebugThemeFilterView = {
	destroy = 0,
	container = "RoomDebugThemeFilterViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/room/debug/roomdebugthemefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomBuildingInteractionView = {
	destroy = 0,
	container = "RoomBuildingInteractionViewContainer",
	mainRes = "ui/viewres/room/roombuildinginteractionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {}
}
module_views.RoomInventorySelectView = {
	destroy = 0,
	container = "RoomInventorySelectViewContainer",
	mainRes = "ui/viewres/room/roominventoryselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				RoomViewBuilding.prefabPath
			}
		},
		{
			{
				RoomTransportPathFailTips.prefabPath
			}
		}
	}
}
module_views.RoomTipsView = {
	destroy = 0,
	container = "RoomTipsViewContainer",
	mainRes = "ui/viewres/room/roomtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RoomBlockPackageView = {
	bgBlur = 0,
	container = "RoomBlockPackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/room/roomblockpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/room/roomtopright.prefab"
	}
}
module_views.RoomThemeTipView = {
	destroy = 0,
	container = "RoomThemeTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomthemetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomMaterialTipView = {
	bgBlur = 1,
	container = "RoomMaterialTipViewContainer",
	mainRes = "ui/viewres/room/roommaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.RoomStoreGoodsTipView = {
	bgBlur = 1,
	container = "RoomStoreGoodsTipViewContainer",
	mainRes = "ui/viewres/room/roommaterialtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoomInitBuildingView = {
	destroy = 0,
	container = "RoomInitBuildingViewContainer",
	mainRes = "ui/viewres/room/roominitbuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/room/roomtopright.prefab",
		[2] = IconMgrConfig.UrlRoomGoodsItemIcon
	}
}
module_views.RoomLevelUpView = {
	destroy = 0,
	container = "RoomLevelUpViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/room/roomlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomLevelUpTipsView = {
	destroy = 0,
	container = "RoomLevelUpTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomleveluptipsview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomBuildingFilterView = {
	destroy = 0,
	container = "RoomBuildingFilterViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/room/roombuildingfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomThemeFilterView = {
	destroy = 0,
	container = "RoomThemeFilterViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/room/roomthemefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomMiniMapView = {
	destroy = 0,
	container = "RoomMiniMapViewContainer",
	mainRes = "ui/viewres/room/roomminimapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomFormulaView = {
	destroy = 0,
	container = "RoomFormulaViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/room/roomformulaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/room/roomformulaitem.prefab",
		[2] = "ui/viewres/room/roomtopright.prefab",
		[3] = IconMgrConfig.UrlRoomGoodsItemIcon
	}
}
module_views.RoomFormulaMsgBoxView = {
	destroy = 0,
	container = "RoomFormulaMsgBoxViewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomformulaviewmsgboxview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoomProductLineLevelUpView = {
	destroy = 0,
	container = "RoomProductLineLevelUpViewContainer",
	maskAlpha = 0,
	bgBlur = 3,
	mainRes = "ui/viewres/room/roomproductlinelevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomStrengthView = {
	destroy = 0,
	container = "RoomStrengthViewContainer",
	mainRes = "ui/viewres/room/roomstrengthview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.RoomCommonStrengthView = {
	destroy = 0,
	container = "RoomCommonStrengthViewContainer",
	mainRes = "ui/viewres/room/roomcommonstrengthview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/room/roomtopright.prefab"
	}
}
module_views.RoomAccelerateView = {
	destroy = 0,
	container = "RoomAccelerateViewContainer",
	mainRes = "ui/viewres/room/roomaccelerateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.RoomCharacterPlaceView = {
	destroy = 0,
	container = "RoomCharacterPlaceViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/room/roomcharacterplaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/room/roomcharacterplaceitem.prefab",
		[2] = "ui/viewres/room/roomtopright.prefab"
	}
}
module_views.RoomCharacterPlaceInfoView = {
	destroy = 0,
	container = "RoomCharacterPlaceInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomcharacterplaceinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/room/roomcharacterplaceitem.prefab"
	}
}
module_views.RoomDebugEntranceView = {
	destroy = 0,
	container = "RoomDebugEntranceViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugentranceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomDebugSelectPackageView = {
	destroy = 0,
	container = "RoomDebugSelectPackageViewContainer",
	mainRes = "ui/viewres/room/debug/roomdebugselectpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomOpenGuideView = {
	destroy = 0,
	container = "RoomOpenGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roomopenguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomGuideView = {
	destroy = 0,
	container = "RoomGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomSceneTaskDetailView = {
	bgBlur = 1,
	container = "RoomSceneTaskDetailViewContainer",
	mainRes = "ui/viewres/room/roomtaskdetailview.prefab",
	destroy = 0,
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomBlockPackageGetView = {
	bgBlur = 1,
	container = "RoomBlockPackageGetViewContainer",
	mainRes = "ui/viewres/room/roomblockpackagegetview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.RoomBranchView = {
	destroy = 0,
	container = "RoomBranchViewContainer",
	mainRes = "ui/viewres/room/roombranchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RoomInformPlayerView = {
	destroy = 0,
	container = "RoomInformPlayerViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/roominformplayerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/common/viewframe/commonwindow01.prefab"
			}
		}
	}
}
module_views.RoomLayoutView = {
	bgBlur = 1,
	container = "RoomLayoutViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/room/layout/roomlayoutview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RoomLayoutItem.prefabUrl
	}
}
module_views.RoomLayoutItemTips = {
	destroy = 0,
	container = "RoomLayoutItemTipsContainer",
	mainRes = "ui/viewres/room/layout/roomlayoutitemtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RoomLayoutBgSelectView = {
	destroy = 0,
	container = "RoomLayoutBgSelectViewContainer",
	mainRes = "ui/viewres/room/layout/roomlayoutbgselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RoomLayoutCreateTipsView = {
	destroy = 0,
	container = "RoomLayoutCreateTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcreatetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomLayoutCopyView = {
	destroy = 0,
	container = "RoomLayoutCopyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomLayoutRenameView = {
	destroy = 0,
	container = "RoomLayoutRenameViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomLayoutFindShareView = {
	destroy = 0,
	container = "RoomLayoutFindShareViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomTransportPathView = {
	destroy = 0,
	container = "RoomTransportPathViewContainer",
	mainRes = "ui/viewres/room/transport/roomtransportpathview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RoomTransportPathFailTips.prefabPath
			}
		}
	}
}
module_views.RoomTransportSiteView = {
	destroy = 0,
	container = "RoomTransportSiteViewContainer",
	mainRes = "ui/viewres/room/transport/roomtransportsiteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RoomTransportBuildingItem.prefabPath,
		RoomTransportBuildingSkinItem.prefabPath,
		RoomTransportCritterItem.prefabPath
	}
}
module_views.RoomInteractBuildingView = {
	destroy = 0,
	container = "RoomInteractBuildingViewContainer",
	mainRes = "ui/viewres/room/transport/roominteractbuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RoomInteractCharacterItem.prefabUrl
	}
}
module_views.RoomManufacturePlaceCostView = {
	destroy = 0,
	container = "RoomManufacturePlaceCostViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roommanufactureplacecostview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomFishingStoreView = {
	destroy = 0,
	container = "RoomFishingStoreViewContainer",
	mainRes = "ui/viewres/room/fish/roomfishstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomFishingRewardView = {
	destroy = 0,
	container = "RoomFishingRewardViewContainer",
	mainRes = "ui/viewres/room/fish/roomfishrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.HandbookView = {
	destroy = 0,
	container = "HandbookViewContainer",
	mainRes = "ui/viewres/handbook/handbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.HandbookStoryView = {
	destroy = 0,
	container = "HandbookStoryViewContainer",
	mainRes = "ui/viewres/handbook/handbookstoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/handbook/handbookstoryitem.prefab"
	}
}
module_views.HandbookCGView = {
	destroy = 0,
	container = "HandbookCGViewContainer",
	mainRes = "ui/viewres/handbook/handbookcgview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/handbook/handbookcgitem.prefab"
	}
}
module_views.HandbookCGDetailView = {
	destroy = 0,
	container = "HandbookCGDetailViewContainer",
	mainRes = "ui/viewres/handbook/handbookcgdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.HandBookCharacterSwitchView = {
	destroy = 0,
	container = "HandBookCharacterSwitchViewContainer",
	mainRes = "ui/viewres/handbook/handbookcharacterswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.HandbookEquipView = {
	destroy = 0,
	container = "HandbookEquipViewContainer",
	mainRes = "ui/viewres/handbook/handbookequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.HandbookSkinView = {
	destroy = 0,
	container = "HandbookSkinViewContainer",
	mainRes = "ui/viewres/handbook/new/skinbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = HandbookEnum.SkinSceneAsset
}
module_views.HandbookSkinSuitDetailView1_8 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView1_8Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_1_8.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView1_9 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView1_9Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_1_9.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_0 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_0Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_0.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_3 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_3Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_1 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_1Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_1.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_2 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_2Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_4 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_4Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_4.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_5 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_5Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_5.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_8 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_8Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_8.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_9 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_9Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_9.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_0 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_0Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_0.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_1 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_1Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_1.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_2 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_2Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_3 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_3Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_3_1 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_3_1Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_3_1.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_4 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_4Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_4.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_5 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_5Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_5.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_7 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_7Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_7.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_8 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_8Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_8.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_8_5 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_8_5Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_8_5.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_8_5_1 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_8_5_1Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_1_4.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_9 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_9Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_9.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView3_9_1 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView3_9_1Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_3_9_1.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView1_7 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView1_7Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_1_7.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_6 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_6Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_6.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.HandbookSkinSuitDetailView2_7 = {
	destroy = 0,
	container = "HandbookSkinSuitDetailView2_7Container",
	mainRes = "ui/viewres/skinhandbook/skinsuitdetailview_2_7.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/skinhandbook/skinsuitdetailviewbtns.prefab"
	}
}
module_views.EquipFilterView = {
	destroy = 10,
	container = "EquipFilterViewContainer",
	mainRes = "ui/viewres/handbook/equipfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.HandbookWeekWalkView = {
	destroy = 0,
	container = "HandbookWeekWalkViewContainer",
	mainRes = "ui/viewres/handbook/handbookweekwalkview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.HandbookWeekWalkMapView = {
	destroy = 0,
	container = "HandbookWeekWalkMapViewContainer",
	mainRes = "ui/viewres/handbook/handbookweekwalkmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TeachNoteView = {
	destroy = 0.5,
	container = "TeachNoteViewContainer",
	mainRes = "ui/viewres/teach/teachnoteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/teach/teachnoterewarditem.prefab"
	}
}
module_views.TeachNoteDetailView = {
	destroy = 0,
	container = "TeachNoteDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/teach/teachnotedetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.EndOfDreamView = {
	destroy = 0,
	container = "EndOfDreamViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/endofdream/endofdreamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonPuzzlePipeView = {
	destroy = 0,
	container = "DungeonPuzzlePipeViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlepipeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/dungeon/puzzle/dungeonpipeitem.prefab",
		[2] = "ui/viewres/dungeon/puzzle/dungeonpipeconnectitem.prefab"
	}
}
module_views.DungeonPuzzleCircuitView = {
	destroy = 0,
	container = "DungeonPuzzleCircuitViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlecircuitview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {}
}
module_views.DungeonPuzzleQuestionView = {
	destroy = 0,
	container = "DungeonPuzzleQuestionViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlequestionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonPuzzleMazeDrawView = {
	destroy = 0,
	container = "DungeonPuzzleMazeDrawViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzlemazedrawview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/dungeon/puzzle/dungeonmazeitem.prefab",
		"ui/viewres/dungeon/puzzle/dungeonpuzzlemazepath.prefab",
		"ui/viewres/dungeon/puzzle/dungeonmazepawn.prefab"
	}
}
module_views.DungeonMazeView = {
	destroy = 0,
	container = "DungeonMazeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonexploreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonexploreview_wordcontent.prefab",
		[2] = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonexploreview_wordeffect.prefab"
	}
}
module_views.DungeonMazeResultView = {
	destroy = 0,
	container = "DungeonMazeResultViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonMazeV3a7View = {
	destroy = 0,
	container = "DungeonMazeV3a7ViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_dungeonmaze/v3a7_dungeonexploreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_7/v3a7_dungeonmaze/v3a7_dungeonexploreview_wordcontent.prefab",
		[2] = "ui/viewres/versionactivity_3_7/v3a7_dungeonmaze/v3a7_dungeonexploreview_wordeffect.prefab"
	}
}
module_views.DungeonMazeV3a7ResultView = {
	destroy = 0,
	container = "DungeonMazeV3a7ResultViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_dungeonmaze/v3a7_dungeonresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonJumpGameView = {
	destroy = 0,
	container = "DungeonJumpGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeon_jumpview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonJumpGameResultView = {
	destroy = 0,
	container = "DungeonJumpGameResultViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeon_jumpresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.PutCubeGameView = {
	destroy = 0,
	container = "PutCubeGameViewContainer",
	mainRes = "ui/viewres/dungeon/puzzle/putcubegameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PushBoxView = {
	destroy = 0,
	container = "PushBoxViewContainer",
	mainRes = "ui/viewres/pushbox/pushboxview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityPushBoxLevelView = {
	destroy = 0,
	container = "VersionActivityPushBoxLevelViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitypushboxlevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityPushBoxGameView = {
	destroy = 0,
	container = "VersionActivityPushBoxGameViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitypushboxgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityPushBoxTaskView = {
	destroy = 0,
	container = "VersionActivityPushBoxTaskViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitypushboxtaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DungeonSeasonMainView = {
	destroy = 0,
	container = "DungeonSeasonMainViewContainer",
	mainRes = "ui/viewres/dungeon/season/dungeonSeasonMainView.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivityEnterView = {
	destroy = 0,
	container = "VersionActivityEnterViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityVideoView = {
	destroy = 0,
	container = "VersionActivityVideoViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.VersionActivityMainView = {
	bgBlur = 1,
	container = "VersionActivityMainViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity/versionactivitymainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityTaskView = {
	bgBlur = 3,
	container = "VersionActivityTaskViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitytaskview.prefab",
	destroy = 0,
	blurFactor = 0.64,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity/versionactivitytaskitem.prefab"
	}
}
module_views.VersionActivityNewsView = {
	destroy = 0,
	container = "VersionActivityNewsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitynewsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivityStoreView = {
	destroy = 0,
	container = "VersionActivityStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitystoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivityNormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivityNormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivityPuzzleView = {
	destroy = 0,
	container = "VersionActivityPuzzleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitypuzzleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V1a6_CachotEnterView = {
	destroy = 0,
	container = "V1a6_CachotEnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_CachotMainView = {
	destroy = 0,
	container = "V1a6_CachotMainViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_mainview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_CachotRoomView = {
	destroy = 0,
	container = "V1a6_CachotRoomViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_roomview.prefab",
	layer = "HUD",
	viewType = ViewType.Normal
}
module_views.V1a6_CachotCollectionView = {
	destroy = 0,
	container = "V1a6_CachotCollectionViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotDifficultyView = {
	bgBlur = 1,
	container = "V1a6_CachotDifficultyViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_difficultyview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotResultView = {
	destroy = 0,
	container = "V1a6_CachotResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_CachotFinishView = {
	destroy = 0,
	container = "V1a6_CachotFinishViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_finishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotEndingView = {
	destroy = 0,
	container = "V1a6_CachotEndingViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_endingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotRewardView = {
	destroy = 0,
	container = "V1a6_CachotRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.V1a6_CachotTeamView = {
	destroy = 0,
	container = "V1a6_CachotTeamViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_CachotTeamPreView = {
	destroy = 0,
	container = "V1a6_CachotTeamPreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_CachotHeroGroupFightView = {
	bgBlur = 4,
	container = "V1a6_CachotHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.V1a6_CachotHeroGroupEditView = {
	container = "V1a6_CachotHeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.V1a6_CachotLoadingView = {
	destroy = 0,
	container = "V1a6_CachotLoadingViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_loadingview.prefab",
	layer = "TOP",
	viewType = ViewType.Full
}
module_views.V1a6_CachotLayerChangeView = {
	bgBlur = 1,
	container = "V1a6_CachotLayerChangeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_leveljumpview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotTipsView = {
	destroy = 0,
	container = "V1a6_CachotTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_tipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.V1a6_CachotStoreView = {
	destroy = 0,
	container = "V1a6_CachotStoreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.V1a6_CachotEpisodeView = {
	destroy = 0,
	container = "V1a6_CachotEpisodeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/episode/v1a6_cachot_episodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.V1a6_CachotNormalStoreGoodsView = {
	destroy = 0,
	container = "V1a6_CachotNormalStoreGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_storegoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.V1a6_CachotCollectionView = {
	destroy = 0,
	container = "V1a6_CachotCollectionViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionitem.prefab"
	}
}
module_views.V1a6_CachotCollectionBagView = {
	destroy = 0,
	container = "V1a6_CachotCollectionBagViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionbagview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionbagitem.prefab"
	}
}
module_views.V1a6_CachotCollectionGetView = {
	destroy = 0,
	container = "V1a6_CachotCollectionGetViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectiongetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotCollectionSelectView = {
	destroy = 0,
	container = "V1a6_CachotCollectionSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotCollectionEnchantView = {
	destroy = 0,
	container = "V1a6_CachotCollectionEnchantViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionenchantview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionbagitem.prefab"
	}
}
module_views.V1a6_CachotCollectionUnlockedView = {
	destroy = 0,
	container = "V1a6_CachotCollectionUnlockedViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionunlockedview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotCollectionOverView = {
	destroy = 0,
	container = "V1a6_CachotCollectionOverViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_collectionoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.V1a6_CachotProgressView = {
	destroy = 0,
	container = "V1a6_CachotProgressViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_progressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_progressitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_CachotUpgradeView = {
	destroy = 0,
	container = "V1a6_CachotUpgradeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_upgradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab"
	}
}
module_views.V1a6_CachotUpgradeResultView = {
	destroy = 0,
	container = "V1a6_CachotUpgradeResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_upgraderesultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab"
	}
}
module_views.V1a6_CachotRoleRecoverView = {
	destroy = 0,
	container = "V1a6_CachotRoleRecoverViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerecoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
module_views.V1a6_CachotRoleRecoverResultView = {
	destroy = 0,
	container = "V1a6_CachotRoleRecoverResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerecoverresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
module_views.V1a6_CachotRoleRevivalView = {
	destroy = 0,
	container = "V1a6_CachotRoleRevivalViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerevivalview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
module_views.V1a6_CachotRoleRevivalResultView = {
	destroy = 0,
	container = "V1a6_CachotRoleRevivalResultViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_rolerevivalresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teampresetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_teamprepareitem.prefab"
	}
}
module_views.V1a6_CachotEquipInfoTeamShowView = {
	bgBlur = 1,
	container = "V1a6_CachotEquipInfoTeamShowViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_equipinfoteamshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/equip/equipinfoteamshowitem.prefab"
	}
}
module_views.VersionActivity1_3AstrologyView = {
	destroy = 0,
	container = "VersionActivity1_3AstrologyViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyplanetitem.prefab",
		[2] = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyplateview.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyplateview.prefab"
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyselectview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologyresultview.prefab"
			}
		}
	}
}
module_views.VersionActivity1_3AstrologySuccessView = {
	destroy = 0,
	container = "VersionActivity1_3AstrologySuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologysuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_3AstrologyPropView = {
	destroy = 0,
	container = "VersionActivity1_3AstrologyPropViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_astrologyview/v1a3_astrologypropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	customAnimBg = {
		"blackbg"
	}
}
module_views.VersionActivity1_3BuffView = {
	destroy = 0,
	container = "VersionActivity1_3BuffViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_buffview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_buffview_bufficonitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_3BuffTipView = {
	destroy = 0,
	container = "VersionActivity1_3BuffTipViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_buffviewtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_3FairyLandView = {
	destroy = 0,
	container = "VersionActivity1_3FairyLandViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_fairylandview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_3/v1a3_buffview/v1a3_fairylanditem.prefab"
	}
}
module_views.VersionActivity1_3EnterView = {
	destroy = 0,
	container = "VersionActivity1_3EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/versionactivity_1_3_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_3DungeonMapView = {
	container = "VersionActivity1_3DungeonMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_3/map/versionactivity_1_3_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/versionactivity_1_3/map/v1a3_dungeonmapinteractiveitem.prefab",
		"ui/viewres/versionactivity_1_3/map/v1a3_map_direction.prefab",
		"ui/viewres/versionactivity_1_3/map/v1a3_dungeon_change.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.VersionActivity1_3DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_3DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_3DungeonChangeView = {
	destroy = 0,
	container = "VersionActivity1_3DungeonChangeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/map/v1a3_dungeon_change.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity1_3StoreView = {
	destroy = 0,
	container = "VersionActivity1_3StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_3NormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivity1_3NormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_3TaskView = {
	destroy = 0,
	container = "VersionActivity1_3TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/map/v1a3_main_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_3/map/v1a3_main_taskitem.prefab"
	}
}
module_views.VersionActivityDungeonMapView = {
	destroy = 0,
	container = "VersionActivityDungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitydungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity/versionactivitymapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab",
		"ui/viewres/dungeon/chaptermap/map_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityDungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivityDungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivitydungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityExchangeView = {
	destroy = 0,
	container = "VersionActivityExchangeViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityexchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivityTipsView = {
	destroy = 0,
	container = "VersionActivityTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity/versionactivitytipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.VersionActivityExchangeTaskView = {
	destroy = 0,
	container = "VersionActivityExchangeTaskViewContainer",
	mainRes = "ui/viewres/versionactivity/versionactivityexchangetaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity1_2EnterView = {
	destroy = 0,
	container = "VersionActivity1_2EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WaterMarkView = {
	destroy = 0,
	container = "WaterMarkViewContainer",
	mainRes = "ui/viewres/player/watermarkview.prefab",
	viewType = ViewType.Normal,
	layer = UILayerName.IDCanvasPopUp,
	anim = ViewAnim.Default
}
module_views.SdkFitAgeTipView = {
	destroy = 0,
	container = "SdkFitAgeTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sdk/sdkfitagetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.DungeonPuzzleOuijaView = {
	destroy = 0,
	container = "DungeonPuzzleOuijaViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/puzzle/dungeonpuzzleouijaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ActivityWarmUpGameView = {
	destroy = 0,
	container = "ActivityWarmUpGameViewContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmupgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ActivityWarmUpView = {
	destroy = 0,
	container = "ActivityWarmUpViewContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ActivityWarmUpTask = {
	destroy = 0,
	container = "ActivityWarmUpTaskViewContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmuptask.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/activity/warmup/activitywarmuptaskitem.prefab"
	}
}
module_views.ActivityWarmUpTips = {
	destroy = 0,
	container = "ActivityWarmUpTipsContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmuptipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ActivityWarmUpNews = {
	destroy = 0,
	container = "ActivityWarmUpNewsContainer",
	mainRes = "ui/viewres/activity/warmup/activitywarmupnews.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity109ChessEntry = {
	destroy = 0,
	container = "Activity109ChessEntryContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessentryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity109ChessMapList = {
	destroy = 0,
	container = "Activity109ChessMapListViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessmaplistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity109ChessTask = {
	destroy = 0,
	container = "Activity109ChessTaskViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chesstask.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity109ChessGameClear = {
	destroy = 0,
	container = "Activity109ChessGameClearContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessentryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ActivityChessGame = {
	bgBlur = 4,
	container = "ActivityChessGameContainer",
	destroy = 0,
	mainRes = "ui/viewres/activity/chessmap/activitychessmapgame.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/activity/chessmap/activitychessmapbasetile.prefab",
		[2] = "ui/viewres/activity/chessmap/activitychessmapinteract.prefab"
	}
}
module_views.ActivityChessGameResultView = {
	destroy = 0,
	container = "ActivityChessGameResultViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activitychessmapgameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ActivityChessGameRewardView = {
	destroy = 0,
	container = "ActivityChessGameRewardViewContainer",
	mainRes = "ui/viewres/activity/chessmap/activity109chessrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BpView = {
	container = "BpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/battlepass/bpview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	preloader = module_views_preloader,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/battlepass/bpbonusview.prefab"
			},
			{
				"ui/viewres/battlepass/bptaskview.prefab"
			}
		}
	},
	otherRes = {
		ResUrl.getBattlePassBg("full/img_bp_bg"),
		[2] = "ui/viewres/battlepass/bpbonusview.prefab",
		[3] = ResUrl.getBattlePassBg("img_reward_bg_shadow")
	}
}
module_views.BpSPView = {
	container = "BpSPViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/battlepass/bpspview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	preloader = module_views_preloader,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/battlepass/bpbonusview2.prefab"
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/battlepass/bpbonusview2.prefab",
		[2] = "ui/viewres/battlepass/bpsp_change.prefab"
	}
}
module_views.BpChangeView = {
	destroy = 0,
	container = "BpChangeViewContainer",
	mainRes = "ui/viewres/battlepass/bpsp_change.prefab",
	layer = "TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.BPSPFaceView = {
	destroy = 0,
	container = "BPSPFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpspfaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BPFaceView_Old = {
	destroy = 0,
	container = "BPFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpfaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BPFaceView = {
	destroy = 0,
	container = "BPFaceFestivalViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpface_skinfestivalview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BPSkinFaceView = {
	destroy = 0,
	container = "BPSkinFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpfaceview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BPSkinFaceView_Store = {
	destroy = 0,
	container = "BPSkinFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpfaceview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity119View = {
	destroy = 0,
	container = "Activity119ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/dreamtail/versionactivity_1_2_dreamtailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity114View = {
	destroy = 0,
	container = "Activity114ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114taskview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114mainview.prefab"
			}
		}
	}
}
module_views.Activity114PhotoView = {
	destroy = 0,
	container = "Activity114PhotoViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114photoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity114FullPhotoView = {
	bgBlur = 1,
	container = "Activity114FullPhotoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114photodetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity114FinishEventView = {
	bgBlur = 3,
	container = "Activity114FinishEventViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114finisheventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity114ScoreReportView = {
	destroy = 0,
	container = "Activity114ScoreReportViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/v1a2_114scorereportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity114TransitionView = {
	destroy = 0,
	container = "Activity114TransitionViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114transitionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	customAnimFadeTime = {
		nil,
		0.5
	}
}
module_views.Activity114EmptyView = {
	destroy = 0,
	container = "BaseViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/v1a2_empty.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.Activity114GetPhotoView = {
	destroy = 0,
	container = "Activity114GetPhotoViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114getphotoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.Activity114DiceView = {
	bgBlur = 3,
	container = "Activity114DiceViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114diceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity114EventSelectView = {
	destroy = 0,
	container = "Activity114EventSelectViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114eventselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity114MeetView = {
	destroy = 0,
	container = "Activity114MeetViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/activity114/versionactivity_1_2_114meetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity114TravelView = {
	destroy = 0,
	container = "Activity114TravelViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_tripenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_2StoreView = {
	destroy = 0,
	container = "VersionActivity1_2StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/map/other/versionactivity_1_2_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_2TaskView = {
	destroy = 0,
	container = "VersionActivity1_2TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/map/other/versionactivity_1_2_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_2/map/other/versionactivity_1_2_taskitem.prefab"
	}
}
module_views.YaXianMapView = {
	destroy = 0,
	container = "YaXianMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"scenes/dynamic/yaxian/yaxiancurve.asset"
	}
}
module_views.YaXianRewardView = {
	destroy = 0,
	container = "YaXianRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianrewardsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianrewardsitem.prefab"
	}
}
module_views.YaXianGameView = {
	destroy = 0,
	container = "YaXianGameContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiangameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.YaXianGameResultView = {
	destroy = 0,
	container = "YaXianGameResultContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiangameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.YaXianGameTipView = {
	destroy = 0,
	container = "YaXianGameTipViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiangametipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.YaXianFindToothView = {
	destroy = 0,
	container = "YaXianFindToothViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxianfindtoothview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.YaXianCollectView = {
	destroy = 0,
	container = "YaXianCollectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/yaxian/versionactivity_1_2_yaxiancollectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.BpBuyView = {
	destroy = 0,
	container = "BpBuyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpbuyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.BpInformationView = {
	destroy = 0,
	container = "BpInformationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpinformationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BpSPInformationView = {
	destroy = 0,
	container = "BpInformationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpspinformationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BpLevelupTipView = {
	destroy = 0,
	container = "BpLevelupTipViewContainer",
	mainRes = "ui/viewres/battlepass/bpleveluptipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.BpRuleTipsView = {
	destroy = 0,
	container = "BpRuleTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpruletipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BpSPRuleTipsView = {
	destroy = 0,
	container = "BpRuleTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpspruletipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BpChargeView = {
	destroy = 0,
	container = "BpChargeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpchargeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.BpChargeABTestView = {
	destroy = 0,
	container = "BpChargeABTestViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpchargeviewabtest.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.BpBonusSelectView = {
	destroy = 0,
	container = "BpBonusSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpbonusselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BpPropView = {
	container = "BpPropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/battlepass/bppropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	tabRes = {
		[2] = {
			{
				"ui/viewres/common/commonrighttipsview.prefab"
			}
		}
	},
	customAnimBg = {
		"blackbg"
	}
}
module_views.BpPropView2 = {
	bgBlur = 1,
	container = "BpPropView2Container",
	destroy = 0,
	mainRes = "ui/viewres/battlepass/bppropview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	},
	customAnimBg = {
		"blackbg"
	}
}
module_views.BpVideoView = {
	destroy = 0,
	container = "BpVideoViewContainer",
	mainRes = "ui/viewres/battlepass/bpvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.BpReceiveRewardView = {
	destroy = 0,
	container = "BpReceiveRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/battlepass/bpreceiverewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity_1_2_HeroGroupView = {
	bgBlur = 4,
	container = "VersionActivity_1_2_HeroGroupViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.VersionActivity_1_2_HeroGroupEditView = {
	container = "VersionActivity_1_2_HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.VersionActivity_1_2_FacilityTipsView = {
	destroy = 0,
	container = "VersionActivity_1_2_FacilityTipsViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_facilitytipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.Va_1_2_CharacterTipView = {
	bgBlur = 2,
	container = "Va_1_2_CharacterTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/va_1_2_charactertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_attributetip/bg",
		"#go_careertip/bg",
		"#go_skilltip/skilltip1/skillbg",
		"#go_skilltip/skilltip2/skillbg/bg",
		"#go_passiveskilltip/talentbg"
	}
}
module_views.VersionActivity1_2DungeonView = {
	container = "VersionActivity1_2DungeonViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_2/map/versionactivity_1_2_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab",
		"ui/viewres/dungeon/chaptermap/map_directiongreen.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.VersionActivity1_2DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_2DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity_1_2_StoryCollectView = {
	destroy = 0,
	container = "VersionActivity_1_2_StoryCollectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/versionactivity_1_2_storycollectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {}
}
module_views.VersionActivity_1_2_DungeonMapNoteView = {
	destroy = 0,
	container = "VersionActivity_1_2_DungeonMapNoteViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapnoteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {}
}
module_views.ActivityTradeBargain = {
	destroy = 0,
	container = "ActivityTradeBargainViewContainer",
	mainRes = "ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_tradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_tradequoteview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_traderewardview.prefab"
			}
		}
	}
}
module_views.TestTaskView = {
	destroy = 0,
	container = "TestTaskViewContainer",
	mainRes = "ui/viewres/testtask/testtaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ActivityStoryShowView = {
	destroy = 0,
	container = "ActivityStoryShowViewContainer",
	mainRes = "ui/viewres/activity/show/activitystoryshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ActivityDreamShowView = {
	destroy = 0,
	container = "ActivityDreamShowViewContainer",
	mainRes = "ui/viewres/activity/show/activitydreamshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ActivityClassShowView = {
	destroy = 0,
	container = "ActivityClassShowViewContainer",
	mainRes = "ui/viewres/activity/show/activityclassshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SeasonMainView = {
	destroy = 0,
	container = "SeasonMainViewContainer",
	mainRes = "ui/viewres/season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.SeasonMarketView = {
	destroy = 0,
	container = "SeasonMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SeasonSpecialMarketView = {
	destroy = 0,
	container = "SeasonSpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SeasonRetailView = {
	destroy = 0,
	container = "SeasonRetailViewContainer",
	mainRes = "ui/viewres/season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SeasonRetailLevelInfoView = {
	destroy = 0,
	container = "SeasonRetailLevelInfoViewContainer",
	mainRes = "ui/viewres/season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SeasonTaskView = {
	destroy = 0,
	container = "SeasonTaskViewContainer",
	mainRes = "ui/viewres/season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasontaskitem.prefab"
	}
}
module_views.SeasonSettlementView = {
	destroy = 0,
	container = "SeasonSettlementViewContainer",
	mainRes = "ui/viewres/season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SeasonCelebrityCardGetlView = {
	destroy = 0,
	container = "SeasonCelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SeasonEquipView = {
	bgBlur = 0,
	container = "SeasonEquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
module_views.SeasonEquipHeroView = {
	bgBlur = 0,
	container = "SeasonEquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
module_views.SeasonFightFailView = {
	destroy = 0,
	container = "SeasonFightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SeasonFightSuccView = {
	destroy = 0,
	container = "SeasonFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SeasonStoreView = {
	destroy = 0,
	container = "SeasonStoreViewContainer",
	mainRes = "ui/viewres/season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/season/seasonstoreitem.prefab"
	}
}
module_views.SeasonEquipSelfChoiceView = {
	destroy = 0,
	container = "SeasonEquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
module_views.SeasonCelebrityCardTipView = {
	container = "SeasonCelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
module_views.SeasonEquipComposeView = {
	bgBlur = 0,
	container = "SeasonEquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
module_views.SeasonEquipBookView = {
	bgBlur = 0,
	container = "SeasonEquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/season/seasoncelebritycarditem.prefab"
	}
}
module_views.SeasonFightRuleTipView = {
	destroy = 0,
	container = "SeasonFightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/season/seasonfightcardview.prefab"
			}
		}
	}
}
module_views.SeasonHeroGroupFightView = {
	bgBlur = 0,
	container = "SeasonHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season1_2MainView = {
	destroy = 0,
	container = "Season1_2MainViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.Season1_2MarketView = {
	destroy = 0,
	container = "Season1_2MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a2_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_2SpecialMarketView = {
	destroy = 0,
	container = "Season1_2SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a2_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_2RetailView = {
	destroy = 0,
	container = "Season1_2RetailViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_2RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_2RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_2TaskView = {
	destroy = 0,
	container = "Season1_2TaskViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasontaskitem.prefab"
	}
}
module_views.Season1_2SettlementView = {
	destroy = 0,
	container = "Season1_2SettlementViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a2_season/seasonsettlementherogroupitem.prefab"
	}
}
module_views.Season1_2CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_2CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_2EquipView = {
	bgBlur = 0,
	container = "Season1_2EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_2EquipHeroView = {
	bgBlur = 0,
	container = "Season1_2EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_2FightFailView = {
	destroy = 0,
	container = "Season1_2FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_2FightSuccView = {
	destroy = 0,
	container = "Season1_2FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_2StoreView = {
	destroy = 0,
	container = "Season1_2StoreViewContainer",
	mainRes = "ui/viewres/v1a2_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a2_season/seasonstoreitem.prefab"
	}
}
module_views.Season1_2EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_2EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_2CelebrityCardTipView = {
	container = "Season1_2CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a2_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_2EquipComposeView = {
	bgBlur = 0,
	container = "Season1_2EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_2EquipBookView = {
	bgBlur = 0,
	container = "Season1_2EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a2_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_2FightRuleTipView = {
	destroy = 0,
	container = "Season1_2FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a2_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a2_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a2_season/seasonfightcardview.prefab"
			}
		}
	}
}
module_views.Season1_2HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_2HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a2_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season1_2AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_2AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a2_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SummerSignPart1View_1_2 = {
	destroy = 0,
	container = "SummerSignPart1ViewContainer_1_2",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitynorsignview_1_2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitynorsignitem_1_2.prefab"
	}
}
module_views.SummerSignPart2View_1_2 = {
	destroy = 0,
	container = "SummerSignPart2ViewContainer_1_2",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitynorsignview_1_2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitynorsignitem_1_2.prefab"
	}
}
module_views.Season1_3MainView = {
	destroy = 0,
	container = "Season1_3MainViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_zongmaoshali_a.prefab",
		section4 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section04.prefab",
		scene = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_background_a.prefab",
		section1 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section01.prefab",
		section6 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section06.prefab",
		role3 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_kanjila_a.prefab",
		role6 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_zongmaoshali_b.prefab",
		section3 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section03.prefab",
		role1 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_jialabona_a.prefab",
		role4 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_kanjila_b.prefab",
		section5 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section05.prefab",
		section2 = "scenes/v1a3_m_s15_sjwf_1_3/scene_prefab/m_s15_sj_1_3_section02.prefab",
		role2 = "scenes/v1a3_m_s15_sjwf_1_3/perfab/m_s15_1_3_jialabona_b.prefab"
	},
	preloader = module_views_preloader
}
module_views.Season1_3MarketView = {
	destroy = 0,
	container = "Season1_3MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a3_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_3SpecialMarketView = {
	destroy = 0,
	container = "Season1_3SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a3_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_3RetailView = {
	destroy = 0,
	container = "Season1_3RetailViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_3RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_3RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_3TaskView = {
	destroy = 0,
	container = "Season1_3TaskViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasontaskitem.prefab"
	}
}
module_views.Season1_3SettlementView = {
	destroy = 0,
	container = "Season1_3SettlementViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a3_season/seasonsettlementherogroupitem.prefab"
	}
}
module_views.Season1_3CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_3CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_3EquipView = {
	bgBlur = 0,
	container = "Season1_3EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_3EquipHeroView = {
	bgBlur = 0,
	container = "Season1_3EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_3FightFailView = {
	destroy = 0,
	container = "Season1_3FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_3FightSuccView = {
	destroy = 0,
	container = "Season1_3FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_3StoreView = {
	destroy = 0,
	container = "Season1_3StoreViewContainer",
	mainRes = "ui/viewres/v1a3_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a3_season/seasonstoreitem.prefab"
	}
}
module_views.Season1_3EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_3EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_3CelebrityCardTipView = {
	container = "Season1_3CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a3_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_3EquipComposeView = {
	bgBlur = 0,
	container = "Season1_3EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_3EquipBookView = {
	bgBlur = 0,
	container = "Season1_3EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a3_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a3_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_3FightRuleTipView = {
	destroy = 0,
	container = "Season1_3FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a3_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a3_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a3_season/seasonfightcardview.prefab"
			}
		}
	}
}
module_views.Season1_3HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_3HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a3_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season1_3AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_3AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a3_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ActivityTradeSuccessView = {
	destroy = 0,
	container = "ActivityTradeSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_2/trade/versionactivity_1_2_tradesuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Va3ChessGameScene = {
	destroy = 0,
	container = "Va3ChessGameSceneContainer",
	mainRes = "ui/viewres/versionactivity_1_3/va3chess/va3chessgamescene.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.JiaLaBoNaGameResultView = {
	destroy = 0,
	container = "JiaLaBoNaGameResultViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonagameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.JiaLaBoNaMapView = {
	bgBlur = 0,
	container = "JiaLaBoNaMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonamapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		JiaLaBoNaMapViewStageItem.prefabPath,
		JiaLaBoNaEnum.MapSceneRes[JiaLaBoNaEnum.Chapter.One],
		JiaLaBoNaEnum.MapSceneRes[JiaLaBoNaEnum.Chapter.Two]
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.JiaLaBoNaGameView = {
	bgBlur = 0,
	container = "JiaLaBoNaGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonagameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/va3chess/va3chessgamescene.prefab"
			}
		}
	}
}
module_views.JiaLaBoNaTaskView = {
	bgBlur = 0,
	container = "JiaLaBoNaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonataskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		JiaLaBoNaTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.JiaLaBoNaStoryView = {
	bgBlur = 3,
	container = "JiaLaBoNaStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonastoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		JiaLaBoNaStoryViewItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_3RadioView = {
	destroy = 0,
	container = "VersionActivity1_3RadioViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_radio/v1a3_radio.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity1_3ChessMapView = {
	destroy = 0,
	container = "Activity1_3ChessMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity1_3ChessMapNodeItem.prefabPath,
		Activity1_3ChessEnum.MapSceneResPath[1],
		Activity1_3ChessEnum.MapSceneResPath[2]
	}
}
module_views.Activity1_3ChessTaskView = {
	destroy = 0,
	container = "Activity1_3ChessTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity1_3ChessTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity1_3ChessGameView = {
	destroy = 0,
	container = "Activity1_3ChessGameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_chessgamescene.prefab"
			}
		}
	}
}
module_views.Activity1_3ChessResultView = {
	destroy = 0,
	container = "Activity1_3ChessResultContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity1_3ChessStoryView = {
	bgBlur = 1,
	container = "Activity1_3ChessStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity1_3ChessStoryViewItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ArmMainView = {
	destroy = 0,
	container = "ArmMainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ArmRewardView = {
	bgBlur = 0,
	container = "ArmRewardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		ArmRewardViewTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ArmPuzzlePipeView = {
	bgBlur = 3,
	container = "ArmPuzzlePipeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armpuzzlepipeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		ArmPuzzlePipeItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity1_3_119View = {
	destroy = 0,
	container = "Activity1_3_119ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_3/v1a3_bookview/v1a3_bookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123EntryView = {
	destroy = 0,
	container = "Season123EntryViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act123/season123mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123EntryOverview = {
	destroy = 0,
	container = "Season123EntryOverviewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123entryoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123RetailView = {
	destroy = 0,
	container = "Season123RetailViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act123/season123retaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Season123HeroGroupFightView = {
	bgBlur = 4,
	container = "Season123HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season123EpisodeListView = {
	destroy = 0,
	container = "Season123EpisodeListViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act123/season123episodelistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123EpisodeLoadingView = {
	destroy = 0,
	container = "Season123EpisodeLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123episodeloadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Season123EpisodeDetailView = {
	destroy = 0,
	container = "Season123EpisodeDetailViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act123/season123marketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123PickAssistView = {
	destroy = 0,
	container = "Season123PickAssistViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123pickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123pickassistitem.prefab"
	}
}
module_views.Season123HeroGroupEditView = {
	container = "Season123HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/seasonver/act123/season123herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123herogroupedititem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.Season123PickHeroEntryView = {
	destroy = 0,
	container = "Season123PickHeroEntryViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123pickheroentryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123PickHeroView = {
	destroy = 0,
	container = "Season123PickHeroViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123pickheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123pickheroitem.prefab"
	}
}
module_views.Season123StageLoadingView = {
	destroy = 0,
	container = "Season123StageLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123loadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Season123StageFinishView = {
	destroy = 0,
	container = "Season123StageFinishViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123stagefinishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Season123ShowHeroView = {
	destroy = 0,
	container = "Season123ShowHeroViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123showheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123EquipHeroView = {
	bgBlur = 0,
	container = "Season123EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123equipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123EquipView = {
	bgBlur = 0,
	container = "Season123EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123equipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123EnemyView = {
	bgBlur = 1,
	container = "Season123EnemyViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123enemyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg",
		"#simage_rightbg"
	}
}
module_views.Season123StoreView = {
	destroy = 0,
	container = "Season123StoreViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123storeitem.prefab"
	}
}
module_views.Season123TaskView = {
	destroy = 0,
	container = "Season123TaskViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123taskitem.prefab"
	}
}
module_views.Season123EquipBookView = {
	bgBlur = 0,
	container = "Season123EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123equipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123equipbookitem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123BatchDecomposeView = {
	bgBlur = 0,
	container = "Season123BatchDecomposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123batchdecomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123decomposeitem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123DecomposeFilterView = {
	destroy = 10,
	container = "Season123DecomposeFilterViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123decomposefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Season123DecomposeView = {
	container = "Season123DecomposeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123decomposeview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123CelebrityCardTipView = {
	container = "Season123CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123celebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123CelebrityCardGetView = {
	destroy = 0,
	container = "Season123CelebrityCardGetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123celebritycardgetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123CardPackageView = {
	bgBlur = 1,
	container = "Season123CardPackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act123/season123cardpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act123/season123cardpackageitem.prefab",
		[2] = "ui/viewres/seasonver/act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123StoryView = {
	destroy = 0,
	container = "Season123StoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123StoryPagePopView = {
	destroy = 0,
	container = "Season123StoryPagePopViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123storypagepopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123RecordWindow = {
	destroy = 0,
	container = "Season123RecordWindowContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123recordwindow.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123FightSuccView = {
	destroy = 0,
	container = "Season123FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123FightFailView = {
	destroy = 0,
	container = "Season123FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123fightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123SettlementView = {
	destroy = 0,
	container = "Season123SettlementViewContainer",
	mainRes = "ui/viewres/seasonver/act123/season123settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/seasonver/act123/season123settlementherogroupitem.prefab"
	}
}
module_views.Season123AdditionRuleTipView = {
	destroy = 0,
	container = "Season123AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act123/season123additionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123FightRuleTipView = {
	destroy = 0,
	container = "Season123FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act123/season123fightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/seasonver/act123/season123fightruleview.prefab"
			},
			{
				"ui/viewres/seasonver/act123/season123fightcardview.prefab"
			}
		}
	}
}
module_views.Season123ResetView = {
	destroy = 0,
	container = "Season123ResetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act123/season123resetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_4EnterView = {
	destroy = 0,
	container = "VersionActivity1_4EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/versionactivity_1_4_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity132CollectView = {
	destroy = 0,
	container = "Activity132CollectViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_collect/v1a4_collectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity132CollectDetailView = {
	destroy = 0,
	container = "Activity132CollectDetailViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_collect/v1a4_collectdetail.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity136ChoiceView = {
	destroy = 0,
	container = "Activity136ChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/activity136choiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/activity136choiceitem.prefab"
	}
}
module_views.Activity136View = {
	destroy = 0,
	container = "Activity136ViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/v2a2_selfselectfivestarsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity136FullView = {
	destroy = 0,
	container = "Activity136FullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_selfselectfivestars/v2a2_selfselectfivestarsfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Role37PuzzleView = {
	destroy = 0,
	container = "Role37PuzzleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_questionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Role37PuzzleRecordView = {
	destroy = 0,
	container = "Role37PuzzleRecordViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_recordpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Role37PuzzleResultView = {
	destroy = 0,
	container = "Role37PuzzleResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity130TaskView = {
	bgBlur = 0,
	container = "Activity130TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity130TaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity130GameView = {
	destroy = 0,
	container = "Activity130GameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity130LevelView = {
	bgBlur = 0,
	container = "Activity130LevelViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_levelviewstageitem.prefab",
		"ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_dungeon_change.prefab",
		"scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_zjm_37_a_p.prefab",
		"scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_zjm_37_b_p.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ActivityDoubleFestivalSignPaiLianView_1_3 = {
	destroy = 0,
	container = "ActivityDoubleFestivalSignPaiLianViewContainer_1_3",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activitydoublefestivalsignpailianview_1_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/activitydoublefestivalsignitem_1_3.prefab"
	}
}
module_views.Activity130DialogView = {
	destroy = 0,
	container = "Activity130DialogViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_dialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity130CollectView = {
	bgBlur = 1,
	container = "Activity130CollectViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_collectpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_collectitem.prefab"
	}
}
module_views.Activity131TaskView = {
	bgBlur = 0,
	container = "Activity131TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		Activity131TaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity131GameView = {
	destroy = 0,
	container = "Activity131GameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity131LevelView = {
	bgBlur = 0,
	container = "Activity131LevelViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_levelviewstageitem.prefab",
		[2] = "scenes/v1a4_m_s12_6jshd/prefab/v1a4_m_s12_6_zjm_a.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity131DialogView = {
	destroy = 0,
	container = "Activity131DialogViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_dialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity131LogView = {
	container = "Activity131LogViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_logview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_logitem.prefab",
		[2] = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_logcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity131BattleView = {
	destroy = 0,
	container = "Activity131BattleViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_interactivepanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.Activity133View = {
	destroy = 0,
	container = "Activity133ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133item.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.ActivityStarLightSignPart1PaiLianView_1_3 = {
	destroy = 0,
	container = "ActivityStarLightSignPart1PaiLianViewContainer_1_3",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activitystarlightsignpart1pailianview_1_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ActivityStarLightSignPart2PaiLianView_1_3 = {
	destroy = 0,
	container = "ActivityStarLightSignPart2PaiLianViewContainer_1_3",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activitystarlightsignpart2pailianview_1_3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.DailyAllowanceView = {
	destroy = 0,
	container = "DailyAllowanceViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_goldview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity133TaskView = {
	destroy = 0,
	container = "Activity133TaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_shiprepair/activity133taskitem.prefab"
	}
}
module_views.Activity134View = {
	destroy = 0,
	container = "Activity134ViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/v1a4_dustyrecordsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/v1a4_dustyrecordsreportitem.prefab",
		[2] = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/v1a4_dustyrecordsprogressitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Activity134TaskView = {
	destroy = 0,
	container = "Activity134TaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/activity134taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_dustyrecords/activity134taskitem.prefab"
	}
}
module_views.VersionActivity1_4TaskView = {
	destroy = 0,
	container = "VersionActivity1_4TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_collect/task/v1a4_main_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_collect/task/v1a4_main_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a4_BossRushMainView = {
	bgBlur = 0,
	container = "V1a4_BossRushMainViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrushmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrushmainitem.prefab",
		[2] = BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon
	}
}
module_views.V1a4_BossRushLevelDetail = {
	bgBlur = 0,
	container = "V1a4_BossRushLevelDetailContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrushleveldetail.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon,
		BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine
	},
	preloader = module_views_preloader
}
module_views.V1a4_BossRush_ScoreTaskAchievement = {
	bgBlur = 1,
	container = "V1a4_BossRush_ScoreTaskAchievementContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scoretaskachievement.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scoretaskachievementitem.prefab",
		[2] = BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon
	}
}
module_views.V1a4_BossRush_ResultView = {
	destroy = 0,
	container = "V1a4_BossRush_ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_result_assess,
		BossRushEnum.ResPath.v1a4_bossrush_herogroup,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
	}
}
module_views.V1a4_BossRush_ResultPanel = {
	destroy = 0,
	container = "V1a4_BossRush_ResultPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_resultpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_result_assess
	}
}
module_views.V1a4_BossRush_ScheduleView = {
	destroy = 0,
	container = "V1a4_BossRush_ScheduleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scheduleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scheduleitem.prefab"
	}
}
module_views.V1a4_BossRush_EnemyInfoView = {
	destroy = 0,
	container = "V1a4_BossRush_EnemyInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_enemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_BossRush_EnterView = {
	destroy = 0,
	container = "V1a6_BossRush_EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V1a6_BossRush_StoreView = {
	destroy = 0,
	container = "V1a6_BossRush_StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.V1a6_BossRush_BonusView = {
	destroy = 0,
	container = "V1a6_BossRush_BonusViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_scoretaskachievement.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				BossRushEnum.ResPath.v1a6_bossrush_achievementview
			},
			{
				BossRushEnum.ResPath.v1a6_bossrush_scheduleview
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_achievementitem.prefab",
		"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_scheduleitem.prefab",
		BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon,
		"ui/viewres/versionactivity_1_4/v1a4_bossrush/v2a1_bossrush_specialscheduleitem.prefab"
	}
}
module_views.V1a6_BossRush_ResultView = {
	destroy = 0,
	container = "V1a6_BossRush_ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a4_bossrush_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a4_bossrush_result_assess,
		BossRushEnum.ResPath.v1a4_bossrush_herogroup,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1,
		BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
	}
}
module_views.V1a6_BossRush_ResultPanel = {
	destroy = 0,
	container = "V1a6_BossRush_ResultPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_resultpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		BossRushEnum.ResPath.v1a6_bossrush_result_assess,
		BossRushEnum.ResPath.v1a4_bossrush_result_assess
	}
}
module_views.V2a1_BossRush_OfferRoleView = {
	destroy = 0,
	container = "V2a1_BossRush_OfferRoleViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v2a1_bossrush_offercharview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v2a1_bossrush_offercharitem.prefab"
	}
}

BossRushDefine.init(module_views)
V3a8EchoSongViewDefine.init(module_views)

module_views.VersionActivity1_4DungeonView = {
	bgBlur = 0,
	container = "VersionActivity1_4DungeonViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dungeon/v1a4_dungeonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_4/v1a4_dungeon/v1a4_dungeonitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_4DungeonEpisodeView = {
	bgBlur = 0,
	container = "VersionActivity1_4DungeonEpisodeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_dungeon/v1a4_dungeonepisodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Activity129View = {
	bgBlur = 0,
	container = "Activity129ViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_tokenstore/v1a4_tokenstore.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Season1_4MainView = {
	destroy = 0,
	container = "Season1_4MainViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_z_6.prefab",
		section4 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section04.prefab",
		scene = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_background_a.prefab",
		section1 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section01.prefab",
		section6 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section06.prefab",
		role3 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_y_6.prefab",
		role6 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_y_37.prefab",
		section3 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section03.prefab",
		role1 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_z_37.prefab",
		role4 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_z_sfy.prefab",
		section5 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section05.prefab",
		section2 = "scenes/v1a4_m_s15_sj_1_4/scene_prefab/v1a4_m_s15_sj_1_4_section02.prefab",
		role2 = "scenes/v1a4_m_s15_sj_1_4/prefab/m_s15_sj_yfyt_qz_y_sfy.prefab"
	},
	preloader = module_views_preloader
}
module_views.Season1_4MarketView = {
	destroy = 0,
	container = "Season1_4MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a4_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_4SpecialMarketView = {
	destroy = 0,
	container = "Season1_4SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a4_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_4RetailView = {
	destroy = 0,
	container = "Season1_4RetailViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_4RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_4RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_4TaskView = {
	destroy = 0,
	container = "Season1_4TaskViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasontaskitem.prefab"
	}
}
module_views.Season1_4SettlementView = {
	destroy = 0,
	container = "Season1_4SettlementViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a4_season/seasonsettlementherogroupitem.prefab"
	}
}
module_views.Season1_4CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_4CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_4EquipView = {
	bgBlur = 0,
	container = "Season1_4EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_4EquipHeroView = {
	bgBlur = 0,
	container = "Season1_4EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_4FightFailView = {
	destroy = 0,
	container = "Season1_4FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_4FightSuccView = {
	destroy = 0,
	container = "Season1_4FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_4StoreView = {
	destroy = 0,
	container = "Season1_4StoreViewContainer",
	mainRes = "ui/viewres/v1a4_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a4_season/seasonstoreitem.prefab"
	}
}
module_views.Season1_4EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_4EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_4CelebrityCardTipView = {
	container = "Season1_4CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a4_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_4EquipComposeView = {
	bgBlur = 0,
	container = "Season1_4EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_4EquipBookView = {
	bgBlur = 0,
	container = "Season1_4EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a4_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a4_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_4FightRuleTipView = {
	destroy = 0,
	container = "Season1_4FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a4_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a4_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a4_season/seasonfightcardview.prefab"
			}
		}
	}
}
module_views.Season1_4HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_4HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a4_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season1_4AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_4AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a4_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_4SumView = {
	destroy = 0,
	container = "Season1_4SumViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/v1a4_season/seasonsumview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V1a4_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a4_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
module_views.V1a4_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a4_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
module_views.V1a4_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a4_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
module_views.V1a4_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a4_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a4_role_signitem.prefab"
	}
}
module_views.TurnbackPopupBeginnerView = {
	destroy = 0,
	container = "TurnbackPopupBeginnerViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/turnback/turnbackpopupbeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbackpopuprewardview.prefab"
	}
}
module_views.TurnbackBeginnerView = {
	bgBlur = 1,
	container = "TurnbackBeginnerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/turnback/turnbackbeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbackcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TurnbackTaskView = {
	destroy = 0,
	container = "TurnbackTaskViewContainer",
	mainRes = "ui/viewres/turnback/turnbacktaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbacktaskitem.prefab"
	}
}
module_views.TurnbackDungeonShowView = {
	destroy = 0,
	container = "TurnbackDungeonShowViewContainer",
	mainRes = "ui/viewres/turnback/turnbackdungeonshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackRewardShowView = {
	destroy = 0,
	container = "TurnbackRewardShowViewContainer",
	mainRes = "ui/viewres/turnback/turnbackrewardshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackSignInView = {
	destroy = 0,
	container = "TurnbackSignInViewContainer",
	mainRes = "ui/viewres/turnback/turnbacksigninview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnbacksigninitem.prefab"
	}
}
module_views.TurnbackRecommendView = {
	destroy = 0,
	container = "TurnbackRecommendViewContainer",
	mainRes = "ui/viewres/turnback/turnbackrecommendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnBackInvitationMainView = {
	destroy = 0,
	container = "TurnBackInvitationMainViewContainer",
	mainRes = "ui/viewres/activity/v2a5_turnback_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackNewBeginnerView = {
	bgBlur = 1,
	container = "TurnbackNewBeginnerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/turnback/new/turnbacknewbeginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/new/turnbacknewcategoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TurnbackNewTaskView = {
	destroy = 0,
	container = "TurnbackNewTaskViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewtaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/new/turnbacknewtaskitem.prefab"
	}
}
module_views.TurnbackNewBenfitView = {
	destroy = 0,
	container = "TurnbackNewBenfitViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewbenfitview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackNewProgressView = {
	destroy = 0,
	container = "TurnbackNewProgressViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewprogressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackNewSignInView = {
	destroy = 0,
	container = "TurnbackNewSignInViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewsigninview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackNewRecommendView = {
	destroy = 0,
	container = "TurnbackNewRecommendViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacknewrecommendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackNewLatterView = {
	bgBlur = 1,
	container = "TurnbackNewLatterViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbacklatterview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.TurnbackDoubleRewardChargeView = {
	bgBlur = 1,
	container = "TurnbackDoubleRewardChargeViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbackdoublerewardchargeview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.TurnbackNewShowRewardView = {
	destroy = 0,
	container = "TurnbackNewShowRewardViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbackshowrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TurnbackReviewView = {
	destroy = 0,
	container = "TurnbackReviewViewContainer",
	mainRes = "ui/viewres/turnback/new/turnbackstoryreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.AchievementEntryView = {
	destroy = 0,
	container = "AchievementEntryViewContainer",
	mainRes = "ui/viewres/achievement/achievemententryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AchievementMainView = {
	destroy = 0,
	container = "AchievementMainViewContainer",
	mainRes = "ui/viewres/achievement/achievementmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/achievement/achievementmainitem.prefab",
		"ui/viewres/achievement/achievementmainicon.prefab",
		"ui/viewres/achievement/achievementmainitem_misihai.prefab"
	}
}
module_views.AchievementSelectView = {
	destroy = 0,
	container = "AchievementSelectViewContainer",
	mainRes = "ui/viewres/achievement/achievementselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/achievement/achievementselectitem.prefab",
		"ui/viewres/achievement/achievementmainicon.prefab",
		"ui/viewres/achievement/achievementselectitem_misihai.prefab"
	}
}
module_views.AchievementLevelView = {
	bgBlur = 1,
	container = "AchievementLevelViewContainer",
	mainRes = "ui/viewres/achievement/achievementlevelview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	customAnimBg = {
		"bg"
	},
	otherRes = {
		[1] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
module_views.AchievementNamePlateLevelView = {
	bgBlur = 1,
	container = "AchievementNamePlateLevelViewContainer",
	mainRes = "ui/viewres/achievement/achievementlevelview_misihai.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	customAnimBg = {
		"bg"
	}
}
module_views.AchievementNamePlateUnlockView = {
	bgBlur = 1,
	container = "AchievementNamePlateUnlockViewContainer",
	mainRes = "ui/viewres/tower/tower_achievement_unlockview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	customAnimBg = {
		"bg"
	}
}
module_views.AchievementNamePlatePanelView = {
	bgBlur = 1,
	container = "AchievementNamePlatePanelViewContainer",
	mainRes = "ui/viewres/tower/tower_achievement_panelview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	customAnimBg = {
		"bg"
	}
}
module_views.AchievementGroupPreView = {
	destroy = 0,
	container = "AchievementGroupPreViewContainer",
	bgBlur = 1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
module_views.VoiceChooseView = {
	destroy = 0,
	container = "VoiceChooseViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/voice/voicechooseview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/voice/voicechooseitem.prefab"
	}
}
module_views.VersionActivity1_5EnterView = {
	destroy = 0,
	container = "VersionActivity1_5EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/versionactivity_1_5_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_5DungeonMapView = {
	destroy = 0,
	container = "VersionActivity1_5DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab",
		"ui/viewres/versionactivity_1_5/dungeon/v1a5_dungeonmapinteractiveitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_5DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_5DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_5StoreView = {
	destroy = 0,
	container = "VersionActivity1_5StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoleStoryActivityMainView = {
	bgBlur = 0,
	container = "RoleStoryActivityMainViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/rolestory/actrolestorymainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		itemRes = "ui/viewres/dungeon/rolestory/actrolestoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/dungeon/rolestory/rolestorycurrencyview.prefab"
			}
		}
	}
}
module_views.RoleStoryHeroGroupFightView = {
	bgBlur = 4,
	container = "RoleStoryHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/herogroup/herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.RoleStoryDispatchView = {
	bgBlur = 0,
	container = "RoleStoryDispatchViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorydispatchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		storyItemRes = "ui/viewres/dungeon/rolestory/rolestorydispatchstoryitem.prefab",
		normalItemRes = "ui/viewres/dungeon/rolestory/rolestorydispatchnormalitem.prefab"
	}
}
module_views.RoleStoryDispatchTipsView = {
	destroy = 0,
	container = "RoleStoryDispatchTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorydispatchtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/dungeon/rolestory/rolestorycurrencyview.prefab"
			}
		}
	}
}
module_views.RoleStoryReviewView = {
	destroy = 0,
	container = "RoleStoryReviewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/rolestory/rolestoryreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoleStoryDispatchMainView = {
	destroy = 0,
	container = "RoleStoryDispatchMainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorydispatchmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		itemRes = "ui/viewres/dungeon/rolestory/actrolestoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/dungeon/rolestory/rolestorycurrencyview.prefab"
			}
		}
	}
}
module_views.VersionActivity1_5NormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivity1_5NormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_5TaskView = {
	destroy = 0,
	container = "VersionActivity1_5TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_taskitem.prefab"
	}
}
module_views.VersionActivity1_5DispatchView = {
	destroy = 0,
	container = "VersionActivity1_5DispatchViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dispatchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity1_5RevivalTaskView = {
	bgBlur = 1,
	container = "VersionActivity1_5RevivalTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_revival/v1a5_revivaltaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_5/dungeon/v1a5_revival/v1a5_revivaltaskitem.prefab"
	}
}
module_views.VersionActivity1_5DungeonMapTaskView = {
	destroy = 0,
	container = "VersionActivity1_5DungeonMapTaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/versionactivity_1_5_dungeonmaptaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V1a5BuildingView = {
	destroy = 0,
	container = "V1a5BuildingViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_building/v1a5_buildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.V1a5BuildingDetailView = {
	destroy = 0,
	container = "V1a5BuildingDetailViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_building/v1a5_buildingdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.V1a5BuildingSkillView = {
	destroy = 0,
	container = "V1a5BuildingSkillViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/dungeon/v1a5_building/v1a5_buildingskillview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaMapView = {
	bgBlur = 0,
	container = "AiZiLaMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaStageItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaStoryView = {
	bgBlur = 3,
	container = "AiZiLaStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaStoryItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaTaskView = {
	bgBlur = 0,
	container = "AiZiLaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaEquipView = {
	bgBlur = 3,
	container = "AiZiLaEquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_equipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath2
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaRecordView = {
	destroy = 0,
	container = "AiZiLaRecordViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_recordview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaHandbookView = {
	bgBlur = 3,
	container = "AiZiLaHandbookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_handbook.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaEpsiodeDetailView = {
	bgBlur = 3,
	container = "AiZiLaEpsiodeDetailViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_epsiodedetail.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaGameOpenEffectView = {
	destroy = 0,
	container = "AiZiLaGameOpenEffectViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameopeneffectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.AiZiLaGameView = {
	bgBlur = 0,
	container = "AiZiLaGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaGameResultView = {
	destroy = 0,
	container = "AiZiLaGameResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	}
}
module_views.AiZiLaGameStateView = {
	destroy = 0,
	container = "AiZiLaGameStateViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gamestateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaGamePackView = {
	bgBlur = 3,
	container = "AiZiLaGamePackViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gamepackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AiZiLaGameEventView = {
	destroy = 0,
	container = "AiZiLaGameEventViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameeventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	}
}
module_views.AiZiLaGameEventResult = {
	destroy = 0,
	container = "AiZiLaGameEventResultContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_gameeventresult.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		AiZiLaGoodsItem.prefabPath
	}
}
module_views.Activity142MapView = {
	destroy = 0,
	container = "Activity142MapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity142StoryView = {
	destroy = 0,
	container = "Activity142StoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity142TaskView = {
	destroy = 0,
	container = "Activity142TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity142CollectView = {
	destroy = 0,
	container = "Activity142CollectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_collectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity142GetCollectionView = {
	destroy = 0,
	container = "Activity142GetCollectionViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_getcollectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Activity142ResultView = {
	destroy = 0,
	container = "Activity142ResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity142GameView = {
	destroy = 0,
	container = "Activity142GameViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_kerandian/v1a5_kerandian_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_3/va3chess/va3chessgamescene.prefab"
			}
		}
	}
}
module_views.SportsNewsView = {
	destroy = 0,
	container = "SportsNewsViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_mainreaditem.prefab",
		"ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_maintaskitem.prefab",
		"ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_tasktabitem.prefab"
	}
}
module_views.SportsNewsTaskView = {
	bgBlur = 1,
	container = "SportsNewsTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_taskitem.prefab",
		[2] = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_tasktabitem.prefab"
	}
}
module_views.SportsNewsReadView = {
	destroy = 0,
	container = "SportsNewsReadViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_readview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SportsNewsPaperView = {
	destroy = 0,
	container = "SportsNewsPaperViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_news/v1a5_news_paperview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_5WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_5WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_warmup/v1a5_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.PeaceUluView = {
	destroy = 0,
	container = "PeaceUluViewContainer",
	mainRes = "ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_taskitem.prefab",
		[2] = "ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_progressitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_mainview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_gameview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_5/v1a5_peaceulu/v1a5_peaceulu_resultview.prefab"
			}
		}
	}
}
module_views.Season1_5MainView = {
	destroy = 0,
	container = "Season1_5MainViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_kanjila_b.prefab",
		section4 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section04.prefab",
		scene = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_background_a.prefab",
		section1 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section01.prefab",
		section6 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section06.prefab",
		role3 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_shasirong_a.prefab",
		role6 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_shasirong_b.prefab",
		section3 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section03.prefab",
		role1 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_aizila_a.prefab",
		role4 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_aizila_b.prefab",
		section5 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section05.prefab",
		section2 = "scenes/v1a5_m_s15_sj_zhex/scene_prefab/m_s15_sj_1_5_section02.prefab",
		role2 = "scenes/v1a5_m_s15_sj_zhex/perfab/m_s15_1_5_kanjila_a.prefab"
	}
}
module_views.Season1_5MarketView = {
	destroy = 0,
	container = "Season1_5MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a5_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_5SpecialMarketView = {
	destroy = 0,
	container = "Season1_5SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a5_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_5RetailView = {
	destroy = 0,
	container = "Season1_5RetailViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_5RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_5RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_5TaskView = {
	destroy = 0,
	container = "Season1_5TaskViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasontaskitem.prefab"
	}
}
module_views.Season1_5SettlementView = {
	destroy = 0,
	container = "Season1_5SettlementViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a5_season/seasonsettlementherogroupitem.prefab"
	}
}
module_views.Season1_5CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_5CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_5EquipView = {
	bgBlur = 0,
	container = "Season1_5EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_5EquipHeroView = {
	bgBlur = 0,
	container = "Season1_5EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_5FightFailView = {
	destroy = 0,
	container = "Season1_5FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_5FightSuccView = {
	destroy = 0,
	container = "Season1_5FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_5StoreView = {
	destroy = 0,
	container = "Season1_5StoreViewContainer",
	mainRes = "ui/viewres/v1a5_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a5_season/seasonstoreitem.prefab"
	}
}
module_views.Season1_5EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_5EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_5CelebrityCardTipView = {
	container = "Season1_5CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a5_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_5EquipComposeView = {
	bgBlur = 0,
	container = "Season1_5EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_5EquipBookView = {
	bgBlur = 0,
	container = "Season1_5EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a5_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a5_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_5FightRuleTipView = {
	destroy = 0,
	container = "Season1_5FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a5_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a5_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a5_season/seasonfightcardview.prefab"
			}
		}
	}
}
module_views.Season1_5HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_5HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a5_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season1_5AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_5AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a5_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_5SumView = {
	destroy = 0,
	container = "Season1_5SumViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/v1a5_season/seasonsumview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V1a5_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a5_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
module_views.V1a5_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a5_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
module_views.V1a5_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a5_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
module_views.V1a5_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a5_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_role_signitem.prefab"
	}
}
module_views.V1a5_DoubleFestival_PanelSignView = {
	destroy = 0,
	container = "V1a5_DoubleFestival_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_doublefestival_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_doublefestival_signitem.prefab"
	}
}
module_views.V1a5_DoubleFestival_FullSignView = {
	destroy = 0,
	container = "V1a5_DoubleFestival_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a5_doublefestival_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a5_doublefestival_signitem.prefab"
	}
}
module_views.V1a5_DoubleFestival_WishPanel = {
	destroy = 0,
	container = "V1a5_DoubleFestival_WishPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a5_doublefestival_wishpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.DialogueView = {
	bgBlur = 1,
	container = "DialogueViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dialogue/dialogueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.VersionActivity2_0DialogueView = tabletool.copy(module_views.DialogueView)
module_views.VersionActivity2_0DialogueView.mainRes = "ui/viewres/versionactivity_2_0/v2a0_dialogueview.prefab"
module_views.TipDialogView = {
	destroy = 0,
	container = "TipDialogViewContainer",
	mainRes = "ui/viewres/tipdialog/tipdialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoleStoryTipView = {
	destroy = 0,
	container = "RoleStoryTipViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/dungeon/rolestory/rolestorytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RoleStoryRewardView = {
	bgBlur = 0,
	container = "RoleStoryRewardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/rolestory/rolestoryprogressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/dungeon/rolestory/rolestoryprogressitem.prefab"
	}
}
module_views.RoleStoryFightSuccView = {
	destroy = 0,
	container = "RoleStoryFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/rolestory/rolestoryfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_6EnterView = {
	destroy = 0,
	container = "VersionActivity1_6EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/versionactivity_1_6_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_6/va_1_6_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_v1a1reprint/v1a6_v1a1reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_season/v1a6_season_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_6/v1a6_explore/v1a6_explore_enterview.prefab"
			}
		}
	}
}
module_views.VersionActivity1_6EnterVideoView = {
	destroy = 0,
	container = "VersionActivity1_6EnterVideoViewContainer",
	mainRes = "ui/viewres/battlepass/bpvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_6DungeonMapView = {
	container = "VersionActivity1_6DungeonMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/dungeon/versionactivity_1_6_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_6/dungeon/versionactivity_1_6_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.VersionActivity1_6DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_6DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/dungeon/versionactivity_1_6_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_6DungeonBossView = {
	bgBlur = 0,
	container = "VersionActivity1_6DungeonBossViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_main.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_6_BossScheduleView = {
	destroy = 0,
	container = "VersionActivity1_6_BossScheduleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_scheduleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_scheduleitem.prefab"
	}
}
module_views.VersionActivity1_6BossInfoView = {
	destroy = 0,
	container = "VersionActivity1_6BossInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/baseenemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_6BossFightSuccView = {
	destroy = 0,
	container = "VersionActivity1_6BossFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_successview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_6StoreView = {
	destroy = 0,
	container = "VersionActivity1_6StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/versionactivity_1_6_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_6NormalStoreGoodsView = {
	bgBlur = 1,
	container = "VersionActivity1_6NormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_6TaskView = {
	destroy = 0,
	container = "VersionActivity1_6TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/versionactivity_1_6_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_6/versionactivity_1_6_taskitem.prefab"
	}
}
module_views.VersionActivity1_6SkillView = {
	destroy = 0,
	container = "VersionActivity1_6SkillViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_talent/v1a6_talent_lvupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_6SkillLvUpView = {
	destroy = 0,
	container = "VersionActivity1_6SkillLvUpViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_talent/v1a6_talent_wishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.GoldenMilletPresentView = {
	destroy = 0,
	container = "GoldenMilletPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_goldenmilletpresent.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ActQuNiangLevelView = {
	destroy = 0,
	container = "ActQuNiangLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_levelviewstageitem2.prefab"
	}
}
module_views.ActQuNiangTaskView = {
	bgBlur = 0,
	container = "ActQuNiangTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		ActQuNiangTaskItem.prefabPath
	}
}
module_views.ActGeTianLevelView = {
	destroy = 0,
	container = "ActGeTianLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_levelviewstageitem2.prefab"
	}
}
module_views.ActGeTianTaskView = {
	bgBlur = 0,
	container = "ActGeTianTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_getian/v1a6_getian_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		ActGeTianTaskItem.prefabPath
	}
}
module_views.V1a6_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a6_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a6_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a6_role_signitem.prefab"
	}
}
module_views.V1a6_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a6_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a6_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a6_role_signitem.prefab"
	}
}
module_views.NewYearEveGiftView = {
	destroy = 0,
	container = "NewYearEveGiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_eve/v1a6_eve_dialogueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.NewYearEveActivityView = {
	destroy = 0,
	container = "NewYearEveActivityViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_eve/v1a6_eve_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Season1_6MainView = {
	destroy = 0,
	container = "Season1_6MainViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		role5 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_quniang_a.prefab",
		section4 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section04.prefab",
		scene = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_background_a.prefab",
		section1 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section01.prefab",
		section6 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section06.prefab",
		role3 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_xiaoyenisai_a.prefab",
		role6 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_xiaoyenisai_b.prefab",
		section3 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section03.prefab",
		role1 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_getian_a.prefab",
		role4 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_getian_b.prefab",
		section5 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section05.prefab",
		section2 = "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_m_s15_section02.prefab",
		role2 = "scenes/v1a6_m_s15_sj_wcmt/perfab/v1a6_m_s15_quniang_b.prefab"
	}
}
module_views.Season1_6MarketView = {
	destroy = 0,
	container = "Season1_6MarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a6_season/seasonmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_6SpecialMarketView = {
	destroy = 0,
	container = "Season1_6SpecialMarketViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/v1a6_season/seasonspecialmarketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_6RetailView = {
	destroy = 0,
	container = "Season1_6RetailViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonretailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_6RetailLevelInfoView = {
	destroy = 0,
	container = "Season1_6RetailLevelInfoViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonretaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season1_6TaskView = {
	destroy = 0,
	container = "Season1_6TaskViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasontaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasontaskitem.prefab"
	}
}
module_views.Season1_6SettlementView = {
	destroy = 0,
	container = "Season1_6SettlementViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonsettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/v1a6_season/seasonsettlementherogroupitem.prefab"
	}
}
module_views.Season1_6CelebrityCardGetlView = {
	destroy = 0,
	container = "Season1_6CelebrityCardGetlViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasoncelebritycardgetlview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_6EquipView = {
	bgBlur = 0,
	container = "Season1_6EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_6EquipHeroView = {
	bgBlur = 0,
	container = "Season1_6EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipcarditem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_6FightFailView = {
	destroy = 0,
	container = "Season1_6FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasonfightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_6FightSuccView = {
	destroy = 0,
	container = "Season1_6FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasonfightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_6StoreView = {
	destroy = 0,
	container = "Season1_6StoreViewContainer",
	mainRes = "ui/viewres/v1a6_season/seasonstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		itemPath = "ui/viewres/v1a6_season/seasonstoreitem.prefab"
	}
}
module_views.Season1_6EquipSelfChoiceView = {
	destroy = 0,
	container = "Season1_6EquipSelfChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasonmulticardchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonmulticardchoiceitem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_6CelebrityCardTipView = {
	container = "Season1_6CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v1a6_season/seasoncelebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_6EquipComposeView = {
	bgBlur = 0,
	container = "Season1_6EquipComposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipcomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipcomposeitem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_6EquipBookView = {
	bgBlur = 0,
	container = "Season1_6EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonequipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/v1a6_season/seasonequipbookitem.prefab",
		[2] = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"
	}
}
module_views.Season1_6FightRuleTipView = {
	destroy = 0,
	container = "Season1_6FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a6_season/seasonfightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/v1a6_season/seasonfightruleview.prefab"
			},
			{
				"ui/viewres/v1a6_season/seasonfightcardview.prefab"
			}
		}
	}
}
module_views.Season1_6HeroGroupFightView = {
	bgBlur = 4,
	container = "Season1_6HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/v1a6_season/seasonherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season1_6AdditionRuleTipView = {
	destroy = 0,
	container = "Season1_6AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v1a6_season/seasonadditionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season1_6SumView = {
	destroy = 0,
	container = "Season1_6SumViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/v1a6_season/seasonsumview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V1a6_Spring_PanelSignView = {
	destroy = 0,
	container = "V1a6_Spring_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a6_spring_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a6_spring_signitem.prefab"
	}
}
module_views.FurnaceTreasureView = {
	destroy = 0,
	container = "FurnaceTreasureViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_secretstore/v1a6_secretstore_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FurnaceTreasureBuyView = {
	destroy = 0,
	container = "FurnaceTreasureBuyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_secretstore/v1a6_secretstore_buyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.ReactivityStoreView = {
	destroy = 0,
	container = "ReactivityStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.ReactivityRuleView = {
	destroy = 0,
	container = "ReactivityRuleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/reprint_ruleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.ReactivityTaskView = {
	bgBlur = 3,
	container = "ReactivityTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_taskview.prefab",
	destroy = 0,
	blurFactor = 0.64,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_taskitem.prefab"
	}
}
module_views.LimitedRoleView = {
	destroy = 0,
	container = "LimitedRoleViewContainer",
	mainRes = "ui/viewres/main/limitedroleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity1_6WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_6WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_6/v1a6_warmup/v1a6_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity1_7WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_7WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_warmup/v1a7_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		mapRes = "ui/viewres/versionactivity_1_7/v1a7_warmup/v1a7_warmupmap.prefab"
	}
}
module_views.VersionActivity1_7EnterView = {
	destroy = 0,
	container = "VersionActivity1_7EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_enter/v1a7_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_7/v1a7_enter/v1a7_enterview_dungeon.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_v1a2reprint/v1a7_v1a2reprint_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_7/v1a7_season/v1a7_season_enterview.prefab"
			}
		}
	}
}
module_views.VersionActivity1_7StoreView = {
	destroy = 0,
	container = "VersionActivity1_7StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_dungeon/v1a7_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_7TaskView = {
	destroy = 0,
	container = "VersionActivity1_7TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_dungeon/v1a7_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_7/v1a7_dungeon/v1a7_taskitem.prefab"
	}
}
module_views.ActIsoldeLevelView = {
	destroy = 0,
	container = "ActIsoldeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_levelviewstageitem2.prefab"
	}
}
module_views.ActIsoldeTaskView = {
	bgBlur = 0,
	container = "ActIsoldeTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_isolde/v1a7_isolde_taskitem.prefab"
	}
}
module_views.ActMarcusLevelView = {
	destroy = 0,
	container = "ActMarcusLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_levelviewstageitem2.prefab"
	}
}
module_views.ActMarcusTaskView = {
	bgBlur = 0,
	container = "ActMarcusTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_7/v1a7_marcus/v1a7_marcus_taskitem.prefab"
	}
}
module_views.V1a7_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a7_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a7_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
module_views.V1a7_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a7_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a7_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
module_views.V1a7_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a7_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a7_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
module_views.V1a7_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a7_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a7_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a7_role_signitem.prefab"
	}
}
module_views.V1a7_DoubleDropView = {
	destroy = 0,
	container = "V1a7_DoubleDropViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a7_doubledrop.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.FullScreenVideoView = {
	destroy = 0,
	container = "FullScreenVideoViewContainer",
	mainRes = "ui/viewres/battlepass/bpvideoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LanternFestivalQuestionTipView = {
	destroy = 0,
	container = "LanternFestivalQuestionTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_questionpanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.LanternFestivalActivityView = {
	destroy = 0,
	container = "LanternFestivalActivityViewContainer",
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_item.prefab"
	}
}
module_views.LanternFestivalView = {
	bgBlur = 1,
	container = "LanternFestivalViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_7/v1a7_lamp/v1a7_lamp_item.prefab"
	}
}
module_views.VersionActivity1_8EnterView = {
	destroy = 0,
	container = "VersionActivity1_8EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_enter/v1a8_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_8/v1a8_enter/v1a8_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_3/map/v1a8_v1a3reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_8/v1a8_season/v1a8_season_enterview.prefab"
			}
		}
	}
}
module_views.VersionActivity1_8DungeonMapView = {
	destroy = 0,
	container = "VersionActivity1_8DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_8DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity1_8DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_8StoreView = {
	destroy = 0,
	container = "VersionActivity1_8StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_8TaskView = {
	destroy = 0,
	container = "VersionActivity1_8TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_taskitem.prefab"
	}
}
module_views.VersionActivity1_8DispatchView = {
	destroy = 0,
	container = "VersionActivity1_8DispatchViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_dispatchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity1_8FactoryMapView = {
	destroy = 0,
	container = "VersionActivity1_8FactoryMapViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factorymapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_dungeon/mapline/v1a8_mapline.prefab"
	}
}
module_views.VersionActivity1_8FactoryBlueprintView = {
	destroy = 0,
	container = "VersionActivity1_8FactoryBlueprintViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factoryblueprintview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_8FactoryRepairView = {
	bgBlur = 1,
	container = "VersionActivity1_8FactoryRepairViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factoryrepairview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factoryrepairitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_8FactoryCompositeView = {
	destroy = 0,
	container = "VersionActivity1_8FactoryCompositeViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_dungeon/v1a8_factorycompositeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V1a8_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a8_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a8_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
module_views.V1a8_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a8_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a8_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
module_views.V1a8_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a8_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a8_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
module_views.V1a8_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a8_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a8_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_role_signitem.prefab"
	}
}
module_views.ActWeilaLevelView = {
	destroy = 0,
	container = "ActWeilaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_levelviewstageitem2.prefab"
	}
}
module_views.ActWeilaTaskView = {
	bgBlur = 0,
	container = "ActWeilaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_weila/v1a8_weila_taskitem.prefab"
	}
}
module_views.ActWindSongLevelView = {
	destroy = 0,
	container = "ActWindSongLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_levelviewstageitem2.prefab"
	}
}
module_views.ActWindSongTaskView = {
	bgBlur = 0,
	container = "ActWindSongTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_8/v1a8_windsong/v1a8_windsong_taskitem.prefab"
	}
}
module_views.VersionActivity1_8WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_8WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_8/v1a8_warmup/v1a8_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a8_Work_FullSignView = {
	destroy = 0,
	container = "V1a8_Work_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a8_work_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_work_signitem.prefab"
	}
}
module_views.V1a8_Work_PanelSignView = {
	destroy = 0,
	container = "V1a8_Work_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a8_work_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a8_work_signitem.prefab"
	}
}
module_views.Season123_2_3EntryView = {
	destroy = 0,
	container = "Season123_2_3EntryViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123_2_3EntryOverview = {
	destroy = 0,
	container = "Season123_2_3EntryOverviewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123entryoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123_2_3RetailView = {
	destroy = 0,
	container = "Season123_2_3RetailViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123retaillevelinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Season123_2_3HeroGroupFightView = {
	bgBlur = 4,
	container = "Season123_2_3HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season123_2_3EpisodeListView = {
	destroy = 0,
	container = "Season123_2_3EpisodeListViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123episodelistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123_2_3EpisodeLoadingView = {
	destroy = 0,
	container = "Season123_2_3EpisodeLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123episodeloadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Season123_2_3EpisodeDetailView = {
	destroy = 0,
	container = "Season123_2_3EpisodeDetailViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123marketview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123_2_3PickAssistView = {
	destroy = 0,
	container = "Season123_2_3PickAssistViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123pickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123pickassistitem.prefab"
	}
}
module_views.Season123_2_3HeroGroupEditView = {
	container = "Season123_2_3HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123herogroupedititem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.Season123_2_3PickHeroEntryView = {
	destroy = 0,
	container = "Season123_2_3PickHeroEntryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123pickheroentryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3PickHeroView = {
	destroy = 0,
	container = "Season123_2_3PickHeroViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123pickheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123pickheroitem.prefab"
	}
}
module_views.Season123_2_3StageLoadingView = {
	destroy = 0,
	container = "Season123_2_3StageLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123loadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Season123_2_3StageFinishView = {
	destroy = 0,
	container = "Season123_2_3StageFinishViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123stagefinishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Season123_2_3ShowHeroView = {
	destroy = 0,
	container = "Season123_2_3ShowHeroViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123showheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3EquipHeroView = {
	bgBlur = 0,
	container = "Season123_2_3EquipHeroViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123equipheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3EquipView = {
	bgBlur = 0,
	container = "Season123_2_3EquipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123equipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123equipcarditem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3EnemyView = {
	bgBlur = 1,
	container = "Season123_2_3EnemyViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123enemyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"#simage_bg",
		"#simage_rightbg"
	}
}
module_views.Season123_2_3StoreView = {
	destroy = 0,
	container = "Season123_2_3StoreViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123storeitem.prefab"
	}
}
module_views.Season123_2_3TaskView = {
	destroy = 0,
	container = "Season123_2_3TaskViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123taskitem.prefab"
	}
}
module_views.Season123_2_3EquipBookView = {
	bgBlur = 0,
	container = "Season123_2_3EquipBookViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123equipbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123equipbookitem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3BatchDecomposeView = {
	bgBlur = 0,
	container = "Season123_2_3BatchDecomposeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123batchdecomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123decomposeitem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3DecomposeFilterView = {
	destroy = 10,
	container = "Season123_2_3DecomposeFilterViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123decomposefilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Season123_2_3DecomposeView = {
	container = "Season123_2_3DecomposeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123decomposeview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3CelebrityCardTipView = {
	container = "Season123_2_3CelebrityCardTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123celebritycardtipview.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3CelebrityCardGetView = {
	destroy = 0,
	container = "Season123_2_3CelebrityCardGetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123celebritycardgetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123_2_3CardPackageView = {
	bgBlur = 1,
	container = "Season123_2_3CardPackageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123cardpackageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/v2a3_act123/season123cardpackageitem.prefab",
		[2] = "ui/viewres/seasonver/v2a3_act123/season123celebritycarditem.prefab"
	}
}
module_views.Season123_2_3StoryView = {
	destroy = 0,
	container = "Season123_2_3StoryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season123_2_3StoryPagePopView = {
	destroy = 0,
	container = "Season123_2_3StoryPagePopViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123storypagepopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123_2_3RecordWindow = {
	destroy = 0,
	container = "Season123_2_3RecordWindowContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123recordwindow.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123_2_3FightSuccView = {
	destroy = 0,
	container = "Season123_2_3FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123_2_3FightFailView = {
	destroy = 0,
	container = "Season123_2_3FightFailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123fightfailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123_2_3SettlementView = {
	destroy = 0,
	container = "Season123_2_3SettlementViewContainer",
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		itemRes = "ui/viewres/seasonver/v2a3_act123/season123settlementherogroupitem.prefab"
	}
}
module_views.Season123_2_3AdditionRuleTipView = {
	destroy = 0,
	container = "Season123_2_3AdditionRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123additionruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Season123_2_3FightRuleTipView = {
	destroy = 0,
	container = "Season123_2_3FightRuleTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123fightruletipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/seasonver/v2a3_act123/season123fightruleview.prefab"
			},
			{
				"ui/viewres/seasonver/v2a3_act123/season123fightcardview.prefab"
			}
		}
	}
}
module_views.Season123_2_3ResetView = {
	destroy = 0,
	container = "Season123_2_3ResetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/v2a3_act123/season123resetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.FightWaveChangeView = {
	destroy = 0,
	container = "FightWaveChangeViewContainer",
	mainRes = "ui/viewres/fight/fightwavechangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.GMFightEntityView = {
	destroy = 0,
	container = "GMFightEntityViewContainer",
	mainRes = "ui/viewres/gm/gmfightentityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.PickAssistView = {
	destroy = 0,
	container = "PickAssistViewContainer",
	mainRes = "ui/viewres/pickassist/pickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/pickassist/pickassistitem.prefab"
	}
}
module_views.BGMSwitchView = {
	bgBlur = 0,
	container = "BGMSwitchViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/bgmswitch/bgmswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/animations/dynamic/maincamera.controller"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.BGMSwitchMusicFilterView = {
	destroy = 0,
	container = "BGMSwitchMusicFilterViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/bgmswitch/bgmswitchfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RougeMapView = {
	bgBlur = 0,
	container = "RougeMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougemapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CommonHeroGroupItem,
		RougeEnum.ResPath.CommonLvItem,
		RougeEnum.ResPath.CoinView
	}
}
module_views.RougeMapChoiceView = {
	bgBlur = 0,
	container = "RougeMapChoiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge/map/rougechoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/rouge/map/rougemapchoiceitem.prefab",
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CommonHeroGroupItem,
		RougeEnum.ResPath.CommonLvItem,
		RougeEnum.ResPath.CommonCollectionSlotItem,
		RougeEnum.ResPath.CoinView
	}
}
module_views.RougeMapPieceChoiceView = {
	bgBlur = 0,
	container = "RougeMapPieceChoiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge/map/rougechoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/rouge/map/rougemapchoiceitem.prefab",
		"ui/viewres/rouge/map/rougemapchoiceoptionitem.prefab",
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CommonHeroGroupItem,
		RougeEnum.ResPath.CommonLvItem,
		RougeEnum.ResPath.CommonCollectionSlotItem,
		RougeEnum.ResPath.CoinView
	}
}
module_views.RougeCollectionDropView = {
	bgBlur = 0,
	container = "RougeCollectionDropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeBossCollectionDropView = {
	bgBlur = 0,
	container = "RougeBossCollectionDropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/dlc/103/rougebosscollectionselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeActivityTaskView = {
	destroy = 0,
	container = "RougeActivityTaskViewContainer",
	mainRes = "ui/viewres/rouge/rougeactivitytaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/rouge/rougeactivitytaskitem.prefab"
	}
}
module_views.RougeStoreView = {
	destroy = 0,
	container = "RougeMapStoreViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge/map/rougestoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CoinView,
		RougeEnum.ResPath.CommonCollectionItem
	}
}
module_views.RougeStoreGoodsView = {
	bgBlur = 1,
	container = "RougeStoreGoodsViewContainer",
	destroy = 10,
	mainRes = "ui/viewres/rouge/map/rougestoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		RougeEnum.ResPath.CoinView
	},
	tabRes = {
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeFinishView = {
	destroy = 0,
	container = "RougeFinishViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge/map/rougefinishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RougeNextLayerView = {
	destroy = 0,
	container = "RougeNextLayerViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge/map/rougenextlayerview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RougeMapCollectionAbandonView = {
	bgBlur = 0,
	container = "RougeMapCollectionAbandonViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionabandonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeMapEnum.CollectionLeftItemRes,
		RougeMapEnum.CollectionRightItemRes
	}
}
module_views.RougeMapCollectionExchangeView = {
	bgBlur = 0,
	container = "RougeMapCollectionExchangeViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionexchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeMapEnum.CollectionLeftItemRes,
		RougeMapEnum.CollectionRightItemRes
	}
}
module_views.RougeMapCollectionStorageView = {
	bgBlur = 0,
	container = "RougeMapCollectionStorageViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/map/rougecollectionstoageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeMapEnum.CollectionLeftItemRes,
		RougeMapEnum.CollectionRightItemRes
	}
}
module_views.RougeMapTipView = {
	destroy = 0,
	container = "RougeMapTipViewContainer",
	mainRes = "ui/viewres/rouge/map/rougemaptipview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.RougeLevelUpView = {
	destroy = 0,
	container = "RougeLevelUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/map/rougelevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RougeFightSuccessView = {
	destroy = 0,
	container = "RougeFightSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/fight/rougefightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RougeFavoriteView = {
	destroy = 0,
	container = "RougeFavoriteViewContainer",
	mainRes = "ui/viewres/rouge/rougefavoriteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeResultReportView = {
	destroy = 0,
	container = "RougeResultReportViewContainer",
	mainRes = "ui/viewres/rouge/rougeresultreportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/rouge/rougeresultreportitem.prefab",
		[2] = "ui/viewres/rouge/rougeresultheroitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeFavoriteCollectionView = {
	destroy = 0,
	container = "RougeFavoriteCollectionViewContainer",
	mainRes = "ui/viewres/rouge/rougefavoritecollectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/rouge/rougecollectionlistitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/rouge/rougecollectionlistview.prefab"
			},
			{
				"ui/viewres/rouge/rougecollectionhandbookview.prefab"
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeReviewView = {
	destroy = 0,
	container = "RougeReviewViewContainer",
	mainRes = "ui/viewres/rouge/rougereviewview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougereviewitem.prefab"
	}
}
module_views.RougeIllustrationListView = {
	destroy = 0,
	container = "RougeIllustrationListViewContainer",
	mainRes = "ui/viewres/rouge/rougeillustrationlistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeillustrationlistpage.prefab",
		[2] = "ui/viewres/rouge/rougeillustrationlistitem.prefab"
	}
}
module_views.RougeIllustrationDetailView = {
	destroy = 0,
	container = "RougeIllustrationDetailViewContainer",
	mainRes = "ui/viewres/rouge/rougeillustrationdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeFactionIllustrationView = {
	destroy = 0,
	container = "RougeFactionIllustrationViewContainer",
	mainRes = "ui/viewres/rouge/rougefactionillustrationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougefactionillustrationitem.prefab"
	}
}
module_views.RougeFactionIllustrationDetailView = {
	destroy = 0,
	container = "RougeFactionIllustrationDetailViewContainer",
	mainRes = "ui/viewres/rouge/rougefactionillustrationdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougefactionillustrationdetailitem.prefab"
	}
}
module_views.RougeTalentView = {
	destroy = 0,
	container = "RougeTalentViewContainer",
	mainRes = "ui/viewres/rouge/rougetalentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeInitTeamView = {
	destroy = 0,
	container = "RougeInitTeamViewContainer",
	mainRes = "ui/viewres/rouge/rougeinitteamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/rouge/rougeherogroupedititem.prefab",
		[2] = RougeEnum.ResPath.rougepageprogress
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougePickAssistView = {
	destroy = 0,
	container = "RougePickAssistViewContainer",
	mainRes = "ui/viewres/rouge/rougepickassistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougepickassistitem.prefab"
	}
}
module_views.RougeTeamView = {
	destroy = 0,
	container = "RougeTeamViewContainer",
	mainRes = "ui/viewres/rouge/rougeteamview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeherogroueffectitem.prefab"
	}
}
module_views.RougeHeroGroupFightView = {
	bgBlur = 4,
	container = "RougeHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/rougeherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.RougeMainView = {
	destroy = 0,
	container = "RougeMainViewContainer",
	mainRes = "ui/viewres/rouge/rougemainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeHeroGroupEditView = {
	container = "RougeHeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/rouge/rougeherogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeherogroupedititem.prefab",
		[2] = "ui/viewres/rouge/rougeherogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.RougeDifficultyView = {
	destroy = 0,
	container = "RougeDifficultyViewContainer",
	mainRes = "ui/viewres/rouge/rougedifficultyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.rougedifficultyitem,
		RougeEnum.ResPath.rougepageprogress
	}
}
module_views.RougeCollectionGiftView = {
	destroy = 0,
	container = "RougeCollectionGiftViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectiongiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.rougepageprogress
	}
}
module_views.RougeFactionView = {
	destroy = 0,
	container = "RougeFactionViewContainer",
	mainRes = "ui/viewres/rouge/rougefactionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.rougefactionitem,
		RougeEnum.ResPath.rougepageprogress
	}
}
module_views.RougeRewardNoticeView = {
	destroy = 0,
	container = "RougeRewardNoticeViewContainer",
	mainRes = "ui/viewres/rouge/rougerewardnoticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeRewardView = {
	destroy = 0,
	container = "RougeRewardViewContainer",
	mainRes = "ui/viewres/rouge/rougerewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougerewardThemeTipView = {
	destroy = 0,
	container = "RougerewardThemeTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/rougerewardthemetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RougeCollectionChessView = {
	destroy = 0,
	container = "RougeCollectionChessViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionchessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		RougeEnum.ResPath.CollectionIconItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeCollectionTipView = {
	destroy = 0,
	container = "RougeCollectionTipViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectiontipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeCollectionEnchantView = {
	destroy = 0,
	container = "RougeCollectionEnchantViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionenchantview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeCollectionOverView = {
	destroy = 0,
	container = "RougeCollectionOverViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RougeEnum.ResPath.CollectionIconItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeCollectionFilterView = {
	destroy = 0,
	container = "RougeCollectionFilterViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.RougeCollectionCompositeView = {
	destroy = 0,
	container = "RougeCollectionCompositeViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectioncompositeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		RougeEnum.ResPath.CollectionIconItem,
		RougeEnum.ResPath.CommonCollectionItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeCollectionHandBookView = {
	destroy = 0,
	container = "RougeCollectionHandBookViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectionhandbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeCollectionInitialView = {
	destroy = 0,
	container = "RougeCollectionInitialViewContainer",
	mainRes = "ui/viewres/rouge/rougecollectioninitialview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	}
}
module_views.RougeEndingThreeView = {
	destroy = 0,
	container = "RougeEndingThreeViewContainer",
	mainRes = "ui/viewres/rouge/rougeendingthreeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal
}
module_views.RougeResultView = {
	destroy = 0,
	container = "RougeResultViewContainer",
	mainRes = "ui/viewres/rouge/rougeresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeSettlementView = {
	destroy = 0,
	container = "RougeSettlementViewContainer",
	mainRes = "ui/viewres/rouge/rougesettlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeResultReView = {
	destroy = 0,
	container = "RougeResultReViewContainer",
	mainRes = "ui/viewres/rouge/rougeresultreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge/rougeresultheroitem.prefab"
	}
}
module_views.RougeTalentTreeTrunkView = {
	destroy = 0,
	container = "RougeTalentTreeTrunkViewContainer",
	mainRes = "ui/viewres/rouge/tree/rougetalenttreeview_trunk.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		branchitem = "ui/viewres/rouge/tree/rougetalenttreeitem.prefab"
	}
}
module_views.RougeTalentTreeView = {
	destroy = 0,
	container = "RougeTalentTreeViewContainer",
	mainRes = "ui/viewres/rouge/tree/rougetalenttreeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_1.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_2.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_3.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_4.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_5.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_6.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_7.prefab"
			},
			{
				"ui/viewres/rouge/tree/rougetalenttreeview_branch_8.prefab"
			}
		}
	},
	otherRes = {
		branchitem = "ui/viewres/rouge/tree/rougetalenttreeitem.prefab"
	}
}
module_views.RougeTalentTreeOverview = {
	destroy = 0,
	container = "RougeTalentTreeOverviewContainer",
	mainRes = "ui/viewres/rouge/tree/rougetalenttreeoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeOpenGuideView = {
	destroy = 0,
	container = "RougeOpenGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/guide/rougeguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RougeDLCSelectView = {
	destroy = 0,
	container = "RougeDLCSelectViewContainer",
	mainRes = "ui/viewres/rouge/dlc/rougedlcselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RougeDLCTipsView = {
	destroy = 0,
	container = "RougeDLCTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/rougedlctipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.DecalogPresentView = {
	destroy = 0,
	container = "DecalogPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_versionsummon.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V1a9DecalogPresentFullView = {
	destroy = 0,
	container = "V1a9DecalogPresentFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RougeLimiterView = {
	destroy = 0,
	container = "RougeLimiterViewContainer",
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		LimiterGroupItem = "ui/viewres/rouge/dlc/101/rougelimiterdebuffitem.prefab",
		LimiterItem = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
	}
}
module_views.RougeLimiterLockedTipsView = {
	destroy = 0,
	container = "RougeLimiterLockedTipsViewContainer",
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterlockedtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RougeLimiterBuffView = {
	destroy = 0,
	container = "RougeLimiterBuffViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterbuffview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		BuffItem = "ui/viewres/rouge/dlc/101/rougelimiterbuffitem.prefab",
		LimiterItem = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
	}
}
module_views.RougeLimiterOverView = {
	destroy = 0,
	container = "RougeLimiterOverViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiteroverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				"ui/viewres/rouge/dlc/101/rougelimiterdebuffoverview.prefab"
			},
			{
				"ui/viewres/rouge/dlc/101/rougelimiterbuffoverview.prefab"
			}
		}
	}
}
module_views.RougeLimiterResultView = {
	destroy = 0,
	container = "RougeLimiterResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/dlc/101/rougelimiterresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RougeDangerousView = {
	destroy = 0,
	container = "RougeDangerousViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/rouge/dlc/101/rougedangerousview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.RougeFactionLockedTips = {
	destroy = 0,
	container = "RougeFactionLockedTipsContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge/rougefactionlockedtips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RougeCollectionLevelUpView = {
	bgBlur = 0,
	container = "RougeCollectionLevelUpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge/dlc/102/rougecollectionlevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RougeEnum.ResPath.CollectionDetailBtnItem
			}
		}
	},
	otherRes = {
		RougeEnum.ResPath.CommonCollectionItem,
		RougeEnum.ResPath.CollectionLevelUpLeftItem,
		RougeEnum.ResPath.CollectionLevelUpRightItem
	}
}
module_views.FairyLandOptionView = {
	destroy = 0,
	container = "FairyLandOptionViewContainer",
	bgBlur = 2,
	mainRes = "ui/viewres/fairyland/fairylandoptionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.FairyLandView = {
	destroy = 0,
	container = "FairyLandViewContainer",
	mainRes = "ui/viewres/fairyland/fairylandview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		scene = "scenes/v1a9_m_s14_hhdt/v1a9_m_s14_hddt_p.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.FairyLandCompleteView = {
	destroy = 0,
	container = "FairyLandCompleteViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fairyland/fairylandcompleteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.ToughBattleEnterView = {
	destroy = 0,
	container = "ToughBattleEnterViewContainer",
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattle_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		word = "ui/viewres/dungeon/toughbattle/toughbattle_mainview_word.prefab"
	}
}
module_views.ToughBattleMapView = {
	destroy = 0,
	container = "ToughBattleMapViewContainer",
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattlemapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		rolelist = "ui/viewres/dungeon/toughbattle/toughbattle_supportrolelistview.prefab"
	}
}
module_views.ToughBattleLoadingView = {
	bgBlur = 3,
	container = "ToughBattleLoadingViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattleloadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.ToughBattleEnemyInfoView = {
	bgBlur = 1,
	container = "ToughBattleEnemyInfoViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattle_enemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.ToughBattleSkillView = {
	bgBlur = 1,
	container = "ToughBattleSkillViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dungeon/toughbattle/toughbattle_supportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		rolelist = "ui/viewres/dungeon/toughbattle/toughbattle_supportrolelistview.prefab"
	}
}
module_views.ToughBattleActEnterView = module_views.ToughBattleEnterView
module_views.ToughBattleActMapView = module_views.ToughBattleMapView
module_views.ToughBattleActLoadingView = module_views.ToughBattleLoadingView
module_views.ToughBattleFightSuccView = {
	destroy = 0,
	container = "ToughBattleFightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.InvestigateClueView = {
	destroy = 0,
	container = "InvestigateClueViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/investigate/investigateclueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.InvestigateView = {
	destroy = 0,
	container = "InvestigateViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigateroleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.InvestigateOpinionTabView = {
	destroy = 0,
	container = "InvestigateOpinionTabViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigateopiniontabview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/dungeon/investigate/investigateopinionitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/dungeon/investigate/investigateopinionview.prefab"
			},
			{
				"ui/viewres/dungeon/investigate/investigateopinionextendview.prefab"
			}
		}
	}
}
module_views.InvestigateRoleStoryView = {
	destroy = 0,
	container = "InvestigateRoleStoryViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigaterolestory.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.InvestigateTaskView = {
	destroy = 0,
	container = "InvestigateTaskViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigatetaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/dungeon/investigate/investigatetaskitem.prefab"
	}
}
module_views.InvestigateTipsView = {
	destroy = 0,
	container = "InvestigateTipsViewContainer",
	mainRes = "ui/viewres/dungeon/investigate/investigatetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.BalanceUmbrellaClueView = {
	destroy = 0,
	container = "BalanceUmbrellaClueViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/balanceumbrella/balanceumbrellaclueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.BalanceUmbrellaView = {
	destroy = 0,
	container = "BalanceUmbrellaViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/balanceumbrella/balanceumbrellaview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_9EnterView = {
	destroy = 0,
	container = "VersionActivity1_9EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_enterview_dungeon.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_season/v1a9_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_rouge/v1a9_rouge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_9/v1a9_explore/v1a9_explore_enterview.prefab"
			}
		}
	}
}
module_views.VersionActivity1_9StoreView = {
	destroy = 0,
	container = "VersionActivity1_9StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_dungeon/v1a9_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity1_9TaskView = {
	destroy = 0,
	container = "VersionActivity1_9TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_1_9/v1a9_enter/v1a9_taskitem.prefab"
	}
}
module_views.RoomGiftView = {
	destroy = 0,
	container = "RoomGiftViewContainer",
	mainRes = "ui/viewres/activity/v1a9_roomgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V1a9DecalogPresentView = {
	destroy = 0,
	container = "V1a9DecalogPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_versionsummon.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SemmelWeisGiftView = {
	destroy = 0,
	container = "SemmelWeisGiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_semmelweisgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.SemmelWeisGiftFullView = {
	destroy = 0,
	container = "SemmelWeisGiftFullViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_semmelweisgiftfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V1a9_MatildagiftView = {
	destroy = 0,
	container = "V1a9_MatildagiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_matildagiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V1a9_ActivityShow_MatildagiftView = {
	destroy = 0,
	container = "V1a9_ActivityShow_MatildagiftViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_matildagiftfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.HeroInvitationView = {
	destroy = 0,
	container = "HeroInvitationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/heroinvitation/invitationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/dungeon/heroinvitation/invitationitem.prefab"
	}
}
module_views.HeroInvitationDungeonMapView = {
	destroy = 0,
	container = "HeroInvitationDungeonMapViewContainer",
	mainRes = "ui/viewres/dungeon/heroinvitation/dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.OptionPackageDownloadView = {
	destroy = 0,
	container = "OptionPackageDownloadViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/optionpackage/optionpackagedownloadview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V1a9_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V1a9_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a9_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
module_views.V1a9_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V1a9_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a9_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
module_views.V1a9_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V1a9_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a9_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
module_views.V1a9_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V1a9_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a9_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_role_signitem.prefab"
	}
}
module_views.DragonBoatFestivalQuestionTipView = {
	destroy = 0,
	container = "DragonFestivalQuestionTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dragonboat/dragonboat_questionpanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.DragonBoatFestivalActivityView = {
	destroy = 0,
	container = "DragonBoatFestivalActivityViewContainer",
	mainRes = "ui/viewres/dragonboat/dragonboat_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/dragonboat/dragonboat_item.prefab"
	}
}
module_views.DragonBoatFestivalView = {
	bgBlur = 1,
	container = "DragonBoatFestivalViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/dragonboat/dragonboat_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/dragonboat/dragonboat_item.prefab"
	}
}
module_views.V1a9_AnniversarySign_PanelSignView = {
	destroy = 0,
	container = "V1a9_AnniversarySign_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v1a9_anniversarysign_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_anniversarysign_signitem.prefab"
	}
}
module_views.V1a9_AnniversarySign_FullSignView = {
	destroy = 0,
	container = "V1a9_AnniversarySign_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v1a9_anniversarysign_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v1a9_anniversarysign_signitem.prefab"
	}
}
module_views.ActLucyLevelView = {
	destroy = 0,
	container = "ActLucyLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_levelviewstageitem2.prefab"
	}
}
module_views.ActLucyTaskView = {
	bgBlur = 0,
	container = "ActLucyTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_lucy/v1a9_lucy_taskitem.prefab"
	}
}
module_views.ActKaKaNiaLevelView = {
	destroy = 0,
	container = "ActKaKaNiaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_levelviewstageitem2.prefab"
	}
}
module_views.ActKaKaNiaTaskView = {
	bgBlur = 0,
	container = "ActKaKaNiaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_1_9/v1a9_kakania/v1a9_kakania_taskitem.prefab"
	}
}
module_views.VersionActivity1_9WarmUpView = {
	destroy = 0,
	container = "VersionActivity1_9WarmUpViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_1_9/v1a9_warmup/v1a9_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Permanent1_1EnterView = {
	destroy = 0,
	container = "Permanent1_1EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a1_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_2EnterView = {
	destroy = 0,
	container = "Permanent1_2EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a2_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_3EnterView = {
	destroy = 0,
	container = "Permanent1_3EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a3_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_4EnterView = {
	destroy = 0,
	container = "Permanent1_4EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a4_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_5EnterView = {
	destroy = 0,
	container = "Permanent1_5EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a5_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_6EnterView = {
	destroy = 0,
	container = "Permanent1_6EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a6_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_7EnterView = {
	destroy = 0,
	container = "Permanent1_7EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a7_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_8EnterView = {
	destroy = 0,
	container = "Permanent1_8EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a8_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent1_9EnterView = {
	destroy = 0,
	container = "Permanent1_9EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a9_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_0EnterView = {
	destroy = 0,
	container = "Permanent2_0EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/a10_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}

ActivityWelfareViewDefine.init(module_views)

module_views.GMErrorView = {
	destroy = 0,
	container = "GMErrorViewContainer",
	mainRes = "ui/viewres/gm/gmerrorview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity2_0EnterView = {
	destroy = 0,
	container = "VersionActivity2_0EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_enter/v2a0_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_0/v2a0_enter/v2a0_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_season/v2a0_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_v1a5reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_0StoreView = {
	destroy = 0,
	container = "VersionActivity2_0StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_0TaskView = {
	destroy = 0,
	container = "VersionActivity2_0TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_taskitem.prefab"
	}
}
module_views.VersionActivity2_0DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_0DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_0DungeonMapGraffitiEnterView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonMapGraffitiEnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeonmapgraffitienterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity2_0DungeonGraffitiView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonGraffitiViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeongraffitiview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeongraffitiitem.prefab",
		"ui/materials/dynamic/ui_halfgray2.mat",
		"ui/materials/dynamic/ui_halfgray.mat"
	}
}
module_views.VersionActivity2_0DungeonGraffitiDrawView = {
	destroy = 0,
	container = "VersionActivity2_0DungeonGraffitiDrawViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_dungeon/v2a0_dungeongraffitidrawview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a0_SummerSign_PanelView = {
	destroy = 0,
	container = "V2a0_SummerSign_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a0_summersign_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_summersign_signitem.prefab"
	}
}
module_views.V2a0_SummerSign_FullView = {
	destroy = 0,
	container = "V2a0_SummerSign_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a0_summersign_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_summersign_signitem.prefab"
	}
}
module_views.V2a0_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a0_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a0_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
module_views.V2a0_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a0_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a0_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
module_views.V2a0_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a0_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a0_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
module_views.V2a0_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a0_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a0_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a0_role_signitem.prefab"
	}
}
module_views.V2a0_WarmUp = {
	destroy = 0,
	container = "V2a0_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_warmup/v2a0_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ActMercuriaLevelView = {
	destroy = 0,
	container = "ActMercuriaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_levelviewstageitem2.prefab"
	}
}
module_views.ActMercuriaTaskView = {
	bgBlur = 0,
	container = "ActMercuriaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_mercuria/v2a0_mercuria_taskitem.prefab"
	}
}
module_views.ActJoeLevelView = {
	destroy = 0,
	container = "ActJoeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_levelviewstageitem.prefab",
		[2] = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_levelviewstageitem2.prefab"
	}
}
module_views.ActJoeTaskView = {
	bgBlur = 0,
	container = "ActJoeTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_0/v2a0_joe/v2a0_joe_taskitem.prefab"
	}
}
module_views.OptionalChargeView = {
	destroy = 0,
	container = "OptionalChargeViewContainer",
	mainRes = "ui/viewres/store/optionalgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.OptionalGroupChargeView = {
	destroy = 0,
	container = "OptionalGroupChargeViewContainer",
	mainRes = "ui/viewres/store/optionalgroupchargeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.PlayerCardView = {
	container = "PlayerCardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/personalcard/playercardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		achieveview = "ui/viewres/player/personalcard/playercardachieveview.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab",
		groupview = "ui/viewres/player/personalcard/playercardgroupview.prefab",
		carditem = "ui/viewres/player/personalcard/playercarditem.prefab",
		assitview = "ui/viewres/player/personalcard/playercardassitview.prefab",
		chapterview = "ui/viewres/player/personalcard/playercardchapterview.prefab",
		infoview = "ui/viewres/player/personalcard/playercardinfoview.prefab"
	}
}
module_views.NewPlayerCardView = {
	container = "NewPlayerCardViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/playercard/playercardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
module_views.NewPlayerCardContentView = {
	container = "NewPlayerCardContentViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/player/playercard/playercardcontentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		badge = "ui/viewres/player/playercard/playercard_socialbadgeview.prefab",
		switch = "ui/viewres/player/playercard/playercard_socialbadgeswitchview.prefab",
		misihaiitem = "ui/viewres/player/playercard/playercardachieve_misihai.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab",
		skinpreview = "ui/viewres/player/playercard/playercardskinpreview.prefab"
	}
}
module_views.PlayerCardEnterSettingView = {
	destroy = 0,
	container = "PlayerCardEnterSettingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/playercard/playercardsettingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Model
}
module_views.PlayerCardCritterPlaceView = {
	destroy = 0,
	container = "PlayerCardCritterPlaceViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardcritterplaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PlayerCardBaseInfoView = {
	destroy = 0,
	container = "PlayerCardBaseInfoViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardbaseinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PlayerCardProgressView = {
	destroy = 0,
	container = "PlayerCardProgressViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardprogressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	customAnimFadeTime = {
		0.3
	},
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PlayerCardShowView = {
	destroy = 0,
	container = "PlayerCardShowViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/personalcard/playercardshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		carditem = "ui/viewres/player/personalcard/playercarditem.prefab"
	}
}
module_views.PlayerCardLayoutView = {
	destroy = 0,
	container = "PlayerCardLayoutViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/player/personalcard/playercardlayoutview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		achieveview = "ui/viewres/player/personalcard/playercardachieveview.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab",
		groupview = "ui/viewres/player/personalcard/playercardgroupview.prefab",
		carditem = "ui/viewres/player/personalcard/playercarditem.prefab",
		assitview = "ui/viewres/player/personalcard/playercardassitview.prefab",
		chapterview = "ui/viewres/player/personalcard/playercardchapterview.prefab",
		infoview = "ui/viewres/player/personalcard/playercardinfoview.prefab"
	}
}
module_views.PlayerCardCharacterSwitchView = {
	destroy = 0,
	container = "PlayerCardCharacterSwitchViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardroleswitchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/character/characterswitchitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PlayerCardAchievementSelectView = {
	destroy = 0,
	container = "PlayerCardAchievementSelectViewContainer",
	mainRes = "ui/viewres/achievement/achievementselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/achievement/achievementselectitem.prefab",
		"ui/viewres/achievement/achievementmainicon.prefab",
		"ui/viewres/achievement/achievementselectitem_misihai.prefab"
	}
}
module_views.PlayerCardGetView = {
	bgBlur = 1,
	container = "PlayerCardGetViewContainer",
	mainRes = "ui/viewres/player/playercard/playercardgetview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		misihaiitem = "ui/viewres/player/playercard/playercardachieve_misihai.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab",
		skinpreview = "ui/viewres/player/playercard/playercardskinpreview.prefab"
	}
}
module_views.PlayerCardGetSocialView = {
	destroy = 0,
	container = "PlayerCardGetSocialViewContainer",
	mainRes = "ui/viewres/social/socialview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/social/socialfrienditem.prefab",
		"ui/viewres/social/socialrequestitem.prefab",
		"ui/viewres/social/socialsearchitem.prefab",
		"ui/viewres/social/socialblacklistitem.prefab",
		"ui/viewres/social/socialmessageitem.prefab",
		"ui/viewres/social/socialheroitem.prefab",
		"ui/viewres/social/socialcontentitem.prefab",
		"ui/viewres/achievement/achievementmainicon.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/social/socialfriendsview.prefab"
			},
			{
				"ui/viewres/social/socialsearchview.prefab"
			},
			{
				"ui/viewres/social/socialrequestview.prefab"
			},
			{
				"ui/viewres/social/socialblacklistview.prefab"
			}
		}
	},
	customAnimBg = {
		"hasbg"
	}
}
module_views.PlayerCardBadgeGetView = {
	bgBlur = 1,
	container = "PlayerCardBadgeGetViewContainer",
	mainRes = "ui/viewres/player/playercard/playercard_socialbadgegetview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.VersionActivity2_2EnterView = {
	destroy = 0,
	container = "VersionActivity2_2EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_enter/v2a2_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_2/v2a2_enter/v2a2_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_season/v2a2_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_2/v2a2_roomcritter/v2a2_roomcritter_enterview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_2StoreView = {
	destroy = 0,
	container = "VersionActivity2_2StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_dungeon/v2a2_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_2TaskView = {
	destroy = 0,
	container = "VersionActivity2_2TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_dungeon/v2a2_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_dungeon/v2a2_taskitem.prefab"
	}
}
module_views.VersionActivity2_2RoomSignView = {
	destroy = 0,
	container = "VersionActivity2_2RoomSignViewContainer",
	mainRes = "ui/viewres/activity/v2a2_room_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/activity/v2a2_room_rewarditem.prefab"
	}
}
module_views.EliminateTaskView = {
	destroy = 0,
	container = "EliminateTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_taskitem.prefab"
	}
}
module_views.EliminateSelectChessMenView = {
	destroy = 0,
	container = "EliminateSelectChessMenViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectchessmenview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectchessmenitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectchessmenslot.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.EliminateSelectRoleView = {
	destroy = 0,
	container = "EliminateSelectRoleViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectroleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminateselectroleitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.EliminateMapView = {
	destroy = 0,
	container = "EliminateMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminatemapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[2] = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminatemapstageitemnormal.prefab",
		[3] = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminatemapstageitemboss.prefab"
	}
}
module_views.EliminateNoticeView = {
	destroy = 0,
	container = "EliminateNoticeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_noticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.EliminateLevelResultView = {
	bgBlur = 3,
	container = "EliminateLevelResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.EliminateLevelRewardView = {
	destroy = 0,
	container = "EliminateLevelRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.EliminateEffectView = {
	destroy = 0,
	container = "EliminateEffectViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_chesseffectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.EliminateCharacterSkillTipView = {
	destroy = 0,
	container = "CharacterSkillTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_skilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.EliminateLevelView = {
	destroy = 0,
	container = "EliminateLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_teamchess_chessitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_fourchessitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_sixchessitem.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/eliminatescenecanvas.prefab",
		nil,
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_chesstips.prefab",
		"ui/viewres/versionactivity_2_2/v2a2_eliminate/v2a2_eliminate_maxchessitem.prefab",
		nil,
		"ui/materials/dynamic/ui_effects_gray.mat",
		"ui/materials/dynamic/ui_effects.mat",
		"singlebg/season/full/seasonsecretlandentrance_mask.png"
	},
	preloader = module_views_preloader
}
module_views.TianShiNaNaMainView = {
	destroy = 0,
	container = "TianShiNaNaMainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TianShiNaNaLevelView = {
	destroy = 0,
	container = "TianShiNaNaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "scenes/v2a2_m_s12_tsnn_jshd/prefab/v2a2_m_s12_tsnn_box_p.prefab"
	}
}
module_views.TianShiNaNaTalkView = {
	destroy = 0,
	container = "TianShiNaNaTalkViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_talkview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.TianShiNaNaResultView = {
	bgBlur = 3,
	container = "TianShiNaNaResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.TianShiNaNaTaskView = {
	destroy = 0,
	container = "TianShiNaNaTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_taskitem.prefab"
	}
}
module_views.V2a2_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a2_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a2_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
module_views.V2a2_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a2_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a2_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
module_views.V2a2_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a2_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a2_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
module_views.V2a2_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a2_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a2_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_role_signitem.prefab"
	}
}
module_views.V2a2_RedLeafFestival_FullView = {
	destroy = 0,
	container = "V2a2_RedLeafFestival_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a2_redleaffestival_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_redleaffestival_signitem.prefab"
	}
}
module_views.V2a2_RedLeafFestival_PanelView = {
	destroy = 0,
	container = "V2a2_RedLeafFestival_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a2_redleaffestival_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a2_redleaffestival_signitem.prefab"
	}
}
module_views.V2a2_WarmUp = {
	destroy = 0,
	container = "V2a2_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a2_warmup/v2a2_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RoomManufactureBuildingView = {
	destroy = 0,
	container = "RoomManufactureBuildingViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturebuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				RoomManufactureBuildingDetailBanner.prefabPath
			}
		}
	}
}
module_views.RoomManufactureBuildingDetailView = {
	destroy = 0,
	container = "RoomManufactureBuildingDetailViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturebuildingdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomManufactureCritterDetail.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomCritterListView = {
	destroy = 0,
	container = "RoomCritterListViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturecritterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RoomManufactureAddPopView = {
	destroy = 0,
	container = "RoomManufactureAddPopViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufactureaddpopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RoomBuildingLevelUpView = {
	bgBlur = 1,
	container = "RoomBuildingLevelUpViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/room/critter/roomcritterbuildinglevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoomManufactureBuildingLevelUpTipsView = {
	destroy = 0,
	container = "RoomManufactureBuildingLevelUpTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcritterleveluptipsview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RoomManufactureAccelerateView = {
	destroy = 0,
	container = "RoomManufactureAccelerateViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roommanufactureaccelerateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.RoomOverView = {
	destroy = 0,
	container = "RoomOverViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roomoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/manufacture/roommanufactureoverview.prefab"
			},
			{
				"ui/viewres/room/manufacture/roomtransportoverview.prefab"
			}
		}
	}
}
module_views.RoomManufactureWrongTipView = {
	destroy = 0,
	container = "RoomManufactureWrongTipViewContainer",
	mainRes = "ui/viewres/room/manufacture/roommanufacturewrongtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RoomCritterOneKeyView = {
	destroy = 0,
	container = "RoomCritterOneKeyViewContainer",
	mainRes = "ui/viewres/room/manufacture/roomcritteronekeyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomOneKeyView = {
	destroy = 0,
	container = "RoomOneKeyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roomonekeytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.RoomCritterBuildingView = {
	destroy = 0,
	container = "RoomCritterBuildingViewContainer",
	mainRes = "ui/viewres/room/manufacture/roomcritterbuildingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomTrainSlotItem.prefabPath,
		RoomTrainHeroItem.prefabPath,
		RoomCritterTrainItem.prefabPath,
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/manufacture/roomcritterrestview.prefab"
			},
			{
				"ui/viewres/room/critter/roomcrittertrainview.prefab"
			},
			{
				"ui/viewres/room/critter/roomcrittersummonview.prefab"
			},
			{
				"ui/viewres/room/critter/roomcritterincubateview.prefab"
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoomCritterPlaceView = {
	destroy = 0,
	container = "RoomCritterPlaceViewContainer",
	mainRes = "ui/viewres/room/manufacture/roomcritterplaceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.RoomCritterTrainReportView = {
	destroy = 0,
	container = "RoomCritterTrainReportViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomtrainreportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomTrainAccelerateView = {
	destroy = 0,
	container = "RoomTrainAccelerateViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomtrainaccelerateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomCritterTrainEventView = {
	destroy = 0,
	container = "RoomCritterTrainEventViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittertraineventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomCritterTrainStoryView = {
	destroy = 0,
	container = "RoomCritterTrainStoryViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittertrainstoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoomCritterTrainEventResultView = {
	destroy = 0,
	container = "RoomCritterTrainEventResultViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittertraineventresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		RoomCritterTrainDetailItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoomCritterExchangeView = {
	destroy = 0,
	container = "RoomCritterExchangeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcritterexchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.RoomCritterRenameView = {
	destroy = 0,
	container = "RoomCritterRenameViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/layout/roomlayoutcopyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomCritterSummonSkipView = {
	destroy = 0,
	container = "RoomCritterSummonSkipViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittersummonskipview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				"ui/viewres/room/critter/roomcrittersummondragview.prefab"
			}
		}
	}
}
module_views.RoomGetCritterView = {
	destroy = 0,
	container = "RoomGetCritterViewContainer",
	mainRes = "ui/viewres/room/critter/roomgetcritterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/room/critter/egg/roomcritter_egg1.prefab",
		"ui/viewres/room/critter/egg/roomcritter_egg2.prefab",
		"ui/viewres/room/critter/egg/roomcritter_egg3.prefab"
	}
}
module_views.RoomCritterSummonResultView = {
	destroy = 0,
	container = "RoomCritterSummonResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcrittersummonresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/room/critter/egg/roomcrittersummonresult_egg1.prefab",
		"ui/viewres/room/critter/egg/roomcrittersummonresult_egg2.prefab",
		"ui/viewres/room/critter/egg/roomcrittersummonresult_egg3.prefab"
	}
}
module_views.RoomCritterSummonRuleTipsView = {
	destroy = 0,
	container = "RoomCritterSummonRuleTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/critter/roomcrittersummonruletipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomCriiterDetailSimpleView = {
	destroy = 0,
	container = "RoomCriiterDetailSimpleViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.RoomCritterDetailYoungView = {
	destroy = 0,
	container = "RoomCritterDetailYoungViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdetailyoungview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomCritterDetailMaturityView = {
	destroy = 0,
	container = "RoomCritterDetailMaturityViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdetailmaturityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomCritterFilterView = {
	destroy = 0,
	container = "RoomCritterFilterViewContainer",
	mainRes = "ui/viewres/room/critter/roomcrittersearchfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RoomTradeView = {
	destroy = 0,
	container = "RoomTradeViewContainer",
	mainRes = "ui/viewres/room/trade/roomtradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/trade/roomdailyorderview.prefab"
			},
			{
				"ui/viewres/room/trade/roomwholesaleview.prefab"
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		RoomDailyOrderItem.ResUrl,
		RoomWholesaleItem.ResUrl
	}
}
module_views.RoomRecordView = {
	destroy = 0,
	container = "RoomRecordViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/record/roomrecordview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/record/roomtradetaskview.prefab"
			},
			{
				"ui/viewres/room/record/roomlogview.prefab"
			},
			{
				"ui/viewres/room/record/roomcritterhandbookview.prefab"
			}
		}
	},
	otherRes = {
		"ui/viewres/room/record/roomtradetaskitem.prefab",
		"ui/viewres/room/record/roomtradelevelunlockitem.prefab",
		"ui/viewres/room/record/roomlogitem.prefab"
	}
}
module_views.RoomTradeLevelUpTipsView = {
	destroy = 0,
	container = "RoomTradeLevelUpTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/record/roomtradeleveluptipsview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomCritterHandBookBackView = {
	destroy = 0,
	container = "RoomCritterHandBookBackViewContanier",
	bgBlur = 1,
	mainRes = "ui/viewres/room/record/roomhandbookbackview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.FULL,
	anim = ViewAnim.Default
}
module_views.RoomBackpackView = {
	destroy = 0,
	container = "RoomBackpackViewContainer",
	mainRes = "ui/viewres/room/roombackpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/room/roombackpackcritterview.prefab"
			},
			{
				"ui/viewres/room/roombackpackproprview.prefab"
			}
		}
	}
}
module_views.RoomCritterDecomposeView = {
	destroy = 0,
	container = "RoomCritterDecomposeViewContainer",
	mainRes = "ui/viewres/room/critter/roomcritterdecomposeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.RoomManufactureGetView = {
	destroy = 0,
	container = "RoomManufactureGetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roommanufacturegetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.RoomCritterRestTipsView = {
	destroy = 0,
	container = "RoomCritterRestTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/manufacture/roomcritterresttipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_1EnterView = {
	destroy = 0,
	container = "VersionActivity2_1EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_enter/v2a1_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_1/v2a1_enter/v2a1_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_season/v2a1_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_1/v2a1_rouge/v2a1_rouge_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_1StoreView = {
	destroy = 0,
	container = "VersionActivity2_1StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_1TaskView = {
	destroy = 0,
	container = "VersionActivity2_1TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_taskitem.prefab"
	}
}
module_views.VersionActivity2_1DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_1DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_1DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_1DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_dungeon/v2a1_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a1_MoonFestival_PanelView = {
	destroy = 0,
	container = "V2a1_MoonFestival_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a1_moonfestival_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_moonfestival_signitem.prefab"
	}
}
module_views.V2a1_MoonFestival_FullView = {
	destroy = 0,
	container = "V2a1_MoonFestival_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a1_moonfestival_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_moonfestival_signitem.prefab"
	}
}
module_views.V2a1_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a1_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a1_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
module_views.V2a1_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a1_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a1_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
module_views.V2a1_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a1_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a1_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
module_views.V2a1_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a1_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a1_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a1_role_signitem.prefab"
	}
}
module_views.V2a1_WarmUp = {
	destroy = 0,
	container = "V2a1_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_warmup/v2a1_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity165StoryEnterView = {
	destroy = 0,
	container = "Activity165StoryEnterViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_1/act165/act165storyenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity165StoryReviewView = {
	destroy = 0,
	container = "Activity165StoryReviewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_1/act165/act165storyreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity165StoryEditView = {
	destroy = 0,
	container = "Activity165StoryEditViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_1/act165/act165storyeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/act165/story/go_story1.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CommonTrialHeroDetailView = {
	destroy = 0,
	container = "CommonTrialHeroDetailViewContainer",
	mainRes = "ui/viewres/summon/summonherodetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LanShouPaGameResultView = {
	bgBlur = 3,
	container = "LanShouPaGameResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.LanShouPaMapView = {
	bgBlur = 0,
	container = "LanShouPaMapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_levelviewstageitem.prefab",
		"scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_01_p.prefab",
		"scenes/v1a3_m_s12_dfw_jlbn/prefab/m_s12_jlbn_zjm_02_p.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LanShouPaGameView = {
	bgBlur = 0,
	container = "LanShouPaGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LanShouPaTaskView = {
	bgBlur = 0,
	container = "LanShouPaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LanShouPaStoryView = {
	bgBlur = 3,
	container = "LanShouPaStoryViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_storyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_storyviewitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AergusiLevelView = {
	bgBlur = 0,
	container = "AergusiLevelViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_levelitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AergusiDialogView = {
	destroy = 0,
	container = "AergusiDialogViewContainer",
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_dialogview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AergusiClueView = {
	bgBlur = 1,
	container = "AergusiClueViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_clueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_clueitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AergusiTaskView = {
	bgBlur = 0,
	container = "AergusiTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		AergusiTaskItem.prefabPath
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AergusiFailView = {
	bgBlur = 1,
	container = "AergusiFailViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_failview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.AergusiDialogStartView = {
	bgBlur = 1,
	container = "AergusiDialogStartViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_dialogstartview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.AergusiDialogEndView = {
	bgBlur = 1,
	container = "AergusiDialogEndViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_dialogendingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.PlayerCardCharacterSwitchTipsView = {
	destroy = 0,
	container = "PlayerCardCharacterSwitchTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/player/playercard/playercardroleswitchtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.Season166MainView = {
	destroy = 0,
	container = "Season166MainViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.Season166BaseSpotView = {
	destroy = 0,
	container = "Season166_2_6BaseSpotViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166basespotview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act166/season166wordcontent.prefab",
		[2] = "ui/viewres/seasonver/act166/season166wordeffect.prefab"
	}
}
module_views.Season166TrainView = {
	destroy = 0,
	container = "Season166_2_6TrainViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166trainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act166/season166wordcontent.prefab",
		[2] = "ui/viewres/seasonver/act166/season166wordeffect.prefab"
	}
}
module_views.Season166TeachView = {
	destroy = 0,
	container = "Season166TeachViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/seasonver/act166/season166teachview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season166HeroGroupFightView = {
	bgBlur = 4,
	container = "Season166_2_6HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act166/season166herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Season166HeroGroupEditView = {
	container = "Season166HeroGroupEditViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/seasonver/act166/season166herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/seasonver/act166/season166herogroupedititem.prefab",
		[2] = "ui/viewres/seasonver/act166/season166herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.Season166HeroGroupTargetView = {
	destroy = 0,
	container = "Season166HeroGroupTargetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166herogrouptargetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Season166InformationMainView = {
	destroy = 0,
	container = "Season166_2_6InformationMainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act166/season_infoanalyze_reportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season166InformationAnalyView = {
	destroy = 0,
	container = "Season166_2_6InformationAnalyViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act166/season_infoanalyze_reportdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season166InformationRewardView = {
	destroy = 0,
	container = "Season166InformationRewardViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/seasonver/act166/season_infoanalyze_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season166TalentView = {
	destroy = 0,
	container = "Season166TalentViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166talentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season166TalentSelectView = {
	destroy = 0,
	container = "Season166_2_6TalentSelectViewContainer",
	mainRes = "ui/viewres/seasonver/act166/season166talentselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Season166ResultView = {
	destroy = 0,
	container = "Season166ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.Season166ResultPanel = {
	destroy = 0,
	container = "Season166ResultPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166resultpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.Season166TalentInfoView = {
	destroy = 0,
	container = "Season166TalentInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/seasonver/act166/season166talentinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.LoperaMainView = {
	destroy = 0,
	container = "LoperaMainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_mapstageitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LoperaLevelView = {
	destroy = 0,
	container = "LoperaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LoperaLevelTipsView = {
	destroy = 0,
	container = "LoperaLevelTipsViewContainer",
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_leveltipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.LoperaTaskView = {
	bgBlur = 0,
	container = "LoperaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LoperaGameResultView = {
	destroy = 0,
	container = "LoperaGameResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		LoperaGoodsItem.prefabPath3
	}
}
module_views.LoperaSmeltView = {
	bgBlur = 3,
	container = "LoperaSmeltViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_smeltview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		LoperaGoodsItem.prefabPath3
	}
}
module_views.LoperaSmeltResultView = {
	destroy = 0,
	container = "LoperaSmeltResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_smeltresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity173FullView = {
	destroy = 0,
	container = "Activity173FullViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_limitdecorate/v2a2_limitdecoratefullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity173PanelView = {
	destroy = 0,
	container = "Activity173PanelViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_2/v2a2_limitdecorate/v2a2_limitdecoratepanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.GiftInsightHeroChoiceView = {
	destroy = 0,
	container = "GiftInsightHeroChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/gift/giftinsightherochoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/gift/giftinsightherochoiceitem.prefab"
	}
}
module_views.FightEnemyActionView = {
	destroy = 0,
	container = "FightEnemyActionViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fight/fightenemyactionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/fight/fightcarditem.prefab"
	}
}
module_views.StressTipView = {
	destroy = 0,
	container = "StressTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/fightstresstip/fightstresstipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.WebView = {
	destroy = 0,
	container = "WebViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/webview/webview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Full
}
module_views.TowerGuideView = {
	destroy = 0,
	container = "TowerGuideViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerguideview.prefab",
	blurFactor = 0.3,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.TowerPermanentView = {
	destroy = 0,
	container = "TowerPermanentViewContainer",
	mainRes = "ui/viewres/tower/towerpermanentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerMopUpView = {
	destroy = 0,
	container = "TowerMopUpViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/tower/towermopupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TowerMainView = {
	destroy = 0,
	container = "TowerMainViewContainer",
	mainRes = "ui/viewres/tower/towermainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerBossSelectView = {
	destroy = 0,
	container = "TowerBossSelectViewContainer",
	mainRes = "ui/viewres/tower/towerbossselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/tower/towerbossselectitem.prefab"
	}
}
module_views.TowerBossEpisodeView = {
	destroy = 0,
	container = "TowerBossEpisodeViewContainer",
	mainRes = "ui/viewres/tower/towerbossepisodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerBossSpEpisodeView = {
	destroy = 0,
	container = "TowerBossSpEpisodeViewContainer",
	mainRes = "ui/viewres/tower/towerbossspepisodeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerBossTalentModifyNameView = {
	bgBlur = 3,
	container = "TowerBossTalentModifyNameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/tower/towerbosstalentmodifynameview.prefab",
	blurFactor = 0.4,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TowerAssistBossView = {
	destroy = 0,
	container = "TowerAssistBossViewContainer",
	mainRes = "ui/viewres/tower/towerassistbosstview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/tower/towerassistbossitem.prefab"
	}
}
module_views.TowerHeroGroupFightView = {
	bgBlur = 4,
	container = "TowerHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/tower/towerherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.TowerAssistBossDetailView = {
	destroy = 0,
	container = "TowerAssistBossDetailViewContainer",
	mainRes = "ui/viewres/tower/towerassistbosstdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerAssistBossTalentView = {
	destroy = 0,
	container = "TowerAssistBossTalentViewContainer",
	mainRes = "ui/viewres/tower/towertalentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerAssistBossTalentTallView = {
	destroy = 0,
	container = "TowerAssistBossTalentTallViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towertalentallview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerBossResultView = {
	destroy = 0,
	container = "TowerBossResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerbossresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.TowerPermanentResultView = {
	destroy = 0,
	container = "TowerPermanentResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerpermanentresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.TowerTaskView = {
	destroy = 0,
	container = "TowerTaskViewContainer",
	mainRes = "ui/viewres/tower/towertaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/tower/towertaskitem.prefab"
	}
}
module_views.TowerTimeLimitLevelView = {
	destroy = 0,
	container = "TowerTimeLimitLevelViewContainer",
	mainRes = "ui/viewres/tower/towertimelimitlevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerBossSkillTipsView = {
	destroy = 0,
	container = "TowerBossSkillTipsViewContainer",
	mainRes = "ui/viewres/tower/towerbosstipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerBossAttributeTipsView = {
	destroy = 0,
	container = "TowerBossAttributeTipsViewContainer",
	mainRes = "ui/viewres/tower/towerbossattributetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerBossHeroGroupAttributeTipsView = {
	destroy = 0,
	container = "TowerBossHeroGroupAttributeTipsViewContainer",
	mainRes = "ui/viewres/tower/towerherogrouptipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerSkillTipView = {
	destroy = 0,
	container = "TowerSkillTipViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/tower/towerbossskilltipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_newskilltip/skillbg"
	}
}
module_views.TowerStoreView = {
	destroy = 0,
	container = "TowerStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.TowerHeroTrialView = {
	destroy = 0,
	container = "TowerHeroTrialViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/tower/towerherotrialview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TowerBossTeachView = {
	destroy = 0,
	container = "TowerBossTeachViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/tower/towerbossteachview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.TowerDeepHeroGroupFightView = {
	bgBlur = 4,
	container = "TowerDeepHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/tower/towerdeepherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.TowerDeepTeamSaveView = {
	destroy = 0,
	container = "TowerDeepTeamSaveViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerdeepteamsaveview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TowerDeepTaskView = {
	destroy = 0,
	container = "TowerDeepTaskViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/tower/towerdeeptaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/tower/towerdeeptaskitem.prefab"
	}
}
module_views.TowerDeepResultView = {
	destroy = 0,
	container = "TowerDeepResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/tower/towerdeepresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}

TowerComposeViewDefine.init(module_views)

module_views.VersionActivity2_3EnterView = {
	destroy = 0,
	container = "VersionActivity2_3EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_enter/v2a3_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_3/v2a3_enter/v2a3_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_enter/v2a3_act174enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_3/v2a3_season/v2a3_season_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_3StoreView = {
	destroy = 0,
	container = "VersionActivity2_3StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_3TaskView = {
	destroy = 0,
	container = "VersionActivity2_3TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_taskitem.prefab"
	}
}
module_views.VersionActivity2_3DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_3DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_3DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_3DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ActDuDuGuLevelView = {
	destroy = 0,
	container = "ActDuDuGuLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_levelstageitem.prefab"
	}
}
module_views.ActDuDuGuTaskView = {
	bgBlur = 0,
	container = "ActDuDuGuTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_roledudugu/v2a3_roledudugu_taskitem.prefab"
	}
}
module_views.ZhiXinQuanErLevelView = {
	destroy = 0,
	container = "ZhiXinQuanErLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_levelviewstageitem.prefab"
	}
}
module_views.ZhiXinQuanErTaskView = {
	bgBlur = 0,
	container = "ZhiXinQuanErTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/v2a3_zhixinquaner_taskitem.prefab"
	}
}
module_views.PuzzleMazeDrawView = {
	destroy = 0,
	container = "PuzzleMazeDrawViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazedrawview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazeitem.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazepath.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazepawn.prefab",
		"ui/viewres/versionactivity_2_3/v2a3_zhixinquaner/maze/v2a3_puzzlemazeswitchitem.prefab"
	}
}
module_views.Act174MainView = {
	destroy = 0,
	container = "Act174MainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act174BadgeWallView = {
	destroy = 0,
	container = "Act174BadgeWallViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174badgewallview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Act174RotationView = {
	destroy = 0,
	container = "Act174RotationViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174ruledetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act174StoreView = {
	destroy = 0,
	container = "Act174StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Act174ForcePickView = {
	destroy = 0,
	container = "Act174ForcePickViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174forcepickview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act174GameView = {
	destroy = 0,
	container = "Act174GameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act174MatchView = {
	destroy = 0,
	container = "Act174MatchViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174matchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Act174FightReadyView = {
	destroy = 0,
	container = "Act174FightReadyViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174fightreadyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity174Enum.PrefabPath.BattleHero
	}
}
module_views.Act174BetSuccessView = {
	destroy = 0,
	container = "Act174BetSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174betsuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act174FightResultView = {
	destroy = 0,
	container = "Act174FightResultViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174fightresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		Activity174Enum.PrefabPath.BattleHero
	}
}
module_views.Act174EndLessView = {
	destroy = 0,
	container = "Act174EndLessViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174endlessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Act174SettlementView = {
	destroy = 0,
	container = "Act174SettlementViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		Activity174Enum.PrefabPath.BattleHero
	}
}
module_views.Act174ItemTipView = {
	destroy = 0,
	container = "Act174ItemTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174itemtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act174BuffTipView = {
	destroy = 0,
	container = "Act174BuffTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174bufftipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.Act174RoleInfo = {
	destroy = 0,
	container = "Act174RoleInfoContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_3/act174/act174roleinfo.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.VersionActivity2_3NewCultivationGiftView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationGiftViewContainer",
	mainRes = "ui/viewres/activity/v2a3_destiny_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity2_3NewCultivationGiftFullView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationGiftFullViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_destiny_panelsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity2_3NewCultivationGiftRewardView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationGiftRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_newcultivationgift/v2a3_newcultivationrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.VersionActivity2_3NewCultivationDetailView = {
	destroy = 0,
	container = "VersionActivity2_3NewCultivationDetailViewContainer",
	mainRes = "ui/viewres/activity/v2a3_destiny_preview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.V2a3_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a3_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a3_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
module_views.V2a3_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a3_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a3_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
module_views.V2a3_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a3_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
module_views.V2a3_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a3_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a3_role_signitem.prefab"
	}
}
module_views.VersionActivity2_4EnterView = {
	destroy = 0,
	container = "VersionActivity2_4EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_enter/v2a4_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_4/v2a4_enter/v2a4_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_reprint/v2a4_v1a8reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_rouge/v2a4_rouge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_4/v2a4_season/v2a4_season_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_4DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_4DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_4DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_4DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_4StoreView = {
	destroy = 0,
	container = "VersionActivity2_4StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_4SudokuView = {
	destroy = 0,
	container = "VersionActivity2_4SudokuViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_sudokuview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_4TaskView = {
	destroy = 0,
	container = "VersionActivity2_4TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_dungeon/v2a4_taskitem.prefab"
	}
}
module_views.PinballTaskView = {
	destroy = 0,
	container = "PinballTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_taskitem.prefab"
	}
}
module_views.PinballCityView = {
	destroy = 0,
	container = "PinballCityViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_cityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		menu = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_building_menu.prefab",
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
module_views.PinballGameView = {
	destroy = 0,
	container = "PinballGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.PinballMapSelectView = {
	bgBlur = 1,
	container = "PinballMapSelectViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_mapselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
module_views.PinballBuildView = {
	destroy = 0,
	container = "PinballBuildViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_buildview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
module_views.PinballUpgradeView = {
	destroy = 0,
	container = "PinballUpgradeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_upgradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
module_views.PinballCurrencyTipView = {
	destroy = 0,
	container = "PinballCurrencyTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currency_tip.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.PinballResultView = {
	destroy = 0,
	container = "PinballResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.PinballTalentView = {
	bgBlur = 1,
	container = "PinballTalentViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_talentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		currency = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_currencyitem.prefab"
	}
}
module_views.PinballRestLoadingView = {
	destroy = 0,
	container = "PinballRestLoadingViewContainer",
	bgBlur = 1,
	delayTime = 4,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_restview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.PinballStartLoadingView = {
	destroy = 0,
	container = "PinballLoadingViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_loadingview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.PinballDayEndView = {
	destroy = 0,
	container = "PinballDayEndViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_pinball/v2a4_pinball_dayendview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.WuErLiXiLevelView = {
	destroy = 0,
	container = "WuErLiXiLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_levelitem.prefab"
	}
}
module_views.WuErLiXiGameView = {
	destroy = 0,
	container = "WuErLiXiGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WuErLiXiUnitTipView = {
	destroy = 0,
	container = "WuErLiXiUnitTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_unittipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.WuErLiXiTaskView = {
	destroy = 0,
	container = "WuErLiXiTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_wuerlixi/v2a4_wuerlixi_taskitem.prefab"
	}
}
module_views.VersionActivity2_4MusicFreeView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freetrack.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freenotelistiitem.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freenoteitem.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeinstrument.prefab"
	}
}
module_views.VersionActivity2_4MusicBeatView = {
	destroy = 0,
	container = "VersionActivity2_4MusicBeatViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_beatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_beatitem.prefab"
	}
}
module_views.VersionActivity2_4MusicBeatResultView = {
	destroy = 0,
	container = "VersionActivity2_4MusicBeatResultViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_beatresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_beatresultcomboitem.prefab",
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_beatresultevaluateitem.prefab"
	}
}
module_views.VersionActivity2_4MusicTaskView = {
	destroy = 0,
	container = "VersionActivity2_4MusicTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_balaluoer_taskitem.prefab"
	}
}
module_views.VersionActivity2_4MusicFreeInstrumentSetView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeInstrumentSetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeinstrument_set.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeinstrument_setitem.prefab"
	}
}
module_views.VersionActivity2_4MusicFreeCalibrationView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeCalibrationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freecalibration.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freecalibrationitem.prefab"
	}
}
module_views.VersionActivity2_4MusicFreeAccompanyView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeAccompanyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeaccompanyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.VersionActivity2_4MusicFreeImmerseView = {
	destroy = 0,
	container = "VersionActivity2_4MusicFreeImmerseViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_freeimmerse.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.VersionActivity2_4MusicChapterView = {
	destroy = 0,
	container = "VersionActivity2_4MusicChapterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_chapterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_4/v2a4_bakaluoer/v2a4_bakaluoer_chapteritem.prefab"
	}
}
module_views.AutoChessMainView = {
	destroy = 0,
	container = "AutoChessMainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.BadgeItem,
		AutoChessStrEnum.ResPath.WarningItem
	}
}
module_views.AutoChessLeaderShowView = {
	destroy = 0,
	container = "AutoChessLeaderShowViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessleadershowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.LeaderCard
	}
}
module_views.AutoChessLeaderNextView = {
	destroy = 0,
	container = "AutoChessLeaderNextViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessleadernextview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.LeaderItem
	}
}
module_views.AutoChessCourseView = {
	destroy = 0,
	container = "AutoChessCourseViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscourseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.BadgeItem
	}
}
module_views.AutoChessBadgeView = {
	destroy = 0,
	container = "AutoChessBadgeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbadgeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.BadgeItem
	}
}
module_views.AutoChessLevelView = {
	destroy = 0,
	container = "AutoChessLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesslevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.LevelItem
	}
}
module_views.AutoChessTaskView = {
	destroy = 0,
	container = "AutoChessTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesstaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessTaskItem.prefabPath,
		AutoChessStrEnum.ResPath.WarningItem
	}
}
module_views.AutoChessRankUpView = {
	destroy = 0,
	container = "AutoChessRankUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbadgeupgradeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.BadgeItem
	}
}
module_views.AutoChessFriendBattleView = {
	destroy = 0,
	container = "AutoChessFriendBattleViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvpenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AutoChessFriendBattleRecordView = {
	destroy = 0,
	container = "AutoChessFriendBattleRecordViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessrecordview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AutoChessFriendListView = {
	destroy = 0,
	container = "AutoChessFriendListViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessfriendlistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.AutoChessHandbookPreviewView = {
	destroy = 0,
	container = "AutoChessHandbookPreviewViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessbooklevelpreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.ChessCard
	}
}
module_views.AutoChessCultivateView = {
	destroy = 0,
	container = "AutoChessCultivateViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscultivateview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.WarningItem
	}
}
module_views.AutoChessBossBookView = {
	destroy = 0,
	container = "AutoChessBossBookViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbossbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AutoChessSpecialBookView = {
	destroy = 0,
	container = "AutoChessSpecialBookViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessspecialbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.CollectionItem,
		AutoChessStrEnum.ResPath.LeaderCard,
		AutoChessStrEnum.ResPath.WarningItem
	}
}
module_views.AutoChessCardpackView = {
	destroy = 0,
	container = "AutoChessCardpackViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscardpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.CardPackItem,
		AutoChessStrEnum.ResPath.LeaderCard,
		AutoChessStrEnum.ResPath.CollectionItem,
		AutoChessStrEnum.ResPath.WarningItem
	}
}
module_views.AutoChessGameView = {
	destroy = 0,
	container = "AutoChessGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		AutoChessStrEnum.ResPath.ChessEntity,
		AutoChessStrEnum.ResPath.LeaderEntity
	}
}
module_views.AutoChessForcePickView = {
	destroy = 0,
	container = "AutoChessForcePickViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessforcepickview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.ChessCard
	}
}
module_views.AutoChessMallView = {
	destroy = 0,
	container = "AutoChessMallViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessmallview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AutoChessMallInfoView = {
	destroy = 0,
	container = "AutoChessMallInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessmallinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.ChessCard
	}
}
module_views.AutoChessMallLevelUpView = {
	destroy = 0,
	container = "AutoChessMallLevelUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessstorelevelup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AutoChessResultView = {
	destroy = 0,
	container = "AutoChessResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AutoChessPvpSettleView = {
	destroy = 0,
	container = "AutoChessPvpSettleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvpsettleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.BadgeItem
	}
}
module_views.AutoChessPveSettleView = {
	destroy = 0,
	container = "AutoChessPveSettleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvesettleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.AutoChessPveFirstSettleView = {
	destroy = 0,
	container = "AutoChessPveFirstSettleViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvefirstsettleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AutoChessStartFightView = {
	destroy = 0,
	container = "AutoChessStartFightViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessenteranimview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.AutoChessCrazyModeTipView = {
	destroy = 0,
	container = "AutoChessCrazyModeTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesscrazymodetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.AutoChessLeaderBuffView = {
	destroy = 0,
	container = "AutoChessLeaderBuffViewContainer",
	maskAlpha = 0,
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessleaderbuffview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AutoChessCrazySettleView = {
	destroy = 0,
	container = "AutoChessCrazySettleViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesscrazysettleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AutoChessBeginView = {
	destroy = 0,
	container = "AutoChessBeginViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessbeginview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.LeaderItem,
		AutoChessStrEnum.ResPath.CardPackItem
	}
}
module_views.AutoChessCardpackInfoView = {
	destroy = 0,
	container = "AutoChessCardpackInfoViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscardpackinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		AutoChessStrEnum.ResPath.CardPackItem,
		AutoChessStrEnum.ResPath.LeaderCard,
		AutoChessStrEnum.ResPath.CollectionItem
	}
}
module_views.AutoChessCollectionView = {
	destroy = 0,
	container = "AutoChessCollectionViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesscollectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.CollectionItem
	}
}
module_views.AutoChessWarnUpView = {
	destroy = 0,
	container = "AutoChessWarnUpViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesswarnupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		AutoChessStrEnum.ResPath.WarningItem,
		AutoChessStrEnum.ResPath.CardPackItem,
		AutoChessStrEnum.ResPath.CollectionItem,
		AutoChessStrEnum.ResPath.LeaderCard
	}
}
module_views.VersionActivity2_5EnterView = {
	destroy = 0,
	container = "VersionActivity2_5EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_enter/v2a5_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_5/v2a5_enter/v2a5_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/v2a5_reprint/v2a5_v1a6reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/v2a5_enter/v2a5_autochess_enterview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_5StoreView = {
	destroy = 0,
	container = "VersionActivity2_5StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_5TaskView = {
	destroy = 0,
	container = "VersionActivity2_5TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_taskitem.prefab"
	}
}
module_views.VersionActivity2_5DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_5DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_5DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivity2_5DungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_dungeon/v2a5_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act183MainView = {
	destroy = 0,
	container = "Act183MainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				Act183Enum.StoreEntryPrefabUrl
			}
		}
	}
}
module_views.Act183DungeonView = {
	destroy = 0,
	container = "Act183DungeonViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_dungeonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act183TaskView = {
	destroy = 0,
	container = "Act183TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskitem.prefab",
		"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskheader.prefab",
		"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_taskonekeyitem.prefab"
	}
}
module_views.Act183BadgeView = {
	destroy = 0,
	container = "Act183BadgeViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_badgeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act183FinishView = {
	destroy = 0,
	container = "Act183FinishViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_finishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act183SettlementView = {
	destroy = 0,
	container = "Act183SettlementViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act183ReportView = {
	destroy = 0,
	container = "Act183ReportViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_reportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_reportitem.prefab"
	}
}
module_views.Act183RepressView = {
	destroy = 0,
	container = "Act183RepressViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_repressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act183HeroGroupFightView = {
	bgBlur = 4,
	container = "Act183HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.Act183HeroGroupEditView = {
	container = "Act183HeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupedititem.prefab",
		[2] = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.Act183FightSuccView = {
	destroy = 0,
	container = "Act183FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Act183CurrencyReplaceTipsView = {
	destroy = 0,
	container = "Act183CurrencyReplaceTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_currencyreplacetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.FeiLinShiDuoGameView = {
	destroy = 0,
	container = "FeiLinShiDuoGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduogameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/feilinshiduo/map/v2a5_feilinshiduogamemap.prefab",
		jump = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/jump.prefab",
		start = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/start.prefab",
		option = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/option.prefab",
		wall = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/wall.prefab",
		target = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/target.prefab",
		box = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/box.prefab",
		door = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/door.prefab",
		colorplane = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/colorplane.prefab",
		trap = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/trap.prefab",
		stair = "ui/viewres/versionactivity_2_5/feilinshiduo/map/element/stair.prefab"
	}
}
module_views.FeiLinShiDuoEpisodeLevelView = {
	destroy = 0,
	container = "FeiLinShiDuoEpisodeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_levelviewstageitem.prefab"
	}
}
module_views.FeiLinShiDuoTaskView = {
	destroy = 0,
	container = "FeiLinShiDuoTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_taskitem.prefab"
	}
}
module_views.FeiLinShiDuoResultView = {
	destroy = 0,
	container = "FeiLinShiDuoResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/feilinshiduo/view/v2a5_feilinshiduo_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.LinkageActivity_PanelView = {
	destroy = 0,
	container = "LinkageActivity_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/linkageactivity_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.LinkageActivity_FullView = {
	destroy = 0,
	container = "LinkageActivity_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/linkageactivity_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a3_WarmUp = {
	destroy = 0,
	container = "V2a3_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a3_warmup/v2a3_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	preloader = module_views_preloader
}
module_views.V2a3_Special_FullSignView = {
	destroy = 0,
	container = "V2a3_Special_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a3_special_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a3_Special_PanelsView = {
	destroy = 0,
	container = "V2a3_Special_PanelsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a3_special_panelsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity181MainView = {
	destroy = 0,
	container = "Activity181MainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_actxmasview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity181RewardView = {
	destroy = 0,
	container = "Activity181RewardViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_4/v2a4_actxmasrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a4_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a4_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
module_views.V2a4_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a4_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a4_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
module_views.V2a4_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a4_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
module_views.V2a4_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a4_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a4_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a4_role_signitem.prefab"
	}
}
module_views.V2a4_WarmUp = {
	destroy = 0,
	container = "V2a4_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a4_WarmUp_DialogueView = {
	destroy = 0,
	container = "V2a4_WarmUp_DialogueViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup_dialogueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a4_WarmUp_TaskView = {
	destroy = 0,
	container = "V2a4_WarmUp_TaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/v2a4_warmup/v2a4_warmup_taskitem.prefab"
	}
}
module_views.V2a4_WarmUp_ResultView = {
	destroy = 0,
	container = "V2a4_WarmUp_ResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v2a4_warmup/v2a4_warmup_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LiangYueGameView = {
	bgBlur = 1,
	container = "LiangYueGameViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyuemeshitem.prefab",
		[2] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyuechessitem.prefab"
	}
}
module_views.LiangYueLevelView = {
	destroy = 0,
	container = "LiangYueLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_levelviewstageitem.prefab"
	}
}
module_views.LiangYueTaskView = {
	destroy = 0,
	container = "LiangYueTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_5/liangyue/view/v2a5_liangyue_taskitem.prefab"
	}
}
module_views.V2a5_Role_FullSignView_Part1 = {
	destroy = 0,
	container = "V2a5_Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
module_views.V2a5_Role_FullSignView_Part2 = {
	destroy = 0,
	container = "V2a5_Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a5_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
module_views.V2a5_Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "V2a5_Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
module_views.V2a5_Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "V2a5_Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a5_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a5_role_signitem.prefab"
	}
}
module_views.Activity186View = {
	destroy = 0,
	container = "Activity186ViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186view.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity186EffectView = {
	destroy = 0,
	container = "Activity186EffectViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186effectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Activity186GiftView = {
	destroy = 0,
	container = "Activity186GiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186giftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Activity186GameInviteView = {
	destroy = 0,
	container = "Activity186GameInviteViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186gameinviteview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity186GameDrawlotsView = {
	destroy = 0,
	container = "Activity186GameDrawlotsViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186gamedrawlotsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity186TaskView = {
	bgBlur = 0,
	container = "Activity186TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/versionactivity_2_5/act186/activity186taskitem.prefab"
	}
}
module_views.Activity186SignView = {
	bgBlur = 0,
	container = "Activity186SignViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186signview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/versionactivity_2_5/act186/activity186signitem.prefab"
	}
}
module_views.Activity186GameBiscuitsView = {
	destroy = 0,
	container = "Activity186GameBiscuitsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/act186/activity186gamebiscuitsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LifeCirclePickChoice = {
	destroy = 0,
	container = "LifeCirclePickChoiceContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/lifecircle/lifecirclepickchoice.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LifeCircleRewardView = {
	destroy = 0,
	container = "LifeCircleRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/lifecircle/lifecirclerewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/common/commonpropitem.prefab"
	}
}
module_views.Activity187View = {
	destroy = 0,
	container = "Activity187ViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_lanternfestival/v2a5_lanternfestival.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a5DecalogPresentView = {
	destroy = 0,
	container = "V2a5DecalogPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_versionsummon.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V2a5DecalogPresentFullView = {
	destroy = 0,
	container = "V2a5DecalogPresentFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V2a5_DecorateStoreView = {
	destroy = 0,
	container = "V2a5_DecorateStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a5_decoratestore_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.V2a5_DecorateStoreFullView = {
	destroy = 0,
	container = "V2a5_DecorateStoreFullViewContainer",
	mainRes = "ui/viewres/activity/v2a5_decoratestore_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V2a5_GoldenMilletPresentView = {
	destroy = 0,
	container = "V2a5_GoldenMilletPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_goldenmilletpresent.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V2a5_GoldenMilletPresentFullView = {
	destroy = 0,
	container = "V2a5_GoldenMilletPresentFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_5/v2a5_goldenmilletpresentfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V2a5_WarmUp = {
	destroy = 0,
	container = "V2a5_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a5_warmup/v2a5_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity2_6EnterView = {
	destroy = 0,
	container = "VersionActivity2_6EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_enter/v2a6_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_6/v2a6_enter/v2a6_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/v2a6_rouge/v2a6_rouge_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_6/v2a6_season/v2a6_season_enterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_6StoreView = {
	destroy = 0,
	container = "VersionActivity2_6StoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_dungeon/v2a6_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_6TaskView = {
	destroy = 0,
	container = "VersionActivity2_6TaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_dungeon/v2a6_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_6/v2a6_dungeon/v2a6_taskitem.prefab"
	}
}

DiceHeroViewDefine.init(module_views)

module_views.XugoujiLevelView = {
	destroy = 0,
	container = "XugoujiLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_levelitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.XugoujiTaskView = {
	bgBlur = 0,
	container = "XugoujiTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_taskitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.XugoujiGameView = {
	destroy = 0,
	container = "XugoujiGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.XugoujiGameResultView = {
	destroy = 0,
	container = "XugoujiGameResultViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.XugoujiCardInfoView = {
	destroy = 0,
	container = "XugoujiCardInfoViewContainer",
	mainRes = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_skilltips.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ShortenAct_FullView = {
	destroy = 0,
	container = "ShortenAct_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/shortenact_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/shortenact_taskitem.prefab"
	}
}
module_views.ShortenAct_PanelView = {
	destroy = 0,
	container = "ShortenAct_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/shortenact_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/shortenact_taskitem.prefab"
	}
}
module_views.V2a6_WeekwalkHeart_FullView = {
	destroy = 0,
	container = "V2a6_WeekwalkHeart_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a6_weekwalkheart_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a6_WeekwalkHeart_PanelView = {
	destroy = 0,
	container = "V2a6_WeekwalkHeart_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a6_weekwalkheart_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a6_WarmUp = {
	destroy = 0,
	container = "V2a6_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a6_warmup/v2a6_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionActivity2_7EnterView = {
	destroy = 0,
	container = "VersionActivity2_7EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_enter/v2a7_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_7/v2a7_enter/v2a7_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_7/v2a7_enter/v2a7_act191enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_7/v2a7_coopergarland/v2a7_coopergarland_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_7/v2a7_reprint/v2a7_v2a0reprint_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_7StoreView = {
	destroy = 0,
	container = "VersionActivityFixedStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_dungeon/v2a7_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_7TaskView = {
	destroy = 0,
	container = "VersionActivityFixedTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_dungeon/v2a7_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_7/v2a7_dungeon/v2a7_taskitem.prefab"
	}
}
module_views.VersionActivity2_7DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_7DungeonMapViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_dungeon/v2a7_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/versionactivity_2_7/v2a7_dungeon/v2a7_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/versionactivity_2_7/v2a7_dungeon/v2a7_dungeonmap_direction.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_7DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivityFixedDungeonMapLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_dungeon/v2a7_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a7LoadingSpaceView = {
	destroy = 999999,
	container = "V2a7LoadingSpaceViewContainer",
	mainRes = "ui/viewres/scene/loadingview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.CooperGarlandGameView = {
	destroy = 0,
	container = "CooperGarlandGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_coopergarland/v2a7_coopergarland_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CooperGarlandLevelView = {
	destroy = 0,
	container = "CooperGarlandLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_coopergarland/v2a7_coopergarland_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_7/v2a7_coopergarland/v2a7_coopergarland_levelitem.prefab"
	}
}
module_views.CooperGarlandTaskView = {
	destroy = 0,
	container = "CooperGarlandTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_coopergarland/v2a7_coopergarland_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_7/v2a7_coopergarland/v2a7_coopergarland_taskitem.prefab"
	}
}
module_views.CooperGarlandResultView = {
	destroy = 0,
	container = "CooperGarlandResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_7/v2a7_coopergarland/v2a7_coopergarland_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V2a7_Labor_FullSignView = {
	destroy = 0,
	container = "V2a7_Labor_FullSignViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a7_labor_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a7_labor_signitem.prefab"
	}
}
module_views.V2a7_Labor_PanelSignView = {
	destroy = 0,
	container = "V2a7_Labor_PanelSignViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a7_labor_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a7_labor_signitem.prefab"
	}
}
module_views.V2a7_WarmUp = {
	destroy = 0,
	container = "V2a7_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a7_warmup/v2a7_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}

LengZhou6ViewDefine.init(module_views)

module_views.Act191MainView = {
	destroy = 0,
	container = "Act191MainViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act191BadgeView = {
	destroy = 0,
	container = "Act191BadgeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191badgeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Act191InfoView = {
	destroy = 0,
	container = "Act191InfoViewContainer",
	maskAlpha = 0,
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191infoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act191StoreView = {
	destroy = 0,
	container = "Act191StoreViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act191InitBuildView = {
	destroy = 0,
	container = "Act191InitBuildViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191initbuildview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.HeroHeadItem,
		Activity191Enum.PrefabPath.FetterItem
	}
}
module_views.Act191StageView = {
	destroy = 0,
	container = "Act191StageViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191stageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.NodeListItem,
		Activity191Enum.PrefabPath.TeamComp
	}
}
module_views.Act191ShopView = {
	destroy = 0,
	container = "Act191ShopViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191shopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.NodeListItem,
		Activity191Enum.PrefabPath.TeamComp,
		Activity191Enum.PrefabPath.HeroHeadItem
	}
}
module_views.Act191EnhancePickView = {
	destroy = 0,
	container = "Act191EnhancePickViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191enhancepickview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Act191AdventureView = {
	destroy = 0,
	container = "Act191AdventureViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191adventureview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.RewardItem
	}
}
module_views.Act191HeroGroupView = {
	destroy = 0,
	container = "Act191HeroGroupViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.FetterItem,
		Activity191Enum.PrefabPath.RewardItem
	}
}
module_views.Act191EnemyInfoView = {
	destroy = 0,
	container = "Act191EnemyInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191enemyinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.HeroHeadItem,
		Activity191Enum.PrefabPath.FetterItem
	}
}
module_views.Act191HeroEditView = {
	container = "Act191HeroEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191heroeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.HeroEditItem,
		Activity191Enum.PrefabPath.FetterItem
	}
}
module_views.Act191CharacterExSkillView = {
	container = "Act191CharacterExSkillViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191characterexskillview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/character/characterskilldescripte.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	customAnimBg = {
		"bg"
	}
}
module_views.Act191HeroTipView = {
	destroy = 0,
	container = "Act191HeroTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191herotipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act191CollectionTipView = {
	destroy = 0,
	container = "Act191CollectionTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191collectiontipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act191EnhanceTipView = {
	destroy = 0,
	container = "Act191EnhanceTipViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191enhancetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act191FetterTipView = {
	destroy = 0,
	container = "Act191FetterTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191fettertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		Activity191Enum.PrefabPath.HeroHeadItem
	}
}
module_views.Act191FightSuccView = {
	destroy = 0,
	container = "Act191FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		Activity191Enum.PrefabPath.BossHpItem,
		Activity191Enum.PrefabPath.RewardItem
	}
}
module_views.Act191SettlementView = {
	destroy = 0,
	container = "Act191SettlementViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		Activity191Enum.PrefabPath.NodeListItem,
		Activity191Enum.PrefabPath.FetterItem
	}
}
module_views.Act191CharacterTipView = {
	bgBlur = 2,
	container = "Act191CharacterTipViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191charactertipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#go_passiveskilltip/talentbg"
	}
}
module_views.Act191CharacterDestinyView = {
	destroy = 0,
	container = "Act191CharacterDestinyViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191characterdestinyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act191SwitchView = {
	destroy = 0,
	container = "Act191SwitchViewContainer",
	bgBlur = 0.5,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191switchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act191BuffTipView = {
	destroy = 10,
	container = "Act191BuffTipViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191bufftipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Act191ItemView = {
	destroy = 0,
	container = "Act191ItemViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191itemview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.Act191GetView = {
	destroy = 0,
	container = "Act191GetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191getview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		Activity191Enum.PrefabPath.HeroHeadItem
	}
}
module_views.Act191CollectionView = {
	destroy = 0,
	container = "Act191CollectionViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191collectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.CollectionItem,
		Activity191Enum.PrefabPath.HeroHeadItem
	}
}
module_views.Act191AssistantView = {
	destroy = 0,
	container = "Act191AssistantViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191assistantview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act191CollectionChangeView = {
	destroy = 0,
	container = "Act191CollectionChangeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191collectionchangeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_7/act191/act191collectiontipview.prefab"
			}
		}
	},
	otherRes = {
		Activity191Enum.PrefabPath.CollectionItem
	}
}
module_views.Act191CollectionGetView = {
	destroy = 0,
	container = "Act191CollectionGetViewContainer",
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191collectiongetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		Activity191Enum.PrefabPath.CollectionItem
	}
}
module_views.Act191EnhanceView = {
	destroy = 0,
	container = "Act191EnhanceViewContainer",
	maskAlpha = 0,
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_7/act191/act191enhanceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.V2a7_SelfSelectSix_FullView = {
	destroy = 0,
	container = "V2a7_SelfSelectSix_FullViewContainer",
	mainRes = "ui/viewres/activity/v2a7_selfselectsix_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V2a7_SelfSelectSix_PanelView = {
	destroy = 0,
	container = "V2a7_SelfSelectSix_PanelViewContainer",
	maskAlpha = 0,
	bgBlur = 2,
	mainRes = "ui/viewres/activity/v2a7_selfselectsix_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a7_SelfSelectSix_PickChoiceView = {
	bgBlur = 2,
	container = "V2a7_SelfSelectSix_PickChoiceViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/activity/v2a7_selfselectsix_pickchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a7_selfselectsix_pickchoiceitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TowerGiftFullView = {
	destroy = 0,
	container = "TowerGiftFullViewContainer",
	mainRes = "ui/viewres/activity/v2a7_tower_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.TowerGiftPanelView = {
	destroy = 0,
	container = "TowerGiftPanelViewContainer",
	maskAlpha = 0,
	bgBlur = 2,
	mainRes = "ui/viewres/activity/v2a7_tower_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.CharacterDestinyStoneUpView = {
	destroy = 0,
	container = "CharacterDestinyStoneUpViewContainer",
	mainRes = "ui/viewres/activity/v2a7_tower_characterdestinystoneview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Nomal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_9EnterView = {
	destroy = 0,
	container = "VersionActivity2_9EnterViewContainer",
	mainRes = "ui/viewres/sp01/enter/versionactivity_2_9_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "scenes/sp01_m_s18_kv/sp01_m_s17_kv_p.prefab"
	}
}
module_views.VersionActivity2_9DungeonMapView = {
	destroy = 0,
	container = "VersionActivity2_9DungeonMapViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/v2a9_dungeonmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		"ui/viewres/sp01/assassin2/v2a9_mapepisodeitem.prefab",
		"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
		"ui/viewres/sp01/assassin2/v2a9_dungeonmap_direction.prefab",
		"ui/viewres/sp01/assassin2/v2a9_dungeonmapbg.prefab",
		"scenes/dynamic/sp01_m_s08_dna/dnamove_y.asset",
		"scenes/dynamic/sp01_m_s08_dna/dnamove_z.asset"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_9DungeonMapLevelView = {
	destroy = 0,
	container = "VersionActivityFixedDungeonMapLevelViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/v2a9_dungeonmaplevelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		},
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_9DungeonFragmentInfoView = {
	destroy = 0,
	container = "VersionActivity2_9DungeonFragmentInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/v2a9_dungeonfragmentinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.VersionActivity2_9HeroGroupFightView = {
	bgBlur = 4,
	container = "VersionActivity2_9HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/sp01/assassin2/v2a9_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.VersionActivity2_9FightSuccView = {
	destroy = 0,
	container = "VersionActivity2_9FightSuccViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/v2a9_fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.VersionActivity2_9StoreView = {
	destroy = 0,
	container = "VersionActivityFixedStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/v2a9_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_9TaskView = {
	destroy = 0,
	container = "VersionActivityFixedTaskViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/v2a9_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/sp01/assassin2/v2a9_taskitem.prefab"
	}
}
module_views.AssassinTaskView = {
	destroy = 0,
	container = "AssassinTaskViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassin2_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/sp01/assassin2/assassin2_taskitem.prefab"
	}
}
module_views.AssassinLoginView = {
	destroy = 0,
	container = "AssassinLoginViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinloginview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.AssassinMapView = {
	destroy = 0,
	container = "AssassinMapViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinBuildingMapView = {
	destroy = 0,
	container = "AssassinBuildingMapViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinbuildingmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "singlebg/assassin2_singlebg/manor/assassin2_manor_mapbg.png",
		[2] = "singlebg/assassin2_singlebg/manor/assassin2_manor_mask1.png"
	}
}
module_views.AssassinQuestMapView = {
	destroy = 0,
	container = "AssassinQuestMapViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinquestmapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/dungeon/chaptermap/map_direction.prefab"
	}
}
module_views.AssassinQuestDetailView = {
	destroy = 0,
	container = "AssassinQuestDetailViewContainer",
	maskAlpha = 0,
	mainRes = "ui/viewres/sp01/assassin2/assassinquestdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AssassinStealthGameOverView = {
	destroy = 0,
	container = "AssassinStealthGameOverViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassinstealthgameoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.AssassinStealthGameGetItemView = {
	destroy = 0,
	container = "AssassinStealthGameGetItemViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassinstealthgamegetitemview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.AssassinStealthGamePauseView = {
	destroy = 0,
	container = "AssassinStealthGamePauseViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassinstealthgamepauseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.AssassinStealthGameResultView = {
	destroy = 0,
	container = "AssassinStealthGameResultViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinstealthgameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AssassinStealthGameEventView = {
	destroy = 0,
	container = "AssassinStealthGameEventViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassinstealthgameeventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.AssassinTechniqueView = {
	destroy = 0,
	container = "AssassinTechniqueViewContainer",
	maskAlpha = 0,
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassintechniqueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.FightRouge2TechniqueView = {
	destroy = 0,
	container = "FightRouge2TechniqueViewContainer",
	maskAlpha = 0,
	bgBlur = 1,
	mainRes = "ui/viewres/fight/fight_rouge2/fight_rouge2_techniqueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.AssassinHeroView = {
	destroy = 0,
	container = "AssassinHeroViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinheroview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinStatsView = {
	destroy = 0,
	container = "AssassinStatsViewContainer",
	maskAlpha = 0,
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassinstatsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.AssassinEquipView = {
	destroy = 0,
	container = "AssassinEquipViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinBackpackView = {
	destroy = 0,
	container = "AssassinBackpackViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinbackpackview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinStealthGameView = {
	destroy = 0,
	container = "AssassinStealthGameViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinstealthgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinBuildingLevelUpView = {
	destroy = 0,
	container = "AssassinBuildingLevelUpViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinbuildinglevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinBuildingLevelUpSuccessView = {
	destroy = 0,
	container = "AssassinBuildingLevelUpSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassinbuildinglevelupsuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinEyeGameView = {
	destroy = 0,
	container = "AssassinEyeGameViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassineyegameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinLineGameView = {
	destroy = 0,
	container = "AssassinLineGameViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinlinegameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinPointGameView = {
	destroy = 0,
	container = "AssassinPointGameViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinpointgameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinLibraryView = {
	destroy = 0,
	container = "AssassinLibraryViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinlibraryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/sp01/assassin2/assassinlibraryheroview.prefab"
			},
			{
				"ui/viewres/sp01/assassin2/assassinlibrarylistview.prefab"
			},
			{
				"ui/viewres/sp01/assassin2/assassinlibraryvideolistview.prefab"
			}
		}
	}
}
module_views.AssassinLibraryDetailView = {
	destroy = 0,
	container = "AssassinLibraryDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/assassin2/assassinlibrarydetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinLibraryToastView = {
	destroy = 0,
	container = "AssassinLibraryToastViewContainer",
	mainRes = "ui/viewres/sp01/assassin2/assassinlibrarytoastview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal
}
module_views.Permanent2_1EnterView = {
	destroy = 0,
	container = "Permanent2_1EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a1_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a3_ReactivityEnterview = {
	destroy = 0,
	container = "V2a3_ReactivityEnterviewContainer",
	mainRes = "ui/viewres/sp01/reactivity/v2a3_reactivityenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_4EnterView = {
	destroy = 0,
	container = "Permanent2_4EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a4_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_5EnterView = {
	destroy = 0,
	container = "Permanent2_5EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a5_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_6EnterView = {
	destroy = 0,
	container = "Permanent2_6EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a6_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_7EnterView = {
	destroy = 0,
	container = "Permanent2_7EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a7_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_8EnterView = {
	destroy = 0,
	container = "Permanent2_8EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a8_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent3_0EnterView = {
	destroy = 0,
	container = "Permanent3_0EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v3a0_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent3_1EnterView = {
	destroy = 0,
	container = "Permanent3_1EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v3a1_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_2EnterView = {
	destroy = 0,
	container = "Permanent2_2EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a2_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Permanent2_3EnterView = {
	destroy = 0,
	container = "Permanent2_3EnterViewContainer",
	mainRes = "ui/viewres/dungeon/reappear/v2a3_reappear_mainactivity_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.OdysseyDungeonView = {
	destroy = 0,
	container = "OdysseyDungeonViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseydungeonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/sp01/odyssey/odysseydungeonelementitem.prefab",
		"ui/viewres/sp01/odyssey/odysseymapdirection.prefab",
		"ui/viewres/sp01/odyssey/odysseydungeonlevelcomp.prefab"
	}
}
module_views.OdysseyDungeonInteractView = {
	destroy = 0,
	container = "OdysseyDungeonInteractViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseydungeoninteractview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseyitemicon.prefab",
		[2] = "ui/viewres/sp01/odyssey/odysseydungeonlevelcomp.prefab"
	}
}
module_views.OdysseyItemTipView = {
	destroy = 0,
	container = "OdysseyItemTipViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseyitemtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.OdysseyDungeonMapSelectInfoView = {
	destroy = 0,
	container = "OdysseyDungeonMapSelectInfoViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseydungeonmapselectinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.OdysseyDungeonRewardView = {
	destroy = 0,
	container = "OdysseyDungeonRewardViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseydungeonrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseyitemicon.prefab"
	}
}
module_views.OdysseyTalentTreeView = {
	destroy = 0,
	container = "OdysseyTalentTreeViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseytalenttreeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseytalenttreeitem.prefab"
	}
}
module_views.OdysseyMythView = {
	destroy = 0,
	container = "OdysseyMythViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseymythview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.OdysseyHeroGroupView = {
	bgBlur = 4,
	container = "OdysseyHeroGroupViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/sp01/odyssey/odysseyherogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab",
		[2] = "ui/viewres/sp01/odyssey/odysseyherogroupequipitem.prefab"
	}
}
module_views.OdysseyMembersView = {
	destroy = 0,
	container = "OdysseyMembersViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseymembersview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.OdysseyMembersTipView = {
	destroy = 0,
	container = "OdysseyMembersTipViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseymemberstipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseyitemicon.prefab"
	}
}
module_views.OdysseyHeroGroupEditView = {
	container = "OdysseyHeroGroupEditViewContainer",
	destroy = 5,
	mainRes = "ui/viewres/herogroup/herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/herogroup/herogroupedititem.prefab",
		[2] = "ui/viewres/herogroup/herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.OdysseyTrialCharacterTalentView = {
	destroy = 0,
	container = "OdysseyTrialCharacterTalentViewContainer",
	mainRes = "ui/viewres/character/extra/characterskilltalentview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.OdysseyEquipView = {
	destroy = 0,
	container = "OdysseyEquipViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseyequipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseyitemicon.prefab",
		[2] = "ui/viewres/sp01/odyssey/odysseyherogroupequipitem.prefab"
	}
}
module_views.OdysseyLevelRewardView = {
	destroy = 0,
	container = "OdysseyLevelRewardViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseylevelrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.OdysseyBagView = {
	destroy = 0,
	container = "OdysseyBagViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseybagview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseyitemicon.prefab"
	}
}
module_views.OdysseyTaskView = {
	destroy = 0,
	container = "OdysseyTaskViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseytaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseytaskitem.prefab"
	}
}
module_views.OdysseyLibraryToastView = {
	destroy = 0,
	container = "OdysseyLibraryToastViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseylibrarytoastview.prefab",
	layer = "MESSAGE",
	viewType = ViewType.Normal
}
module_views.OdysseySuitTipView = {
	destroy = 0,
	container = "OdysseySuitTipViewContainer",
	mainRes = "ui/viewres/sp01/odyssey/odysseysuittipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.OdysseySuccessView = {
	destroy = 0,
	container = "OdysseySuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/odyssey/odysseysuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseyitemicon.prefab"
	}
}
module_views.OdysseyMythSuccessView = {
	destroy = 0,
	container = "OdysseyMythSuccessViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/sp01/odyssey/odysseymythsuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.OdysseyMythResultView = {
	destroy = 0,
	container = "OdysseyMythResultViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/sp01/odyssey/odysseymythresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		[1] = "ui/viewres/sp01/odyssey/odysseyitemicon.prefab",
		[2] = "ui/viewres/sp01/odyssey/odysseyherogroupequipitem.prefab"
	}
}
module_views.V2a9_VersionSummonFull_Part1 = {
	destroy = 0,
	container = "V2a9_VersionSummonFull_Part1ViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_9/v2a9_versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a9_VersionSummonFull_Part2 = {
	destroy = 0,
	container = "V2a9_VersionSummonFull_Part2ViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_2_9/v2a9_versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a9_VersionSummonPanel_Part1 = {
	destroy = 0,
	container = "V2a9_VersionSummonPanel_Part1ViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_9/v2a9_versionsummonpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V2a9_VersionSummonPanel_Part2 = {
	destroy = 0,
	container = "V2a9_VersionSummonPanel_Part2ViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_9/v2a9_versionsummonpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Act205GameStartView = {
	destroy = 0,
	container = "Act205GameStartViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/act205/act205_gamestartview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act205RuleTipsView = {
	destroy = 0,
	container = "Act205RuleTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/act205/act205_ruletipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.Act205CardSelectView = {
	destroy = 0,
	container = "Act205CardSelectViewContainer",
	mainRes = "ui/viewres/sp01/act205/cardgame/act205_cardselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/sp01/act205/cardgame/act205_carditem.prefab"
	}
}
module_views.Act205CardShowView = {
	destroy = 0,
	container = "Act205CardShowViewContainer",
	mainRes = "ui/viewres/sp01/act205/cardgame/act205_cardshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/sp01/act205/cardgame/act205_carditem.prefab"
	}
}
module_views.Act205CardResultView = {
	destroy = 0,
	container = "Act205CardResultViewContainer",
	mainRes = "ui/viewres/sp01/act205/cardgame/act205_cardresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act205OceanSelectView = {
	destroy = 0,
	container = "Act205OceanSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/act205/oceangame/act205_oceanselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Act205OceanShowView = {
	destroy = 0,
	container = "Act205OceanShowViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/act205/oceangame/act205_oceanshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/sp01/act205/oceangame/act205_oceandiceitem.prefab"
	}
}
module_views.Act205OceanResultView = {
	destroy = 0,
	container = "Act205OceanResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/act205/oceangame/act205_oceanresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.AssassinChaseSelectView = {
	destroy = 0,
	container = "AssassinChaseSelectViewContainer",
	mainRes = "ui/viewres/sp01/act205/recruitgame/act193_recruitselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinChaseProgressView = {
	destroy = 0,
	container = "AssassinChaseProgressViewContainer",
	mainRes = "ui/viewres/sp01/act205/recruitgame/act193_recruitprogressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinChaseResultView = {
	destroy = 0,
	container = "AssassinChaseResultViewContainer",
	mainRes = "ui/viewres/sp01/act205/recruitgame/act193_recruitresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.AssassinChaseGameView = {
	destroy = 0,
	container = "AssassinChaseGameViewContainer",
	mainRes = "ui/viewres/sp01/act205/recruitgame/act193_recruitview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AssassinChaseChatView = {
	destroy = 0,
	container = "AssassinChaseChatViewContainer",
	mainRes = "ui/viewres/sp01/act205/recruitgame/act193_chatview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Activity204EntranceView = {
	destroy = 0,
	container = "Activity204EntranceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/act204/activitycollectionpageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity204TaskView = {
	bgBlur = 0,
	container = "Activity204TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/sp01/act204/activitytaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		itemRes = "ui/viewres/sp01/act204/activitytaskitem.prefab"
	}
}
module_views.V2a9_LinkPackageView = {
	destroy = 0,
	container = "V2a9_LinkPackageViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a9_gift_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a9_LoginSign_PanelView = {
	destroy = 0,
	container = "V2a9_LoginSign_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp01/loginsign/activity_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/sp01/loginsign/activity_signitem.prefab"
	}
}
module_views.V2a9_LoginSign_FullView = {
	bgBlur = 1,
	container = "V2a9_LoginSign_FullViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/sp01/loginsign/activity_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/sp01/loginsign/activity_signitem.prefab"
	}
}

MonthCardViewDefine.init(module_views)

module_views.V2a9_LinkGiftView = {
	destroy = 0,
	container = "V2a9_LinkGiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/s02_gift_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a3_ReactivityStoreView = {
	destroy = 0,
	container = "ReactivityStoreViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_3/v2a3_dungeon/v2a3_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}

CharacterViewDefine.init(module_views)

module_views.VersionActivity2_8BossStoryEyeView = {
	destroy = 0,
	container = "VersionActivity2_8BossStoryEyeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonbossstoryeye.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Nomal,
	preloader = module_views_preloader
}
module_views.VersionActivity2_8BossStoryEnterView = {
	destroy = 0,
	container = "VersionActivity2_8BossStoryEnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonbossstoryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.VersionActivity2_8BossActEnterView = {
	destroy = 0,
	container = "VersionActivity2_8BossActEnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeon/v2a8_dungeonbossactivityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	preloader = module_views_preloader
}
module_views.VersionActivity2_8BossStoryLoadingView = {
	destroy = 0,
	container = "VersionActivity2_8BossStoryLoadingViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonbossstoryloadingview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_dungeonboss/v2a8_dungeonbossstorysnow.prefab"
	}
}
module_views.VersionActivity3_0EnterView = {
	destroy = 0,
	container = "VersionActivity3_0EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_enter/v3a0_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_0/v3a0_enter/v3a0_enterdragitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_3_0/v3a0_enter/v3a0_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_3_0/v3a0_enter/v3a0_karong_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_3_0/v3a0_reprint/v3a0_v2a1reprint_enterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
			}
		}
	}
}
module_views.V3a0_SummerSign_PanelView = {
	destroy = 0,
	container = "V2a0_SummerSign_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a0_summersign_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v3a0_summersign_signitem.prefab"
	}
}
module_views.V3a0_SummerSign_FullView = {
	destroy = 0,
	container = "V2a0_SummerSign_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v3a0_summersign_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v3a0_summersign_signitem.prefab"
	}
}
module_views.VersionActivity2_8EnterView = {
	destroy = 0,
	container = "VersionActivity2_8EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_enter/v2a8_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_2_8/v2a8_enter/v2a8_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_8/survival/v2a8_survival_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_8/v2a8_enter/v2a8_autochess_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_enterview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
			}
		}
	}
}
module_views.VersionActivity2_8StoreView = {
	destroy = 0,
	container = "VersionActivity2_8StoreViewContainer",
	bgBlur = 1,
	mainRes = "",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionActivity2_8TaskView = {
	destroy = 0,
	container = "VersionActivity2_8TaskViewContainer",
	mainRes = "",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		""
	}
}
module_views.MoLiDeErTaskView = {
	destroy = 0,
	container = "MoLiDeErTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_taskitem.prefab"
	}
}
module_views.MoLiDeErGameView = {
	destroy = 0,
	container = "MoLiDeErGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_bottom.prefab"
	}
}
module_views.MoLiDeErEventView = {
	destroy = 0,
	container = "MoLiDeErEventViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_eventview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_bottom.prefab"
	}
}
module_views.MoLiDeErLevelView = {
	destroy = 0,
	container = "MoLiDeErLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_levelviewstageitem.prefab"
	}
}
module_views.MoLiDeErInterludeView = {
	destroy = 0,
	container = "MoLiDeErInterludeViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_interludeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.MoLiDeErResultView = {
	destroy = 0,
	container = "MoLiDeErResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_molideer/v2a8_molideer_dungeonresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.NuoDiKaLevelView = {
	destroy = 0,
	container = "NuoDiKaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_levelitem.prefab"
	}
}
module_views.NuoDiKaGameView = {
	destroy = 0,
	container = "NuoDiKaGameViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.NuoDiKaInfosView = {
	destroy = 0,
	container = "NuoDiKaInfosViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_infosview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.NuoDiKaGameUnitDetailView = {
	destroy = 0,
	container = "NuoDiKaGameUnitDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_unitdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.NuoDiKaGameResultView = {
	destroy = 0,
	container = "NuoDiKaGameResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.NuoDiKaTaskView = {
	destroy = 0,
	container = "NuoDiKaTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_2_8/v2a8_nuodika/v2a8_nuodika_taskitem.prefab"
	}
}
module_views.Activity2ndCollectionPageView = {
	destroy = 0,
	container = "Activity2ndCollectionPageViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_activity2nd/v2a8_activity2ndcollectionpageview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity197View = {
	destroy = 0,
	container = "Activity197ViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_activity2nd/v2a8_activity2ndrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Activity2ndMailView = {
	destroy = 0,
	container = "Activity2ndMailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_activity2nd/v2a8_activity2ndinvitationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Activity2ndTakePhotosView = {
	destroy = 0,
	container = "Activity2ndTakePhotosViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_activity2nd/v2a8_gift_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a8_SelfSelectCharacterFullView = {
	destroy = 0,
	container = "V2a8_SelfSelectCharacterFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_selfselectcharacter/v2a8_selfselectcharacterfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a8_SelfSelectCharacterView = {
	destroy = 0,
	container = "V2a8_SelfSelectCharacterViewContainer",
	maskAlpha = 0,
	bgBlur = 2,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_selfselectcharacter/v2a8_selfselectcharacterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a8_SelfSelectSix_PickChoiceView = {
	bgBlur = 2,
	container = "V2a8_SelfSelectSix_PickChoiceViewContainer",
	maskAlpha = 0,
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_selfselectcharacter/v2a8_selfselectsix_pickchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/versionactivity_2_8/v2a8_selfselectcharacter/v2a8_selfselectsix_pickchoiceitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V2a8_WarmUp = {
	destroy = 0,
	container = "V2a8_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a8_warmup/v2a8_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}

SurvivalViewDefine.init(module_views)
DecalogPresentViewDefine.init(module_views)
CommandStationViewDefine.init(module_views)
SeasonViewDefine.init(module_views)

module_views.TurnBackFullView = {
	destroy = 0,
	container = "TurnBackFullViewContainer",
	mainRes = "ui/viewres/activity/turnback_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a8_WuErLiXiGiftView = {
	destroy = 0,
	container = "V2a8_WuErLiXiGiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_wuerlixigiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V2a8_WuErLiXiGiftFullView = {
	destroy = 0,
	container = "V2a8_WuErLiXiGiftFullViewContainer",
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_wuerlixigiftfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V2a8_DragonBoat_PanelView = {
	destroy = 0,
	container = "V2a8_DragonBoat_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v2a8_dragonboat_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a8_dragonboat_rewarditem.prefab"
	}
}
module_views.V2a8_DragonBoat_FullView = {
	destroy = 0,
	container = "V2a8_DragonBoat_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v2a8_dragonboat_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v2a8_dragonboat_rewarditem.prefab"
	}
}
module_views.RoomBlockGiftChoiceView = {
	destroy = 0,
	container = "RoomBlockGiftChoiceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/room/gift/roomblockgiftchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.RoomBlockGiftStoreGoodsView = {
	bgBlur = 1,
	container = "RoomBlockGiftStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/roomstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Activity2ndShowSkinView = {
	destroy = 0,
	container = "Activity2ndShowSkinViewContainer",
	maskAlpha = 0,
	bgBlur = 2,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_activity2nd/v2a8_skin_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SkinCouponTipView = {
	destroy = 0,
	container = "SkinCouponTipViewContainer",
	maskAlpha = 0,
	bgBlur = 2,
	mainRes = "ui/viewres/versionactivity_2_8/v2a8_activity2nd/v2a8_skin_getpanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity201MaLiAnNaLevelView = {
	destroy = 0,
	container = "Activity201MaLiAnNaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_levelviewstageitem.prefab"
	}
}
module_views.Activity201MaLiAnNaTaskView = {
	destroy = 0,
	container = "Activity201MaLiAnNaTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_taskitem.prefab"
	}
}
module_views.Activity201MaLiAnNaGameView = {
	destroy = 0,
	container = "Activity201MaLiAnNaGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_slotitem.prefab",
		"ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_skillitem.prefab",
		"ui/viewres/versionactivity_3_0/v3a0_malianna/malianna_solider_item.prefab",
		"ui/viewres/versionactivity_3_0/v3a0_malianna/malianna_hero_item.prefab"
	}
}
module_views.MaLiAnNaNoticeView = {
	destroy = 0,
	container = "MaLiAnNaNoticeViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_noticeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.MaLiAnNaResultView = {
	destroy = 0,
	container = "MaLiAnNaResultViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_dungeonresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Activity201MaLiAnNaGameMainView = {
	destroy = 0,
	container = "Activity201MaLiAnNaGameMainViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_loadingpage.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.KaRongLevelView = {
	destroy = 0,
	container = "KaRongLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_karong/v3a0_karong_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_0/v3a0_karong/v3a0_karong_levelitem.prefab"
	}
}
module_views.KaRongTaskView = {
	bgBlur = 0,
	container = "KaRongTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_karong/v3a0_karong_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_0/v3a0_karong/v3a0_karong_taskitem.prefab"
	}
}
module_views.KaRongDrawView = {
	destroy = 0,
	container = "KaRongDrawViewContainer",
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_karong/maze/v3a0_puzzlemazedrawview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_3_0/v3a0_karong/maze/v3a0_puzzlemazeitem.prefab",
		"ui/viewres/versionactivity_3_0/v3a0_karong/maze/v3a0_puzzlemazepath.prefab",
		"ui/viewres/versionactivity_3_0/v3a0_karong/maze/v3a0_puzzlemazepawn.prefab",
		"ui/viewres/versionactivity_3_0/v3a0_karong/maze/v3a0_puzzlemazeblockitem.prefab"
	}
}
module_views.KaRongRoleTagView = {
	destroy = 0,
	container = "KaRongRoleTagViewContainer",
	maskAlpha = 0,
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_3_0/v3a0_karong/v3a0_karong_roletagview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.V3a0_WarmUp = {
	destroy = 0,
	container = "V3a0_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v3a0_warmup/v3a0_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a9_WarmUp = {
	destroy = 0,
	container = "V2a9_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v2a9_warmup/v2a9_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V2a9_Act208MainView = {
	destroy = 0,
	container = "V2a9_Act208MainViewContainer",
	mainRes = "ui/viewres/activity/v2a9_login_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.TowerDeepOperActPanelView = {
	destroy = 0,
	container = "TowerDeepOperActPanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a1_towerdeep_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.TowerDeepOperActFullView = {
	destroy = 0,
	container = "TowerDeepOperActFullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v3a1_towerdeep_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SurvivalOperActPanelView = {
	destroy = 0,
	container = "SurvivalOperActPanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_1/survivaloperact/survivaloperactpanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SurvivalOperActFullView = {
	destroy = 0,
	container = "SurvivalOperActFullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_3_1/survivaloperact/survivaloperactfullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}

VersionActivityViewDefine.init(module_views)
VersionActivity3_2ViewDefine.init(module_views)
VersionActivity3_4ViewDefine.init(module_views)
VersionActivity3_5ViewDefine.init(module_views)
VersionActivity3_6ViewDefine.init(module_views)
VersionActivity3_7ViewDefine.init(module_views)
VersionActivity3_8ViewDefine.init(module_views)
VersionActivity3_9ViewDefine.init(module_views)

module_views.GMYeShuMeiView = {
	destroy = 0,
	container = "GMYeShuMeiViewContainer",
	mainRes = "ui/viewres/gm/gmyeshumeiview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}

NecologistStoryViewDefine.init(module_views)

module_views.Role_PanelSignView_Part1 = {
	destroy = 0,
	container = "Role_PanelSignView_Part1_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/role_signitem.prefab"
	}
}
module_views.Role_PanelSignView_Part2 = {
	destroy = 0,
	container = "Role_PanelSignView_Part2_Container",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/role_signitem.prefab"
	}
}
module_views.Role_FullSignView_Part1 = {
	destroy = 0,
	container = "Role_FullSignView_Part1_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/role_signitem.prefab"
	}
}
module_views.Role_FullSignView_Part2 = {
	destroy = 0,
	container = "Role_FullSignView_Part2_Container",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/role_signitem.prefab"
	}
}
module_views.YeShuMeiGameView = {
	destroy = 0,
	container = "YeShuMeiGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_yeshumei/v3a1_yeshumeigameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.YeShuMeiLevelView = {
	destroy = 0,
	container = "YeShuMeiLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_yeshumei/v3a1_yeshumei_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_1/v3a1_yeshumei/v3a1_yeshumei_levelitem.prefab"
	}
}
module_views.YeShuMeiTaskView = {
	bgBlur = 0,
	container = "YeShuMeiTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_yeshumei/v3a1_yeshumei_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_1/v3a1_yeshumei/v3a1_yeshumei_taskitem.prefab"
	}
}
module_views.V3a1_BpOperActShowView = {
	destroy = 0,
	container = "V3a1_BpOperActShowViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_bpoper/v3a1_bpoperactshowview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.NationalGiftBuyTipView = {
	destroy = 0,
	container = "NationalGiftBuyTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/nationalgiftbuytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.NationalGiftFullView = {
	destroy = 0,
	container = "NationalGiftFullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitynationalgiftview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ActivityWarmUpH5FullView = {
	destroy = 0,
	container = "ActivityWarmUpH5FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/activitywarmuph5fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a1_AutumnSign_PanelView = {
	destroy = 0,
	container = "V2a0_SummerSign_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a1_autumnsign_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v3a1_autumnsign_signitem.prefab"
	}
}
module_views.V3a1_AutumnSign_FullView = {
	destroy = 0,
	container = "V2a0_SummerSign_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v3a1_autumnsign_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v3a1_autumnsign_signitem.prefab"
	}
}
module_views.V3a1_GaoSiNiao_TaskView = {
	bgBlur = 0,
	container = "V3a1_GaoSiNiao_TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_gaosiniao/v3a1_gaosiniao_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_1/v3a1_gaosiniao/v3a1_gaosiniao_taskitem.prefab"
	}
}
module_views.V3a1_GaoSiNiao_LevelView = {
	destroy = 0,
	container = "V3a1_GaoSiNiao_LevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_gaosiniao/v3a1_gaosiniao_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		v3a1_gaosiniao_levelviewstageitem = GaoSiNiaoEnum.ResPath.v3a1_gaosiniao_levelviewstageitem
	}
}
module_views.V3a1_GaoSiNiao_GameView = {
	destroy = 0,
	container = "V3a1_GaoSiNiao_GameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_1/v3a1_gaosiniao/v3a1_gaosiniao_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a1_WarmUp = {
	destroy = 0,
	container = "V3a1_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v3a1_warmup/v3a1_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ChargePushCommonGiftView = {
	destroy = 0,
	container = "ChargePushCommonGiftViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activity_giftbuypanelview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		itemRes = "ui/viewres/store/packagestoregoodsitem.prefab"
	}
}
module_views.ChargePushLevelGoodsView = {
	destroy = 0,
	container = "ChargePushLevelGoodsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activity_giftbuypanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		itemRes = "ui/viewres/store/packagestoregoodsitem.prefab"
	}
}
module_views.ChargePushMonthCardView = {
	destroy = 0,
	container = "ChargePushMonthCardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activity_monthcardbuypanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.UdimoChangeBgView = {
	destroy = 0,
	container = "UdimoChangeBgViewContainer",
	mainRes = "ui/viewres/udimo/udimo_changebgview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.UdimoChangeDecorationView = {
	destroy = 0,
	container = "UdimoChangeDecorationViewContainer",
	mainRes = "ui/viewres/udimo/udimo_changedecorationview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.UdimoInfoView = {
	destroy = 0,
	container = "UdimoInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/udimo/udimo_infoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.UdimoMainView = {
	destroy = 0,
	container = "UdimoMainViewContainer",
	mainRes = "ui/viewres/udimo/udimo_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.HuiDiaoLanGameView = {
	destroy = 0,
	container = "HuiDiaoLanGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolangameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolanplaneitem.prefab",
		[2] = "ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolanelement.prefab"
	}
}
module_views.HuiDiaoLanResultView = {
	destroy = 0,
	container = "HuiDiaoLanResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolan_gameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.HuiDiaoLanEpisodeLevelView = {
	destroy = 0,
	container = "HuiDiaoLanEpisodeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolan_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolan_levelitem.prefab"
	}
}
module_views.HuiDiaoLanTaskView = {
	destroy = 0,
	container = "HuiDiaoLanTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolan_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolan_taskitem.prefab"
	}
}
module_views.CruiseTripleDropFullView = {
	destroy = 0,
	container = "CruiseTripleDropFullViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/v3a2_tripledrop_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.CruiseTripleDropView = {
	destroy = 0,
	container = "CruiseTripleDropViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/v3a2_tripledrop_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CruiseGlobalTaskView = {
	destroy = 0,
	container = "CruiseGlobalTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/v3a2_cruiseglobaltaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.CruiseMainView = {
	destroy = 0,
	container = "CruiseMainViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/v3a2_cruisemainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CruiseOpenCeremonyView = {
	destroy = 0,
	container = "CruiseOpenCeremonyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/v3a2_cruiseopenceremonyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.CruiseSelfTaskView = {
	destroy = 0,
	container = "CruiseSelfTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/v3a2_cruiseselftaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CruiseSelfTaskHeroTypeTipView = {
	destroy = 0,
	container = "CruiseSelfTaskHeroTypeTipViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/v3a2_cruiseselftaskherotypetipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CruiseGameMainView = {
	destroy = 0,
	container = "CruiseGameMainViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/cruisegoldgame/cruisegamemainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CruiseGameTaskView = {
	destroy = 0,
	container = "CruiseGameTaskViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/cruisegoldgame/cruisegametaskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CruiseGamePlayView = {
	destroy = 0,
	container = "CruiseGamePlayViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/cruisegoldgame/cruisegameplayview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.CruiseGamePromptView = {
	destroy = 0,
	container = "CruiseGamePromptViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/cruisegoldgame/cruisegamepromptview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.CruiseGameResultView = {
	bgBlur = 1,
	container = "CruiseGameResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_cruise/cruisegoldgame/cruisegameresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.ItemTalentChooseView = {
	destroy = 0,
	container = "ItemTalentChooseViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/item/itemtalentchooseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.ItemTalentHeroUpView = {
	destroy = 0,
	container = "ItemTalentHeroUpViewContainer",
	mainRes = "ui/viewres/item/itemtalentupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_DifficultySelectView = {
	destroy = 0,
	container = "Rouge2_DifficultySelectViewContainer",
	mainRes = "ui/viewres/rouge2/rouge2_difficultyselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.DifficultyItem
	}
}
module_views.Rouge2_CareerSelectView = {
	destroy = 0,
	container = "Rouge2_CareerSelectViewContainer",
	mainRes = "ui/viewres/rouge2/rouge2_careerselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.AttributeMap,
		Rouge2_Enum.ResPath.RecommendTeamTips
	}
}
module_views.Rouge2_CareerSkillTipsView = {
	destroy = 0,
	container = "Rouge2_CareerSkillTipsViewContainer",
	mainRes = "ui/viewres/rouge2/rouge2_careerskilltipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Rouge2_CareerAttributeTipsView = {
	destroy = 0,
	container = "Rouge2_CareerAttributeTipsViewContainer",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	mainRes = Rouge2_Enum.ResPath.CareerAttributeTips,
	otherRes = {
		Rouge2_Enum.ResPath.CareerAttrActiveItem
	}
}
module_views.Rouge2_SystemSelectView = {
	destroy = 0,
	container = "Rouge2_SystemSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/system/rouge2_systemselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_MapLoadingView = {
	destroy = 0,
	container = "Rouge2_MapLoadingViewContainer",
	mainRes = "ui/viewres/rouge2/loading/rouge2_loadingview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Rouge2_MapView = {
	bgBlur = 0,
	container = "Rouge2_MapViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_mapview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.CoinView,
		Rouge2_Enum.ResPath.AttrToolBar
	}
}
module_views.Rouge2_MapEntrustDetailView = {
	bgBlur = 1,
	container = "Rouge2_MapEntrustDetailViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_mapentrustdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.CoinView
	}
}
module_views.Rouge2_MapChoiceView = {
	bgBlur = 0,
	container = "Rouge2_MapChoiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge2/map/rouge2_choiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.CoinView,
		Rouge2_Enum.ResPath.MapChoiceItem,
		Rouge2_Enum.ResPath.ChoiceCheckItem,
		Rouge2_Enum.ResPath.AttrToolBar
	}
}
module_views.Rouge2_MapExploreChoiceView = {
	bgBlur = 0,
	container = "Rouge2_MapExploreChoiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge2/map/rouge2_mapexplorechoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.CoinView,
		Rouge2_Enum.ResPath.MapExploreChoiceItem,
		Rouge2_Enum.ResPath.ChoiceCheckItem
	}
}
module_views.Rouge2_MapPieceChoiceView = {
	bgBlur = 0,
	container = "Rouge2_MapPieceChoiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge2/map/rouge2_choiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.MapChoiceItem,
		Rouge2_Enum.ResPath.CoinView,
		Rouge2_Enum.ResPath.ChoiceCheckItem
	}
}
module_views.Rouge2_MapDiceView = {
	bgBlur = 1,
	container = "Rouge2_MapDiceViewContainer",
	destroy = 0.5,
	mainRes = "ui/viewres/rouge2/map/rouge2_mapdiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		"scenes/v3a2_ui_touzi/prefabs/v3a2_ui_touzi_1.prefab",
		Rouge2_Enum.ResPath.MapChoiceItem,
		Rouge2_Enum.ResPath.CoinView
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_RelicsDropView = {
	bgBlur = 1,
	container = "Rouge2_RelicsDropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_relicsdropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		Rouge2_Enum.ResPath.ComRelicsItem,
		Rouge2_Enum.ResPath.CoinView
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_MapStoreView = {
	bgBlur = 0,
	container = "Rouge2_MapStoreViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_mapstoreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		Rouge2_Enum.ResPath.CoinView
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_BandRecruitView = {
	bgBlur = 1,
	container = "Rouge2_BandRecruitViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_herorecruitview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge2/map/rouge2_herorecruititem.prefab"
	}
}
module_views.Rouge2_FightSuccessView = {
	destroy = 0,
	container = "Rouge2_FightSuccessViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/fight/rouge2fightsuccview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Rouge2_FinishView = {
	destroy = 0,
	container = "Rouge2_FinishViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge2/result/rouge2_finishview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default
}
module_views.Rouge2_NextLayerView = {
	destroy = 0,
	container = "Rouge2_NextLayerViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/rouge2/map/rouge2_nextlayerview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.Rouge2_MapRelicsAbandonView = {
	destroy = 0,
	container = "Rouge2_MapRelicsAbandonViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_maprelicsabandonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		Rouge2_Enum.ResPath.CoinView,
		Rouge2_Enum.ResPath.ComRelicsItem,
		Rouge2_Enum.ResPath.AttrSplitToolbar
	}
}
module_views.Rouge2_MapBuffAbandonView = {
	destroy = 0,
	container = "Rouge2_MapBuffAbandonViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_mapbuffabandonview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		Rouge2_Enum.ResPath.CoinView,
		Rouge2_Enum.ResPath.ComBuffItem,
		Rouge2_Enum.ResPath.AttrSplitToolbar
	}
}
module_views.Rouge2_MapTipView = {
	destroy = 0,
	container = "Rouge2_MapTipViewContainer",
	mainRes = "ui/viewres/rouge2/map/rouge2_maptipview.prefab",
	layer = "TOP",
	viewType = ViewType.Normal
}
module_views.Rouge2_MapAttributeUpView = {
	bgBlur = 1,
	container = "Rouge2_MapAttributeUpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_attributeupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		Rouge2_Enum.ResPath.AttributeMap,
		Rouge2_Enum.ResPath.AttrToolbar,
		Rouge2_Enum.ResPath.ActiveSkillAttrUpdateItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_AttributeDetailView = {
	destroy = 0,
	container = "Rouge2_AttributeDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/attribute/rouge2_attributedetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		Rouge2_Enum.ResPath.CareerAttrActiveItem,
		Rouge2_Enum.ResPath.ActiveSkillAttrUpdateItem
	}
}
module_views.Rouge2_BuffDropView = {
	bgBlur = 1,
	container = "Rouge2_BuffDropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_buffdropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	otherRes = {
		Rouge2_Enum.ResPath.BuffDropItem
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_AttrBuffDropView = {
	destroy = 0,
	container = "Rouge2_AttrBuffDropViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/map/rouge2_attrbuffdropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_ActiveSkillDropView = {
	bgBlur = 1,
	container = "Rouge2_ActiveSkillDropViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_activeskilldropview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.CommonSkillItem,
		Rouge2_Enum.ResPath.CommonSkillIconItem
	}
}
module_views.Rouge2_ActiveSkillLevelUpView = {
	bgBlur = 1,
	container = "Rouge2_ActiveSkillLevelUpViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/map/rouge2_activeskilllevelupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.CommonSkillItem,
		Rouge2_Enum.ResPath.CommonSkillIconItem
	}
}
module_views.Rouge2_MapCareerTransferView = {
	destroy = 0,
	container = "Rouge2_MapCareerTransferViewContainer",
	mainRes = "ui/viewres/rouge2/map/rouge2careertransferview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Rouge2_HeroGroupFightView = {
	bgBlur = 4,
	container = "Rouge2_HeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/herogroup/rouge2herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab",
		[2] = Rouge2_Enum.ResPath.CoinView
	}
}
module_views.Rouge2_HeroGroupEditView = {
	container = "Rouge2_HeroGroupEditViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/herogroup/rouge2_herogroupeditview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge2/herogroup/rouge2_herogroupedititem.prefab",
		[2] = "ui/viewres/rouge2/herogroup/rouge2_herogroupquickedititem.prefab"
	},
	customAnimBg = {
		"bg"
	}
}
module_views.Rouge2_BackpackTabView = {
	destroy = 0,
	container = "Rouge2_BackpackTabViewContainer",
	mainRes = "ui/viewres/rouge2/backpack/rouge2_backpacktabview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/rouge2/backpack/rouge2_backpackcareerview.prefab"
			},
			{
				"ui/viewres/rouge2/backpack/rouge2_backpackskillrootview.prefab"
			},
			{
				"ui/viewres/rouge2/backpack/rouge2_backpackbuffview.prefab"
			},
			{
				"ui/viewres/rouge2/backpack/rouge2_backpackrelicsview.prefab"
			}
		},
		[4] = {
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.AttributeMap,
		Rouge2_Enum.ResPath.ComRelicsItem,
		Rouge2_Enum.ResPath.ComBuffItem,
		Rouge2_Enum.ResPath.AttrSplitToolbar,
		Rouge2_Enum.ResPath.CoinView,
		Rouge2_Enum.ResPath.BackpackFormulaItem,
		Rouge2_Enum.ResPath.BackpackSkillShowItem,
		Rouge2_Enum.ResPath.BackpackTalentView,
		Rouge2_Enum.ResPath.BackpackSkillView,
		Rouge2_Enum.ResPath.CommonSkillItem,
		Rouge2_Enum.ResPath.CommonSkillIconItem
	}
}
module_views.Rouge2_BackpackBoxTipsView = {
	destroy = 0,
	container = "Rouge2_BackpackBoxTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/backpack/rouge2_backpackboxtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_BackpackTalentResetView = {
	destroy = 0,
	container = "Rouge2_BackpackTalentResetViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/backpack/rouge2_backpacktalentresetview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_BackpackTalentDetailView = {
	destroy = 0,
	container = "Rouge2_BackpackTalentDetailViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/rouge2/backpack/rouge2_backpacktalentdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_BackpackPetStageResultView = {
	destroy = 0,
	container = "Rouge2_BackpackPetStageResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/backpack/rouge2_backpackpetstageresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_ActiveSkillAttrUpdateTipsView = {
	destroy = 0,
	container = "Rouge2_ActiveSkillAttrUpdateTipsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/attribute/rouge2_activeskillattrupdatetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.CareerAttributeTips,
		Rouge2_Enum.ResPath.CommonSkillItem,
		Rouge2_Enum.ResPath.CareerAttrActiveItem,
		Rouge2_Enum.ResPath.CommonSkillIconItem
	}
}
module_views.Rouge2_SaveInfoView = {
	destroy = 0,
	container = "Rouge2_SaveInfoViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/bossbattle/rouge2_saveinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.SaveInfoListItem,
		Rouge2_Enum.ResPath.SaveInfoHeroGroupComp,
		Rouge2_Enum.ResPath.SaveInfoActiveSkillComp
	}
}
module_views.Rouge2_SaveInfoDetailView = {
	destroy = 0,
	container = "Rouge2_SaveInfoDetailViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/bossbattle/rouge2_saveinfodetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		Rouge2_Enum.ResPath.SaveInfoHeroGroupComp,
		Rouge2_Enum.ResPath.SaveInfoActiveSkillComp
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_BossBattleView = {
	destroy = 0,
	container = "Rouge2_BossBattleViewContainer",
	mainRes = "ui/viewres/rouge2/bossbattle/rouge2_bossbattleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge2/bossbattle/rouge2_bossbattlelistitem.prefab"
	}
}
module_views.Rouge2_BossBattleDetailView = {
	destroy = 0,
	container = "Rouge2_BossBattleDetailViewContainer",
	mainRes = "ui/viewres/rouge2/bossbattle/rouge2_bossbattledetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.SaveInfoListItem,
		Rouge2_Enum.ResPath.SaveInfoHeroGroupComp,
		Rouge2_Enum.ResPath.SaveInfoActiveSkillComp
	}
}
module_views.Rouge2_BossBattleResultView = {
	bgBlur = 1,
	container = "Rouge2_BossBattleResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/rouge2/bossbattle/rouge2_bossbattleresultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		Rouge2_Enum.ResPath.BossBattleResultAssessIcon,
		Rouge2_Enum.ResPath.BossBattleHeroGroup,
		Rouge2_Enum.ResPath.BossBattleHeroGroupItem1,
		Rouge2_Enum.ResPath.BossBattleHeroGroupItem2
	}
}
module_views.Rouge2_BossBattleResultPanel = {
	destroy = 0,
	container = "Rouge2_BossBattleResultPanelContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/bossbattle/rouge2_bossbattleresultpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	otherRes = {
		Rouge2_Enum.ResPath.BossBattleResultAssessIcon
	}
}
module_views.Rouge2_EnterView = {
	destroy = 0,
	container = "Rouge2_EnterViewContainer",
	mainRes = "ui/viewres/rouge2/rouge2_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"scenes/v3a2_m_s16_dilao_zhujiemian/scenes_prefab/v3a2_m_s16_scene_001.prefab",
		"scenes/v3a2_m_s16_dilao_zhujiemian/scenes_prefab/v3a2_m_s16_scene_002.prefab",
		"scenes/v3a2_m_s16_dilao_zhujiemian/scenes_prefab/v3a2_m_s16_scene_003.prefab",
		"scenes/v3a2_m_s16_dilao_zhujiemian/scenes_prefab/v3a2_m_s16_scene_004.prefab",
		"scenes/v3a2_m_s16_dilao_zhujiemian/vx/prefab/zhujiemiancurve_root.prefab",
		"ui/animations/dynamic/rouge2_zhujiemiancamera.controller",
		"roles/v3a2_rouge2_hand/rouge2_hand.prefab",
		"roles_special/role_rouge2/v3a2_rouge2_band1/rouge2_band1.prefab",
		"roles_special/role_rouge2/v3a2_rouge2_band2/rouge2_band2.prefab",
		"roles_special/role_rouge2/v3a2_rouge2_band3/rouge2_band3.prefab",
		"roles_special/role_rouge2/v3a2_rouge2_role/rouge2_role.prefab",
		"roles/v3a2_rouge2_hand/rouge2_hand_2.prefab"
	}
}
module_views.Rouge2_ActivityUpdateTipsView = {
	destroy = 0,
	container = "Rouge2_ActivityUpdateTipsViewContainer",
	bgBlur = 3,
	mainRes = "ui/viewres/rouge2/rouge2_activityupdatetipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.Rouge2_MainView = {
	destroy = 0,
	container = "Rouge2_MainViewContainer",
	mainRes = "ui/viewres/rouge2/rouge2_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_SwitchView = {
	destroy = 0,
	container = "Rouge2_SwitchViewContainer",
	mainRes = "ui/viewres/rouge2/rouge2_switchview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Rouge2_StoreView = {
	destroy = 0,
	container = "Rouge2_StoreViewContainer",
	mainRes = "ui/viewres/rouge2/rouge2_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Rouge2_NormalStoreGoodsView = {
	bgBlur = 1,
	container = "Rouge2_NormalStoreGoodsViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/store/normalstoregoodsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"bg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.Rouge2_AlchemyEnterView = {
	destroy = 0,
	container = "Rouge2_AlchemyEnterViewContainer",
	mainRes = "ui/viewres/rouge2/alchemy/rouge2alchemyenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_MaterialListView = {
	destroy = 0,
	container = "Rouge2_MaterialListViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_warehouseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge2/handbook/rouge2_collectionlistitem.prefab"
	}
}
module_views.Rouge2_AlchemyListView = {
	destroy = 0,
	container = "Rouge2_AlchemyListViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/alchemy/rouge2alchemylistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge2/alchemy/rouge2alchemylistitem.prefab",
		[2] = "ui/viewres/rouge2/alchemy/rgoue2_alchemymaterialitem.prefab"
	}
}
module_views.Rouge2_AlchemyMainView = {
	destroy = 0,
	container = "Rouge2_AlchemyMainViewContainer",
	mainRes = "ui/viewres/rouge2/alchemy/rouge2alchemymainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_AlchemySuccessView = {
	destroy = 0,
	container = "Rouge2_AlchemySuccessViewContainer",
	mainRes = "ui/viewres/rouge2/alchemy/rouge2alchemysuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.Rouge2_TalentTreeView = {
	destroy = 0,
	container = "Rouge2_TalentTreeViewContainer",
	mainRes = "ui/viewres/rouge2/tree/rouge2_talenttreeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge2/tree/rouge2_talenttreeitem.prefab"
	}
}
module_views.Rouge2_TalentTreeOverView = {
	destroy = 0,
	container = "Rouge2_TalentTreeOverViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/rouge2/tree/rouge2_talenttreeoverview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_FavoriteCollectionView = {
	destroy = 0,
	container = "Rouge2_FavoriteCollectionViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_favoritecollectionview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/rouge2/handbook/rouge2_collectionlistitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/rouge2/handbook/rouge2_collectionlistview.prefab"
			},
			{
				"ui/viewres/rouge2/handbook/rouge2_collectionhandbookview.prefab"
			}
		},
		{
			{
				Rouge2_Enum.ResPath.ItemDescModeSwitcher
			}
		}
	}
}
module_views.Rouge2_CollectionFilterView = {
	destroy = 0,
	container = "Rouge2_CollectionFilterViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_collectionfilterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.Rouge2_IllustrationMainView = {
	destroy = 0,
	container = "Rouge2_IllustrationMainViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_illustrationmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/rouge2/handbook/rouge2_illustrationlistpage.prefab",
		"ui/viewres/rouge2/handbook/rouge2_illustrationlistitem.prefab",
		"ui/viewres/rouge2/handbook/rouge2_avgreviewitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/rouge2/handbook/rouge2_illustrationlistview.prefab"
			},
			{
				"ui/viewres/rouge2/handbook/rouge2_avgreviewview.prefab"
			}
		}
	}
}
module_views.Rouge2_IllustrationDetailView = {
	destroy = 0,
	container = "Rouge2_IllustrationDetailViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_illustrationdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_CareerHandBookMainView = {
	destroy = 0,
	container = "Rouge2_CareerHandBookMainViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_handbookmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_CareerHandBookDetailView = {
	destroy = 0,
	container = "Rouge2_CareerHandBookDetailViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_handbookdetailtipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Rouge2_CareerHandBookTransferView = {
	destroy = 0,
	container = "Rouge2_CareerHandBookTransferViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_handbookcareerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		Rouge2_Enum.ResPath.AttributeMap
	}
}
module_views.Rouge2_ResultView = {
	destroy = 0,
	container = "Rouge2_ResultViewContainer",
	mainRes = "ui/viewres/rouge2/result/rouge2_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.Rouge2_SettlementView = {
	destroy = 0,
	container = "Rouge2_SettlementViewContainer",
	mainRes = "ui/viewres/rouge2/result/rouge2_settlementview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.Rouge2_ResultFinalView = {
	destroy = 0,
	container = "Rouge2_ResultFinalViewContainer",
	mainRes = "ui/viewres/rouge2/result/rouge2_resultreview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/rouge2/result/rouge2_resultheroitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Rouge2_ResultUnlockInfoView = {
	destroy = 0,
	container = "Rouge2_ResultUnlockInfoViewContainer",
	mainRes = "ui/viewres/rouge2/result/rouge2_unlockinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.Rouge2_SettlementUnlockView = {
	destroy = 0,
	container = "Rouge2_SettlementUnlockViewContainer",
	mainRes = "ui/viewres/rouge2/result/rouge2_settlementview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal,
	otherRes = {
		[1] = "ui/viewres/rouge2/handbook/rouge2_careertalentnode.prefab"
	}
}
module_views.Rouge2_ResultUnlockInfoView = {
	destroy = 0,
	container = "Rouge2_ResultUnlockInfoViewContainer",
	mainRes = "ui/viewres/rouge2/result/rouge2_unlockinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.Rouge2_ResultReportView = {
	destroy = 0,
	container = "Rouge2_ResultReportViewContainer",
	mainRes = "ui/viewres/rouge2/result/rouge2_resultreportview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/rouge2/result/rouge2_resultreportitem.prefab",
		[2] = "ui/viewres/rouge2/result/rouge2_resultheroitem.prefab"
	}
}
module_views.Rouge2_CollectionCollectView = {
	destroy = 0,
	container = "Rouge2_CollectionCollectViewContainer",
	mainRes = "ui/viewres/rouge2/handbook/rouge2_collectioncollectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.BeiLiErGameView = {
	destroy = 0,
	container = "BeiLiErGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_beilier/v3a2_beiliergameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.BeiLiErLevelView = {
	destroy = 0,
	container = "BeiLiErLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_beilier/v3a2_beilier_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_2/v3a2_beilier/v3a2_beilier_levelitem.prefab"
	}
}
module_views.BeiLiErTaskView = {
	bgBlur = 0,
	container = "BeiLiErTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_2/v3a2_beilier/v3a2_beilier_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_2/v3a2_beilier/v3a2_beilier_taskitem.prefab"
	}
}
module_views.Turnback3BeginnerView = {
	bgBlur = 1,
	container = "Turnback3BeginnerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/turnback/turnback3/turnback3_beginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnback3/turnback3_categoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Turnback3PanelView = {
	bgBlur = 1,
	container = "Turnback3PanelViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_panelview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.Turnback3RewardDetailView = {
	bgBlur = 1,
	container = "Turnback3RewardDetailViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_rewarddetailview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.Turnback3SignInView = {
	destroy = 0,
	container = "Turnback3SignInViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_signinview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Turnback3SignInRoleTalkView = {
	bgBlur = 1,
	container = "Turnback3SignInRoleTalkViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_roletalkview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	otherRes = {
		[1] = "ui/viewres/turnback/turnback3/turnback3_rewarditem.prefab"
	}
}
module_views.TurnbackPickEquipView = {
	destroy = 0,
	container = "TurnbackPickEquipViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_equipchooseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Turnback3DoubleView = {
	destroy = 0,
	container = "Turnback3DoubleViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_doubleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Turnback3BpConfirmView = {
	bgBlur = 1,
	container = "Turnback3BpConfirmViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_bpgetpanel.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.Turnback3BpView = {
	destroy = 0,
	container = "Turnback3BpViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_bpview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				"ui/viewres/turnback/turnback3/turnback3_bpbounsview.prefab"
			},
			{
				"ui/viewres/turnback/turnback3/turnback3_bptaskview.prefab"
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/turnback/turnback3/turnback3_taskitem.prefab"
	}
}
module_views.Turnback3StoreView = {
	destroy = 0,
	container = "Turnback3StoreViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_storeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/turnback/turnback3/turnback3_bannerselectitem.prefab",
		[2] = "ui/viewres/turnback/turnback3/turnback3_banneritem.prefab"
	}
}
module_views.Turnback3BuyBpView = {
	bgBlur = 1,
	container = "Turnback3BuyBpViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_bppopup_1.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.Turnback3BuyMonthCardView = {
	bgBlur = 1,
	container = "Turnback3BuyMonthCardViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_bppopup_3.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.Turnback3BuyBpTipView = {
	bgBlur = 1,
	container = "Turnback3BuyBpTipViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_bppopup_2.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.Turnback4BeginnerView = {
	bgBlur = 1,
	container = "Turnback4BeginnerViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/turnback/turnback3/turnback3_beginnerview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/turnback/turnback3/turnback3_categoryitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Turnback4ProgressView = {
	destroy = 0,
	container = "Turnback4ProgressViewContainer",
	mainRes = "ui/viewres/turnback/turnback3/turnback3_progressview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.Turnback4DoubleView = {
	destroy = 0,
	container = "Turnback4DoubleViewContainer",
	mainRes = "ui/viewres/turnback/return4/return4_doubleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Turnback4SignInView = {
	destroy = 0,
	container = "Turnback4SignInViewContainer",
	mainRes = "ui/viewres/turnback/return4/return4_signinview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Turnback4RewardView = {
	destroy = 0,
	container = "Turnback4RewardViewContainer",
	mainRes = "ui/viewres/turnback/return4/return4_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.StoreSupplementMonthCardTipView = {
	bgBlur = 1,
	container = "StoreSupplementMonthCardTipViewContainer",
	mainRes = "ui/viewres/store/storepatchproptips.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.StoreSupplementMonthCardUseView = {
	bgBlur = 1,
	container = "StoreSupplementMonthCardUseViewContainer",
	mainRes = "ui/viewres/store/storepatchpropuseview.prefab",
	destroy = 0,
	blurIterations = 2,
	blurFactor = 0.1,
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.VersionSummonFull_Part1 = {
	destroy = 0,
	container = "VersionSummonFull_Part1ViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionSummonFull_Part2 = {
	destroy = 0,
	container = "VersionSummonFull_Part2ViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/versionsummonfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.VersionSummonPanel_Part1 = {
	destroy = 0,
	container = "VersionSummonPanel_Part1ViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/versionsummonpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.VersionSummonPanel_Part2 = {
	destroy = 0,
	container = "VersionSummonPanel_Part2ViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/versionsummonpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V3A2ActivityCollectView = {
	destroy = 0,
	container = "V3A2ActivityCollectViewContainer",
	mainRes = "ui/viewres/activity/v3a2_activitycollect_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.DecorateSkinSelectView = {
	destroy = 0,
	container = "DecorateSkinSelectViewContainer",
	mainRes = "ui/viewres/store/decorateskinselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.DecorateSkinListView = {
	destroy = 0,
	container = "DecorateSkinListViewContainer",
	mainRes = "ui/viewres/store/decorateskinlistview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a2_WarmUp = {
	destroy = 0,
	container = "V3a2_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v3a2_warmup/v3a2_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}

PartyGameViewDefine.init(module_views)
PartyGameLobbyViewDefine.init(module_views)

module_views.VersionActivity3_3EnterView = {
	destroy = 0,
	container = "VersionActivity3_3EnterViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_enter/v3a3_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_3/v3a3_enter/v3a3_enterdragitem.prefab"
	},
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				"ui/viewres/versionactivity_3_3/v3a3_enter/v3a3_dungeonenterview.prefab"
			},
			{
				"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_enterview.prefab"
			},
			{
				"ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_enterview.prefab"
			},
			{
				"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
			},
			{
				"ui/viewres/rouge2/rouge2_activityview.prefab"
			},
			{
				"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
			},
			{
				"ui/viewres/tower/towermainentryview.prefab"
			},
			{
				"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
			}
		}
	}
}
module_views.ArcadeHallView = {
	destroy = 0,
	container = "ArcadeHallViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_hallview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				"ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_currencyitem.prefab"
			}
		}
	}
}
module_views.ArcadeRefundTipView = {
	bgBlur = 1,
	container = "ArcadeRefundTipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_eliminate/v3a7_eliminate_refundtipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.ArcadeGameView = {
	destroy = 0,
	container = "ArcadeGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				"ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_currencyitem.prefab"
			}
		}
	}
}
module_views.ArcadeGameResultView = {
	bgBlur = 3,
	container = "ArcadeGameResultViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.ArcadeHandBookView = {
	destroy = 0,
	container = "ArcadeHandBookViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_handbookview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.ArcadeDevelopView = {
	destroy = 0,
	container = "ArcadeDevelopViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_selectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	tabRes = {
		{
			{
				"ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_heroview.prefab"
			},
			{
				"ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_talentview.prefab"
			}
		},
		{
			{
				"ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_currencyitem.prefab"
			}
		}
	}
}
module_views.ArcadeTipsView = {
	destroy = 0,
	container = "ArcadeTipsViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/tips/v3a3_eliminate_tipsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		ArcadeEnum.BuildingTipsViewRes,
		ArcadeEnum.CollectionTipsViewRes,
		ArcadeEnum.HeroTipsViewRes,
		ArcadeEnum.SkillTipsViewRes,
		ArcadeEnum.CurrencyTipsViewRes
	}
}
module_views.ArcadeRewardView = {
	destroy = 0,
	container = "ArcadeRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	otherRes = {
		itemRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_rewarditem.prefab"
	}
}
module_views.ArcadeQuitTipView = {
	destroy = 0,
	container = "ArcadeQuitTipViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_quittipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.MarshaGameView = {
	destroy = 0,
	container = "MarshaGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.MarshaLevelView = {
	destroy = 0,
	container = "MarshaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_levelitem.prefab"
	}
}
module_views.MarshaTaskView = {
	bgBlur = 0,
	container = "MarshaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_taskitem.prefab"
	}
}
module_views.MarshaReadyView = {
	destroy = 0,
	container = "MarshaReadyViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_readyview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.MarshaPauseView = {
	destroy = 0,
	container = "MarshaPauseViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_pauseview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.MarshaResultView = {
	destroy = 0,
	container = "MarshaResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_marsha/v3a3_marsha_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.IgorGameView = {
	destroy = 0,
	container = "IgorGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.IgorGameSuccessView = {
	destroy = 0,
	container = "IgorGameSuccessViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_gamesuccessview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.IgorGameFailView = {
	destroy = 0,
	container = "IgorGameFailViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_gamefailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.IgorTaskView = {
	bgBlur = 0,
	container = "IgorTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_taskitem.prefab"
	}
}
module_views.IgorEpisodeLevelView = {
	destroy = 0,
	container = "IgorEpisodeLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_3/v3a3_igor/v3a3_igor_levelitem.prefab"
	}
}
module_views.IgorTipsView = {
	destroy = 10,
	container = "IgorTipsViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/commonbufftipview/commonbufftipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a3_DoubleDanActivity_PanelView = {
	destroy = 0,
	container = "V3a3_DoubleDanActivity_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a3_doubledanactivity_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a3_DoubleDanActivity_FullView = {
	destroy = 0,
	container = "V3a3_DoubleDanActivity_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v3a3_doubledanactivity_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a3TowerGiftFullView = {
	destroy = 0,
	container = "V3a3TowerGiftFullViewContainer",
	mainRes = "ui/viewres/activity/v3a3_towerdeep_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V3a3TowerGiftPanelView = {
	destroy = 0,
	container = "V3a3TowerGiftPanelViewContainer",
	maskAlpha = 0,
	bgBlur = 2,
	mainRes = "ui/viewres/activity/v3a3_towerdeep_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SkinDiscountCompensateActivityView = {
	destroy = 0,
	container = "SkinDiscountCompensateActivityViewContainer",
	mainRes = "ui/viewres/store/skindiscountcompensateactivityview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.SkinDiscountCompensateSelectView = {
	destroy = 0,
	container = "SkinDiscountCompensateSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/skindiscountcompensateselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.GMFightRuleView = {
	destroy = 0,
	container = "GMFightRuleViewContainer",
	mainRes = "ui/viewres/gm/gmfightruleview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a3_WarmUp = {
	destroy = 0,
	container = "V3a3_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v3a3_warmup/v3a3_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a4BBSView = {
	destroy = 0,
	container = "V3a4BBSViewContainer",
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_bbs/v3a4_bbsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}

LaplaceForumViewDefine.init(module_views)
TowerV3a7ViewDefine.init(module_views)

module_views.SummonGiftPropBaseView = {
	destroy = 0,
	container = "SummonGiftPropBaseViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/activity_giftbuypanelview3.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/store/packagestoregoodsitem.prefab"
	}
}

PartyClothViewDefine.init(module_views)

module_views.HeroExpBoxView = {
	destroy = 0,
	container = "HeroExpBoxViewContainer",
	mainRes = "ui/viewres/activity/v3a4_destiny_pickchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/activity/v3a4_destinygift_pickchoiceitem.prefab"
	}
}
module_views.HeroExpBoxPanelView = {
	destroy = 0,
	container = "HeroExpBoxPanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a4_destiny_panelsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.LuSiJianGameView = {
	destroy = 0,
	container = "LuSiJianGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_game_cutting1.prefab",
		"ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_game_cutting2.prefab",
		"ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_game_cutting3.prefab",
		"ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_game_cutting4.prefab"
	}
}
module_views.LuSiJianLevelView = {
	destroy = 0,
	container = "LuSiJianLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_levelitem.prefab"
	}
}
module_views.LuSiJianTaskView = {
	bgBlur = 0,
	container = "LuSiJianTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_taskitem.prefab"
	}
}
module_views.V3a4GiftRecommendFullview = {
	destroy = 0,
	container = "V3a4GiftRecommendFullviewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v3a4_giftrecommend_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a4GiftRecommendPanelview = {
	destroy = 0,
	container = "V3a4GiftRecommendPanelviewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a4_giftrecommend_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SceneUIPackageFullView = {
	destroy = 0,
	container = "SceneUIPackageFullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/sceneuipackage_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.SceneUIPackagePanelView = {
	destroy = 0,
	container = "SceneUIPackagePanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/sceneuipackage_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3A4ActivityCollectView = {
	destroy = 0,
	container = "V3A4ActivityCollectViewContainer",
	mainRes = "ui/viewres/activity/v3a2_activitycollect_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a4_DoubleDropView = {
	destroy = 0,
	container = "V3a4_DoubleDropViewContainer",
	mainRes = "ui/viewres/activity/v3a4_doubledrop.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a6DoubleDropView = {
	destroy = 0,
	container = "V3a6DoubleDropViewContainer",
	mainRes = "ui/viewres/activity/v3a6_doubledrop.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a4_GoldenMilletPresentView = {
	destroy = 0,
	container = "V3a4_GoldenMilletPresentViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a4_goldenmilletpresent.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V3a4_GoldenMilletPresentFullView = {
	destroy = 0,
	container = "V3a4_GoldenMilletPresentFullViewContainer",
	mainRes = "ui/viewres/activity/v3a4_goldenmilletpresentfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V3a4DestinyGiftFullView = {
	destroy = 0,
	container = "V3a4DestinyGiftFullViewContainer",
	mainRes = "ui/viewres/activity/v3a4_destinygift_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a4DestinyGiftPanelView = {
	destroy = 0,
	container = "V3a4DestinyGiftPanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a4_destinygift_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a4_Chg_LevelView = {
	destroy = 0,
	container = "V3a4_Chg_LevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_chg/v3a4_chg_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		v3a4_chg_levelitem = ChgEnum.ResPath.v3a4_chg_levelitem
	}
}
module_views.V3a4_Chg_TaskView = {
	bgBlur = 0,
	container = "V3a4_Chg_TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_chg/v3a4_chg_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_4/v3a4_chg/v3a4_chg_taskitem.prefab"
	}
}
module_views.V3a4_Chg_GameView = {
	destroy = 0,
	container = "V3a4_Chg_GameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_chg/v3a4_chg_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		v3a4_chg_gameitem = ChgEnum.ResPath.v3a4_chg_gameitem
	}
}
module_views.V3a4_Chg_GameStartView = {
	destroy = 0,
	container = "V3a4_Chg_GameStartViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_chg/v3a4_chg_gamestartview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a4_Chg_ResultView = {
	destroy = 0,
	container = "V3a4_Chg_ResultViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_3_4/v3a4_chg/v3a4_chg_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.WarmUp = {
	destroy = 0,
	container = "WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/warmup/warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LamonaLevelView = {
	destroy = 0,
	container = "LamonaLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_lamona/v3a5_lamona_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_5/v3a5_lamona/v3a5_lamona_levelitem.prefab"
	}
}
module_views.LamonaTaskView = {
	bgBlur = 0,
	container = "LamonaTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_lamona/v3a5_lamona_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_5/v3a5_lamona/v3a5_lamona_taskitem.prefab"
	}
}
module_views.LamonaGameView = {
	destroy = 0,
	container = "LamonaGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_lamona/v3a5_lamona_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		"ui/viewres/versionactivity_3_5/v3a5_lamona/lamona_unit/v3a5_lamona_player.prefab",
		"ui/viewres/versionactivity_3_5/v3a5_lamona/lamona_unit/v3a5_lamona_ghost.prefab",
		"ui/viewres/versionactivity_3_5/v3a5_lamona/lamona_unit/v3a5_lamona_prop.prefab",
		"ui/viewres/versionactivity_3_5/v3a5_lamona/lamona_unit/v3a5_lamona_wall.prefab",
		"ui/viewres/versionactivity_3_5/v3a5_lamona/lamona_unit/v3a5_lamona_fog.prefab"
	}
}
module_views.LamonaResultView = {
	destroy = 0,
	container = "LamonaResultViewContainer",
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_lamona/v3a5_lamona_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V3a5_SchoolStartView = {
	destroy = 0,
	container = "V3a5_SchoolStartViewContainer",
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_schoolstartview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a5_SchoolStartRewardView = {
	destroy = 0,
	container = "V3a5_SchoolStartRewardViewContainer",
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_schoolstartrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.LorentzGameView = {
	destroy = 0,
	container = "LorentzGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_lorentz/v3a5_lorentz_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.LorentzLevelView = {
	destroy = 0,
	container = "LorentzLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_lorentz/v3a5_lorentz_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_5/v3a5_lorentz/v3a5_lorentz_levelitem.prefab"
	}
}
module_views.LorentzTaskView = {
	bgBlur = 0,
	container = "LorentzTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_5/v3a5_lorentz/v3a5_lorentz_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_5/v3a5_lorentz/v3a5_lorentz_taskitem.prefab"
	}
}
module_views.AbyssMainView = {
	destroy = 0,
	container = "AbyssMainViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/cloudredemption/cloudredemption_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AbyssEnterView = {
	destroy = 0,
	container = "AbyssEnterViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/cloudredemption/cloudredemption_enterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V3A5ActivityCollectView = {
	destroy = 0,
	container = "V3A5ActivityCollectViewContainer",
	mainRes = "ui/viewres/activity/v3a2_activitycollect_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.DungeonExploreView = {
	destroy = 0,
	container = "DungeonExploreViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/explore/exploremainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AbyssStageDetailView = {
	destroy = 0,
	container = "AbyssStageDetailViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/cloudredemption/cloudredemption_chapterdetailview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		"ui/viewres/cloudredemption/clip/clip_icon_01.prefab",
		"ui/viewres/cloudredemption/clip/clip_icon_02.prefab",
		"ui/viewres/cloudredemption/clip/clip_icon_03.prefab"
	}
}
module_views.AbyssStageDetailsView = {
	destroy = 0,
	container = "AbyssStageDetailsViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/cloudredemption/cloudredemption_detailsview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.AbyssHeroGroupFightView = {
	bgBlur = 4,
	container = "AbyssHeroGroupFightViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/cloudredemption/cloudredemption_herogroupview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		},
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/fight/clothskill.prefab"
	}
}
module_views.AbyssTaskView = {
	destroy = 0,
	container = "AbyssTaskViewContainer",
	bgBlur = 4,
	mainRes = "ui/viewres/cloudredemption/cloudredemption_rewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/cloudredemption/cloudredemption_rewarditem.prefab"
	}
}
module_views.AbyssFightSuccView = {
	destroy = 0,
	container = "AbyssFightSuccViewContainer",
	mainRes = "ui/viewres/cloudredemption/cloudredemption_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.ActivityCollectView = {
	destroy = 0,
	container = "ActivityCollectViewContainer",
	mainRes = "ui/viewres/activity/v3a2_activitycollect_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.CurrencyExchangeTipsView = {
	destroy = 0,
	container = "CurrencyExchangeTipsViewContainer",
	mainRes = "ui/viewres/store/storecurrencyreplacetipsmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.TeachingEnterView = {
	destroy = 0,
	container = "TeachingEnterViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/teaching/teachingenterview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TeachingMainView = {
	destroy = 0,
	container = "TeachingMainViewContainer",
	mainRes = "ui/viewres/teaching/teachingmainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.TeachingPopView = {
	bgBlur = 1,
	container = "TeachingPopViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/teaching/teachingpopview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}

V3a6YaMiViewDefine.init(module_views)

module_views.V3a6_WarmUp = {
	destroy = 0,
	container = "V3a6_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/v3a6_warmup/v3a6_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a6_WarmUp_DialogueView = {
	destroy = 0,
	container = "V3a6_WarmUp_DialogueViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v3a6_warmup/v3a6_warmup_dialogueview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a6_WarmUp_TaskView = {
	destroy = 0,
	container = "V3a6_WarmUp_TaskViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/v3a6_warmup/v3a6_warmup_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	otherRes = {
		[1] = "ui/viewres/v3a6_warmup/v3a6_warmup_taskitem.prefab"
	}
}

SodacheViewDefine.init(module_views)
StoryViewDefine.init(module_views)
Anniversary3ViewDefine.init(module_views)

module_views.TravelGoView = {
	destroy = 0,
	container = "TravelGoViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_xiaoruiannong/travelgoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.XRuiAnYiLevelView = {
	destroy = 0,
	container = "XRuiAnYiLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_xiaoruiannong/v3a7_xiaoruiannong_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Internal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_7/v3a7_xiaoruiannong/v3a7_xiaoruiannong_levelitem.prefab"
	}
}
module_views.XRuiAnYiTaskView = {
	bgBlur = 0,
	container = "XRuiAnYiTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_xiaoruiannong/v3a7_xiaoruiannong_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_7/v3a7_xiaoruiannong/v3a7_xiaoruiannong_taskitem.prefab"
	}
}
module_views.TravelGoResultView = {
	destroy = 0,
	container = "TravelGoResultViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_xiaoruiannong/v3a7_xiaoruiannong_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Act236MainView = {
	destroy = 0,
	container = "Act236MainViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_cumulativerecharge/v3a7_cumulativerechargemainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a7_GoldenMilletPresent = {
	destroy = 0,
	container = "V3a7_GoldenMilletPresentContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a7_goldenmilletpresent.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V3a7_GoldenMilletPresentFull = {
	destroy = 0,
	container = "V3a7_GoldenMilletPresentFullContainer",
	mainRes = "ui/viewres/activity/v3a7_goldenmilletpresentfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V3a7SelfSelectPickView = {
	destroy = 0,
	container = "V3a7SelfSelectPickViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a7_selfselectsix_pickchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a7SelfSelectFullView = {
	destroy = 0,
	container = "V3a7SelfSelectFullViewContainer",
	mainRes = "ui/viewres/activity/v3a7_selfselectsix_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.SkinSelfSelectView = {
	destroy = 0,
	container = "SkinSelfSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_cumulativerecharge/v3a7_cumulativerechargeselectview2.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.GiftMultipleHeroChoiceView = {
	destroy = 0,
	container = "GiftMultipleHeroChoiceViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_cumulativerecharge/v3a7_cumulativerechargeselectview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.V3a7_SkinGiftFullView = {
	destroy = 0,
	container = "V3a7_SkinGiftFullViewContainer",
	mainRes = "ui/viewres/activity/v3a7_skingift_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V3a7_SkinGiftCheckView = {
	destroy = 0,
	container = "V3a7_SkinGiftCheckViewContainer",
	mainRes = "ui/viewres/activity/v3a7_skingift_checkview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a7_Wmz_LevelView = {
	destroy = 0,
	container = "V3a7_Wmz_LevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_wmz/v3a7_wmz_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		v3a7_wmz_levelitem = WmzEnum.ResPath.v3a7_wmz_levelitem
	}
}
module_views.V3a7_Wmz_TaskView = {
	bgBlur = 0,
	container = "V3a7_Wmz_TaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_wmz/v3a7_wmz_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		v3a7_wmz_taskitem = WmzEnum.ResPath.v3a7_wmz_taskitem
	}
}
module_views.V3a7_Wmz_GameView = {
	destroy = 0,
	container = "V3a7_Wmz_GameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_wmz/v3a7_wmz_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a7_Wmz_ResultView = {
	destroy = 0,
	container = "V3a7_Wmz_ResultViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/versionactivity_3_7/v3a7_wmz/v3a7_wmz_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V3a8_DragonBoatActivity_FullView = {
	destroy = 0,
	container = "V3a8_DragonBoatActivity_FullViewContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/activity/v3a8_dragonboatactivity_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.V3a8_DragonBoatActivity_PanelView = {
	destroy = 0,
	container = "V3a8_DragonBoatActivity_PanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a8_dragonboatactivity_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.V3a8_WarmUp = {
	destroy = 0,
	container = "V3a8_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/warmup/v3a8_warmup.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}

AtomicDungeonMapViewDefine.init(module_views)
AtomicViewDefine.init(module_views)

module_views.Sp02_PaoMian_MainView = {
	destroy = 0,
	container = "Sp02_PaoMian_MainViewContainer",
	mainRes = "ui/viewres/sp02/paomian/sp02_paomian_mainview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Sp02_GuessMeView = {
	destroy = 0,
	container = "Sp02_GuessMeViewContainer",
	mainRes = "ui/viewres/sp02/paomian/sp02_guessmeview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Sp02_MarcusView = {
	destroy = 0,
	container = "Sp02_MarcusViewContainer",
	mainRes = "ui/viewres/sp02/paomian/sp02_marcusview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.Sp02_HeroLibraryView = {
	destroy = 0,
	container = "Sp02_HeroLibraryViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp02/paomian/sp02_herolibraryview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.Sp02_PaoMian_ShopPanelView = {
	destroy = 0,
	container = "Sp02_PaoMian_ShopPanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp02/paomian/sp02_paomian_shoppanelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	},
	otherRes = {
		misihaiitem = "ui/viewres/player/playercard/playercardachieve_misihai.prefab",
		achieveitem = "ui/viewres/achievement/achievementmainicon.prefab"
	}
}
module_views.TwinssychubeEquipInfoView = {
	destroy = 0,
	container = "TwinssychubeEquipInfoViewContainer",
	mainRes = "ui/viewres/sp02/twins/sp02_twinspsychubeequipinfoview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.SP02_SummonPoolProgressRewardView = {
	destroy = 0,
	container = "SP02_SummonPoolProgressRewardViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/summon/version_sp02/sp02_summonrewardpanel.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.SP02_SummonPoolProgressRewardSelectView = {
	destroy = 0,
	container = "SP02_SummonPoolProgressRewardSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/sp02/summon/sp02_selfselect_pickrewardview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Internal
}
module_views.GiftMultipleInspirationHeroPreviewView = {
	destroy = 0,
	container = "GiftMultipleInspirationHeroPreviewViewContainer",
	mainRes = "ui/viewres/sp02/summon/sp02_selfselect_pickchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full
}
module_views.SP02_LinkGiftFullView = {
	destroy = 0,
	container = "SP02_LinkGiftFullViewContainer",
	mainRes = "ui/viewres/activity/sp02_linkgift_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.SP02_LinkGiftPanelView = {
	destroy = 0,
	container = "SP02_LinkGiftPanelViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/store/sp02_linkgift_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.EquipLvUpChooseView = {
	destroy = 0,
	container = "EquipLvUpChooseViewContainer",
	mainRes = "ui/viewres/equip/equippickchoiceview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.EquipLvUpItemUseTipView = {
	bgBlur = 1,
	container = "EquipLvUpItemUseTipViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/power/powerbuytipview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default,
	customAnimBg = {
		"#simage_tipbg"
	},
	tabRes = {
		{
			{
				CurrencyView.prefabPath
			}
		}
	}
}
module_views.GoldenMilletPresent = {
	destroy = 0,
	container = "GoldenMilletPresentContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/goldenmilletpresent.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}
module_views.GoldenMilletPresentFull = {
	destroy = 0,
	container = "GoldenMilletPresentFullContainer",
	mainRes = "ui/viewres/activity/goldenmilletpresentfull.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.HedoneLevelView = {
	destroy = 0,
	container = "HedoneLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_9/v3a9_hedone/v3a9_hedone_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_9/v3a9_hedone/v3a9_hedone_levelitem.prefab"
	}
}
module_views.HedoneTaskView = {
	bgBlur = 0,
	container = "HedoneTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_9/v3a9_hedone/v3a9_hedone_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_9/v3a9_hedone/v3a9_hedone_taskitem.prefab"
	}
}
module_views.HedoneGameView = {
	destroy = 0,
	container = "HedoneGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_9/v3a9_hedone/v3a9_hedone_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.HedoneResultView = {
	destroy = 0,
	container = "HedoneResultViewContainer",
	mainRes = "ui/viewres/versionactivity_3_9/v3a9_hedone/v3a9_hedone_resultview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.NaxisuosiLevelView = {
	destroy = 0,
	container = "NaxisuosiLevelViewContainer",
	mainRes = "ui/viewres/versionactivity_3_9/v3a9_naxisuosi/v3a9_naxisuosi_levelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_9/v3a9_naxisuosi/v3a9_naxisuosi_levelitem.prefab"
	}
}
module_views.NaxisuosiTaskView = {
	bgBlur = 0,
	container = "NaxisuosiTaskViewContainer",
	destroy = 0,
	mainRes = "ui/viewres/versionactivity_3_9/v3a9_naxisuosi/v3a9_naxisuosi_taskview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	},
	otherRes = {
		[1] = "ui/viewres/versionactivity_3_9/v3a9_naxisuosi/v3a9_naxisuosi_taskitem.prefab"
	}
}
module_views.NaxisuosiGameView = {
	destroy = 0,
	container = "NaxisuosiGameViewContainer",
	mainRes = "ui/viewres/versionactivity_3_9/v3a9_naxisuosi/v3a9_naxisuosi_gameview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Full,
	tabRes = {
		{
			{
				NavigateButtonsView.prefabPath
			}
		}
	}
}
module_views.V3a9_BDuckLinkageFullView = {
	destroy = 0,
	container = "V3a9_BDuckLinkageFullViewContainer",
	mainRes = "ui/viewres/activity/v3a9_linkgift_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal
}
module_views.V3a9_BDuckLinkagePatFaceView = {
	destroy = 0,
	container = "V3a9_BDuckLinkagePatFaceViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/activity/v3a9_linkgift_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Internal
}
module_views.V3a9_WarmUp = {
	destroy = 0,
	container = "V3a9_WarmUpContainer",
	bgBlur = 0,
	mainRes = "ui/viewres/warmup/warmup1.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
module_views.WarmUp1 = module_views.V3a9_WarmUp
module_views.DungeonRecheckElementsView = {
	destroy = 0,
	container = "DungeonRecheckElementsViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/dungeon/dungeonelementrecheckview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}
module_views.StoreDecorateCombinationView = {
	container = "StoreDecorateCombinationViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/mainsceneswitch/sceneuipackagegoodstipview_2.prefab",
	destroy = 0,
	blurIterations = 3,
	blurFactor = 0.85,
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	desampleRate = PostProcessingMgr.DesamplingRate.x8,
	reduceRate = PostProcessingMgr.DesamplingRate.x8
}
module_views.AbyssBuffSelectView = {
	destroy = 0,
	container = "AbyssBuffSelectViewContainer",
	bgBlur = 1,
	mainRes = "ui/viewres/cloudredemption/cloudredemption_choosebuffview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal
}

local ViewName = {}

for k, v in pairs(module_views) do
	ViewName[k] = k
end

setGlobal("ViewName", ViewName)

return module_views
