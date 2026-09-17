local FormationTestFightManager = class("FormationTestFightManager", (require("controller.formation.base_formation_manager")))

FormationTestFightManager.MULTITON_MSG = "FormationTestFightManager instancealready constructed!"

function FormationTestFightManager:ctor()
	FormationTestFightManager.super.ctor(self)
end

function FormationTestFightManager:getFormationInfo()
	self._formationInfo = {
		{}
	}

	local test_fight_manager = require("controller.test_fight_manager")
	local var_2_1 = {}

	if self.configType == CONFIG_TYPE_TEST_FIGHT_EMPTY then
		var_2_1 = test_fight_manager:getPvpArray()
	elseif self.configType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
		var_2_1 = test_fight_manager:getPlayerArray()
	end

	for iter_2_0 = 1, FORMATION_SHOW_GIRL_NUM do
		tbl = var_2_1[iter_2_0] or {}

		local var_2_2 = {
			pos = iter_2_0,
			fight_girl = tbl.servantid
		}

		var_2_2.assist_girl = tbl.horcrux and tbl.horcrux.itemid
		var_2_2.modelid = tbl.modelid

		table.insert(self._formationInfo[1], var_2_2)
	end

	return self._formationInfo
end

return FormationTestFightManager
