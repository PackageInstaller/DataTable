-- chunkname: @modules/logic/college/defines/CollegeViewDefine.lua

module("modules.logic.college.defines.CollegeViewDefine", package.seeall)

local CollegeViewDefine = class("CollegeViewDefine")

function CollegeViewDefine.init(module_views)
	module_views.CollegeMainView = {
		destroy = 0,
		container = "CollegeMainViewContainer",
		mainRes = "modules/college/ui/viewres/college_mainview.prefab",
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
			city = CollegeEnum.CityPrefabPath,
			city_low = CollegeEnum.CityLowPrefabPath,
			map = CollegeEnum.MapPrefabPath,
			mapbg = CollegeEnum.MapPrefabBgPath,
			currency = CollegeEnum.PrefabPath.Currency,
			flyEffect = CollegeEnum.PrefabPath.FlyEffect
		}
	}
	module_views.CollegeToastView = {
		destroy = 0,
		container = "CollegeToastViewContainer",
		mainRes = "modules/college/ui/viewres/college_maptipview.prefab",
		layer = "MESSAGE",
		viewType = ViewType.Normal
	}
	module_views.CollegeEnterAnimView = {
		destroy = 0,
		container = "CollegeEnterAnimViewContainer",
		maskAlpha = 0,
		mainRes = "modules/college/ui/viewres/college_entereffectview.prefab",
		layer = "TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.CollegeSwitchSceneAnimView = {
		destroy = 0,
		container = "CollegeSwitchSceneAnimViewContainer",
		maskAlpha = 0,
		mainRes = "modules/college/ui/viewres/college_switcheffectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.CollegeRoundEndAnimView = {
		destroy = 0,
		container = "CollegeRoundEndAnimViewContainer",
		mainRes = "modules/college/ui/viewres/college_switcheffectview_2.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.CollegeTaskView = {
		destroy = 0,
		container = "CollegeTaskViewContainer",
		bgBlur = 1,
		mainRes = "modules/college/ui/viewres/college_taskview.prefab",
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
	module_views.CollegeBuildingView = {
		destroy = 0,
		container = "CollegeBuildingViewContainer",
		mainRes = "modules/college/ui/viewres/college_bottominfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
	module_views.CollegeAreaView = {
		destroy = 0,
		container = "CollegeAreaViewContainer",
		mainRes = "modules/college/ui/viewres/college_bottominfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Internal
	}
	module_views.CollegeCurrencyTipsView = {
		destroy = 0,
		container = "CollegeCurrencyTipsViewContainer",
		mainRes = "modules/college/ui/viewres/college_currencytipsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.CollegeRoleBagView = {
		destroy = 0,
		container = "CollegeRoleBagViewContainer",
		bgBlur = 1,
		mainRes = "modules/college/ui/viewres/college_roleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			roleItem = CollegeEnum.PrefabPath.RoleItem,
			rolePanel = CollegeEnum.PrefabPath.RolePanel
		}
	}
	module_views.CollegeRoleDispatchView = tabletool.copy(module_views.CollegeRoleBagView)
	module_views.CollegeRoleDispatchView.container = "CollegeRoleDispatchViewContainer"
	module_views.CollegeRoleRefinedBagView = tabletool.copy(module_views.CollegeRoleBagView)
	module_views.CollegeRoleRefinedBagView.container = "CollegeRoleRefinedBagViewContainer"
	module_views.CollegeRoleRecruitView = {
		destroy = 0,
		container = "CollegeRoleRecruitViewContainer",
		bgBlur = 1,
		mainRes = "modules/college/ui/viewres/college_rolerecruitview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			roleItem = CollegeEnum.PrefabPath.RoleItem,
			rolePanel = CollegeEnum.PrefabPath.RolePanel
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.CollegeRoleGainView = {
		destroy = 0,
		container = "CollegeRoleGainViewContainer",
		bgBlur = 1,
		mainRes = "modules/college/ui/viewres/college_rolegainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			roleItem = CollegeEnum.PrefabPath.RoleItem,
			rolePanel = CollegeEnum.PrefabPath.RolePanel
		}
	}
	module_views.CollegeRoleRefinedView = {
		destroy = 0,
		container = "CollegeRoleRefinedViewContainer",
		bgBlur = 1,
		mainRes = "modules/college/ui/viewres/college_rolerefinedview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			roleItem = CollegeEnum.PrefabPath.RoleItem,
			rolePanel = CollegeEnum.PrefabPath.RolePanel
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.CollegeStatusView = {
		destroy = 0,
		container = "CollegeStatusViewContainer",
		maskAlpha = 0,
		mainRes = "modules/college/ui/viewres/college_statusview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.CollegeMilestoneView = {
		destroy = 0,
		container = "CollegeMilestoneViewContainer",
		mainRes = "modules/college/ui/viewres/college_milestoneview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		otherRes = {
			stoneItem = CollegeEnum.PrefabPath.MilestoneThemeItem
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.CollegeStoryView = {
		destroy = 0,
		container = "CollegeStoryViewContainer",
		mainRes = "modules/college/ui/viewres/college_storyview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal,
		otherRes = {
			CollegeEnum.MemoryMaskPath
		}
	}
	module_views.CollegeStoryView2 = {
		destroy = 0,
		container = "CollegeStoryView2Container",
		maskAlpha = 0,
		mainRes = "modules/college/ui/viewres/college_storyview2.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.CollegeOptionView = {
		destroy = 0,
		container = "CollegeOptionViewContainer",
		mainRes = "modules/college/ui/viewres/college_optionview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.CollegeRelationShipBoard = {
		destroy = 0,
		container = "CollegeRelationShipBoardContainer",
		mainRes = "modules/college/ui/viewres/college_relationshipboard.prefab",
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
					"modules/college/ui/viewres/college_relationshipboardpage.prefab"
				},
				{
					"modules/college/ui/viewres/college_relationshipboardpage2.prefab"
				}
			}
		},
		otherRes = {
			"ui/animations/dynamic/commandstation_boardeff.controller",
			"modules/college/ui/viewres/college_relationshipboardpage.prefab",
			"modules/college/ui/viewres/college_relationshipboardpage2.prefab"
		}
	}
	module_views.CollegeRelationShipDetail = {
		destroy = 0,
		container = "CollegeRelationShipDetailContainer",
		mainRes = "modules/college/ui/viewres/college_relationshipdetail.prefab",
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
	module_views.CollegeTeamDetailView = {
		destroy = 0,
		container = "CollegeTeamDetailViewContainer",
		bgBlur = 1,
		mainRes = "modules/college/ui/viewres/college_teamprofileview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
end

return CollegeViewDefine
