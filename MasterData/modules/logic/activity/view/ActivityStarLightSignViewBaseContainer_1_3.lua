-- chunkname: @modules/logic/activity/view/ActivityStarLightSignViewBaseContainer_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignViewBaseContainer_1_3", package.seeall)

local ActivityStarLightSignViewBaseContainer_1_3 = class("ActivityStarLightSignViewBaseContainer_1_3", Activity101SignViewBaseContainer)

function ActivityStarLightSignViewBaseContainer_1_3:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = ActivityStarLightSignItem_1_3
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -12
end

function ActivityStarLightSignViewBaseContainer_1_3:onGetMainViewClassType()
	assert(false, "please override this function")
end

return ActivityStarLightSignViewBaseContainer_1_3
