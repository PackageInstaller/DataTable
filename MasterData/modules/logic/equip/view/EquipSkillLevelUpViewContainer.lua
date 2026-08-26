-- chunkname: @modules/logic/equip/view/EquipSkillLevelUpViewContainer.lua

module("modules.logic.equip.view.EquipSkillLevelUpViewContainer", package.seeall)

local EquipSkillLevelUpViewContainer = class("EquipSkillLevelUpViewContainer", BaseViewContainer)

function EquipSkillLevelUpViewContainer:buildViews()
	return {
		EquipSkillLevelUpView.New()
	}
end

return EquipSkillLevelUpViewContainer
