-- chunkname: @modules/logic/activity/view/ActivityStarLightSignPart2View_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignPart2View_1_3", package.seeall)

local ActivityStarLightSignPart2View_1_3 = class("ActivityStarLightSignPart2View_1_3", ActivityStarLightSignViewBase_1_3)

function ActivityStarLightSignPart2View_1_3:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle2"))
	self._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlightfullbg2"))
end

return ActivityStarLightSignPart2View_1_3
