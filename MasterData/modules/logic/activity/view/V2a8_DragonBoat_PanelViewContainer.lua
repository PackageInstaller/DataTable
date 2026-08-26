-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_PanelViewContainer.lua

module("modules.logic.activity.view.V2a8_DragonBoat_PanelViewContainer", package.seeall)

local V2a8_DragonBoat_PanelViewContainer = class("V2a8_DragonBoat_PanelViewContainer", V2a8_DragonBoat_RewardItemViewContainer)

function V2a8_DragonBoat_PanelViewContainer:onModifyListScrollParam(refListScrollParam)
	V2a8_DragonBoat_RewardItemViewContainer.onModifyListScrollParam(self, refListScrollParam)

	refListScrollParam.scrollGOPath = "root/#scroll_ItemList"
end

function V2a8_DragonBoat_PanelViewContainer:onGetMainViewClassType()
	return V2a8_DragonBoat_PanelView
end

return V2a8_DragonBoat_PanelViewContainer
