-- chunkname: @modules/logic/equip/view/EquipBreakResultViewContainer.lua

module("modules.logic.equip.view.EquipBreakResultViewContainer", package.seeall)

local EquipBreakResultViewContainer = class("EquipBreakResultViewContainer", BaseViewContainer)

function EquipBreakResultViewContainer:buildViews()
	return {
		EquipBreakResultView.New()
	}
end

return EquipBreakResultViewContainer
