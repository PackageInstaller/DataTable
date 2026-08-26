-- chunkname: @modules/logic/versionactivity3_8/common/VersionActivity3_8ViewDefine.lua

module("modules.logic.versionactivity3_8.common.VersionActivity3_8ViewDefine", package.seeall)

local VersionActivity3_8ViewDefine = class("VersionActivity3_8ViewDefine")

function VersionActivity3_8ViewDefine.init(module_views)
	VersionActivity3_8ViewDefine.initEnter(module_views)
	VersionActivity3_8ViewDefine.initDungeon(module_views)
	VersionActivity3_8ViewDefine.initDungeonMiscView(module_views)
	VersionActivity3_8ViewDefine.initPuzzleView(module_views)
	VersionActivity3_8ViewDefine.initDianJiShiView(module_views)
end

function VersionActivity3_8ViewDefine.initEnter(module_views)
	module_views.VersionActivity3_8EnterView = {
		destroy = 0,
		container = "VersionActivity3_8EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_enter/v3a8_enterview.prefab",
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
					"ui/viewres/versionactivity_3_8/v3a8_enter/v3a8_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_8/v3a8_huishengyao/view/v3a8_huishengyao_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_8/v3a8_dianjishi/v3a8_dianjishi_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_8/v3a8_reprint/v3a8_v3a1reprint_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_1/v3a1_enter/v3a1_act191enterview.prefab"
				},
				{
					"ui/viewres/cloudredemption/cloudredemption_enterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/cloudredemption/cloudredemption_enterview.prefab"
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

function VersionActivity3_8ViewDefine.initDungeon(module_views)
	module_views.VersionActivity3_8StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_storeview.prefab",
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
	module_views.VersionActivity3_8TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_taskview.prefab",
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
			"ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_taskitem.prefab"
		}
	}
	module_views.VersionActivity3_8DungeonMapView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_dungeonmap_direction.prefab",
			normalSceneItem = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_mapepisodeitem3.prefab",
			spSceneItem = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_mapepisodeitem4.prefab",
			spItem = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_mapepisodeitem2.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_8DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_dungeonmaplevelview.prefab",
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

function VersionActivity3_8ViewDefine.initDungeonMiscView(module_views)
	module_views.VersionActivity3_8DungeonReportFullView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportFullViewContainer1",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_dungeonreport_fullview.prefab",
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
	module_views.VersionActivity3_8DungeonReportTipsView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonReportTipsViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dungeon/v3a8_dungeonreport_tipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.VersionActivity3_8DungeonFragmentInfoView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonFragmentInfoViewContainer1",
		bgBlur = 1,
		mainRes = "ui/viewres/dungeon/dungeonfragmentinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
end

function VersionActivity3_8ViewDefine.initPuzzleView(module_views)
	module_views.V3a8PuzzleView = {
		destroy = 0,
		container = "V3a8PuzzleViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/story/v3a8_avg_view.prefab",
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

function VersionActivity3_8ViewDefine.initDianJiShiView(module_views)
	module_views.DianJiShiGameView = {
		destroy = 0,
		container = "DianJiShiGameViewContainer",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dianjishi/v3a8_dianjishi_gameview.prefab",
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
	module_views.DianJiShiLevelView = {
		destroy = 0,
		container = "DianJiShiLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dianjishi/v3a8_dianjishi_levelview.prefab",
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
			[1] = "ui/viewres/versionactivity_3_8/v3a8_dianjishi/v3a8_dianjishi_levelitem.prefab"
		}
	}
	module_views.DianJiShiTaskView = {
		bgBlur = 0,
		container = "DianJiShiTaskViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_dianjishi/v3a8_dianjishi_taskview.prefab",
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
			[1] = "ui/viewres/versionactivity_3_8/v3a8_dianjishi/v3a8_dianjishi_taskitem.prefab"
		}
	}
end

return VersionActivity3_8ViewDefine
