-- chunkname: @modules/logic/versionactivity3_6/yami/define/V3a6YaMiViewDefine.lua

module("modules.logic.versionactivity3_6.yami.define.V3a6YaMiViewDefine", package.seeall)

local V3a6YaMiViewDefine = class("V3a6YaMiViewDefine")

function V3a6YaMiViewDefine.init(module_views)
	module_views.V3a6YaMiMainView = {
		destroy = 0,
		container = "V3a6YaMiMainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_mainview.prefab",
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
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_fundingitem
				}
			}
		},
		otherRes = {
			HeroEntity = V3a6YaMiEnum.ResPath.HeroEntity,
			AttrFloat = V3a6YaMiEnum.ResPath.AttrFloat,
			Talk = V3a6YaMiEnum.ResPath.Talk
		}
	}
	module_views.V3a6YaMiTaskView = {
		destroy = 0,
		container = "V3a6YaMiTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_taskview.prefab",
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
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_fundingitem
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_taskitem.prefab"
		}
	}
	module_views.V3a6YaMiProductHandbookView = {
		destroy = 0,
		container = "V3a6YaMiProductHandbookViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_encyclopediaview.prefab",
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
					"ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_productsdetailpanel.prefab"
				}
			},
			{
				{
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_fundingitem
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_productsitem.prefab"
		}
	}
	module_views.V3a6YaMiHeroHandbookView = {
		destroy = 0,
		container = "V3a6YaMiHeroHandbookViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_handbookview.prefab",
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
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeedetailpanel
				}
			},
			{
				{
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_fundingitem
				}
			}
		},
		otherRes = {
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeeitem
		}
	}
	module_views.V3a6YaMiProductView = {
		destroy = 0,
		container = "V3a6YaMiProductViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_choosematerialsview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Model,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_categoryitem
		}
	}
	module_views.V3a6YaMiPerformView = {
		destroy = 0,
		container = "V3a6YaMiPerformViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_performview.prefab",
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
			HeroEntity = V3a6YaMiEnum.ResPath.HeroEntity,
			AttrFloat = V3a6YaMiEnum.ResPath.AttrFloat,
			Talk = V3a6YaMiEnum.ResPath.Talk
		}
	}
	module_views.V3a6YaMiSelectHeroView = {
		destroy = 0,
		container = "V3a6YaMiSelectHeroViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_choosepersonview.prefab",
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
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeeitem,
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employee_ogitem
		}
	}
	module_views.V3a6YaMiSelectHeroHandbookView = {
		destroy = 0,
		container = "V3a6YaMiSelectHeroHandbookViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_handbookview2.prefab",
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
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeedetailpanel
				}
			},
			{
				{
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_fundingitem
				}
			}
		},
		otherRes = {
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeeitem
		}
	}
	module_views.V3a6YaMiConfirmSelectionView = {
		destroy = 0,
		container = "V3a6YaMiConfirmSelectionViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_confirmselectionview.prefab",
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
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeeitem,
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_categoryitem
		}
	}
	module_views.V3a6YaMiCutHeroView = {
		destroy = 0,
		container = "V3a6YaMiCutHeroViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_handbookinfopanel.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeedetailpanel
				}
			}
		}
	}
	module_views.V3a6YaMiSkillView = {
		destroy = 0,
		container = "V3a6YaMiSkillViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_handbookview.prefab",
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
					V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeedetailpanel
				}
			}
		},
		otherRes = {
			V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeeitem
		}
	}
	module_views.V3a6YaMiEvaluationView = {
		destroy = 0,
		container = "V3a6YaMiEvaluationViewContainer",
		mainRes = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_evaluationresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

return V3a6YaMiViewDefine
