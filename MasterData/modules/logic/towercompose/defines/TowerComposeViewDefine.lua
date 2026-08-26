-- chunkname: @modules/logic/towercompose/defines/TowerComposeViewDefine.lua

module("modules.logic.towercompose.defines.TowerComposeViewDefine", package.seeall)

local TowerComposeViewDefine = {}

function TowerComposeViewDefine.init(module_views)
	module_views.TowerMainSelectView = {
		destroy = 0,
		container = "TowerMainSelectViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towermainselectview.prefab",
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
	module_views.TowerComposeThemeView = {
		destroy = 0,
		container = "TowerComposeThemeViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposethemeview.prefab",
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
			[1] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerModeChangeView = {
		destroy = 0,
		container = "TowerModeChangeViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towermodechangeview.prefab",
		layer = "GUIDE",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.TowerComposeMainView = {
		destroy = 0,
		container = "TowerComposeMainViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposemainview.prefab",
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
	module_views.TowerComposeEnvView = {
		destroy = 0,
		container = "TowerComposeEnvViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/tower/towercompose/towercomposeenvview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.TowerComposeRoleView = {
		destroy = 0,
		container = "TowerComposeRoleViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/tower/towercompose/towercomposeroleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.TowerComposeResultView = {
		bgBlur = 3,
		container = "TowerComposeResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/tower/towercompose/towercompose_resultview.prefab",
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
			[1] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerComposeNormalResultView = {
		bgBlur = 3,
		container = "TowerComposeNormalResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/tower/towercompose/towercompose_resultview2.prefab",
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
			[1] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerComposeResearchView = {
		destroy = 0,
		container = "TowerComposeResearchViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposeresearchview.prefab",
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
			[1] = "ui/viewres/tower/towercompose/towercomposeresearchitem.prefab"
		}
	}
	module_views.TowerComposeTaskView = {
		destroy = 0,
		container = "TowerComposeTaskViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposetaskview.prefab",
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
			[1] = "ui/viewres/tower/towercompose/towercomposetaskitem.prefab"
		}
	}
	module_views.TowerComposeModEquipView = {
		destroy = 0,
		container = "TowerComposeModEquipViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposemodequipview.prefab",
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
			[1] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerComposeHeroGroupBuffView = {
		destroy = 0,
		container = "TowerComposeHeroGroupBuffViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/tower/towercompose/towercomposeherogroupbuffview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.TowerComposeHeroGroupView = {
		bgBlur = 4,
		container = "TowerComposeHeroGroupViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/tower/towercompose/towercomposeherogroupview.prefab",
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
			[1] = "ui/viewres/fight/clothskill.prefab",
			[2] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerComposeModTipView = {
		destroy = 0,
		container = "TowerComposeModTipViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposemodtipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerComposeHeroGroupEditView = {
		container = "TowerComposeHeroGroupEditViewContainer",
		destroy = 5,
		mainRes = "ui/viewres/herogroup/herogroupeditview.prefab",
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
			[1] = "ui/viewres/tower/towercompose/towercomposeherogroupedititem.prefab",
			[2] = "ui/viewres/tower/towercompose/towercomposeherogroupquickedititem.prefab"
		},
		customAnimBg = {
			"bg"
		}
	}
	module_views.TowerComposePlayerClothView = {
		bgBlur = 1,
		container = "TowerComposePlayerClothViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/player/playerclothview.prefab",
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
		customAnimBg = {
			"frame/imgBg",
			"titlebg"
		}
	}
	module_views.FightSwitchPlaneView = {
		destroy = 0,
		container = "FightSwitchPlaneViewContainer",
		mainRes = "ui/viewres/tower/towercompose/toweradvancedsecondplanestart.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.TowerComposeModDescTipView = {
		destroy = 0,
		container = "TowerComposeModDescTipViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposemoddesctipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerComposeExtraTips = {
		destroy = 0,
		container = "TowerComposeExtraTipsContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposeextratips.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.TowerComposeSaveView = {
		destroy = 0,
		container = "TowerComposeSaveViewContainer",
		bgBlur = 3,
		mainRes = "ui/viewres/tower/towercompose/towercomposesaveview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/spriteassets/tower2.asset"
		}
	}
	module_views.TowerComposePickAssistView = {
		destroy = 0,
		container = "TowerComposePickAssistViewContainer",
		mainRes = "ui/viewres/tower/towercompose/towercomposeassistview.prefab",
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
			[1] = "ui/viewres/tower/towercompose/towercomposeassistitem.prefab"
		}
	}
end

return TowerComposeViewDefine
