-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_FullViewContainer.lua

module("modules.logic.activity.view.V2a8_DragonBoat_FullViewContainer", package.seeall)

local V2a8_DragonBoat_FullViewContainer = class("V2a8_DragonBoat_FullViewContainer", V2a8_DragonBoat_RewardItemViewContainer)

function V2a8_DragonBoat_FullViewContainer:onModifyListScrollParam(refListScrollParam)
	V2a8_DragonBoat_RewardItemViewContainer.onModifyListScrollParam(self, refListScrollParam)

	refListScrollParam.scrollGOPath = "#scroll_ItemList"
end

function V2a8_DragonBoat_FullViewContainer:onGetMainViewClassType()
	return V2a8_DragonBoat_FullView
end

return V2a8_DragonBoat_FullViewContainer
