-- chunkname: @modules/logic/activity/view/ActivityStarLightSignPaiLianViewBaseContainer_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignPaiLianViewBaseContainer_1_3", package.seeall)

local ActivityStarLightSignPaiLianViewBaseContainer_1_3 = class("ActivityStarLightSignPaiLianViewBaseContainer_1_3", Activity101SignViewBaseContainer)

function ActivityStarLightSignPaiLianViewBaseContainer_1_3:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = ActivityStarLightSignItem_1_3
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -12
end

function ActivityStarLightSignPaiLianViewBaseContainer_1_3:onGetMainViewClassType()
	assert(false, "please override thid function")
end

return ActivityStarLightSignPaiLianViewBaseContainer_1_3
