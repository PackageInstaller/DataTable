local FormationSpecialExploreManager = class("FormationSpecialExploreManager", (require("controller.formation.base_formation_manager")))

FormationSpecialExploreManager.MULTITON_MSG = "FormationSpecialExploreManager instancealready constructed!"

function FormationSpecialExploreManager:ctor()
	FormationSpecialExploreManager.super.ctor(self)

	self.configType = nil
end

function FormationSpecialExploreManager:requestInfo(arg_2_1, arg_2_2, arg_2_3)
	return
end

function FormationSpecialExploreManager:setFormationInfo(arg_3_1)
	self._formationInfo = {
		arg_3_1
	}
end

function FormationSpecialExploreManager:getFormationInfo()
	return self._formationInfo
end

return FormationSpecialExploreManager
