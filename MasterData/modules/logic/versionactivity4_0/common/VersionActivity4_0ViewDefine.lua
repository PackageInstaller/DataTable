-- chunkname: @modules/logic/versionactivity4_0/common/VersionActivity4_0ViewDefine.lua

module("modules.logic.versionactivity4_0.common.VersionActivity4_0ViewDefine", package.seeall)

local VersionActivity4_0ViewDefine = class("VersionActivity4_0ViewDefine")

function VersionActivity4_0ViewDefine.init(module_views)
	VersionActivity4_0ViewDefine.initEnter(module_views)
	VersionActivity4_0ViewDefine.initDeleike(module_views)
	VersionActivity4_0ViewDefine.initSpLilya(module_views)
end

function VersionActivity4_0ViewDefine.initSpLilya(module_views)
	module_views.SpLilyaLevelView = {
		destroy = 0,
		container = "SpLilyaLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_hongnujian/v4a0_hongnujian_levelview.prefab",
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
			[1] = "ui/viewres/versionactivity_4_0/v4a0_hongnujian/v4a0_hongnujian_levelitem.prefab"
		}
	}
	module_views.SpLilyaTaskView = {
		bgBlur = 0,
		container = "SpLilyaTaskViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_hongnujian/v4a0_hongnujian_taskview.prefab",
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
			[1] = "ui/viewres/versionactivity_4_0/v4a0_hongnujian/v4a0_hongnujian_taskitem.prefab"
		}
	}
	module_views.SpLilyaGameView = {
		destroy = 0,
		container = "SpLilyaGameViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_fightview.prefab",
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
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_spiritslider.prefab",
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_hnjslider.prefab",
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_bullet.prefab",
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_enemy_bar.prefab",
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_enemy_aim.prefab",
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/skill_hongnujian_boom1.prefab",
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/skill_hongnujian_boom2.prefab",
			"ui/animations/dynamic/v4a0_monster_action.controller",
			"ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_fight_damage.prefab",
			"ui/viewres/pc/pcbuttonitem.prefab"
		}
	}
	module_views.SpLilyaGameTipView = {
		destroy = 0,
		container = "SpLilyaGameTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_hongnujian/fight/v4a0_hongnujian_bosstipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.SpLilyaGameResultView = {
		destroy = 0,
		container = "SpLilyaGameResultViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_hongnujian/v4a0_hongnujian_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

function VersionActivity4_0ViewDefine.initEnter(module_views)
	module_views.VersionActivity4_0EnterView = {
		destroy = 0,
		container = "VersionActivity4_0EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_enter/v4a0_enterview.prefab",
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
					"ui/viewres/versionactivity_4_0/v4a0_enter/v4a0_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_4_0/v4a0_matchgame/v4a0_matchgame_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_4_0/v4a0_autochess/v4a0_autochess_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_4_0/v4a0_hongnujian/v4a0_hongnujian_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_enterview.prefab"
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
		}
	}
end

function VersionActivity4_0ViewDefine.initDeleike(module_views)
	module_views.DeleikeGameView = {
		destroy = 0,
		container = "DeleikeGameViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_gameview.prefab",
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
			DeleikeEnum.GameScenePath
		}
	}
	module_views.DeleikeLevelView = {
		destroy = 0,
		container = "DeleikeLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_levelview.prefab",
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
			[1] = "ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_levelitem.prefab"
		}
	}
	module_views.DeleikeTaskView = {
		bgBlur = 0,
		container = "DeleikeTaskViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_taskview.prefab",
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
			[1] = "ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_taskitem.prefab"
		}
	}
	module_views.DeleikeGameResultView = {
		destroy = 0,
		container = "DeleikeGameResultViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
end

return VersionActivity4_0ViewDefine
