-- chunkname: @modules/logic/sp02/dungeonmap/define/AtomicDungeonMapViewDefine.lua

module("modules.logic.sp02.dungeonmap.define.AtomicDungeonMapViewDefine", package.seeall)

local AtomicDungeonMapViewDefine = {}

function AtomicDungeonMapViewDefine.init(module_views)
	module_views.AtomicLineGameView = {
		destroy = 0,
		container = "AtomicLineGameViewContainer",
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicheart_linegameview.prefab",
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
	module_views.AtomicColorGameView = {
		destroy = 0,
		container = "AtomicColorGameViewContainer",
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicheart_colorgameview.prefab",
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
	module_views.AtomicRhythmGameView = {
		destroy = 0,
		container = "AtomicRhythmGameViewContainer",
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicheart_rhythmgameview.prefab",
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
	module_views.AtomicDungeonMainView = {
		destroy = 0,
		container = "AtomicDungeonMainViewContainer",
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_mainview.prefab",
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
			"ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_element.prefab",
			"ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_polygonelement.prefab",
			"ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_mapdirection.prefab",
			"ui/animations/dynamic/atomic_mapselect.controller",
			"ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_sceneroot.prefab",
			"scenes/sp02_m_s20_zthd/prefab/sp02_m_s20_zthd_sky_p.prefab",
			"scenes/sp02_m_s20_zthd/prefab/sp02_m_s20_zthd_dofmask.prefab"
		}
	}
	module_views.AtomicDungeonInteractView = {
		destroy = 0,
		container = "AtomicDungeonInteractViewContainer",
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_interactview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.AtomicDungeonPolygonSelectView = {
		destroy = 0,
		container = "AtomicDungeonPolygonSelectViewContainer",
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_polygonselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_10EnterView = {
		destroy = 0,
		container = "VersionActivity3_10EnterViewContainer",
		mainRes = "ui/viewres/sp02/sp02_enterview.prefab",
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
	module_views.VersionActivity3_10DungeonMapView = {
		destroy = 0,
		container = "VersionActivity3_10DungeonMapViewContainer",
		mainRes = "ui/viewres/sp02/dungeon/sp02_dungeonmapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/sp02/dungeon/sp02_mapepisodeitem.prefab",
			"ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab",
			"ui/viewres/dungeon/chaptermap/map_direction.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.VersionActivity3_10StoreView = {
		destroy = 0,
		container = "VersionActivityFixedStoreViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/sp02/dungeon/sp02_storeview.prefab",
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
	module_views.VersionActivity3_10DungeonMapLevelView = {
		destroy = 0,
		container = "VersionActivityFixedDungeonMapLevelViewContainer",
		mainRes = "ui/viewres/sp02/dungeon/sp02_dungeonmaplevelview.prefab",
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
	module_views.VersionActivity3_10TaskView = {
		destroy = 0,
		container = "VersionActivityFixedTaskViewContainer",
		mainRes = "ui/viewres/sp02/dungeon/sp02_taskview.prefab",
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
			"ui/viewres/sp02/dungeon/sp02_taskitem.prefab"
		}
	}
	module_views.AtomicDungeonHeroGroupView = {
		bgBlur = 4,
		container = "AtomicDungeonHeroGroupViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_herogroupview.prefab",
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
	module_views.AtomicDungeonTaskView = {
		destroy = 0,
		container = "AtomicDungeonTaskViewContainer",
		mainRes = "ui/viewres/sp02/dungeon/sp02_atomicdungeon_taskview.prefab",
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
			[1] = "ui/viewres/sp02/dungeon/sp02_atomicdungeon_taskitem.prefab"
		}
	}
	module_views.AtomicDataBaseToastView = {
		destroy = 0,
		container = "AtomicDataBaseToastViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/sp02/dungeon/sp02_atomicdungeon_dataview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.AtomicDungeonHardFightResultView = {
		destroy = 0,
		container = "AtomicDungeonHardFightResultViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.AtomicDungeonPolygonInteractView = tabletool.copy(module_views.AtomicDungeonInteractView)
	module_views.AtomicDungeonPolygonInteractView.mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_polygoninteractview.prefab"
	module_views.AtomicDungeonPolygonSuccView = {
		destroy = 0,
		container = "AtomicDungeonPolygonSuccViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/sp02/dungeonmap/sp02_atomicdungeon_polygonsuccview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.AtomicDungeonFightSuccView = tabletool.copy(module_views.FightSuccView)
	module_views.AtomicDungeonFightSuccView.container = "AtomicDungeonFightSuccViewContainer"
	module_views.V3A10_HeroGroupFightView = {
		bgBlur = 4,
		container = "V3A10_HeroGroupFightViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/sp02/dungeon/sp02_herogroupview.prefab",
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
	module_views.V3A10_FightSuccView = {
		destroy = 0,
		container = "V3A10_FightSuccViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/sp02/dungeon/sp02_fightsuccview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
end

return AtomicDungeonMapViewDefine
