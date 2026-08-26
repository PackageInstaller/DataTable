-- chunkname: @modules/logic/commandstation/define/CommandStationViewDefine.lua

module("modules.logic.commandstation.define.CommandStationViewDefine", package.seeall)

local CommandStationViewDefine = {}

function CommandStationViewDefine.init(module_views)
	module_views.CommandStationEnterView = {
		destroy = 0,
		container = "CommandStationEnterViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_enterview.prefab",
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
			"singlebg/commandstation/enter/commandstation_enter_fullbg.png",
			"singlebg/commandstation/enter/commandstation_enter_mask.png",
			"singlebg/commandstation/enter/commandstation_enter_decbg.png",
			"ui/spriteassets/sp_commandstation.asset"
		}
	}
	module_views.CommandStationPaperView = {
		destroy = 0,
		container = "CommandStationPaperViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_paperview.prefab",
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
			"singlebg/commandstation/paper/commandstation_paper_fullbg.png"
		}
	}
	module_views.CommandStationPaperGetView = {
		bgBlur = 4,
		container = "CommandStationPaperGetViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/commandstation/commandstation_getdiskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.CommandStationPaperGetRewardView = {
		bgBlur = 4,
		container = "CommandStationPaperGetRewardViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/commandstation/commandstation_getdiskview2.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.CommandStationTaskView = {
		destroy = 0,
		container = "CommandStationTaskViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_taskview.prefab",
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
			"ui/viewres/commandstation/commandstation_taskitem.prefab"
		},
		preloader = module_views_preloader
	}
	module_views.CommandStationDispatchEventMainView = {
		destroy = 0,
		container = "CommandStationDispatchEventMainViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_dispatcheventmainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/commandstation/commandstation_dispatcheventprocessheroitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/commandstation/commandstation_dispatcheventnormalview.prefab"
				},
				{
					"ui/viewres/commandstation/commandstation_dispatcheventprocessview.prefab"
				}
			}
		}
	}
	module_views.CommandStationCharacterEventView = {
		destroy = 0,
		container = "CommandStationCharacterEventViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_charactereventview.prefab",
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
	module_views.CommandStationDialogueEventView = {
		destroy = 0,
		container = "CommandStationDialogueEventViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_dialogueeventview.prefab",
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
	module_views.CommandStationMapView = {
		container = "CommandStationMapViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/commandstation/commandstation_mapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/viewres/commandstation/commandstation_mapitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		preloader = module_views_preloader
	}
	module_views.CommandStationTimelineEventView = {
		destroy = 0,
		container = "CommandStationTimelineEventViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_timelineeventview.prefab",
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
	module_views.CommandStationDetailView = {
		destroy = 0,
		container = "CommandStationDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/commandstation/commandstation_timedetailpanel.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
	module_views.CommandStationEnterAnimView = {
		destroy = 0,
		container = "CommandStationEnterAnimViewContainer",
		mainRes = "ui/viewres/commandstation/commandstation_enteranimview.prefab",
		layer = "POPUP_SECOND",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal,
		otherRes = {
			[1] = "ui/animations/dynamic/commandstation_enter.controller",
			[2] = "ui/spriteassets/sp_commandstation.asset"
		}
	}
	module_views.CommandStationRelationShipBoard = {
		destroy = 0,
		container = "CommandStationRelationShipBoardContainer",
		mainRes = "ui/viewres/commandstation/commandstation_relationshipboard.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/commandstation/commandstation_relationshipboardpage.prefab"
				},
				{
					"ui/viewres/commandstation/commandstation_relationshipboardpage2.prefab"
				}
			}
		},
		otherRes = {
			"ui/animations/dynamic/commandstation_boardeff.controller",
			"ui/viewres/commandstation/commandstation_relationshipboardpage.prefab",
			"ui/viewres/commandstation/commandstation_relationshipboardpage2.prefab"
		}
	}
	module_views.CommandStationRelationShipDetail = {
		destroy = 0,
		container = "CommandStationRelationShipDetailContainer",
		mainRes = "ui/viewres/commandstation/commandstation_relationshipdetail.prefab",
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
	module_views.CommandStationMapDisplayView = {
		destroy = 0,
		container = "CommandStationMapDisplayViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/commandstation/commandstation_mapdisplayview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			[1] = "ui/viewres/commandstation/commandstation_mapitem.prefab"
		},
		preloader = module_views_preloader
	}
	module_views.CommandStationTeamDetailView = {
		destroy = 0,
		container = "CommandStationTeamDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/commandstation/commandstation_teamprofileview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
end

return CommandStationViewDefine
