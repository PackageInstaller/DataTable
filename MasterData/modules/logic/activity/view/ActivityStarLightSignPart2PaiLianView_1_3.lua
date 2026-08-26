-- chunkname: @modules/logic/activity/view/ActivityStarLightSignPart2PaiLianView_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignPart2PaiLianView_1_3", package.seeall)

local ActivityStarLightSignPart2PaiLianView_1_3 = class("ActivityStarLightSignPart2PaiLianView_1_3", ActivityStarLightSignPaiLianViewBase_1_3)

function ActivityStarLightSignPart2PaiLianView_1_3:_editableInitView()
	self._actId = ActivityEnum.Activity.StarLightSignPart2_1_3

	self._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlighthalfbg2"))
	self._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle2"))
end

return ActivityStarLightSignPart2PaiLianView_1_3
