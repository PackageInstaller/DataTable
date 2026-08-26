-- chunkname: @modules/logic/versionactivity3_7/anniversary3/define/Anniversary3ViewDefine.lua

module("modules.logic.versionactivity3_7.anniversary3.define.Anniversary3ViewDefine", package.seeall)

local Anniversary3ViewDefine = {}

function Anniversary3ViewDefine.init(module_views)
	module_views.Anniversary3MainView = {
		destroy = 0,
		container = "Anniversary3MainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_mainview.prefab",
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
	module_views.Anniversary3MailView = {
		destroy = 0,
		container = "Anniversary3MailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_mailview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.Anniversary3SignView = {
		destroy = 0,
		container = "Anniversary3SignViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_signview.prefab",
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
	module_views.Anniversary3SignRoleTalkView = {
		bgBlur = 1,
		container = "Anniversary3SignRoleTalkViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_signroletalkview.prefab",
		destroy = 0,
		blurIterations = 2,
		blurFactor = 0.1,
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		desampleRate = PostProcessingMgr.DesamplingRate.x8,
		reduceRate = PostProcessingMgr.DesamplingRate.x8,
		otherRes = {
			[1] = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_signroletalkrewarditem.prefab"
		}
	}
	module_views.Anniversary3ActBpView = {
		destroy = 0,
		container = "Anniversary3ActBpViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_actbpview.prefab",
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
	module_views.Anniversary3ActBpPropView = {
		destroy = 0,
		container = "Anniversary3ActBpPropViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_actbppropview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.GuessGameMainView = {
		destroy = 0,
		container = "GuessGameMainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_mainview.prefab",
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
	module_views.GuessGamePlayView = {
		destroy = 0,
		container = "GuessGamePlayViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playnpcsview.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playgiftitem.prefab",
			[2] = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playroleitem.prefab"
		}
	}
	module_views.GuessGamePlayGiftGuessView = {
		bgBlur = 3,
		container = "GuessGamePlayGiftGuessViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playguessview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playtasktipview.prefab"
				}
			},
			{
				{
					"ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playnpcsview.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playgiftitem.prefab",
			[2] = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playroleitem.prefab"
		}
	}
	module_views.GuessGamePlayRoundTipsView = {
		destroy = 0,
		container = "GuessGamePlayRoundTipsViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playroundtipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.GuessGamePlayResultView = {
		bgBlur = 1,
		container = "GuessGamePlayResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_anniversary3/v3a7_anniversary3_guessgame_playresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

return Anniversary3ViewDefine
