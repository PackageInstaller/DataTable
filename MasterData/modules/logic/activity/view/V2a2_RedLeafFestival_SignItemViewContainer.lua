-- chunkname: @modules/logic/activity/view/V2a2_RedLeafFestival_SignItemViewContainer.lua

module("modules.logic.activity.view.V2a2_RedLeafFestival_SignItemViewContainer", package.seeall)

local V2a2_RedLeafFestival_SignItemViewContainer = class("V2a2_RedLeafFestival_SignItemViewContainer", Activity101SignViewBaseContainer)

function V2a2_RedLeafFestival_SignItemViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V2a2_RedLeafFestival_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V2a2_RedLeafFestival_SignItemViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

return V2a2_RedLeafFestival_SignItemViewContainer
