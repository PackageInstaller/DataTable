-- chunkname: @modules/logic/activity/view/Role_SignItem_SignViewContainer.lua

module("modules.logic.activity.view.Role_SignItem_SignViewContainer", package.seeall)

local Role_SignItem_SignViewContainer = class("Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function Role_SignItem_SignViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = Role_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -12
end

function Role_SignItem_SignViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

return Role_SignItem_SignViewContainer
