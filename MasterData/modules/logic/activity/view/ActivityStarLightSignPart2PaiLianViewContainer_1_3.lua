-- chunkname: @modules/logic/activity/view/ActivityStarLightSignPart2PaiLianViewContainer_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignPart2PaiLianViewContainer_1_3", package.seeall)

local ActivityStarLightSignPart2PaiLianViewContainer_1_3 = class("ActivityStarLightSignPart2PaiLianViewContainer_1_3", ActivityStarLightSignPaiLianViewBaseContainer_1_3)

function ActivityStarLightSignPart2PaiLianViewContainer_1_3:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = ActivityStarLightSignItem_1_3
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -12.1
end

function ActivityStarLightSignPart2PaiLianViewContainer_1_3:onGetMainViewClassType()
	return ActivityStarLightSignPart2PaiLianView_1_3
end

return ActivityStarLightSignPart2PaiLianViewContainer_1_3
