-- chunkname: @modules/logic/versionactivity3_7/common/VersionActivity3_7ViewDefine.lua

module("modules.logic.versionactivity3_7.common.VersionActivity3_7ViewDefine", package.seeall)

local VersionActivity3_7ViewDefine = class("VersionActivity3_7ViewDefine")

function VersionActivity3_7ViewDefine.init(module_views)
	VersionActivity3_7ViewDefine.initEnter(module_views)
end

function VersionActivity3_7ViewDefine.initEnter(module_views)
	module_views.VersionActivity3_7EnterView = {
		destroy = 0,
		container = "VersionActivity3_7EnterViewContainer",
		mainRes = "ui/viewres/versionactivity_3_7/v3a7_enter/v3a7_enterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			},
			{
				{
					"ui/viewres/versionactivity_3_7/v3a7_enter/v3a7_dungeonenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_7/v3a7_enter/v3a7_sodacheenterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/v3a2_bossrush_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_7/v3a7_xiaoruiannong/v3a7_xiaoruiannong_enterview.prefab"
				},
				{
					"ui/viewres/dungeon/rolestory/rolestoryenterview.prefab"
				},
				{
					"ui/viewres/rouge2/rouge2_activityview.prefab"
				},
				{
					"ui/viewres/cloudredemption/cloudredemption_enterview.prefab"
				},
				{
					"ui/viewres/versionactivity_3_7/v3a7_wmz/v3a7_wmz_enterview.prefab"
				},
				{
					"ui/viewres/activity/show/activityweekwalkdeepshowview.prefab"
				},
				{
					"ui/viewres/tower/towermainentryview.prefab"
				},
				{
					"ui/viewres/activity/show/activiyweekwalkheartshowview.prefab"
				}
			}
		}
	}
end

return VersionActivity3_7ViewDefine
