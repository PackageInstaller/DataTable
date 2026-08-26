-- chunkname: @modules/logic/survival/define/SurvivalViewDefine.lua

module("modules.logic.survival.define.SurvivalViewDefine", package.seeall)

local SurvivalViewDefine = class("SurvivalViewDefine")

function SurvivalViewDefine.init(module_views)
	SurvivalViewDefine.initMapDefine(module_views)
	SurvivalViewDefine.initShelterDefine(module_views)

	module_views.SurvivalView = {
		destroy = 0,
		container = "SurvivalViewContainer",
		mainRes = "ui/viewres/survival/map/survivalview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalShelterRewardView = {
		bgBlur = 0,
		container = "SurvivalShelterRewardViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalshelterrewardview.prefab",
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
			itemRes = "ui/viewres/survival/shelter/survivalshelterrewarditem.prefab"
		}
	}
	module_views.SurvivalItemInfoView = {
		destroy = 0,
		container = "SurvivalItemInfoViewContainer",
		mainRes = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalCurrencyTipView = {
		destroy = 0,
		container = "SurvivalCurrencyTipViewContainer",
		mainRes = "ui/viewres/survival/map/survivalcurrencytipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalHandbookView = {
		destroy = 0,
		container = "SurvivalHandbookViewContainer",
		mainRes = "ui/viewres/survival/handbook/survivalhandbookview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			survivalhandbookeventitem = "ui/viewres/survival/handbook/survivalhandbookeventitem.prefab",
			survivalrewardinheritnpcitem = "ui/viewres/survival/rewardinherit/survivalrewardinheritnpcitem.prefab",
			survivalmapbagitem = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			survivalpartnermanageinfoview = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab",
			survivalhandbooknpcitem = "ui/viewres/survival/handbook/survivalhandbooknpcitem.prefab",
			survivalcamera = "survival/common/survivalcamera.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.SurvivalHandbookInfoView = {
		destroy = 0,
		container = "SurvivalHandbookInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/handbook/survivalhandbookinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalRewardInheritView = {
		destroy = 0,
		container = "SurvivalRewardInheritViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/rewardinherit/survivalrewardinheritview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			survivalhandbooknpcitem = "ui/viewres/survival/handbook/survivalhandbooknpcitem.prefab",
			survivalrewardinheritnpcitem = "ui/viewres/survival/rewardinherit/survivalrewardinheritnpcitem.prefab",
			survivalmapbagitem = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			survivalnpcheaditem = "ui/viewres/survival/shelter/survivalnpcheaditem.prefab"
		}
	}
	module_views.SurvivalRewardSelectView = {
		bgBlur = 1,
		container = "SurvivalRewardSelectViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/survival/rewardinherit/survivalrewardselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			survivalhandbooknpcitem = "ui/viewres/survival/handbook/survivalhandbooknpcitem.prefab",
			survivalrewardinheritnpcitem = "ui/viewres/survival/rewardinherit/survivalrewardinheritnpcitem.prefab",
			survivalmapbagitem = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			survivalnpcheaditem = "ui/viewres/survival/shelter/survivalnpcheaditem.prefab"
		}
	}
	module_views.SurvivalReputationSelectView = {
		destroy = 0,
		container = "SurvivalReputationSelectViewContainer",
		mainRes = "ui/viewres/survival/reputation/survivalreputationselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			survivalmapbagitem = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			survivalreputationselectbagitem = "ui/viewres/survival/reputation/survivalreputationselectbagitem.prefab",
			survivalreputationbuilditem = "ui/viewres/survival/reputation/survivalreputationbuilditem.prefab"
		}
	}
	module_views.SurvivalReputationShopView = {
		destroy = 0,
		container = "SurvivalReputationShopViewContainer",
		mainRes = "ui/viewres/survival/reputation/survivalreputationshopview.prefab",
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
			survivalmapbagitem = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalCommonTipsView = {
		destroy = 10,
		container = "SurvivalCommonTipsViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/commonbufftipview/commonbufftipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalRoleSelectView = {
		bgBlur = 1,
		container = "SurvivalRoleSelectViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/role/survivalroleselectview.prefab",
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
			survivalcommondesccomp = "ui/viewres/survival/common/survivalcommondesccomp.prefab",
			survivalroleattrcomp = "ui/viewres/survival/role/survivalroleattrcomp.prefab"
		}
	}
	module_views.SurvivalRoleLevelUpView = {
		destroy = 0,
		container = "SurvivalRoleLevelUpViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/role/survivalrolelevelupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalLeaveMsgView = {
		destroy = 0,
		container = "SurvivalLeaveMsgViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/leavemessage/survivalleavemsgview.prefab",
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
	module_views.SurvivalGiveBackView = {
		bgBlur = 1,
		container = "SurvivalGiveBackViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/leavemessage/survivalgivebackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			survivalmapbagitem = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			survivalmapbaginfoview = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.SurvivalTechView = {
		destroy = 0,
		container = "SurvivalTechViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/survival/tech/survivaltechview.prefab",
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
	module_views.SurvivalTechShelterView = {
		destroy = 0,
		container = "SurvivalTechShelterViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/survival/tech/survivaltechshelterview.prefab",
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
	module_views.SurvivalRoleLevelTipPopView = {
		destroy = 0,
		container = "SurvivalRoleLevelTipPopViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/survival/role/survivalroleleveltippopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.AnimInternal
	}
	module_views.SurvivalStoreView = {
		destroy = 0,
		container = "SurvivalStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/common/survivalstoreview.prefab",
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
	module_views.SurvivalInfoView = {
		destroy = 0,
		container = "SurvivalInfoViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/survival/common/survivalcommondesccomp.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.AnimInternal,
		tabRes = {}
	}
end

function SurvivalViewDefine.initMapDefine(module_views)
	module_views.SurvivalMapMainView = {
		destroy = 0,
		container = "SurvivalMapMainViewContainer",
		mainRes = "ui/viewres/survival/map/survivalmapmainview.prefab",
		layer = "HUD",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			unititem = "ui/viewres/survival/map/survivalmapunititem.prefab",
			roleSkillConfirmItem = "ui/viewres/survival/map/survivalmaproleskillconfirmitem.prefab"
		}
	}
	module_views.SurvivalMapEventView = {
		destroy = 0,
		container = "SurvivalMapEventViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivaleventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			cameraRes = "survival/common/survivalcamera.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalMapSearchView = {
		destroy = 0,
		container = "SurvivalMapSearchViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapsearchview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	module_views.SurvivalMapBagView = {
		destroy = 0,
		container = "SurvivalMapBagViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapbagview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalMapResultView = {
		destroy = 0,
		container = "SurvivalMapResultViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalMapResultPanelView = {
		destroy = 0,
		container = "SurvivalMapResultPanelViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/map/survivalmapresultpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalInitTeamView = {
		bgBlur = 1,
		container = "SurvivalInitTeamViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalinitteamview.prefab",
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
			initNpcItemSmall = "ui/viewres/survival/map/survivalinitnpcsmallitem.prefab",
			initNpcItem = "ui/viewres/survival/map/survivalinitnpcitem.prefab",
			survivalbossinvasionview = "ui/viewres/survival/shelter/survivalbossinvasionview.prefab",
			survivalroleattrcomp = "ui/viewres/survival/role/survivalroleattrcomp.prefab",
			initHeroItem = "ui/viewres/survival/map/survivalinitheroitem.prefab",
			initHeroItemSmall = "ui/viewres/survival/map/survivalinitherosmallitem.prefab",
			survivalcommondesccomp = "ui/viewres/survival/common/survivalcommondesccomp.prefab"
		}
	}
	module_views.SurvivalMapTeamView = {
		bgBlur = 4,
		container = "SurvivalMapTeamViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalmapteamview.prefab",
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
			initNpcItemSmall = "ui/viewres/survival/map/survivalinitnpcsmallitem.prefab",
			survivalroleattrcomp = "ui/viewres/survival/role/survivalroleattrcomp.prefab",
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab",
			initHeroItemSmall = "ui/viewres/survival/map/survivalinitherosmallitem.prefab",
			survivalcommondesccomp = "ui/viewres/survival/common/survivalcommondesccomp.prefab"
		}
	}
	module_views.SurvivalNPCSelectView = {
		destroy = 0,
		container = "SurvivalNPCSelectViewContainer",
		mainRes = "ui/viewres/survival/map/survivalnpcselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	module_views.SurvivalPickAssistView = {
		destroy = 0,
		container = "SurvivalPickAssistViewContainer",
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
	module_views.SurvivalInitHeroSelectView = {
		container = "SurvivalInitHeroSelectViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/survival/map/survivalinitselectheroeditview.prefab",
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
			[1] = "ui/viewres/survival/map/survivalherogroupedititem.prefab",
			[2] = "ui/viewres/survival/map/survivalherogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	module_views.SurvivalLoadingView = {
		destroy = 0,
		container = "SurvivalLoadingViewContainer",
		mainRes = "ui/viewres/survival/map/survivalloadingview.prefab",
		layer = "TOP",
		viewType = ViewType.Full,
		otherRes = {
			[1] = "singlebg/survival_singlebg/loading/survival_loading_fullbg.png"
		}
	}
	module_views.SurvivalSmallMapView = {
		destroy = 0,
		container = "SurvivalSmallMapViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalsmallmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.SurvivalToastView = {
		destroy = 0,
		container = "SurvivalToastViewContainer",
		mainRes = "ui/viewres/survival/map/survivaltoastview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal
	}
	module_views.SurvivalLogView = {
		bgBlur = 4,
		container = "SurvivalLogViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalmaploginfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.SurvivalCommitItemView = {
		bgBlur = 4,
		container = "SurvivalCommitItemViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalcommititemview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalHeroGroupFightView = {
		bgBlur = 4,
		container = "SurvivalHeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalherogroupview.prefab",
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
	module_views.SurvivalHeroGroupEditView = {
		container = "SurvivalHeroGroupEditViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/survival/map/survivalherogroupeditview.prefab",
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
			[1] = "ui/viewres/survival/map/survivalherogroupedititem.prefab",
			[2] = "ui/viewres/survival/map/survivalherogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	module_views.SurvivalDropSelectView = {
		destroy = 0,
		container = "SurvivalDropSelectViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/map/survivalrewardchooseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalShopView = {
		bgBlur = 4,
		container = "SurvivalShopViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/map/survivalshopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalGetRewardView = {
		destroy = 0,
		container = "SurvivalGetRewardViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/map/survivalrewardchooseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
end

function SurvivalViewDefine.initShelterDefine(module_views)
	module_views.SurvivalMainView = {
		destroy = 0,
		container = "SurvivalMainViewContainer",
		mainRes = "ui/viewres/survival/shelter/survivalmainview.prefab",
		layer = "HUD",
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
			unititem = "ui/viewres/survival/shelter/survivalshelterunititem.prefab",
			survivalbossinvasionview = "ui/viewres/survival/shelter/survivalbossinvasionview.prefab"
		}
	}
	module_views.SurvivalHardView = {
		destroy = 0,
		container = "SurvivalHardViewContainer",
		mainRes = "ui/viewres/survival/map/survivalselectdifficultyview.prefab",
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
	module_views.SurvivalSelectTalentTreeView = {
		bgBlur = 1,
		container = "SurvivalSelectTalentTreeViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalceremonyopeningview.prefab",
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
			survivalmapbagitem = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	module_views.SurvivalEquipView = {
		bgBlur = 4,
		container = "SurvivalEquipViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalequipview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalEquipOverView = {
		destroy = 0,
		container = "SurvivalEquipOverViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/shelter/survivalequipoverview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.ShelterHeroGroupFightView = {
		bgBlur = 4,
		container = "ShelterHeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalherogroupview.prefab",
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
	module_views.ShelterTaskView = {
		destroy = 0,
		container = "ShelterTaskViewContainer",
		mainRes = "ui/viewres/survival/map/survivaltaskview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	module_views.ShelterNpcManagerView = {
		destroy = 0,
		container = "ShelterNpcManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivalpartnermanageview.prefab",
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
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	module_views.ShelterBuildingManagerView = {
		destroy = 0,
		container = "ShelterBuildingManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivalbuildingmanageview.prefab",
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
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	module_views.ShelterTentManagerView = {
		destroy = 0,
		container = "ShelterTentManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivaltentmanageview.prefab",
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
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	module_views.ShelterRestManagerView = {
		destroy = 0,
		container = "ShelterRestManagerViewContainer",
		mainRes = "ui/viewres/survival/map/survivalrestmanageview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalinitheroitem.prefab",
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	module_views.ShelterRestHeroSelectView = {
		container = "ShelterRestHeroSelectViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/survival/map/survivalinitselectheroeditview.prefab",
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
			[1] = "ui/viewres/survival/map/survivalherogroupedititem.prefab",
			[2] = "ui/viewres/survival/map/survivalherogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	module_views.ShelterMapEventView = {
		destroy = 0,
		container = "ShelterMapEventViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivaleventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			cameraRes = "survival/common/survivalcamera.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalMonsterEventView = {
		destroy = 0,
		container = "SurvivalMonsterEventViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivalmonstereventview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalNpcStationView = {
		destroy = 0,
		container = "SurvivalNpcStationViewContainer",
		mainRes = "ui/viewres/survival/map/survivalnpcstationview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.SurvivalDecreeView = {
		destroy = 0,
		container = "SurvivalDecreeViewContainer",
		mainRes = "ui/viewres/survival/map/survivaldecreeview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivaldecreeitem.prefab",
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab"
		}
	}
	module_views.SurvivalDecreeSelectView = {
		destroy = 0,
		container = "SurvivalDecreeSelectViewContainer",
		mainRes = "ui/viewres/survival/map/survivaldecreeselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalDecreeVoteView = {
		destroy = 0,
		container = "SurvivalDecreeVoteViewContainer",
		mainRes = "ui/viewres/survival/map/survivaldecreevoteview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivaldecreevoteitem.prefab"
		}
	}
	module_views.ShelterMapBagView = {
		destroy = 0,
		container = "ShelterMapBagViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/survival/map/survivalmapbagview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.ShelterHeroWareHouseView = {
		container = "ShelterHeroWareHouseViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalherowarehouseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalherogroupedititem.prefab"
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
	module_views.ShelterRecruitView = {
		destroy = 0,
		container = "ShelterRecruitViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalshelterrecruitview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ShelterCompositeView = {
		bgBlur = 1,
		container = "ShelterCompositeViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalcompositeview.prefab",
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
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.ShelterCompositeSuccessView = {
		bgBlur = 1,
		container = "ShelterCompositeSuccessViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/survival/shelter/survivalcompositesuccessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab"
		}
	}
	module_views.SurvivalCeremonyClosingView = {
		destroy = 0,
		container = "SurvivalCeremonyClosingViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalceremonyclosingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	module_views.SurvivalBootyChooseView = {
		destroy = 0,
		container = "SurvivalBootyChooseViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalbootychooseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			infoView = "ui/viewres/survival/map/survivalpartnermanageinfoview.prefab",
			equipInfoView = "ui/viewres/survival/map/survivalmapbaginfoview.prefab",
			equipItemView = "ui/viewres/survival/map/survivalmapbagitem.prefab",
			itemRes = "ui/viewres/survival/map/survivalmapbagitem.prefab"
		}
	}
	module_views.SurvivalReportView = {
		destroy = 0,
		container = "SurvivalReportViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/shelter/survivalreportview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalEventPanelView = {
		destroy = 0,
		container = "SurvivalEventPanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivaleventpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalBossInvadeView = {
		destroy = 0,
		container = "SurvivalBossInvadeViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/survival/map/survivalbossinvadeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalShelterResultPanelView = {
		destroy = 0,
		container = "SurvivalShelterResultPanelViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/survival/shelter/survivalshelterresultpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalSummaryActView = {
		destroy = 0,
		container = "SurvivalSummaryActViewContainer",
		mainRes = "ui/viewres/survival/shelter/survivalsummaryactview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.SurvivalCollectionRoomView = {
		destroy = 0,
		container = "SurvivalCollectionRoomViewContainer",
		mainRes = "ui/viewres/survival/shelter/survivalcollectionroomview.prefab",
		layer = "HUD",
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
			unititem = "ui/viewres/survival/shelter/survivalshelterunititem.prefab"
		}
	}
end

return SurvivalViewDefine
