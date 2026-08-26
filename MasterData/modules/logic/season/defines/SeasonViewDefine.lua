-- chunkname: @modules/logic/season/defines/SeasonViewDefine.lua

module("modules.logic.season.defines.SeasonViewDefine", package.seeall)

local SeasonViewDefine = class("SeasonViewDefine")

function SeasonViewDefine.init(module_views)
	SeasonViewDefine.initDefine3_0(module_views)
	SeasonViewDefine.initDefine3_5(module_views)
end

function SeasonViewDefine.initDefine3_0(module_views)
	module_views.Season3_0MainView = {
		destroy = 0,
		container = "Season3_0MainViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonmainview.prefab",
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
			role5 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_karong.prefab",
			section4 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section04.prefab",
			scene = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_background_a.prefab",
			section1 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section01.prefab",
			role3 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_shaoxiao.prefab",
			role6 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_weierting.prefab",
			section3 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section03.prefab",
			role1 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_aiguozhe.prefab",
			role4 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_14.prefab",
			section5 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section05.prefab",
			section2 = "scenes/v3a0_m_s15_sj/scene_prefab/v3a0_m_s15_section02.prefab",
			role2 = "scenes/v3a0_m_s15_sj/perfab/m_s15_sj_qz_hongnujian.prefab"
		}
	}
	module_views.Season3_0MarketView = {
		destroy = 0,
		container = "Season3_0MarketViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/v3a0_season/seasonmarketview.prefab",
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
	module_views.Season3_0SpecialMarketView = {
		destroy = 0,
		container = "Season3_0SpecialMarketViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/v3a0_season/seasonspecialmarketview.prefab",
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
	module_views.Season3_0RetailView = {
		destroy = 0,
		container = "Season3_0RetailViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonretailview.prefab",
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
	module_views.Season3_0RetailLevelInfoView = {
		destroy = 0,
		container = "Season3_0RetailLevelInfoViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonretaillevelinfoview.prefab",
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
	module_views.Season3_0TaskView = {
		destroy = 0,
		container = "Season3_0TaskViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasontaskview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasontaskitem.prefab"
		}
	}
	module_views.Season3_0SettlementView = {
		destroy = 0,
		container = "Season3_0SettlementViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonsettlementview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/v3a0_season/seasonsettlementherogroupitem.prefab"
		}
	}
	module_views.Season3_0CelebrityCardGetlView = {
		destroy = 0,
		container = "Season3_0CelebrityCardGetlViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasoncelebritycardgetlview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season3_0EquipView = {
		bgBlur = 0,
		container = "Season3_0EquipViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipcarditem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	module_views.Season3_0EquipHeroView = {
		bgBlur = 0,
		container = "Season3_0EquipHeroViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipheroview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipcarditem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	module_views.Season3_0FightFailView = {
		destroy = 0,
		container = "Season3_0FightFailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonfightfailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season3_0FightSuccView = {
		destroy = 0,
		container = "Season3_0FightSuccViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonfightsuccview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season3_0StoreView = {
		destroy = 0,
		container = "Season3_0StoreViewContainer",
		mainRes = "ui/viewres/v3a0_season/seasonstoreview.prefab",
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
			itemPath = "ui/viewres/v3a0_season/seasonstoreitem.prefab"
		}
	}
	module_views.Season3_0EquipSelfChoiceView = {
		destroy = 0,
		container = "Season3_0EquipSelfChoiceViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonmulticardchoiceview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/v3a0_season/seasonmulticardchoiceitem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	module_views.Season3_0CelebrityCardTipView = {
		container = "Season3_0CelebrityCardTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasoncelebritycardtipview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		otherRes = {
			[1] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	module_views.Season3_0EquipComposeView = {
		bgBlur = 0,
		container = "Season3_0EquipComposeViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipcomposeview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipcomposeitem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	module_views.Season3_0EquipBookView = {
		bgBlur = 0,
		container = "Season3_0EquipBookViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonequipbookview.prefab",
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
			[1] = "ui/viewres/v3a0_season/seasonequipbookitem.prefab",
			[2] = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"
		}
	}
	module_views.Season3_0FightRuleTipView = {
		destroy = 0,
		container = "Season3_0FightRuleTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/v3a0_season/seasonfightruletipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					"ui/viewres/v3a0_season/seasonfightruleview.prefab"
				},
				{
					"ui/viewres/v3a0_season/seasonfightcardview.prefab"
				}
			}
		}
	}
	module_views.Season3_0HeroGroupFightView = {
		bgBlur = 4,
		container = "Season3_0HeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/v3a0_season/seasonherogroupview.prefab",
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
	module_views.Season3_0AdditionRuleTipView = {
		destroy = 0,
		container = "Season3_0AdditionRuleTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/v3a0_season/seasonadditionruletipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season3_0SumView = {
		destroy = 0,
		container = "Season3_0SumViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/v3a0_season/seasonsumview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season3_0StoryView = {
		destroy = 0,
		container = "Season3_0StoryViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonstoryview.prefab",
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
	module_views.Season3_0StoryPagePopView = {
		destroy = 0,
		container = "Season3_0StoryPagePopViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/v3a0_season/seasonstorypagepopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
end

function SeasonViewDefine.initDefine3_5(module_views)
	module_views.Season123_3_5EntryView = {
		destroy = 0,
		container = "Season123_3_5EntryViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123mainview.prefab",
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
					"ui/viewres/seasonver/v3a5_act123/season123carddetailview.prefab"
				}
			}
		}
	}
	module_views.Season123_3_5EntryOverview = {
		destroy = 0,
		container = "Season123_3_5EntryOverviewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123entryoverview.prefab",
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
	module_views.Season123_3_5RetailView = {
		destroy = 0,
		container = "Season123_3_5RetailViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123retaillevelinfoview.prefab",
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
	module_views.Season123_3_5HeroGroupFightView = {
		bgBlur = 4,
		container = "Season123_3_5HeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123herogroupview.prefab",
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
	module_views.Season123_3_5EpisodeListView = {
		destroy = 0,
		container = "Season123_3_5EpisodeListViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123episodelistview.prefab",
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
					"ui/viewres/seasonver/v3a5_act123/season123carddetailview.prefab"
				}
			}
		}
	}
	module_views.Season123_3_5EpisodeLoadingView = {
		destroy = 0,
		container = "Season123_3_5EpisodeLoadingViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123episodeloadingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full
	}
	module_views.Season123_3_5EpisodeDetailView = {
		destroy = 0,
		container = "Season123_3_5EpisodeDetailViewContainer",
		bgBlur = 4,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123marketview.prefab",
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
	module_views.Season123_3_5PickAssistView = {
		destroy = 0,
		container = "Season123_3_5PickAssistViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123pickassistview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123pickassistitem.prefab"
		}
	}
	module_views.Season123_3_5HeroGroupEditView = {
		container = "Season123_3_5HeroGroupEditViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123herogroupeditview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123herogroupedititem.prefab",
			[2] = "ui/viewres/seasonver/v3a5_act123/season123herogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	module_views.Season123_3_5PickHeroEntryView = {
		destroy = 0,
		container = "Season123_3_5PickHeroEntryViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123pickheroentryview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5PickHeroView = {
		destroy = 0,
		container = "Season123_3_5PickHeroViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123pickheroview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123pickheroitem.prefab"
		}
	}
	module_views.Season123_3_5StageLoadingView = {
		destroy = 0,
		container = "Season123_3_5StageLoadingViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123loadingview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.Season123_3_5StageFinishView = {
		destroy = 0,
		container = "Season123_3_5StageFinishViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123stagefinishview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.Season123_3_5ShowHeroView = {
		destroy = 0,
		container = "Season123_3_5ShowHeroViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123showheroview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5EquipHeroView = {
		destroy = 0,
		container = "Season123_3_5EquipHeroViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123equipheroview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123equipcarditem.prefab",
			[2] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5EquipView = {
		destroy = 0,
		container = "Season123_3_5EquipViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123equipview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123equipcarditem.prefab",
			[2] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5EnemyView = {
		bgBlur = 1,
		container = "Season123_3_5EnemyViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123enemyview.prefab",
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
	module_views.Season123_3_5StoreView = {
		destroy = 0,
		container = "Season123_3_5StoreViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123storeview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123storeitem.prefab"
		}
	}
	module_views.Season123_3_5TaskView = {
		destroy = 0,
		container = "Season123_3_5TaskViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123taskview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123taskitem.prefab"
		}
	}
	module_views.Season123_3_5EquipBookView = {
		bgBlur = 0,
		container = "Season123_3_5EquipBookViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123equipbookview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123equipbookitem.prefab",
			[2] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5BatchDecomposeView = {
		bgBlur = 0,
		container = "Season123_3_5BatchDecomposeViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123batchdecomposeview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123decomposeitem.prefab",
			[2] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5DecomposeFilterView = {
		destroy = 10,
		container = "Season123_3_5DecomposeFilterViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123decomposefilterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.Season123_3_5DecomposeView = {
		container = "Season123_3_5DecomposeViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123decomposeview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5CelebrityCardTipView = {
		container = "Season123_3_5CelebrityCardTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123celebritycardtipview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		otherRes = {
			[1] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5CelebrityCardGetView = {
		destroy = 0,
		container = "Season123_3_5CelebrityCardGetViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123celebritycardgetview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season123_3_5CardPackageView = {
		bgBlur = 1,
		container = "Season123_3_5CardPackageViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123cardpackageview.prefab",
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
			[1] = "ui/viewres/seasonver/v3a5_act123/season123cardpackageitem.prefab",
			[2] = "ui/viewres/seasonver/v3a5_act123/season123celebritycarditem.prefab"
		}
	}
	module_views.Season123_3_5StoryView = {
		destroy = 0,
		container = "Season123_3_5StoryViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123storyview.prefab",
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
	module_views.Season123_3_5StoryPagePopView = {
		destroy = 0,
		container = "Season123_3_5StoryPagePopViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123storypagepopview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season123_3_5RecordWindow = {
		destroy = 0,
		container = "Season123_3_5RecordWindowContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123recordwindow.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season123_3_5FightSuccView = {
		destroy = 0,
		container = "Season123_3_5FightSuccViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123fightsuccview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season123_3_5FightFailView = {
		destroy = 0,
		container = "Season123_3_5FightFailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123fightfailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season123_3_5SettlementView = {
		destroy = 0,
		container = "Season123_3_5SettlementViewContainer",
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123settlementview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			itemRes = "ui/viewres/seasonver/v3a5_act123/season123settlementherogroupitem.prefab"
		}
	}
	module_views.Season123_3_5AdditionRuleTipView = {
		destroy = 0,
		container = "Season123_3_5AdditionRuleTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123additionruletipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.Season123_3_5FightRuleTipView = {
		destroy = 0,
		container = "Season123_3_5FightRuleTipViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123fightruletipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					"ui/viewres/seasonver/v3a5_act123/season123fightruleview.prefab"
				},
				{
					"ui/viewres/seasonver/v3a5_act123/season123fightcardview.prefab"
				}
			}
		}
	}
	module_views.Season123_3_5ResetView = {
		destroy = 0,
		container = "Season123_3_5ResetViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123resetview.prefab",
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
	module_views.Season123_3_5ProgressView = {
		destroy = 0,
		container = "Season123_3_5ProgressViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123progressview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			itemRes = "ui/viewres/seasonver/v3a5_act123/season123progressitem.prefab"
		}
	}
	module_views.Season123_3_5CardDescView = {
		destroy = 0,
		container = "Season123_3_5CardDescViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/seasonver/v3a5_act123/season123carddescview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return SeasonViewDefine
