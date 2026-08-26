-- chunkname: @modules/logic/versionactivity2_6/dicehero/defines/DiceHeroViewDefine.lua

module("modules.logic.versionactivity2_6.dicehero.defines.DiceHeroViewDefine", package.seeall)

local DiceHeroViewDefine = {}

function DiceHeroViewDefine.init(module_views)
	module_views.DiceHeroTaskView = {
		destroy = 0,
		container = "DiceHeroTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_taskview.prefab",
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
			"ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_taskitem.prefab"
		}
	}
	module_views.DiceHeroResultView = {
		destroy = 0,
		container = "DiceHeroResultViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_gameresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.DiceHeroTalkView = {
		destroy = 0,
		container = "DiceHeroTalkViewContainer",
		mainRes = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_talkview.prefab",
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
	module_views.DiceHeroGameView = {
		destroy = 0,
		container = "DiceHeroGameViewContainer",
		mainRes = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_gameview.prefab",
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
			effect = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_effectview.prefab",
			roleinfoitem = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_roleinfoitem.prefab",
			diceitem = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_diceitem.prefab"
		}
	}
	module_views.DiceHeroMainView = {
		destroy = 0,
		container = "DiceHeroMainViewContainer",
		mainRes = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_mainview.prefab",
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
	module_views.DiceHeroLevelView = {
		destroy = 0,
		container = "DiceHeroLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_levelview.prefab",
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
			roleinfoitem = "ui/viewres/versionactivity_2_6/dicehero/v2a6_dicehero_roleinfoitem.prefab"
		}
	}
end

return DiceHeroViewDefine
