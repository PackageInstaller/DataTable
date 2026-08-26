-- chunkname: @modules/logic/activitywelfare/define/ActivityWelfareViewDefine.lua

module("modules.logic.activitywelfare.define.ActivityWelfareViewDefine", package.seeall)

local ActivityWelfareViewDefine = {}

function ActivityWelfareViewDefine.init(module_views)
	module_views.ActivityWelfareView = {
		destroy = 0,
		container = "ActivityWelfareViewContainer",
		mainRes = "ui/viewres/activity/activitybeginnerview.prefab",
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
					"ui/viewres/activity/newwelfare/newwelfarefullview.prefab"
				}
			}
		},
		otherRes = {
			[1] = "ui/viewres/activity/activitynormalcategoryitem.prefab"
		}
	}
	module_views.NewWelfareView = {
		destroy = 0,
		container = "NewWelfareViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/newwelfare/newwelfarefullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.NewWelfarePanel = {
		destroy = 0,
		container = "NewWelfarePanelContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/actiivty/newwelfare/newwelfarepanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
	module_views.ActivityNoviceSignView = {
		bgBlur = 0,
		container = "ActivityNoviceSignViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/activity/newwelfare/activitynovicesignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/activity/newwelfare/activitynovicesignitem.prefab"
		},
		customAnimBg = {}
	}
	module_views.ActivityInsightShowView = {
		destroy = 0,
		container = "ActivityInsightShowViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/show/activityinsightshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ActivityInsightShowView_2_3 = {
		destroy = 0,
		container = "ActivityInsightShowView_2_3Container",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_3/v2a3_newinsight/v2a3_activityinsightshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ActivityInsightShowView_2_4 = {
		destroy = 0,
		container = "ActivityInsightShowView_2_4Container",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_4/v2a4_newinsight/v2a4_activityinsightshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ActivityInsightShowView_2_5 = {
		destroy = 0,
		container = "ActivityInsightShowView_2_5Container",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_5/v2a5_newinsight/v2a5_activityinsightshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ActivityInsightShowView_2_6 = {
		destroy = 0,
		container = "ActivityInsightShowView_2_6Container",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_6/v2a6_newinsight/v2a6_activityinsightshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ActivityInsightShowView_2_7 = {
		destroy = 0,
		container = "ActivityInsightShowView_2_7Container",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_7/v2a7_newinsight/v2a7_activityinsightshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_9InsightShowView = {
		destroy = 0,
		container = "VersionActivity3_9InsightShowViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_3_9/v3a9_newinsight/v3a9_activityinsightshowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8NewWelfareView = {
		destroy = 0,
		container = "VersionActivity3_8NewWelfareViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/newwelfare/v3a8_newwelfareview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8NoviceSignView = {
		destroy = 0,
		container = "VersionActivity3_8NoviceSignViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/newwelfare/v3a8_novicesignview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8SelfSelectSixView = {
		destroy = 0,
		container = "VersionActivity3_8SelfSelectSixViewContainer",
		mainRes = "ui/viewres/activity/newwelfare/v3a8_selfselectsixview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.DestinyStoneGiftPickChoiceView = {
		bgBlur = 2,
		container = "DestinyStoneGiftPickChoiceViewContainer",
		maskAlpha = 0,
		destroy = 0,
		mainRes = "ui/viewres/activity/v3a9_stone_pickchoiceview.prefab",
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
	module_views.DestinyStoneGiftStoneDetailView = {
		destroy = 0,
		container = "DestinyStoneGiftStoneDetailViewContainer",
		mainRes = "ui/viewres/activity/v3a9_characterdestinystoneview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Nomal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
end

return ActivityWelfareViewDefine
