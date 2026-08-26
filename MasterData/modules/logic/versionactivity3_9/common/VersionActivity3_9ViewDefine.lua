-- chunkname: @modules/logic/versionactivity3_9/common/VersionActivity3_9ViewDefine.lua

module("modules.logic.versionactivity3_9.common.VersionActivity3_9ViewDefine", package.seeall)

local VersionActivity3_9ViewDefine = class("VersionActivity3_9ViewDefine")

function VersionActivity3_9ViewDefine.init(module_views)
	VersionActivity3_9ViewDefine.initEnter(module_views)
	VersionActivity3_9ViewDefine.initDungeon(module_views)
	VersionActivity3_9ViewDefine.initDungeonMiscView(module_views)
	VersionActivity3_9ViewDefine.initHedoneView(module_views)
	VersionActivity3_9ViewDefine.iniRacingView(module_views)
	V3a9RacingCarViewDefine.init(module_views)
end

function VersionActivity3_9ViewDefine.initEnter(module_views)
	module_views.VersionActivity3_9EnterView = {
		destroy = 0,
		container = "VersionActivity3_9EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_enter/v3a9_enterview.prefab",
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
					"ui/viewres/versionactivity_3_9/v3a9_enter/v3a9_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_9/v3a9_hedone/v3a9_hedone_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_9/v3a9_naxisuosi/v3a9_naxisuosi_enterview.prefab"
				},
				{
					"modules/party_game/ui/viewres/main/v3a4_partygameenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_9/v3a9_reprint/v3a9_v3a2reprint_enterview.prefab"
				},
				{
					"ui/viewres/rouge/rougeactivityview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_enterrootview.prefab"
				},
				{
					"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
				},
				{
					"ui/viewres/tower/towermainentryview.prefab"
				},
				{
					"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
				},
				{
					"ui/viewres/cloudredemption/cloudredemption_enterview.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab",
			[2] = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/v3a9_bossrush_enterview.prefab"
		}
	}
end

function VersionActivity3_9ViewDefine.initDungeon(module_views)
	module_views.VersionActivity3_9StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_storeview.prefab",
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
	module_views.VersionActivity3_9TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_taskview.prefab",
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
			"ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_taskitem.prefab"
		}
	}
	module_views.VersionActivity3_9DungeonMapView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_dungeonmap_direction.prefab",
			normalSceneItem = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_mapepisodeitem3.prefab",
			spSceneItem = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_mapepisodeitem4.prefab",
			spItem = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_mapepisodeitem2.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_9DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_dungeonmaplevelview.prefab",
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
end

function VersionActivity3_9ViewDefine.initDungeonMiscView(module_views)
	module_views.VersionActivity3_9DungeonReportFullView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportFullViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_dungeonreport_fullview.prefab",
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
	module_views.VersionActivity3_9DungeonReportTipsView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportTipsViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_dungeon/v3a9_dungeonreport_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.VersionActivity3_9DungeonFragmentInfoView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonFragmentInfoViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

function VersionActivity3_9ViewDefine.initHedoneView(module_views)
	return
end

function VersionActivity3_9ViewDefine.iniRacingView(module_views)
	module_views.V3a9BirdMainView = {
		destroy = 0,
		container = "V3a9BirdMainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/bird/v3a9_flappybird_mainview.prefab",
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
	module_views.V3a9BirdGameView = {
		destroy = 0,
		container = "V3a9BirdGameViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/bird/v3a9_flappybird_gameview.prefab",
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
	module_views.V3a9BirdResultView = {
		destroy = 0,
		container = "V3a9BirdResultViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/bird/v3a9_flappybird_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.V3a9BirdLoadingView = {
		destroy = 0,
		container = "V3a9BirdLoadingViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/v3a9_game_loadingview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal
	}
	module_views.V3a9BirdPauseView = {
		destroy = 0,
		container = "V3a9BirdPauseViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/v3a9_game_quittipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return VersionActivity3_9ViewDefine
