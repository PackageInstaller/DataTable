local FormationMainManager = class("FormationMainManager", (require("controller.formation.base_formation_manager")))

FormationMainManager.MULTITON_MSG = "FormationMainManager instancealready constructed!"

function FormationMainManager:ctor()
	FormationMainManager.super.ctor(self)
end

function FormationMainManager:getFormationInfo()
	self._formationInfo = {}

	for iter_2_0, iter_2_1 in pairs(require("model.playermodel").arrays) do
		self._formationInfo[iter_2_1.id] = {}

		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			if type(iter_2_3) == "table" and iter_2_2 ~= "assist" then
				self._formationInfo[iter_2_1.id][iter_2_3.pos] = iter_2_3
			end
		end
	end

	return self._formationInfo
end

function FormationMainManager:getAssistsInfo()
	local var_3_0 = {}
	local var_3_1 = require("model.playermodel").arrays or {}

	for iter_3_0 = 1, #var_3_1 do
		var_3_0[iter_3_0] = var_3_1[iter_3_0].assist or {}
	end

	return var_3_0
end

function FormationMainManager:requestOneTimeUpdateArray(arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or 1

	local var_4_0 = self:getFormationInfo()[arg_4_1]
	local audio_manager = require("controller.audio_manager")

	arg_4_2.assist = arg_4_2.assist or require("model.playermodel").arrays[arg_4_1].assist or {}

	require("controller.array_manager"):updateArrayOneKey(arg_4_1, arg_4_2, function(arg_5_0)
		if arg_5_0 == 1 then
			self:oneTimeUpdateSuccess()

			local var_5_0 = {}

			for iter_5_0, iter_5_1 in pairs(arg_4_2) do
				if type(iter_5_1) == "table" then
					var_5_0[iter_5_0] = iter_5_1
				end
			end

			self:playVoiceByArray(var_4_0, var_5_0)
		elseif arg_5_0 == 2 then
			global_ShowBlockWords("角色未解锁")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_5_0 == 3 then
			global_ShowBlockWords("无效魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_5_0 == 4 then
			global_ShowBlockWords("魂器对应位置未设置角色")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_5_0 == 5 then
			global_ShowBlockWords("设置了重复角色和魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_5_0 == 6 then
			global_ShowBlockWords("挂机阵容不能为空")
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function FormationMainManager:requestExtendArray(arg_6_1)
	local audio_manager = require("controller.audio_manager")

	require("network.network"):rpc("add_array", nil, function(arg_7_0)
		if arg_7_0.result == 1 then
			local playermodel = require("model.playermodel")

			playermodel.arrays[#playermodel.arrays + 1] = arg_7_0.array

			if arg_7_0.diamond then
				playermodel.diamond = playermodel.diamond - arg_7_0.diamond
			end

			global_update_gold_stone_diamond(nil, nil, arg_7_0.diamond)
			AnalyticManager.add_array()
			self:extendArraySuccess()

			if arg_6_1 then
				arg_6_1(arg_7_0)
			end
		elseif result == 2 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Add[2])
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif result == 3 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Add[3])
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function FormationMainManager:extendArraySuccess()
	if self.layer then
		self.layer:extendArraySuccess()
	end
end

return FormationMainManager
