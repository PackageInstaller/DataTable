-- chunkname: @modules/logic/sp02/atomic/define/AtomicViewDefine.lua

module("modules.logic.sp02.atomic.define.AtomicViewDefine", package.seeall)

local AtomicViewDefine = {}

function AtomicViewDefine.init(module_views)
	module_views.AtomicCultivateView = {
		destroy = 0,
		container = "AtomicCultivateViewContainer",
		mainRes = "ui/viewres/sp02/atomicforyou/sp02_atomicforyou_cultivateview.prefab",
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
			"ui/viewres/sp02/atomicforyou/sp02_atomicforyou_cultivateskillitem.prefab"
		}
	}
	module_views.AtomicDataBaseView = {
		destroy = 0,
		container = "AtomicDataBaseViewContainer",
		mainRes = "ui/viewres/sp02/atomicforyou/sp02_atomicforyou_databaseview.prefab",
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
	module_views.AtomicDataBaseInfoView = {
		destroy = 0,
		container = "AtomicDataBaseInfoViewContainer",
		mainRes = "ui/viewres/sp02/atomicforyou/sp02_atomicforyou_cultureinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.AtomicOperationActivityEnterView = {
		destroy = 0,
		container = "AtomicOperationActivityEnterViewContainer",
		mainRes = "ui/viewres/activity/sp02_activityenterview.prefab",
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
	module_views.AtomicOperationActivityTaskView = {
		destroy = 0,
		container = "AtomicOperationActivityTaskViewContainer",
		mainRes = "ui/viewres/activity/sp02_activitytaskview.prefab",
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
			"ui/viewres/activity/sp02_activitytaskitem.prefab"
		}
	}
	module_views.AtomicOperationActivityGameMainView = {
		destroy = 0,
		container = "AtomicOperationActivityGameMainViewContainer",
		mainRes = "ui/viewres/activity/sp02_activitygamestartview.prefab",
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
	module_views.AtomicOperationActivityPreparationView = {
		destroy = 0,
		container = "AtomicOperationActivityPreparationViewContainer",
		mainRes = "ui/viewres/activity/sp02_activitygametalentview.prefab",
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
	module_views.AtomicOperationActivityGameView = {
		destroy = 0,
		container = "AtomicOperationActivityGameViewContainer",
		mainRes = "ui/viewres/activity/sp02_activitygameview.prefab",
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
	module_views.AtomicOperationActivityGameCountDownView = {
		destroy = 0,
		container = "AtomicOperationActivityGameCountDownViewContainer",
		mainRes = "ui/viewres/activity/sp02_activitygamestartui.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AtomicOperationActivityResultGameView = {
		destroy = 0,
		container = "AtomicOperationActivityResultGameViewContainer",
		mainRes = "ui/viewres/activity/sp02_activitygameresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AtomicRewardView = {
		destroy = 0,
		container = "AtomicRewardViewContainer",
		maskAlpha = 0,
		mainRes = "ui/viewres/sp02/atomicforyou/sp02_atomicforyou_rewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			itemRes = "ui/viewres/sp02/atomicforyou/sp02_atomicforyou_rewarditem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.AtomicOperationActivityGameTipView = {
		destroy = 0,
		container = "AtomicOperationActivityGameTipViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/sp02_activitygameinstruction.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AtomicOperationActivityEnterPatFaceView = {
		destroy = 0,
		container = "AtomicOperationActivityEnterPatFaceViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/sp02_activityenterpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.AtomicAvgPlayView = {
		destroy = 0,
		container = "AtomicAvgPlayViewContainer",
		mainRes = "ui/viewres/sp02/dungeon/sp02_atomic_avg_view.prefab",
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
end

return AtomicViewDefine
