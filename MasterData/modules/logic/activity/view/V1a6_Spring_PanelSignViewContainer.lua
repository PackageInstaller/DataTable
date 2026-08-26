-- chunkname: @modules/logic/activity/view/V1a6_Spring_PanelSignViewContainer.lua

module("modules.logic.activity.view.V1a6_Spring_PanelSignViewContainer", package.seeall)

local V1a6_Spring_PanelSignViewContainer = class("V1a6_Spring_PanelSignViewContainer", Activity101SignViewBaseContainer)

function V1a6_Spring_PanelSignViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V1a6_Spring_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V1a6_Spring_PanelSignViewContainer:onGetMainViewClassType()
	return V1a6_Spring_PanelSignView
end

function V1a6_Spring_PanelSignViewContainer:onBuildViews()
	return {
		self.__mainView
	}
end

return V1a6_Spring_PanelSignViewContainer
