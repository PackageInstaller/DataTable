-- chunkname: @modules/logic/bossrush/view/BossRushDefine.lua

module("modules.logic.bossrush.view.BossRushDefine", package.seeall)

local BossRushDefine = {}

function BossRushDefine.init(module_views)
	module_views.V2a9_BossRushHeroGroupFightView = {
		bgBlur = 4,
		container = "V2a9_BossRushHeroGroupFightViewContainer",
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
			[1] = "ui/viewres/fight/clothskill.prefab",
			[2] = "ui/viewres/sp01/assassin2/v2a9_herogroupskillview.prefab"
		}
	}
	module_views.V2a9_BossRushSkillBackpackView = {
		destroy = 0,
		container = "V2a9_BossRushSkillBackpackViewContainer",
		mainRes = "ui/viewres/sp01/assassin2/assassinbackpackview.prefab",
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
	module_views.V3a2_BossRush_MainView = {
		bgBlur = 0,
		container = "V3a2_BossRush_MainViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_mainview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon,
			BossRushEnum.ResPath.v3a2_bossrush_rankbtn
		}
	}
	module_views.V3a2_BossRush_LevelDetailView = {
		bgBlur = 0,
		container = "V3a2_BossRush_LevelDetailViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_leveldetail,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon,
			BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine,
			[4] = BossRushEnum.ResPath.v3a2_bossrush_strategyitem
		},
		preloader = module_views_preloader
	}
	module_views.V3a2_BossRush_HandBookView = {
		bgBlur = 0,
		container = "V3a2_BossRush_HandBookViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_handbookview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v3a2_bossrush_handbookitem,
			BossRushEnum.ResPath.v3a2_bossrush_rankbtn,
			BossRushEnum.ResPath.v3a2_bossrush_strategyitem
		}
	}
	module_views.V3a2_BossRush_RankView = {
		bgBlur = 0,
		container = "V3a2_BossRush_RankViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_rankview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v3a2_bossrush_rankbonus
		}
	}
	module_views.V3a2_BossRush_ResultView = {
		bgBlur = 1,
		container = "V3a2_BossRush_ResultViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_resultview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_result_assess,
			BossRushEnum.ResPath.v1a4_bossrush_herogroup,
			BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1,
			BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
		}
	}
	module_views.V3a2_BossRush_ResultPanel = {
		destroy = 0,
		container = "V3a2_BossRush_ResultPanelContainer",
		bgBlur = 1,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a2_bossrush_resultpanel,
		otherRes = {
			BossRushEnum.ResPath.v3a2_bossrush_resultassess,
			BossRushEnum.ResPath.v1a4_bossrush_result_assess
		}
	}

	BossRushDefine.initV3a9(module_views)
end

function BossRushDefine.initV3a9(module_views)
	module_views.V3a9_BossRush_MainSwitchModeView = {
		bgBlur = 0,
		container = "V3a9_BossRush_MainSwitchModeViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a9_bossrush_mainswitchmodeview,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					BossRushEnum.ResPath.v3a2_bossrush_mainview
				},
				{
					BossRushEnum.ResPath.v3a9_bossrush_mainview
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon,
			BossRushEnum.ResPath.v3a2_bossrush_rankbtn
		}
	}
	module_views.V3a9_BossRush_LevelDetailView = {
		bgBlur = 0,
		container = "V3a9_BossRush_LevelDetailViewContainer",
		destroy = 0,
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		mainRes = BossRushEnum.ResPath.v3a9_bossrush_leveldetail,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon,
			BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine,
			[4] = BossRushEnum.ResPath.v3a2_bossrush_strategyitem
		},
		preloader = module_views_preloader
	}
	module_views.V3a9_BossRush_HeroGroupFightView = {
		bgBlur = 4,
		container = "V3a9_BossRush_HeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_herogroup.prefab",
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
			[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_heroitem.prefab",
			[3] = "ui/viewres/fight/clothskill.prefab",
			[2] = BossRushEnum.ResPath.v3a9_bossrush_bondsitem
		}
	}
	module_views.V3a9_BossRush_HeroGroupEditView = {
		destroy = 5,
		container = "V3a9_BossRush_HeroGroupEditViewContainer",
		mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_editview.prefab",
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
			[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_edititem.prefab",
			[2] = BossRushEnum.ResPath.v3a9_bossrush_bondsitem
		}
	}
	module_views.V3a9_BossRush_ExpandBondsTipView = {
		destroy = 0,
		container = "V3a9_BossRush_ExpandBondsTipViewContainer",
		mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_bondstipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_heroitem.prefab"
		}
	}
	module_views.V3a9_BossRush_BonusView = {
		bgBlur = 0,
		container = "V3a9_BossRush_BonusViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_scoreview.prefab",
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
			[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_scorebonus.prefab"
		}
	}
	module_views.V3a9_BossRush_ResultView = {
		bgBlur = 1,
		container = "V3a9_BossRush_ResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_resultview.prefab",
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
			BossRushEnum.ResPath.v1a4_bossrush_result_assess,
			BossRushEnum.ResPath.v3a9_bossrush_bondsitem
		}
	}
	module_views.V3a9_BossRush_AssistView = {
		destroy = 0,
		container = "V3a9_BossRush_AssistViewContainer",
		mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_assistview.prefab",
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
			[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_assistitem.prefab",
			[2] = BossRushEnum.ResPath.v3a9_bossrush_bondsitem
		}
	}
	module_views.V3a9_BossRush_SearchFilterView = {
		destroy = 0,
		container = "V3a9_BossRush_SearchFilterViewContainer",
		mainRes = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_searchfilterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

return BossRushDefine
