-- chunkname: @modules/logic/matchgame/defines/MatchGameViewDefine.lua

module("modules.logic.matchgame.defines.MatchGameViewDefine", package.seeall)

local MatchGameViewDefine = {}

function MatchGameViewDefine.init(module_views)
	module_views.MatchGameFightView = {
		destroy = 0,
		container = "MatchGameFightViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamefightview.prefab",
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
			"modules/matchgame/ui/viewres/matchgame/skill/matchgame_item_effect.prefab",
			"ui/materials/dynamic/outlinesprite_lw_ui_doubleline_inside.mat",
			Clean = "modules/matchgame/ui/viewres/matchgame/skill/matchgame_hero_cleanse.prefab",
			NormalDamage = "modules/matchgame/ui/viewres/matchgame/skill/matchgame_hero_bomb_light.prefab",
			HeavyDamage = "modules/matchgame/ui/viewres/matchgame/skill/matchgame_hero_bomb_heavy.prefab",
			Heal = "modules/matchgame/ui/viewres/matchgame/skill/matchgame_hero_heal.prefab",
			Lock = "modules/matchgame/ui/viewres/matchgame/skill/matchgame_hero_lock.prefab",
			Poison = "modules/matchgame/ui/viewres/matchgame/skill/matchgame_hero_poison.prefab"
		}
	}
	module_views.MatchGameFightQuitTipView = {
		destroy = 0,
		container = "MatchGameFightQuitTipViewContainer",
		bgBlur = 1,
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamefightquittipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.MatchGameEnterView = {
		destroy = 0,
		container = "MatchGameEnterViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgameenterview.prefab",
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
	module_views.MatchGameMapView = {
		destroy = 0,
		container = "MatchGameMapViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamemapview.prefab",
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
			"modules/matchgame/ui/viewres/matchgame/matchgame_map_floor_1.prefab",
			"modules/matchgame/ui/viewres/matchgame/matchgame_map_floor_2.prefab",
			"modules/matchgame/ui/viewres/matchgame/matchgame_map_floor_3.prefab",
			"modules/matchgame/ui/viewres/matchgame/matchgame_map_floor_4.prefab",
			"modules/matchgame/ui/viewres/matchgame/matchgame_map_floor_5.prefab",
			RewardItem = MatchGameEnum.MapRewardItemPrefabPath
		}
	}
	module_views.MatchGameChallengeMapView = {
		destroy = 0,
		container = "MatchGameChallengeMapViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamechallengemapview.prefab",
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
	module_views.MatchGamePassMapView = {
		destroy = 0,
		container = "MatchGamePassMapViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamesuccessview.prefab",
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
	module_views.MatchGameRewardView = {
		destroy = 0,
		container = "MatchGameRewardViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamerewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.MatchGameChallengeRewardView = {
		destroy = 0,
		container = "MatchGameChallengeRewardViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamechallengerewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.MatchGameCharacterView = {
		destroy = 0,
		container = "MatchGameCharacterViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamecharacterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				[MatchGameEnum.CharacterTabType.Develop] = {
					"modules/matchgame/ui/viewres/matchgame/matchgamedevelopview.prefab"
				},
				[MatchGameEnum.CharacterTabType.Talent] = {
					"modules/matchgame/ui/viewres/matchgame/matchgametalentview.prefab"
				}
			}
		}
	}
	module_views.MatchGameResultView = {
		destroy = 0,
		container = "MatchGameResultViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgameresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			MatchGameEnum.MapRewardItemPrefabPath
		}
	}
	module_views.MatchGameChallengeResultView = {
		destroy = 0,
		container = "MatchGameChallengeResultViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamechallengeresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.MatchGameMemberInfoView = {
		destroy = 0,
		container = "MatchGameMemberInfoViewContainer",
		bgBlur = 1,
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamememberinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/materials/dynamic/outlinesprite_lw_ui_doubleline_inside.mat"
		}
	}
	module_views.MatchGameHeroGroupView = {
		destroy = 0,
		container = "MatchGameHeroGroupViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgameherogroupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			heroItemRes = MatchGameEnum.CommonHeroCardItemPrefabPath
		}
	}
	module_views.MatchGameHeroGroupEditView = {
		destroy = 0,
		container = "MatchGameHeroGroupEditViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgameherogroupeditview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			heroItemRes = MatchGameEnum.CommonHeroCardItemPrefabPath
		}
	}
	module_views.MatchGameItemTipView = {
		destroy = 0,
		container = "MatchGameItemTipViewContainer",
		bgBlur = 1,
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgameitemtipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.MatchGameCareerTipView = {
		destroy = 0,
		container = "MatchGameCareerTipViewContainer",
		bgBlur = 2,
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamecareertipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.MatchGameTalentTipView = {
		destroy = 0,
		container = "MatchGameTalentTipViewContainer",
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgametalenttipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.MatchGameCharacterGainView = {
		destroy = 0,
		container = "MatchGameCharacterGainViewContainer",
		bgBlur = 1,
		mainRes = "modules/matchgame/ui/viewres/matchgame/matchgamecharactergainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
end

return MatchGameViewDefine
