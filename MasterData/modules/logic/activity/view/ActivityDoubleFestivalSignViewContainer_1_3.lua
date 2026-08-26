-- chunkname: @modules/logic/activity/view/ActivityDoubleFestivalSignViewContainer_1_3.lua

module("modules.logic.activity.view.ActivityDoubleFestivalSignViewContainer_1_3", package.seeall)

local ActivityDoubleFestivalSignViewContainer_1_3 = class("ActivityDoubleFestivalSignViewContainer_1_3", Activity101SignViewBaseContainer)

function ActivityDoubleFestivalSignViewContainer_1_3:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = ActivityDoubleFestivalSignItem_1_3
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function ActivityDoubleFestivalSignViewContainer_1_3:onGetMainViewClassType()
	return ActivityDoubleFestivalSignView_1_3
end

return ActivityDoubleFestivalSignViewContainer_1_3
