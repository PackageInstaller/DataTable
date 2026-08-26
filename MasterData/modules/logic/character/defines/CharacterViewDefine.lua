-- chunkname: @modules/logic/character/defines/CharacterViewDefine.lua

module("modules.logic.character.defines.CharacterViewDefine", package.seeall)

local CharacterViewDefine = {}

function CharacterViewDefine.init(module_views)
	module_views.CharacterSkillTalentView = {
		destroy = 0,
		container = "CharacterSkillTalentViewContainer",
		mainRes = "ui/viewres/character/extra/characterskilltalentview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.CharacterWeaponView = {
		destroy = 0,
		container = "CharacterWeaponViewContainer",
		mainRes = "ui/viewres/character/extra/characterweaponview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.CharacterWeaponEffectView = {
		bgBlur = 1,
		container = "CharacterWeaponEffectViewContainer",
		mainRes = "ui/viewres/character/extra/characterweaponeffectview.prefab",
		destroy = 0,
		blurIterations = 3,
		blurFactor = 0.85,
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8
	}
	module_views.CharacterRecommedView = {
		destroy = 0,
		container = "CharacterRecommedViewContainer",
		mainRes = "ui/viewres/character/recommed/characterrecommendview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			"ui/viewres/character/recommed/recommedgroupitem.prefab",
			"ui/viewres/character/recommed/goalsitem.prefab",
			"ui/viewres/character/recommed/heroitem.prefab",
			"ui/viewres/character/recommed/equipicon.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					[1] = "ui/viewres/character/recommed/recommedgroupview.prefab"
				},
				{
					[1] = "ui/viewres/character/recommed/goalsview.prefab"
				}
			},
			{
				{
					[1] = "ui/viewres/character/recommed/changeheroview.prefab"
				}
			}
		}
	}
end

return CharacterViewDefine
