local FormationGrabMatchManager = class("FormationGrabMatchManager", (require("controller.formation.base_formation_manager")))

FormationGrabMatchManager.MULTITON_MSG = "FormationGrabMatchManager instancealready constructed!"
FormationGrabMatchManager.Type = {
	Defend = -1,
	Attack = -2
}

function FormationGrabMatchManager:ctor()
	FormationGrabMatchManager.super.ctor(self)

	self._formationInfo = {
		attackArray = {},
		defendArray = {}
	}
	self.layerType = nil
end

function FormationGrabMatchManager:setLayerType(arg_2_1)
	self.layerType = arg_2_1
end

function FormationGrabMatchManager:getLayerType()
	return self.layerType
end

function FormationGrabMatchManager:requestInfo(arg_4_1)
	return
end

function FormationGrabMatchManager:requestUpdateArrayFightgirl(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local array_manager = require("controller.array_manager")

	if arg_5_1 == FormationGrabMatchManager.Type.Attack then
		array_manager:updateArenaAttackArray(arg_5_3, arg_5_2, function(arg_6_0)
			if arg_6_0.result == 1 then
				self:updateGirlSuccess(arg_5_3)

				if arg_5_4 then
					arg_5_4(arg_6_0)
				end

				self:playVoiceById(arg_5_2)
			elseif arg_5_4 then
				arg_5_4(arg_6_0)
			end
		end)
	elseif arg_5_1 == FormationGrabMatchManager.Type.Defend then
		array_manager:updateArenaDefenceArray(arg_5_3, arg_5_2, function(arg_7_0)
			if arg_7_0.result == 1 then
				self:updateGirlSuccess(arg_5_3)

				if arg_5_4 then
					arg_5_4(arg_7_0)
				end

				self:playVoiceById(arg_5_2)
			elseif arg_5_4 then
				arg_5_4(arg_7_0)
			end
		end)
	end
end

function FormationGrabMatchManager:requestUpdateArrayAssisgirl(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local array_manager = require("controller.array_manager")

	if arg_8_1 == FormationGrabMatchManager.Type.Attack then
		array_manager:updateArenaAttackArrayAssistgirl(arg_8_3, arg_8_2, function(arg_9_0)
			if arg_9_0.result == 1 and arg_8_4 then
				arg_8_4(arg_9_0)
			end
		end)
	elseif arg_8_1 == FormationGrabMatchManager.Type.Defend then
		array_manager:updateArenaDefenceArrayAssistgirl(arg_8_3, arg_8_2, function(arg_10_0)
			if arg_10_0.result == 1 and arg_8_4 then
				arg_8_4(arg_10_0)
			end
		end)
	end
end

function FormationGrabMatchManager:requestChallenge(arg_11_1, arg_11_2, arg_11_3)
	require("controller.substitution_manager"):switch_to_substitution(arg_11_1, arg_11_2, self._curFormationIndex, function(arg_12_0)
		if arg_12_0 == 1 then
			self:removeLayer()
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			require("controller.array_manager"):executeHangupArrayChange()

			if arg_11_3 then
				arg_11_3(arg_12_0)
			end
		elseif arg_12_0 == 2 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_LEVEL_OPEN)
		elseif arg_12_0 == 3 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_LEVEL_LOCK)
		elseif arg_12_0 == 4 then
			global_ShowBlockWords(L_SUBSTITUTION_ARRAY_ROLE_NUM)
		elseif arg_12_0 == 5 then
			global_ShowBlockWords(L_SUBSTITUTION_INVALID)
		end
	end)
end

function FormationGrabMatchManager:handlerInfo(arg_13_1)
	return
end

function FormationGrabMatchManager:updateFormationInfo(arg_14_1)
	return
end

function FormationGrabMatchManager:getCurFormationIndex()
	self._curFormationIndex = self._curFormationIndex or 1

	return self._curFormationIndex
end

