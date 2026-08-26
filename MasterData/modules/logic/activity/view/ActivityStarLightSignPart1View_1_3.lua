-- chunkname: @modules/logic/activity/view/ActivityStarLightSignPart1View_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignPart1View_1_3", package.seeall)

local ActivityStarLightSignPart1View_1_3 = class("ActivityStarLightSignPart1View_1_3", ActivityStarLightSignViewBase_1_3)

function ActivityStarLightSignPart1View_1_3:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle1"))
	self._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlightfullbg1"))
end

return ActivityStarLightSignPart1View_1_3
