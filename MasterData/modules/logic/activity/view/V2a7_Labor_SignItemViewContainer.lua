-- chunkname: @modules/logic/activity/view/V2a7_Labor_SignItemViewContainer.lua

module("modules.logic.activity.view.V2a7_Labor_SignItemViewContainer", package.seeall)

local V2a7_Labor_SignItemViewContainer = class("V2a7_Labor_SignItemViewContainer", Activity101SignViewBaseContainer)

function V2a7_Labor_SignItemViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V2a7_Labor_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V2a7_Labor_SignItemViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

return V2a7_Labor_SignItemViewContainer
