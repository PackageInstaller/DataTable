local FormationOverclockManager = class("FormationOverclockManager", (require("controller.formation.base_formation_manager")))

FormationOverclockManager.MULTITON_MSG = "FormationOverclockManager instancealready constructed!"

function FormationOverclockManager:ctor()
	FormationOverclockManager.super.ctor(self)

	self._scoreData = {}
end

function FormationOverclockManager:requestInfo(arg_2_1, arg_2_2)
	require("controller.substitution_manager"):get_substitution_battlearrays(arg_2_1, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self._mode = arg_2_1

		self:handlerInfo(arg_3_1, arg_3_2)

		if arg_2_2 then
			arg_2_2(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		end
	end)
end

function FormationOverclockManager:requestUpdateArrayFightgirl(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	require("controller.substitution_manager"):set_substitution_servant(arg_4_1, arg_4_2, arg_4_3, arg_4_4, function(arg_5_0)
		self:updateOnceFormationInfo(arg_5_0.array)

		if arg_5_0.robbed_array then
			self:updateOnceFormationInfo(arg_5_0.robbed_array)
		end

		self:updateGirl()

		if arg_4_5 then
			arg_4_5(arg_5_0)
		end

		self:playVoiceById(arg_4_2)
	end)
end

function FormationOverclockManager:requestUpdateArrayAssisgirl(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	require("controller.substitution_manager"):set_substitution_horcrux(arg_6_1, arg_6_2, arg_6_3, arg_6_4, function(arg_7_0)
		self:updateOnceFormationInfo(arg_7_0.array)

		if arg_7_0.robbed_array then
			self:updateOnceFormationInfo(arg_7_0.robbed_array)
		end

		if arg_6_5 then
			arg_6_5(arg_7_0)
		end
	end)
end

function FormationOverclockManager:requestChallenge(arg_8_1, arg_8_2, arg_8_3)
	require("controller.substitution_manager"):switch_to_substitution(arg_8_1, arg_8_2, self._curFormationIndex, function(arg_9_0)
		if arg_9_0 == 1 then
			self:removeLayer()
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			require("controller.array_manager"):executeHangupArrayChange()

			if arg_8_3 then
				arg_8_3(arg_9_0)
			end
		elseif arg_9_0 == 2 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_LEVEL_OPEN)
		elseif arg_9_0 == 3 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_LEVEL_LOCK)
		elseif arg_9_0 == 4 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_ROLE_NUM)
		elseif arg_9_0 == 5 then
			global_ShowBlockWords(L_SUBSTITUTION_INVALID)
		end
	end)
end

function FormationOverclockManager:handlerInfo(arg_10_1, arg_10_2)
	self:updateFormationInfo(arg_10_2)
	self:updateScoreData(arg_10_1)
	self:updateLayer()
end

function FormationOverclockManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function FormationOverclockManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function FormationOverclockManager:removeLayer()
	if self.layer then
		self.layer:closeAction(function()
			LayerManager:removePopLayer()
			require("controller.array_manager"):executeHangupArrayChange()
		end)
	end
end

function FormationOverclockManager:updateScoreData(arg_15_1)
	self._scoreData = {}

	if next(arg_15_1) then
		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			local var_15_0 = string.len(iter_15_0)
			local var_15_1 = tonumber(string.sub(iter_15_0, var_15_0, var_15_0))

			if var_15_1 then
				self._scoreData[var_15_1] = iter_15_1
			end
		end
	end
end

function FormationOverclockManager:getScoreData(arg_16_1)
	return self._scoreData[arg_16_1]
end

function FormationOverclockManager:getScore(arg_17_1)
	local var_17_0 = self:getScoreData(arg_17_1)

	if var_17_0 then
		return var_17_0.score
	end

	return nil
end

function FormationOverclockManager:updateFormationInfo(arg_18_1)
	self._formationInfo = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		self._formationInfo[iter_18_1.id] = self._formationInfo[iter_18_1.id] or {}

		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			if string.find(iter_18_2, "pos_") then
				self._formationInfo[iter_18_1.id][iter_18_3.pos] = iter_18_3
			elseif iter_18_2 == "assist" then
				self._formationInfo[iter_18_1.id].assist = iter_18_1
			end
		end
	end
end

function FormationOverclockManager:updateOnceFormationInfo(arg_19_1)
	self._formationInfo[arg_19_1.id] = self._formationInfo[arg_19_1.id] or {}

	for iter_19_0, iter_19_1 in pairs(arg_19_1) do
		if string.find(iter_19_0, "pos_") then
			if type(iter_19_1) == "table" then
				self._formationInfo[arg_19_1.id][iter_19_1.pos] = iter_19_1
			elseif iter_19_0 == "assist" then
				self._formationInfo[arg_19_1.id].assist = iter_19_1
			end
		end
	end
end

function FormationOverclockManager:oneTimeUpdateSuccess()
	if self.layer then
		self.layer:oneTimeUpdateSuccess()
	end
end

function FormationOverclockManager:getAssistsInfo()
	local var_21_0 = {}
	local var_21_1 = self:getFormationInfo()

	for iter_21_0 = 1, #var_21_1 do
		var_21_0[iter_21_0] = var_21_1[iter_21_0].assist or {}
	end

	return var_21_0
end

return FormationOverclockManager
