-- chunkname: @modules/logic/versionactivity3_6/common/VersionActivity3_6ViewDefine.lua

module("modules.logic.versionactivity3_6.common.VersionActivity3_6ViewDefine", package.seeall)

local VersionActivity3_6ViewDefine = class("VersionActivity3_6ViewDefine")

function VersionActivity3_6ViewDefine.init(module_views)
	VersionActivity3_6ViewDefine.initEnter(module_views)
	VersionActivity3_6ViewDefine.initDungeon(module_views)
	VersionActivity3_6ViewDefine.initDungeonMiscView(module_views)
	VersionActivity3_6ViewDefine.initPuzzleView(module_views)
end

function VersionActivity3_6ViewDefine.initEnter(module_views)
	module_views.VersionActivity3_6EnterView = {
		destroy = 0,
		container = "VersionActivity3_6EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_enterview.prefab",
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
					"ui/viewres/versionactivity_3_6/v3a6_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/cloudredemption/cloudredemption_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_enterview.prefab"
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

function VersionActivity3_6ViewDefine.initDungeon(module_views)
	module_views.VersionActivity3_6StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_storeview.prefab",
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
	module_views.VersionActivity3_6TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_taskview.prefab",
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
			"ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_taskitem.prefab"
		}
	}
	module_views.VersionActivity3_6DungeonMapView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_dungeonmap_direction.prefab",
			normalSceneItem = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_mapepisodeitem3.prefab",
			spSceneItem = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_mapepisodeitem4.prefab",
			spItem = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_mapepisodeitem2.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_6DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_dungeonmaplevelview.prefab",
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

function VersionActivity3_6ViewDefine.initDungeonMiscView(module_views)
	module_views.VersionActivity3_6DungeonReportFullView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportFullViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_dungeonreport_fullview.prefab",
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
	module_views.VersionActivity3_6DungeonReportTipsView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportTipsViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dungeon/v3a6_dungeonreport_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.VersionActivity3_6DungeonFragmentInfoView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonFragmentInfoViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

function VersionActivity3_6ViewDefine.initPuzzleView(module_views)
	module_views.V3a6PuzzleView = {
		destroy = 0,
		container = "V3a6PuzzleViewContainer",
		mainRes = "ui/viewres/story/avg_spelling_view.prefab",
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
					"ui/viewres/story/characterdialog.prefab"
				}
			}
		}
	}
end

return VersionActivity3_6ViewDefine
