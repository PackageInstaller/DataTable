-- chunkname: @modules/logic/activity/view/ActivityDoubleFestivalSignPaiLianViewContainer_1_3.lua

module("modules.logic.activity.view.ActivityDoubleFestivalSignPaiLianViewContainer_1_3", package.seeall)

local ActivityDoubleFestivalSignPaiLianViewContainer_1_3 = class("ActivityDoubleFestivalSignPaiLianViewContainer_1_3", Activity101SignViewBaseContainer)

function ActivityDoubleFestivalSignPaiLianViewContainer_1_3:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = ActivityDoubleFestivalSignItem_1_3
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function ActivityDoubleFestivalSignPaiLianViewContainer_1_3:onGetMainViewClassType()
	return ActivityDoubleFestivalSignPaiLianView_1_3
end

return ActivityDoubleFestivalSignPaiLianViewContainer_1_3
