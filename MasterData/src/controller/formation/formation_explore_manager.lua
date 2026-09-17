local FormationExploreManager = class("FormationExploreManager", (require("controller.formation.base_formation_manager")))

FormationExploreManager.MULTITON_MSG = "FormationExploreManager instancealready constructed!"

function FormationExploreManager:ctor()
	FormationExploreManager.super.ctor(self)

	self.configType = nil
end

function FormationExploreManager:requestInfo(arg_2_1, arg_2_2, arg_2_3)
	return
end

function FormationExploreManager:requestUpdateArrayFightgirl(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local array_manager = require("controller.array_manager")
	local audio_manager = require("controller.audio_manager")

	if CONFIG_TYPE_EXPLORE == self.configType then
		array_manager:updateArrayFightgirl(arg_3_1, arg_3_2, arg_3_3, nil, function(arg_4_0)
			if arg_4_0 == 1 then
				self:updateGirl()

				if arg_3_4 then
					arg_3_4(arg_4_0)
				end
			elseif arg_4_0 == 5 then
				global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[4], RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_4_0 == 6 then
				global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[2], RISE_WORDS_FAIL)
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	else
		array_manager:updateArrayFightgirlHpInherit(arg_3_1, arg_3_2, arg_3_3, function(arg_5_0, arg_5_1)
			if arg_5_0 == 1 then
				self:updateGirlSuccess(arg_3_2)
				self:playVoiceById(arg_3_3)
			end

			if arg_3_4 then
				arg_3_4(arg_5_0, arg_5_1)
			end
		end)
	end
end

function FormationExploreManager:requestUpdateArrayAssisgirl(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local array_manager = require("controller.array_manager")
	local audio_manager = require("controller.audio_manager")

	if CONFIG_TYPE_EXPLORE == self.configType then
		array_manager:updateArrayAssistgirl(arg_6_1, arg_6_2, arg_6_3, nil, function(arg_7_0)
			if arg_7_0 == 1 then
				if arg_6_4 then
					arg_6_4(arg_7_0)
				end
			elseif arg_7_0 == 2 then
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[2])
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_7_0 == 3 then
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[3])
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_7_0 == 4 then
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[4])
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_7_0 == 6 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[6])
			elseif arg_7_0 == 7 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_HORCRUXSELECT_WARNING[7])
			end
		end)
	else
		array_manager:updateArrayAssistgirlHpInherit(arg_6_1, arg_6_2, arg_6_3, function(arg_8_0, arg_8_1)
			if arg_6_4 then
				arg_6_4(arg_8_0, arg_8_1)
			end
		end)
	end
end

function FormationExploreManager:updateFormationInfo(arg_9_1)
	arg_9_1 = arg_9_1 or {}
	self._formationInfo = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		self._formationInfo[iter_9_1.id] = self._formationInfo[iter_9_1.id] or {}

		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if type(iter_9_3) == "table" then
				local var_9_0 = string.len(iter_9_2)
				local var_9_1 = tonumber(string.sub(iter_9_2, var_9_0, var_9_0))

				self._formationInfo[iter_9_1.id][var_9_1] = iter_9_3
				self._formationInfo[iter_9_1.id][var_9_1].pos = var_9_1
			end
		end
	end
end

function FormationExploreManager:getFormationInfo()
	if CONFIG_TYPE_EXPLORE_HP_INHERIT == self.configType then
		for iter_10_0, iter_10_1 in pairs(require("model.playermodel").exploreArrays or {}) do
			self._formationInfo[iter_10_1.id] = self._formationInfo[iter_10_1.id] or {}

			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				if string.find(iter_10_2, "pos_") then
					local var_10_1 = string.len(iter_10_2)
					local var_10_2 = tonumber(string.sub(iter_10_2, var_10_1, var_10_1))

					self._formationInfo[iter_10_1.id][var_10_2] = iter_10_3
					self._formationInfo[iter_10_1.id][var_10_2].pos = var_10_2
				end
			end
		end

		local var_10_3 = self._formationInfo[self._curFormationIndex] or {}

		return {
			var_10_3
		}
	elseif CONFIG_TYPE_EXPLORE == self.configType then
		self._formationInfo = {}

		for iter_10_4, iter_10_5 in pairs(require("model.playermodel").arrays) do
			self._formationInfo[iter_10_5.id] = {}

			for iter_10_6, iter_10_7 in pairs(iter_10_5) do
				if type(iter_10_7) == "table" and iter_10_6 ~= "assist" then
					self._formationInfo[iter_10_5.id][iter_10_7.pos] = iter_10_7
					self._formationInfo[iter_10_5.id][iter_10_7.pos].pos = iter_10_7.pos
				end
			end
		end

		return self._formationInfo
	end

	return {}
end

function FormationExploreManager:requestOneTimeUpdateArray(arg_11_1, arg_11_2)
	arg_11_1 = arg_11_1 or 1

	local var_11_0 = self:getFormationInfo()[arg_11_1]
	local network = require("network.network")
	local array_manager = require("controller.array_manager")
	local audio_manager = require("controller.audio_manager")

	if CONFIG_TYPE_EXPLORE_HP_INHERIT == self.configType then
		array_manager:updateArrayOneKeyHpInherit(arg_11_1, arg_11_2, function(arg_12_0)
			if arg_12_0 == 1 then
				self:oneTimeUpdateSuccess()

				local var_12_0 = {}

				for iter_12_0, iter_12_1 in pairs(arg_11_2) do
					if type(iter_12_1) == "table" then
						var_12_0[iter_12_0] = iter_12_1
					end
				end

				self:playVoiceByArray(var_11_0, var_12_0)
			else
				global_ShowBlockWords("自动编队失败")
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	elseif CONFIG_TYPE_EXPLORE == self.configType then
		array_manager:updateArrayOneKey(arg_11_1, arg_11_2, function(arg_13_0)
			if arg_13_0 == 1 then
				self:oneTimeUpdateSuccess()
				self:playVoiceByArray(var_11_0, arg_11_2)
			elseif arg_13_0 == 2 then
				global_ShowBlockWords("角色未解锁")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_13_0 == 3 then
				global_ShowBlockWords("无效魂器")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_13_0 == 4 then
				global_ShowBlockWords("魂器对应位置未设置角色")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_13_0 == 5 then
				global_ShowBlockWords("设置了重复角色和魂器")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_13_0 == 6 then
				global_ShowBlockWords("挂机阵容不能为空")
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	end
end

return FormationExploreManager
