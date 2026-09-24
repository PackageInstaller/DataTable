-- chunkname: @modules/logic/store/defines/StoreViewDefine.lua

module("modules.logic.store.defines.StoreViewDefine", package.seeall)

local StoreViewDefine = {}

function StoreViewDefine.init(module_views)
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
		},
		otherRes = {
			[1] = "ui/viewres/store/decoratestorelefttabview.prefab"
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
end

return StoreViewDefine
