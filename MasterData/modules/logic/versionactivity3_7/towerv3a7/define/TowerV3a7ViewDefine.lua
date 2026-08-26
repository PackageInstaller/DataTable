-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/define/TowerV3a7ViewDefine.lua

module("modules.logic.versionactivity3_7.towerv3a7.define.TowerV3a7ViewDefine", package.seeall)

local TowerV3a7ViewDefine = {}

function TowerV3a7ViewDefine.init(module_views)
	module_views.TowerV3a7MapView = {
		destroy = 0,
		container = "TowerV3a7MapViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_tower/v3a7_towermapview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		otherRes = {
			roomItem = "ui/viewres/versionactivity_3_7/v3a7_tower/v3a7_towerroomitem.prefab",
			combatItem = "ui/viewres/versionactivity_3_7/v3a7_tower/v3a7_towercombatitem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.TowerV3a7MainView = {
		destroy = 0,
		container = "TowerV3a7MainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_tower/v3a7_towerfightreview.prefab",
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
end

return TowerV3a7ViewDefine
