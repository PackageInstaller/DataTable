local FormationOldSubstituteManager = class("FormationOldSubstituteManager", (require("controller.formation.base_formation_manager")))

FormationOldSubstituteManager.MULTITON_MSG = "FormationOldSubstituteManager instancealready constructed!"

function FormationOldSubstituteManager:ctor()
	FormationOldSubstituteManager.super.ctor(self)

	self._formationInfo = {}

	for iter_1_0 = 1, 5 do
		local var_1_0 = {}

		for iter_1_1 = 1, 5 do
			var_1_0[iter_1_1] = {
				pos = iter_1_1
			}
		end

		self._formationInfo[iter_1_0] = var_1_0
	end

	self._returnlayer = "AdventureLayer"
end

function FormationOldSubstituteManager:requestInfo(arg_2_1, arg_2_2)
	require("controller.old_substitution_manager"):get_old_substitution_array(function(arg_3_0)
		self:updateFormationInfo(arg_3_0.array)
		self:updateLayer()

		if arg_2_2 then
			arg_2_2()
		end
	end)
end

function FormationOldSubstituteManager:requestUpdateArrayFightgirl(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	require("controller.old_substitution_manager"):set_old_substitution_servant(arg_4_4, arg_4_3, arg_4_2, function(arg_5_0)
		if arg_5_0.result == 1 then
			self:updateOnceFormationInfo(arg_5_0.array)

			if arg_5_0.robbed_array then
				self:updateOnceFormationInfo(arg_5_0.robbed_array)
			end

			self:updateGirl()
		end

		if arg_4_5 then
			arg_4_5(arg_5_0)
		end
	end)
end

function FormationOldSubstituteManager:requestUpdateArrayAssisgirl(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	require("controller.old_substitution_manager"):set_old_substitution_horcrux(arg_6_4, arg_6_3, arg_6_2, function(arg_7_0)
		if arg_7_0.result == 1 then
			self:updateOnceFormationInfo(arg_7_0.array)

			if arg_7_0.robbed_array then
				self:updateOnceFormationInfo(arg_7_0.robbed_array)
			end
		end

		if arg_6_5 then
			arg_6_5(arg_7_0)
		end
	end)
end

function FormationOldSubstituteManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function FormationOldSubstituteManager:updateRed()
	return
end

function FormationOldSubstituteManager:removeLayer()
	if self.layer then
		self.layer:closeAction(function()
			LayerManager:removePopLayer(self.layer.__queueindex)
		end)
	end
end

function FormationOldSubstituteManager:updateFormationInfo(arg_12_1)
	self._formationInfo = {}

	for iter_12_0 = 1, 5 do
		local var_12_0 = {}

		for iter_12_1 = 1, 5 do
			var_12_0[iter_12_1] = arg_12_1[iter_12_0]["pos_" .. iter_12_1]
		end

		self._formationInfo[iter_12_0] = var_12_0
	end
end

function FormationOldSubstituteManager:updateOnceFormationInfo(arg_13_1)
	local var_13_0 = {}

	for iter_13_0 = 1, 5 do
		var_13_0[iter_13_0] = arg_13_1["pos_" .. iter_13_0]
	end

	self._formationInfo[arg_13_1.id] = var_13_0
end

function FormationOldSubstituteManager:canContinueSetGirl()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(require("model.playermodel").haveServant) do
		if iter_14_1 then
			var_14_0 = var_14_0 + 1
		end
	end

	local var_14_1 = 0

	for iter_14_2, iter_14_3 in ipairs(self._formationInfo) do
		for iter_14_4, iter_14_5 in ipairs(iter_14_3) do
			if iter_14_5.fight_girl then
				var_14_1 = var_14_1 + 1
			end
		end
	end

	return var_14_1 < 25 and var_14_1 < var_14_0
end

function FormationOldSubstituteManager:startFight()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(self._formationInfo) do
		for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
			if iter_15_3.fight_girl then
				var_15_0 = var_15_0 + 1
			end
		end
	end

	if var_15_0 == 0 then
		global_ShowBlockWords(L_SUBSTITUTION_WARNING[1])

		return
	end

	require("controller.old_substitution_manager"):switchToSubstitution(function(arg_16_0)
		if arg_16_0 == 1 then
			self:removeLayer()
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", 601)
			LayerManager:switchShowLayer("FightLayer")
			FightManager.refreshFightToType(FIGHTTYPE_SUBSTITUTION_OLD)
		else
			audioManager:playeffectMusicTest("sound/invalid")
			global_ShowBlockWords(L_SUBSTITUTION_WARNING[arg_16_0])
		end
	end)
end

function FormationOldSubstituteManager:setReturnLayer(arg_17_1)
	self._returnlayer = arg_17_1
end

function FormationOldSubstituteManager:getReturnLayer(arg_18_1)
	return self._returnlayer
end

return FormationOldSubstituteManager
