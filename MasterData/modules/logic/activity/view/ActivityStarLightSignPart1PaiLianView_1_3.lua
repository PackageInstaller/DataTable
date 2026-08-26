-- chunkname: @modules/logic/activity/view/ActivityStarLightSignPart1PaiLianView_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignPart1PaiLianView_1_3", package.seeall)

local ActivityStarLightSignPart1PaiLianView_1_3 = class("ActivityStarLightSignPart1PaiLianView_1_3", ActivityStarLightSignPaiLianViewBase_1_3)

function ActivityStarLightSignPart1PaiLianView_1_3:_editableInitView()
	self._actId = ActivityEnum.Activity.StarLightSignPart1_1_3

	self._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlighthalfbg1"))
	self._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle1"))
end

return ActivityStarLightSignPart1PaiLianView_1_3
