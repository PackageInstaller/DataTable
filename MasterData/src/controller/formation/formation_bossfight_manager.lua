local FormationBossfightManager = class("FormationBossfightManager", (require("controller.formation.formation_jumptower_manager")))
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")

FormationBossfightManager.MULTITON_MSG = "FormationBossfightManager instancealready constructed!"

function FormationBossfightManager:ctor()
	FormationBossfightManager.super.ctor(self)
end

local var_0_3 = 5

function FormationBossfightManager:requestInfo(arg_2_1, arg_2_2, arg_2_3)
	self._mode = arg_2_1
	self._formationInfo = {
		{}
	}

	for iter_2_0 = 1, var_0_3 do
		self._formationInfo[1][iter_2_0] = {
			pos = iter_2_0
		}
	end

	local var_2_0 = activity_manager:getBossfightUnlockServant(arg_2_1)

	if var_2_0 and playermodel.haveServant[var_2_0] then
		self._formationInfo[1][1].fight_girl = var_2_0
	end

	self:handlerInfo()
end

function FormationBossfightManager:requestUpdateBossfightGirl(arg_3_1, arg_3_2, arg_3_3)
	self:updateFormationInfo(arg_3_1, arg_3_2, arg_3_3)
	self:updateGirl()
end

function FormationBossfightManager:clearFormation()
	self:requestInfo(self.mode)
end

return FormationBossfightManager
