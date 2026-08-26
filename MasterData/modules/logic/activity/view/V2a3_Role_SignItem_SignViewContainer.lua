-- chunkname: @modules/logic/activity/view/V2a3_Role_SignItem_SignViewContainer.lua

module("modules.logic.activity.view.V2a3_Role_SignItem_SignViewContainer", package.seeall)

local V2a3_Role_SignItem_SignViewContainer = class("V2a3_Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function V2a3_Role_SignItem_SignViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V2a3_Role_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V2a3_Role_SignItem_SignViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

return V2a3_Role_SignItem_SignViewContainer
