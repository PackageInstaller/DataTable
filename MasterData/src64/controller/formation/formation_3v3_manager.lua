local Formation3V3Manager = class("Formation3V3Manager", (require("controller.formation.base_formation_manager")))

Formation3V3Manager.MULTITON_MSG = "Formation3V3Manager instancealready constructed!"

function Formation3V3Manager:ctor()
	Formation3V3Manager.super.ctor(self)

	self._formationNum = 3
end

function Formation3V3Manager:getFormationInfo()
	self._formationInfo = {}

	local arenatft_manager = require("controller.arenatft_manager")

	for iter_2_0 = 1, self._formationNum do
		self._formationInfo[iter_2_0] = {}

		for iter_2_1, iter_2_2 in pairs((arenatft_manager:getAttackArrayData(iter_2_0))) do
			self._formationInfo[iter_2_0][iter_2_2.pos] = iter_2_2
		end
	end

	return self._formationInfo
end

function Formation3V3Manager:requestOneTimeUpdateArray(arg_3_1, arg_3_2)
	arg_3_1 = arg_3_1 or 1

	local var_3_0 = self:getFormationInfo()[arg_3_1]
	local audio_manager = require("controller.audio_manager")

	require("controller.arenatft_manager"):update_arenatft_attack_array_one_key(arg_3_1, arg_3_2, function(arg_4_0)
		if arg_4_0 == 1 then
			self:oneTimeUpdateSuccess()
			self:playVoiceByArray(var_3_0, arg_3_2)
		elseif arg_4_0 == 2 then
			global_ShowBlockWords("角色未解锁")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_4_0 == 3 then
			global_ShowBlockWords("无效魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_4_0 == 4 then
			global_ShowBlockWords("魂器对应位置未设置角色")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_4_0 == 5 then
			global_ShowBlockWords("设置了重复角色和魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

return Formation3V3Manager
