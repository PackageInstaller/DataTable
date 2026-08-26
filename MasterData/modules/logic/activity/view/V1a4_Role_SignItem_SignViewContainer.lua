-- chunkname: @modules/logic/activity/view/V1a4_Role_SignItem_SignViewContainer.lua

module("modules.logic.activity.view.V1a4_Role_SignItem_SignViewContainer", package.seeall)

local V1a4_Role_SignItem_SignViewContainer = class("V1a4_Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function V1a4_Role_SignItem_SignViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V1a4_Role_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

return V1a4_Role_SignItem_SignViewContainer
