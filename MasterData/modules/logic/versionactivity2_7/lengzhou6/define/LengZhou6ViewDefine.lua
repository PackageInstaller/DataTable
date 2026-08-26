-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/define/LengZhou6ViewDefine.lua

module("modules.logic.versionactivity2_7.lengzhou6.define.LengZhou6ViewDefine", package.seeall)

local LengZhou6ViewDefine = class("LengZhou6ViewDefine")

function LengZhou6ViewDefine.init(module_views)
	module_views.LengZhou6TaskView = {
		destroy = 0,
		container = "LengZhou6TaskViewContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_taskview.prefab",
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
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_taskitem.prefab"
		}
	}
	module_views.LengZhou6GameView = {
		destroy = 0,
		container = "LengZhou6GameViewContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_gameview.prefab",
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
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_skillitem.prefab",
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_selectskillitem.prefab",
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_buffitem.prefab",
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_effectitem.prefab"
		}
	}
	module_views.LengZhou6GameResult = {
		destroy = 0,
		container = "LengZhou6GameResultContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_resultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		otherRes = {
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_resultview.prefab"
		}
	}
	module_views.LengZhou6LevelView = {
		destroy = 0,
		container = "LengZhou6LevelViewContainer",
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_levelview.prefab",
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
			"ui/viewres/versionactivity_2_7/v2a7_hissabeth/v2a7_hissabeth_levelitem.prefab"
		}
	}
end

return LengZhou6ViewDefine
