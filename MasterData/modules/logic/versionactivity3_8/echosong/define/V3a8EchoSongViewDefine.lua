-- chunkname: @modules/logic/versionactivity3_8/echosong/define/V3a8EchoSongViewDefine.lua

module("modules.logic.versionactivity3_8.echosong.define.V3a8EchoSongViewDefine", package.seeall)

local V3a8EchoSongViewDefine = class("V3a8EchoSongViewDefine")

function V3a8EchoSongViewDefine.init(module_views)
	module_views.V3a8EchoSongLevelView = {
		destroy = 0,
		container = "V3a8EchoSongLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/view/v3a8_huishengyao_levelview.prefab",
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
			[1] = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/view/v3a8_huishengyao_levelitem.prefab"
		}
	}
	module_views.V3a8EchoSongGameView = {
		destroy = 0,
		container = "V3a8EchoSongGameViewContainer",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_gameview.prefab",
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
			ballItem = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_ballitem.prefab",
			roleItem = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_game_roleitem.prefab",
			bg2 = "singlebg/v3a8_huishengyao_singlebg/v3a8_huishengyao_game_fullbg2.png",
			event2Mask = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_gameview_event_2.prefab",
			switchEvent = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_game_switchevent.prefab",
			endItem = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_game_enditem.prefab",
			trapMask = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_gameview_trap.prefab",
			hitBallItem = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_hitballitem.prefab",
			sceneBg = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_background.prefab",
			lockItem = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_game_lockitem.prefab",
			enemyItem = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_game_enemyitem.prefab",
			bg1 = "singlebg/v3a8_huishengyao_singlebg/v3a8_huishengyao_game_fullbg1.png",
			event1Mask = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/map/v3a8_huishengyao_gameview_event_1.prefab"
		},
		preloader = module_views_preloader
	}
	module_views.V3a8EchoSongResultView = {
		destroy = 0,
		container = "V3a8EchoSongResultViewContainer",
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/view/v3a8_huishengyao_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full
	}
	module_views.V3a8EchoSongTaskView = {
		bgBlur = 0,
		container = "V3a8EchoSongTaskViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/view/v3a8_huishengyao_taskview.prefab",
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
			[1] = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/view/v3a8_huishengyao_taskitem.prefab"
		}
	}
end

return V3a8EchoSongViewDefine
