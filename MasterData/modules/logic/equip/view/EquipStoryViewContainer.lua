-- chunkname: @modules/logic/equip/view/EquipStoryViewContainer.lua

module("modules.logic.equip.view.EquipStoryViewContainer", package.seeall)

local EquipStoryViewContainer = class("EquipStoryViewContainer", BaseViewContainer)

function EquipStoryViewContainer:buildViews()
	return {
		EquipStoryView.New()
	}
end

return EquipStoryViewContainer
