-- chunkname: @modules/logic/versionactivity3_2/common/VersionActivity3_2ViewDefine.lua

module("modules.logic.versionactivity3_2.common.VersionActivity3_2ViewDefine", package.seeall)

local VersionActivity3_2ViewDefine = class("VersionActivity3_2ViewDefine")

function VersionActivity3_2ViewDefine.init(module_views)
	VersionActivity3_2ViewDefine.initEnter(module_views)
	VersionActivity3_2ViewDefine.initDungeon(module_views)
	VersionActivity3_2ViewDefine.initDungeonMiscView(module_views)
end

function VersionActivity3_2ViewDefine.initEnter(module_views)
	module_views.VersionActivity3_2EnterView = {
		destroy = 0,
		container = "VersionActivity3_2EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_2/v3a2_enter/v3a2_enterview.prefab",
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
					"ui/viewres/versionactivity_3_2/v3a2_enter/v3a2_dungeonenterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_2/v3a2_beilier/v3a2_beilier_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_2/v3a2_huidiaolan/v3a2_huidiaolan_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_2/v3a2_enter/v3a2_autochess_enterview.prefab"
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
end

function VersionActivity3_2ViewDefine.initDungeon(module_views)
	module_views.VersionActivity3_2StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
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
	module_views.VersionActivity3_2TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_taskview.prefab",
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
			"ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_taskitem.prefab"
		}
	}
	module_views.VersionActivity3_2DungeonMapView = {
		destroy = 0,
		container = "VersionActivity3_2DungeonMapViewContainer",
		mainRes = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonmap_direction.prefab",
			normalSceneItem = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_mapepisodeitem3.prefab",
			episodeDirection = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonmap_episodedirection.prefab",
			v3a2_dungeonmap_panelview2 = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonmap_panelview2.prefab",
			spItem = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_mapepisodeitem2.prefab",
			spSceneItem = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_mapepisodeitem4.prefab",
			v3a2_dungeonmap_mapitem = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonmap_mapitem.prefab",
			v3a2_dungeonmap_panelview = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonmap_panelview.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_2DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonmaplevelview.prefab",
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

function VersionActivity3_2ViewDefine.initDungeonMiscView(module_views)
	module_views.VersionActivity3_2DungeonReportFullView = {
		destroy = 0,
		container = "VersionActivity3_2DungeonReportFullViewContainer",
		mainRes = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonreport_fullview.prefab",
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
	module_views.VersionActivity3_2DungeonReportTipsView = {
		destroy = 0,
		container = "VersionActivity3_2DungeonReportTipsViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_2/v3a2_dungeon/v3a2_dungeonreport_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.VersionActivity3_2DungeonFragmentInfoView = {
		destroy = 0,
		container = "VersionActivity3_2DungeonFragmentInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

return VersionActivity3_2ViewDefine
