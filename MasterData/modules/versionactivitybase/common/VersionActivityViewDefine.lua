-- chunkname: @modules/versionactivitybase/common/VersionActivityViewDefine.lua

module("modules.versionactivitybase.common.VersionActivityViewDefine", package.seeall)

local VersionActivityViewDefine = class("VersionActivityViewDefine")

function VersionActivityViewDefine.init(module_views)
	VersionActivityViewDefine.V3A1(module_views)
end

function VersionActivityViewDefine.V3A1(module_views)
	module_views.VersionActivity3_1EnterView = {
		destroy = 0,
		container = "VersionActivity3_1EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_1/v3a1_enter/v3a1_enterview.prefab",
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
					"ui/viewres/versionactivity_3_1/v3a1_enter/v3a1_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_1/v3a1_enter/v3a1_act191enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_1/survival/v3a1_survival_enterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_1/v3a1_yeshumei/v3a1_yeshumei_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v1a6_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_1/v3a1_reprint/v3a1_v2a4reprint_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_1/v3a1_gaosiniao/v3a1_gaosiniao_enterview.prefab"
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
	module_views.VersionActivity3_1StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_storeview.prefab",
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
	module_views.VersionActivity3_1TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_taskview.prefab",
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
	module_views.VersionActivity3_1DungeonMapView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapViewContainer",
		mainRes = "ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_dungeonmap_direction.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_1DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_3_1/v3a1_dungeon/v3a1_dungeonmaplevelview.prefab",
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

return VersionActivityViewDefine
