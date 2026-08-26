-- chunkname: @modules/logic/equip/view/EquipTeamShowViewContainer.lua

module("modules.logic.equip.view.EquipTeamShowViewContainer", package.seeall)

local EquipTeamShowViewContainer = class("EquipTeamShowViewContainer", BaseViewContainer)

function EquipTeamShowViewContainer:buildViews()
	return {
		EquipTeamShowView.New()
	}
end

return EquipTeamShowViewContainer
