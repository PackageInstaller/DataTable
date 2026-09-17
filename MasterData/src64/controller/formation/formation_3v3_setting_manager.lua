local Formation3V3SettingManager = class("Formation3V3SettingManager", (require("controller.formation.base_formation_manager")))

Formation3V3SettingManager.MULTITON_MSG = "Formation3V3SettingManager instancealready constructed!"

function Formation3V3SettingManager:ctor()
	Formation3V3SettingManager.super.ctor(self)

	self._formationNum = 3
end

function Formation3V3SettingManager:getFormationInfo()
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

function Formation3V3SettingManager:requestOneTimeUpdateArray(arg_3_1, arg_3_2)
	local audio_manager = require("controller.audio_manager")

	require("controller.arenatft_manager"):update_arenatft_attack_array_one_key(arg_3_1, arg_3_2, function(arg_4_0)
		if arg_4_0 == 1 then
			self:oneTimeUpdateSuccess()
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

return Formation3V3SettingManager
