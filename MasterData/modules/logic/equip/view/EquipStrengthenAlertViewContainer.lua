-- chunkname: @modules/logic/equip/view/EquipStrengthenAlertViewContainer.lua

module("modules.logic.equip.view.EquipStrengthenAlertViewContainer", package.seeall)

local EquipStrengthenAlertViewContainer = class("EquipStrengthenAlertViewContainer", BaseViewContainer)

function EquipStrengthenAlertViewContainer:buildViews()
	return {
		EquipStrengthenAlertView.New()
	}
end

return EquipStrengthenAlertViewContainer
