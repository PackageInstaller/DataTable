-- chunkname: @modules/logic/sodache/define/SodacheViewDefine.lua

module("modules.logic.sodache.define.SodacheViewDefine", package.seeall)

local SodacheViewDefine = class("SodacheViewDefine")

function SodacheViewDefine.init(module_views)
	module_views.SodacheMainView = {
		destroy = 0,
		container = "SodacheMainViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_mainview.prefab",
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
			[1] = "modules/sodache/scene/scenes_prefab/v3a7_m_s08_soudache_jidi_p.prefab"
		}
	}
	module_views.SodacheUpgradeView = {
		destroy = 0,
		container = "SodacheUpgradeViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_upgradeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.SodacheUpgradeResultView = {
		destroy = 0,
		container = "SodacheUpgradeResultViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_upgraderesultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheCostView = {
		destroy = 0,
		container = "SodacheCostViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_costview.prefab",
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
	module_views.SodacheShopView = {
		destroy = 0,
		container = "SodacheShopViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_shopview.prefab",
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
	module_views.SodacheLevelView = {
		destroy = 0,
		container = "SodacheLevelViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_levelview.prefab",
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
	module_views.SodacheLevelUpView = {
		destroy = 0,
		container = "SodacheLevelUpViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_levelupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full
	}
	module_views.SodacheRelicView = {
		destroy = 0,
		container = "SodacheRelicViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_relicview.prefab",
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
	module_views.SodacheRelicUpgradeView = {
		destroy = 0,
		container = "SodacheRelicUpgradeViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_relicupgradeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheRelicOverView = {
		destroy = 0,
		container = "SodacheRelicOverViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_relicoverview.prefab",
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
	module_views.SodacheHandbookView = {
		destroy = 0,
		container = "SodacheHandbookViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_handbookview.prefab",
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
	module_views.SodacheTaskView = {
		destroy = 0,
		container = "SodacheTaskViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_taskview.prefab",
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
	module_views.SodacheStoreView = {
		destroy = 0,
		container = "SodacheStoreViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_storeview.prefab",
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
					CurrencyView.prefabPath
				}
			}
		}
	}
	module_views.SodacheCardDetailView = {
		destroy = 0,
		container = "SodacheCardDetailViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_carddetailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal
	}
	module_views.SodacheMapSelectView = {
		destroy = 0,
		container = "SodacheMapSelectViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_mapselectview.prefab",
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
	module_views.SodacheMapView = {
		destroy = 0,
		container = "SodacheMapViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_mapview.prefab",
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
			nodeAnim = "modules/sodache/scene/vx/prefab/v3a7_map_ludian.prefab"
		}
	}
	module_views.SodacheMapSelectTimeView = {
		destroy = 0,
		container = "SodacheMapSelectTimeViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_mapselecttimeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheMapMonsterAttrView = {
		destroy = 0,
		container = "SodacheMapMonsterAttrViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_mapenemypanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheStatusView = {
		destroy = 0,
		container = "SodacheStatusViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_statusview.prefab",
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
	module_views.SodacheAltarView = {
		destroy = 0,
		container = "SodacheAltarViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_mapaltarview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal
	}
	module_views.SodacheWorshipView = {
		destroy = 0,
		container = "SodacheWorshipViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_cardsubmitview.prefab",
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
	module_views.SodacheEscapeView = {
		destroy = 0,
		container = "SodacheEscapeViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_mapretreatview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheToastView = {
		destroy = 0,
		container = "SodacheToastViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_toastview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal
	}
	module_views.SodacheCardToastView = {
		destroy = 0,
		container = "SodacheCardToastViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_cardtoastview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal
	}
	module_views.SodacheCardQuickSelectView = {
		destroy = 0,
		container = "SodacheCardQuickSelectViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_cardquickselectview.prefab",
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
	module_views.SodacheBagView = {
		destroy = 0,
		container = "SodacheBagViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_bagview.prefab",
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
	module_views.SodacheEvilUpView = {
		destroy = 0,
		container = "SodacheEvilUpViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_evilupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.SodacheDialoguePanelView = {
		destroy = 0,
		container = "SodacheDialoguePanelViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_eventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheRandomEventView = {
		destroy = 0,
		container = "SodacheRandomEventViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_mapeventpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheCheckView = {
		destroy = 0,
		container = "SodacheCheckViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_checkeventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheGetCardView = {
		destroy = 0,
		container = "SodacheGetCardViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_cardview.prefab",
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
	module_views.SodacheHeroGroupFightView = tabletool.copy(module_views.HeroGroupFightView)
	module_views.SodacheHeroGroupFightView.container = "SodacheHeroGroupFightViewContainer"
	module_views.SodacheHeroGroupFightView.mainRes = "modules/sodache/ui/viewres/sodache_herogroupview.prefab"
	module_views.SodacheTakeView = {
		destroy = 0,
		container = "SodacheTakeViewContainer",
		bgBlur = 1,
		mainRes = "modules/sodache/ui/viewres/sodache_takeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.SodacheResultView = {
		destroy = 0,
		container = "SodacheResultViewContainer",
		mainRes = "modules/sodache/ui/viewres/sodache_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full
	}
end

return SodacheViewDefine
