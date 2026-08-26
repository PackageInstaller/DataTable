-- chunkname: @modules/logic/versionactivity3_5/common/VersionActivity3_5ViewDefine.lua

module("modules.logic.versionactivity3_5.common.VersionActivity3_5ViewDefine", package.seeall)

local VersionActivity3_5ViewDefine = class("VersionActivity3_5ViewDefine")

function VersionActivity3_5ViewDefine.init(module_views)
	VersionActivity3_5ViewDefine.initEnter(module_views)
	VersionActivity3_5ViewDefine.initDungeon(module_views)
	VersionActivity3_5ViewDefine.initDungeonMiscView(module_views)
	VersionActivity3_5ViewDefine.initPuzzleView(module_views)
end

function VersionActivity3_5ViewDefine.initEnter(module_views)
	module_views.VersionActivity3_5EnterView = {
		destroy = 0,
		container = "VersionActivity3_5EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_5/v3a5_enter/v3a5_enterview.prefab",
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
					"ui/viewres/versionactivity_3_5/v3a5_enter/v3a5_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_5/v3a5_reprint/v3a5_v2a7reprint_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_5/v3a5_lamona/v3a5_lamona_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_5/v3a5_lorentz/v3a5_lorentz_enterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_5/v3a5_enter/v3a5_autochess_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_5/v3a5_season/v3a5_season_enterview.prefab"
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
end

function VersionActivity3_5ViewDefine.initDungeon(module_views)
	module_views.VersionActivity3_5StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_storeview.prefab",
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
	module_views.VersionActivity3_5TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_taskview.prefab",
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
			"ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_taskitem.prefab"
		}
	}
	module_views.VersionActivity3_5DungeonMapView = {
		destroy = 0,
		container = "VersionActivity3_5DungeonMapViewContainer",
		mainRes = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonmap_direction.prefab",
			normalSceneItem = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_mapepisodeitem3.prefab",
			episodeDirection = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonmap_episodedirection.prefab",
			v3a5_dungeonmap_panelview = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonmap_panelview.prefab",
			spItem = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_mapepisodeitem2.prefab",
			spSceneItem = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_mapepisodeitem4.prefab",
			v3a5_dungeonmap_panelview2 = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonmap_panelview2.prefab",
			v3a5_dungeonmap_mapitem = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonmap_mapitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_5DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonmaplevelview.prefab",
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

function VersionActivity3_5ViewDefine.initDungeonMiscView(module_views)
	module_views.VersionActivity3_5DungeonReportFullView = {
		destroy = 0,
		container = "VersionActivity3_5DungeonReportFullViewContainer",
		mainRes = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonreport_fullview.prefab",
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
	module_views.VersionActivity3_5DungeonReportTipsView = {
		destroy = 0,
		container = "VersionActivity3_5DungeonReportTipsViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_5/v3a5_dungeon/v3a5_dungeonreport_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.VersionActivity3_5DungeonFragmentInfoView = {
		destroy = 0,
		container = "VersionActivity3_5DungeonFragmentInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

function VersionActivity3_5ViewDefine.initPuzzleView(module_views)
	module_views.V3a5PuzzleView = {
		destroy = 0,
		container = "V3a5PuzzleViewContainer",
		mainRes = "ui/viewres/story/v3a5_plot_puzzle_view.prefab",
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
end

return VersionActivity3_5ViewDefine
