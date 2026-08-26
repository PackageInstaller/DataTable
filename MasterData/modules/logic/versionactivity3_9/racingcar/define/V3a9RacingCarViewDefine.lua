-- chunkname: @modules/logic/versionactivity3_9/racingcar/define/V3a9RacingCarViewDefine.lua

module("modules.logic.versionactivity3_9.racingcar.define.V3a9RacingCarViewDefine", package.seeall)

local V3a9RacingCarViewDefine = class("V3a9RacingCarViewDefine")

function V3a9RacingCarViewDefine.init(module_views)
	module_views.V3a9RacingCarMainView = {
		destroy = 0,
		container = "V3a9RacingCarMainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_mainview.prefab",
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
			sectionitem = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_mainsectionitem.prefab"
		}
	}
	module_views.V3a9RacingCarRecordView = {
		destroy = 0,
		container = "V3a9RacingCarRecordViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_recordview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			recorditem = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_recorditem.prefab"
		}
	}
	module_views.V3a9RacingCarResultView = {
		destroy = 0,
		container = "V3a9RacingCarResultViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.V3a9RacingCarGameView = {
		destroy = 0,
		container = "V3a9RacingCarGameViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_gameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.HUD,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.V3a9RacingCarRoleListView = {
		destroy = 0,
		container = "V3a9RacingCarRoleListViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_rolelistview.prefab",
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
			itemRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_rolelistitem.prefab"
		}
	}
	module_views.V3a9RacingTalentView = {
		destroy = 0,
		container = "V3a9RacingTalentViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_talentview.prefab",
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
					"ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_talentpanel.prefab"
				},
				{
					"ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_rolepanel.prefab"
				}
			}
		},
		otherRes = {
			itemRes = "ui/viewres/versionactivity_3_9/v3a9_game/racing/v3a9_racing_rolelistitem.prefab"
		}
	}
	module_views.V3a9RacingRewardView = {
		bgBlur = 1,
		container = "V3a9RacingRewardViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/v3a9_game_rewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			itemRes = "ui/viewres/versionactivity_3_9/v3a9_game/v3a9_game_rewarditem.prefab"
		}
	}
	module_views.V3a9RacingCarLoadingView = {
		destroy = 0,
		container = "V3a9RacingCarLoadingViewContainer",
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_game/v3a9_game_loadingview.prefab",
		layer = "TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

return V3a9RacingCarViewDefine
