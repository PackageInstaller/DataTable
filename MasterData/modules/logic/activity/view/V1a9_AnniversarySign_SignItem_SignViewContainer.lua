-- chunkname: @modules/logic/activity/view/V1a9_AnniversarySign_SignItem_SignViewContainer.lua

module("modules.logic.activity.view.V1a9_AnniversarySign_SignItem_SignViewContainer", package.seeall)

local V1a9_AnniversarySign_SignItem_SignViewContainer = class("V1a9_AnniversarySign_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function V1a9_AnniversarySign_SignItem_SignViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V1a9_AnniversarySign_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V1a9_AnniversarySign_SignItem_SignViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

return V1a9_AnniversarySign_SignItem_SignViewContainer
