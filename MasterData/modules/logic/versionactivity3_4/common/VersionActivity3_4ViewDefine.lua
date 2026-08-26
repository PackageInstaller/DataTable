-- chunkname: @modules/logic/versionactivity3_4/common/VersionActivity3_4ViewDefine.lua

module("modules.logic.versionactivity3_4.common.VersionActivity3_4ViewDefine", package.seeall)

local VersionActivity3_4ViewDefine = class("VersionActivity3_4ViewDefine")

function VersionActivity3_4ViewDefine.init(module_views)
	VersionActivity3_4ViewDefine.initEnter(module_views)
	VersionActivity3_4ViewDefine.initDungeon(module_views)
	VersionActivity3_4ViewDefine.initDungeonMiscView(module_views)
end

function VersionActivity3_4ViewDefine.initEnter(module_views)
	module_views.VersionActivity3_4EnterView = {
		destroy = 0,
		container = "VersionActivity3_4EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_enter/v3a4_enterview.prefab",
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
					"ui/viewres/versionactivity_3_4/v3a4_enter/v3a4_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_4/v3a4_enter/v3a4_partygameenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_4/survival/v3a4_survival_enterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_4/v3a4_lusijian/v3a4_lusijian_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_4/v3a4_reprint/v3a4_v2a5reprint_enterview.prefab"
				},
				{
					"ui/viewres/rouge2/rouge2_activityview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_4/v3a4_chg/v3a4_chg_enterview.prefab"
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

function VersionActivity3_4ViewDefine.initDungeon(module_views)
	module_views.VersionActivity3_4StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_storeview.prefab",
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
	module_views.VersionActivity3_4TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_taskview.prefab",
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
			"ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_taskitem.prefab"
		}
	}
	module_views.VersionActivity3_4DungeonMapView = {
		destroy = 0,
		container = "VersionActivity3_4DungeonMapViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonmap_direction.prefab",
			normalSceneItem = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_mapepisodeitem3.prefab",
			episodeDirection = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonmap_episodedirection.prefab",
			v3a4_dungeonmap_panelview = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonmap_panelview.prefab",
			spItem = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_mapepisodeitem2.prefab",
			spSceneItem = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_mapepisodeitem4.prefab",
			v3a4_dungeonmap_mapitem = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonmap_mapitem.prefab",
			v3a4_dungeonmap_panelview2 = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonmap_panelview2.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_4DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonmaplevelview.prefab",
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

function VersionActivity3_4ViewDefine.initDungeonMiscView(module_views)
	module_views.VersionActivity3_4DungeonReportFullView = {
		destroy = 0,
		container = "VersionActivity3_4DungeonReportFullViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonreport_fullview.prefab",
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
	module_views.VersionActivity3_4DungeonReportTipsView = {
		destroy = 0,
		container = "VersionActivity3_4DungeonReportTipsViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_dungeon/v3a4_dungeonreport_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.VersionActivity3_4DungeonFragmentInfoView = {
		destroy = 0,
		container = "VersionActivity3_4DungeonFragmentInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return VersionActivity3_4ViewDefine