function FormationGrabMatchManager:getFormationInfo(arg_16_1)
	local playermodel = require("model.playermodel")

	arg_16_1 = arg_16_1 or self.layerType

	if arg_16_1 == FormationGrabMatchManager.Type.Attack then
		if playermodel.arenaAttackArray then
			self._formationInfo.attackArray = {
				{}
			}

			for iter_16_0, iter_16_1 in pairs(playermodel.arenaAttackArray) do
				if string.sub(iter_16_0, 1, 3) == "pos" then
					self._formationInfo.attackArray[1][iter_16_1.pos] = iter_16_1
					self._formationInfo.attackArray[1][iter_16_1.pos].pos = iter_16_1.pos
				elseif iter_16_0 == "assist" then
					self._formationInfo.attackArray[1].assist = iter_16_1
				end
			end
		end

		return self._formationInfo.attackArray
	elseif arg_16_1 == FormationGrabMatchManager.Type.Defend then
		if playermodel.arenaArray then
			self._formationInfo.defendArray = {
				{}
			}

			for iter_16_2, iter_16_3 in pairs(playermodel.arenaArray) do
				if string.sub(iter_16_2, 1, 3) == "pos" then
					self._formationInfo.defendArray[1][iter_16_3.pos] = iter_16_3
					self._formationInfo.defendArray[1][iter_16_3.pos].pos = iter_16_3.pos
				elseif iter_16_2 == "assist" then
					self._formationInfo.defendArray[1].assist = iter_16_3
				end
			end
		end

		return self._formationInfo.defendArray
	end

	return {}
end

function FormationGrabMatchManager:getAtkAssistsInfo()
	local var_17_0 = {}
	local var_17_1 = self:getFormationInfo(FormationGrabMatchManager.Type.Attack)

	for iter_17_0 = 1, #var_17_1 do
		var_17_0[iter_17_0] = var_17_1[iter_17_0].assist
	end

	return var_17_0
end

function FormationGrabMatchManager:getAssistsInfo()
	local var_18_0 = {}
	local var_18_1 = self:getFormationInfo()

	for iter_18_0 = 1, #var_18_1 do
		var_18_0[iter_18_0] = var_18_1[iter_18_0].assist or {}
	end

	return var_18_0
end

function FormationGrabMatchManager:getAttackFormationInfo()
	local var_19_0 = require("model.playermodel").arenaAttackArray

	self._formationInfo.attackArray = {
		{}
	}

	if var_19_0 then
		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			self._formationInfo.attackArray[1][iter_19_1.pos] = iter_19_1
		end
	end

	return self._formationInfo.attackArray
end

function FormationGrabMatchManager:getDefendFormationInfo()
	local var_20_0 = require("model.playermodel").arenaArray

	if var_20_0 then
		self._formationInfo.defendArray = {
			{}
		}

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			self._formationInfo.defendArray[1][iter_20_1.pos] = iter_20_1
		end
	end

	return self._formationInfo.defendArray
end

function FormationGrabMatchManager:requestOneTimeUpdateArray(arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 or 1

	local var_21_0 = self:getFormationInfo()[arg_21_1]
	local array_manager = require("controller.array_manager")
	local audio_manager = require("controller.audio_manager")

	arg_21_2.assist = arg_21_2.assist or self:getAssistsInfo()[arg_21_1] or {}

	if self.layerType == FormationGrabMatchManager.Type.Attack then
		array_manager:updateArenaAttackArrayOneKey(arg_21_2, function(arg_22_0)
			if arg_22_0 == 1 then
				self:oneTimeUpdateSuccess()

				local var_22_0 = {}

				for iter_22_0, iter_22_1 in pairs(arg_21_2) do
					if type(iter_22_1) == "table" then
						var_22_0[iter_22_0] = iter_22_1
					end
				end

				self:playVoiceByArray(var_21_0, var_22_0)
			elseif arg_22_0 == 2 then
				global_ShowBlockWords("角色未解锁")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_22_0 == 3 then
				global_ShowBlockWords("无效魂器")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_22_0 == 4 then
				global_ShowBlockWords("魂器对应位置未设置角色")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_22_0 == 5 then
				global_ShowBlockWords("设置了重复角色和魂器")
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	elseif self.layerType == FormationGrabMatchManager.Type.Defend then
		array_manager:updateArenaDefenceArrayOneKey(arg_21_2, function(arg_23_0)
			if arg_23_0 == 1 then
				self:oneTimeUpdateSuccess()
			elseif arg_23_0 == 2 then
				global_ShowBlockWords("角色未解锁")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_23_0 == 3 then
				global_ShowBlockWords("无效魂器")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_23_0 == 4 then
				global_ShowBlockWords("魂器对应位置未设置角色")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_23_0 == 5 then
				global_ShowBlockWords("设置了重复角色和魂器")
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	end
end

return FormationGrabMatchManager
