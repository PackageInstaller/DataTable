local var_0_0 = lx
local var_0_2 = string.format
local var_0_4 = lx.json_decode
local var_0_5 = lx.UserData
local var_0_6 = AudioManager.Instance

lx.define_class("AudioManager", function(arg_1_0)
	function arg_1_0.init(arg_2_0)
		var_0_6:StopAll()
	end

	function arg_1_0:playBackgroundMusic(arg_3_1)
		if not arg_3_1 then
			return
		end

		if not gamecore.ResourceLoader:findPath(arg_3_1, true) then
			return
		end

		local var_3_0 = gamecore.ResourceLoader:loadAudioClip(arg_3_1)

		if var_3_0 and self:isEnableAudio() then
			var_0_6:PlayBGM(var_3_0)

			return arg_3_1, var_3_0
		end
	end

	function arg_1_0:playSE(arg_4_1, arg_4_2)
		if not gamecore.ResourceLoader or not arg_4_1 then
			return
		end

		arg_4_2 = arg_4_2 or false

		if not gamecore.ResourceLoader:findPath(arg_4_1, true) then
			return
		end

		local var_4_0 = gamecore.ResourceLoader:loadAudioClip(arg_4_1)

		if var_4_0 and self:isEnableAudio() then
			var_0_6:PlaySE(var_4_0, arg_4_1, arg_4_2)

			return arg_4_1
		end
	end

	function arg_1_0:playCV(arg_5_1, arg_5_2, arg_5_3)
		self._is_have_cv = false

		if arg_5_3 == "title" then
			arg_5_1 = self:getTitleCVPath(arg_5_1)
		end

		if arg_5_3 == "cv" then
			arg_5_1 = self:getCVpath(arg_5_1)
		end

		if not gamecore.ResourceLoader or not arg_5_1 then
			return
		end

		if not gamecore.ResourceLoader:findPath(arg_5_1, true) then
			return
		end

		arg_5_2 = arg_5_2 or false

		local var_5_0 = gamecore.ResourceLoader:loadAudioClip(arg_5_1)

		if var_5_0 and self:isEnableAudio() then
			self._is_have_cv = true

			var_0_6:PlayCV(var_5_0, arg_5_1, arg_5_2)

			self._cv_length = var_0_6:GetAudioCvLength()

			return arg_5_1
		end
	end

	function arg_1_0.get_AudioManager_obj(arg_6_0)
		return (var_0_6:GetAudioManager())
	end

	function arg_1_0.getCVpath(arg_7_0, arg_7_1)
		local var_7_1 = gamecore.SubPatchManager:getSelectCV()

		if not var_7_1 then
			return
		end

		return (arg_7_1 or nil) and var_0_2(({
			chinesecv = "cv_cn",
			japanesecv = "cv_jp"
		})[var_7_1] .. "/" .. arg_7_1)
	end

	function arg_1_0.getTitleCVPath(arg_8_0, arg_8_1)
		local var_8_1 = gamecore.SubPatchManager:getSelectCV()

		if not var_8_1 then
			return
		end

		if var_8_1 == "chinesecv" and not gamecore.SubPatchManager:getIsDownloadPatch("cv_cn") then
			return
		end

		if var_8_1 == "japanesecv" and not gamecore.SubPatchManager:getIsDownloadPatch("cv_jp") then
			return
		end

		return (var_0_2(({
			chinesecv = "cv_cn",
			japanesecv = "cv_jp"
		})[var_8_1] .. "/" .. arg_8_1))
	end

	function arg_1_0.pauseAll(arg_9_0)
		var_0_6:PauseBGM()
	end

	function arg_1_0.destroyCV(arg_10_0)
		var_0_6:DestroyCV()
	end

	function arg_1_0.resumeAll(arg_11_0)
		var_0_6:ResumeBGM()
	end

	function arg_1_0.set_cv_volume(arg_12_0, arg_12_1)
		var_0_6:SetCVVolumScale(arg_12_1)
	end

	function arg_1_0.set_bgm_volume(arg_13_0, arg_13_1)
		var_0_6:SetBGMVolumScale(arg_13_1)
	end

	function arg_1_0.set_sound_volume(arg_14_0, arg_14_1)
		var_0_6:SetEFFVolumScale(arg_14_1)
	end

	function arg_1_0:isEnableAudio()
		return self._enable_audio
	end

	function arg_1_0:setEnableAudio(arg_16_1)
		self._enable_audio = arg_16_1

		if arg_16_1 then
			self:resumeAll()
		else
			self:pauseAll()
		end
	end

	function arg_1_0:init_volume()
		function get_data(arg_18_0)
			local var_18_0 = var_0_5:getKeyData(arg_18_0)

			if var_18_0 ~= "" then
				var_18_0 = var_0_4(var_18_0).value
			end

			return var_18_0
		end

		local var_17_0 = get_data(gameenum.common_type.setting_key_list.setting_cv_volume)
		local var_17_1 = get_data(gameenum.common_type.setting_key_list.setting_bgm_volum)
		local var_17_2 = get_data(gameenum.common_type.setting_key_list.setting_sound_volume)

		var_17_0 = var_17_0 == "" and 0.5 or var_17_0
		var_17_1 = var_17_1 == "" and 0.5 or var_17_1
		var_17_2 = var_17_2 == "" and 0.5 or var_17_2

		self:set_cv_volume(var_17_0)
		self:set_bgm_volume(var_17_1)
		self:set_sound_volume(var_17_2)
	end

	function arg_1_0.set_bgm_loop(arg_19_0, arg_19_1)
		var_0_6:SetBgmLoop(arg_19_1)
	end
end)

return function()
	local var_20_0 = var_0_0.class("AudioManager")

	var_20_0._enable_audio = true
	var_20_0._is_have_cv = false
	var_20_0._cv_length = 0

	return var_20_0
end
