local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = lx.UserData
local var_0_5 = gameenum.common_type
local var_0_6 = lx.json_encode
local var_0_7 = lx.json_decode
local var_0_8 = gamecore.prompt
local var_0_9 = gamecore.AudioManager
local var_0_10 = gamecore.SubPatchManager
local var_0_11 = table.insert
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = UnityEngine.Vector2
local var_0_14 = gamecore.SceneManager
local var_0_15 = gamecore.util_func
local var_0_16 = lx.http_request
local var_0_17 = gamecore.AuditServerManager
local var_0_19 = gamecore.UserDataManager

log.print_r("=== setting.lua v20260721_1515 FILE loaded ===")

local var_0_20 = {
	SystemSetting = "-2",
	NeverSleep = "-1"
}

gamecore.UILoader:define("setting", function(arg_1_0)
	function arg_1_0:show()
		log.print_r("=== setting.lua v20260721_1515 loaded ===")
		self:setVisible(true)
		self:__init_panel()
		self:__init_mask_move()
		self:init()
	end

	function arg_1_0:__set_now_appversion_num()
		self._version = 0

		local var_3_0 = app:getSystem():getAppVersion()

		for iter_3_0 = 1, #var_3_0 do
			local var_3_1 = tonumber((var_3_0:sub(iter_3_0, iter_3_0)))

			if var_3_1 then
				self._version = self._version + var_3_1
			end
		end
	end

	function arg_1_0:__set_can_getRefreshRate()
		self._have_refreshRate = false

		if not self._version or self._version == 0 then
			self:__set_now_appversion_num()
		end

		local var_4_0 = app:getSystem():getChannel()

		if var_4_0 and var_4_0 ~= "hm_ios_jp" and var_4_0 ~= "hm_ios" then
			if var_4_0 == "xiaomi" or var_4_0 == "yyb" then
				if self._version >= 14 then
					self._have_refreshRate = true
				end
			else
				self._have_refreshRate = true
			end
		end
	end

	function arg_1_0:__show_layer(arg_5_1)
		var_0_5:play_in_out_animation(self._main_seq, arg_5_1, function()
			if not arg_5_1 then
				var_0_2:destroyInstance(self._out)
			end
		end)
	end

	function arg_1_0:__show_cv_layer(arg_7_1)
		self._control.main.set_main.cv_main.cv_select:SetActive(not arg_7_1)
		self._control.main.set_main.cv_main.cv_ok:SetActive(arg_7_1)

		local var_7_0 = var_0_10:getSelectCV()

		if var_7_0 then
			self._control.main.set_main.cv_main.cv_ok.uibm.txt.text.text = var_0_1:getNowLang(var_7_0)
		end

		if self._control.main.set_main.cv_main.cv_select.gameObject.activeSelf then
			if var_0_10:getIsDownloadPatch("cv_cn") then
				self._control.main.set_main.cv_main.cv_select.chinese.txt.text.text = var_0_1:getNowLang("chinesecv")
			end

			if var_0_10:getIsDownloadPatch("cv_jp") then
				self._control.main.set_main.cv_main.cv_select.japanesecv.txt.text.text = var_0_1:getNowLang("japanesecv")
			end
		end
	end

	function arg_1_0:__show_picture_layer(arg_8_1)
		local var_8_0 = self._control.main.set_main.hd_picture_main

		self._control.main.set_main.hd_picture_main.picture_select:SetActive(not arg_8_1)
		var_8_0.picture_ok:SetActive(arg_8_1)

		self._control.main.set_main.hd_picture_main.picture_ok.uibm.txt.text.text = (var_0_5.open_hd_picture and "picture_hd" or "picture_normal") == "picture_hd" and (var_0_10:isDataHDNeedUpdate() and var_0_1:getNowLang("picture_hd_download") or var_0_1:getNowLang("picture_hd")) or var_0_1:getNowLang("picture_normal")

		if var_8_0.picture_select.gameObject.activeSelf then
			var_8_0.picture_select.normal.txt.text.text = var_0_1:getNowLang("picture_normal")
			var_8_0.picture_select.hd.txt.text.text = var_0_10:isDataHDNeedUpdate() and var_0_1:getNowLang("picture_hd_download") or var_0_1:getNowLang("picture_hd")

			if var_0_5.open_hd_picture then
				var_8_0.picture_select.normal.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_04)
				var_8_0.picture_select.hd.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_01)
			else
				var_8_0.picture_select.normal.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_01)
				var_8_0.picture_select.hd.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_04)
			end
		end
	end

	function arg_1_0:__show_tip_layer_by_index(arg_9_1, arg_9_2)
		if arg_9_1 then
			var_0_5:play_in_out_animation(self._control.tip.uITweenSequence, true, nil)
		else
			self._control.tip:SetActive(arg_9_1)
		end

		if not arg_9_1 then
			return
		end

		local var_9_0 = ""

		if self._now_lable == 1 then
			self._now_cv_type = arg_9_2

			if arg_9_2 == var_0_5.now_cv_language.chinses_cv then
				var_9_0 = "cv_cn_notice"
			elseif arg_9_2 == var_0_5.now_cv_language.japanese_cv then
				var_9_0 = "cv_jp_notice"
			end
		elseif self._now_lable == 2 then
			var_9_0 = "check_res_warn"
		elseif self._now_lable == 3 then
			var_9_0 = "check_res_warn"
		end

		self._control.tip.tip_layer.tip.text.text = var_0_1:getNowLang(var_9_0)
	end

	function arg_1_0:__show_repair_page()
		self._control.tip3:SetActive(true)

		self._control.tip3.tip_layer.tip.text.text = var_0_1:getNowLang("check_res_warn")

		self._control.tip3.tip_layer.all_btn.repair_datahd_btn:SetActive(var_0_5.open_hd_picture)
		self._control.tip3.tip_layer.all_btn.repair_data2_btn:SetActive(var_0_5.open_broken)
		self._control.tip3.tip_layer.all_btn.repair_datacv_btn:SetActive(var_0_10:getIsDownloadPatch("cv_cn"))
		self._control.tip3.tip_layer.all_btn.repair_datacv_jp_btn:SetActive(var_0_10:getIsDownloadPatch("cv_jp"))
	end

	function arg_1_0:__show_exchange_layer(arg_11_1)
		if arg_11_1 then
			self._control.exchange:SetActive(true)
			self._control.main:SetActive(false)
			var_0_5:play_in_out_animation(self._control.exchange.uITweenSequence, true, nil)
		else
			var_0_5:play_in_out_animation(self._control.exchange.uITweenSequence, false, function()
				self._control.main:SetActive(true)
				var_0_5:play_in_out_animation(self._control.main.uITweenSequence, true, function()
					self._control.exchange.bg_container.input.inputField.text = ""

					self._control.exchange:SetActive(false)
				end)
			end)
		end
	end

	function arg_1_0.__reset_harmonious_step(arg_14_0)
		arg_14_0._harmonious_step = {}
	end

	function arg_1_0:__detection_harmonious_step()
		if var_0_17:isAuditVersion() then
			return
		end

		if self._user_data.level < var_0_5.unlock_level.harmonious_resource then
			return
		end

		if var_0_10:getIsDownloadPatch("data2") then
			return
		end

		if var_0_3:get_now_harmony() then
			return
		end

		if #self._harmonious_rule ~= #self._harmonious_step then
			return
		end

		local var_15_0 = true

		for iter_15_0, iter_15_1 in ipairs(self._harmonious_rule) do
			if iter_15_1 ~= self._harmonious_step[iter_15_0] then
				var_15_0 = false
			end
		end

		if var_15_0 then
			self._control.tip2:SetActive(true)
		end
	end

	function arg_1_0.__get_data(arg_16_0, arg_16_1)
		local var_16_0 = var_0_4:getKeyData(arg_16_1)

		if var_16_0 ~= "" and var_16_0 ~= " " then
			var_16_0 = var_0_7(var_16_0).value
		end

		return var_16_0
	end

	function arg_1_0.__save_data(arg_17_0, arg_17_1, arg_17_2)
		var_0_4:setKeyData(arg_17_1, var_0_6({
			value = arg_17_2
		}))
	end

	function arg_1_0:__set_cv_layer(arg_18_1)
		self._control.main.set_main.cv_main.cv_ok.uibm.txt.text.text = var_0_1:getNowLang(var_0_10:getSelectCV() or "settingcv")
	end

	function arg_1_0:__set_picture_layer()
		self._control.main.set_main.cv_main.cv_ok.uibm.txt.text.text = var_0_1:getNowLang(var_0_10:getSelectPictureDefinition() or "settingcv")
	end

	function arg_1_0:__set_framerate(arg_20_1)
		local var_20_0 = app:getSystem():getChannel()
		local var_20_1 = ""

		if arg_20_1 == 30 then
			var_20_1 = "settingframerate30"
		elseif arg_20_1 == 60 then
			var_20_1 = "settingframerate60"
		end

		self._now_framerate = arg_20_1
		self._control.main.set_main.live2d_framerate_main.framerate_control.txt.text.text = var_0_1:getNowLang(var_20_1)

		self:__save_data(var_0_5.setting_key_list.setting_framerate, arg_20_1)

		UnityEngine.Application.targetFrameRate = arg_20_1

		if self._have_refreshRate then
			local var_20_2 = self._control.main:GetComponent("GetRefreshRate")

			if var_20_2 and var_20_2:GetNowRefreshRate() == 120 then
				if arg_20_1 == 60 then
					var_0_4:setKeyData("save_high_ref", 120)

					UnityEngine.Application.targetFrameRate = 120
				elseif arg_20_1 == 30 then
					var_0_4:setKeyData("save_high_ref", 30)
				end
			elseif arg_20_1 == 60 then
				var_0_4:setKeyData("save_high_ref", 60)
			elseif arg_20_1 == 30 then
				var_0_4:setKeyData("save_high_ref", 30)
			end
		end
	end

	function arg_1_0.__set_slider(arg_21_0, arg_21_1, arg_21_2)
		arg_21_1.number.text.text = math.ceil(arg_21_2 * 100)
		arg_21_1.slider.slider.value = arg_21_2
	end

	function arg_1_0:__get_input_redeem_code()
		return self._control.exchange.bg_container.input.txt.text.text or ""
	end

	function arg_1_0:__click_cv_event(arg_23_1)
		if arg_23_1 == var_0_5.now_cv_language.chinses_cv then
			if self._is_download_chinese_cv then
				self:__show_cv_layer(true)
				self:__set_cv_layer(var_0_5.now_cv_language.chinses_cv)
			else
				self:__show_tip_layer_by_index(true, arg_23_1)
			end
		elseif arg_23_1 == var_0_5.now_cv_language.japanese_cv then
			if self._is_download_japanese_cv then
				self:__show_cv_layer(true)
				self:__set_cv_layer(var_0_5.now_cv_language.japanese_cv)
			else
				self:__show_tip_layer_by_index(true, arg_23_1)
			end
		end
	end

	function arg_1_0:__click_picture_event(arg_24_1)
		if arg_24_1 == var_0_5.now_picture_type.normal then
			self:__show_picture_layer(true)
			self:__set_cv_layer(var_0_5.now_picture_type.normal)
		elseif arg_24_1 == var_0_5.now_picture_type.hd then
			if var_0_10:isDataHDNeedUpdate() then
				self:__show_picture_layer(true)
				self:__set_cv_layer(var_0_5.now_picture_type.hd)
			else
				self:__show_tip_layer_by_index(true, arg_24_1)
			end
		end
	end

	function arg_1_0:__click_framerate_event(arg_25_1)
		local var_25_0 = 0

		for iter_25_0, iter_25_1 in ipairs(self._framerate_list) do
			if iter_25_1 == self._now_framerate then
				var_25_0 = iter_25_0
			end
		end

		if var_25_0 + arg_25_1 >= 1 and var_25_0 + arg_25_1 <= #self._framerate_list then
			self:__set_framerate(self._framerate_list[var_25_0 + arg_25_1])
		end

		var_0_11(self._harmonious_step, arg_25_1)
		self:__detection_harmonious_step()
	end

	function arg_1_0:__click_live2d_event(arg_26_1, arg_26_2)
		self._control.main.set_main.live2d_framerate_main.live2d_control.left.scaleButton.interactable = arg_26_1
		self._control.main.set_main.live2d_framerate_main.live2d_control.right.scaleButton.interactable = not arg_26_1
		self._control.main.set_main.live2d_framerate_main.live2d_control.txt.text.text = var_0_1:getNowLang(arg_26_1 and "settingopen" or "settingclose")

		if arg_26_1 and not arg_26_2 then
			var_0_8:show(var_0_1:getNowLang("live2denablehint"))
		end

		self:__save_data(var_0_5.setting_key_list.setting_live2d, arg_26_1)
		self:__save_data(var_0_5.setting_key_list.setting_spine, arg_26_1)

		local var_26_1 = var_0_2:getInstance("home")

		if var_26_1 then
			var_26_1:updata_model()
		end
	end

	function arg_1_0:__click_battle_scene_event(arg_27_1, arg_27_2)
		self._control.main.set_main.battle_scene.battle_scene_control.left.scaleButton.interactable = arg_27_1
		self._control.main.set_main.battle_scene.battle_scene_control.right.scaleButton.interactable = not arg_27_1
		self._control.main.set_main.battle_scene.battle_scene_control.txt.text.text = var_0_1:getNowLang(arg_27_1 and "settingopen" or "settingclose")

		self:__save_data(var_0_5.setting_key_list.setting_battle_scene, arg_27_1)
	end

	function arg_1_0:__click_borken_event(arg_28_1, arg_28_2)
		self._control.main.set_main.battle_scene.broken_control.left.scaleButton.interactable = arg_28_1
		self._control.main.set_main.battle_scene.broken_control.right.scaleButton.interactable = not arg_28_1
		self._control.main.set_main.battle_scene.broken_control.txt.text.text = var_0_1:getNowLang(arg_28_1 and "settingopen" or "settingclose")

		self:__save_data(var_0_5.setting_key_list.setting_broken, arg_28_1)
	end

	function arg_1_0.__return_login(arg_29_0)
		var_0_14:restart()
	end

	function arg_1_0:__init_picture_indo()
		self._control.main.set_main.hd_picture_main.picture_ok.uibm.txt.text.text = (var_0_5.open_hd_picture and "picture_hd" or "picture_normal") == "picture_hd" and (var_0_10:isDataHDNeedUpdate() and var_0_1:getNowLang("picture_hd_download") or var_0_1:getNowLang("picture_hd")) or var_0_1:getNowLang("picture_normal")
	end

	function arg_1_0:__init_cv_indo()
		self:__show_cv_layer(true)

		self._is_download_japanese_cv = self:__get_data(var_0_5.setting_key_list.setting_japanese_cv) ~= ""
		self._is_download_chinese_cv = self:__get_data(var_0_5.setting_key_list.setting_chinese_cv) ~= ""
		self._control.main.set_main.cv_main.cv_select.japanesecv.txt.text.text = self._is_download_japanese_cv and var_0_1:getNowLang("japanesecv") or var_0_1:getNowLang("japanesecv") .. var_0_1:getNowLang("needdownload")
		self._control.main.set_main.cv_main.cv_select.chinese.txt.text.text = self._is_download_chinese_cv and var_0_1:getNowLang("chinesecv") or var_0_1:getNowLang("chinesecv") .. var_0_1:getNowLang("needdownload")

		self:__set_cv_layer((self:__get_data(var_0_5.setting_key_list.setting_cv)))
	end

	function arg_1_0:__init_volume()
		local var_32_0 = 0.5
		local var_32_1 = 0.5
		local var_32_2 = 0.5
		local var_32_3 = self:__get_data(var_0_5.setting_key_list.setting_cv_volume)
		local var_32_4 = self:__get_data(var_0_5.setting_key_list.setting_bgm_volum)
		local var_32_5 = self:__get_data(var_0_5.setting_key_list.setting_sound_volume)

		if var_32_3 ~= "" then
			var_32_0 = var_32_3
		end

		if var_32_4 ~= "" then
			var_32_1 = var_32_4
		end

		if var_32_5 ~= "" then
			var_32_2 = var_32_5
		end

		self:__set_slider(self._control.main.set_main.cvvol_main, var_32_0)
		self:__set_slider(self._control.main.set_main.bgm_main, var_32_1)
		self:__set_slider(self._control.main.set_main.sound_main, var_32_2)
	end

	function arg_1_0:__init_framerate()
		self:__set_can_getRefreshRate()

		local var_33_1 = self:__get_data(var_0_5.setting_key_list.setting_framerate)

		self:__set_framerate((var_33_1 ~= "" or nil) and var_33_1)
	end

	function arg_1_0:__init_live2d()
		local var_34_1 = self:__get_data(var_0_5.setting_key_list.setting_live2d)

		self:__click_live2d_event((var_34_1 ~= "" or nil) and var_34_1, true)
	end

	function arg_1_0:__init_login_scene_change()
		local var_35_1 = var_0_19:getDataByID("open_panorama", "0")

		self:__set_login_scene_change((var_35_1 ~= "" or nil) and var_35_1 == "true")
	end

	function arg_1_0:__init_battle_scene_change()
		local var_36_1 = self:__get_data(var_0_5.setting_key_list.setting_battle_scene)

		self:__click_battle_scene_event((var_36_1 ~= "" and var_36_1 ~= " " or nil) and var_36_1, true)
	end

	function arg_1_0:__init_broken_change()
		local var_37_0 = var_0_3:get_now_harmony()
		local var_37_1 = app:getSystem():getChannel()

		if var_37_1 == "hm_android_jp" or var_37_1 == "hm_ios_jp" then
			self._control.main.set_main.battle_scene.broken_txt:SetActive(false)
			self._control.main.set_main.battle_scene.broken_control:SetActive(false)

			return
		end

		if not var_0_5.open_broken then
			self._control.main.set_main.battle_scene.broken_txt:SetActive(false)
			self._control.main.set_main.battle_scene.broken_control:SetActive(false)
		else
			self._control.main.set_main.battle_scene.broken_txt:SetActive(true)
			self._control.main.set_main.battle_scene.broken_control:SetActive(true)
		end

		local var_37_2 = true

		if true ~= "" and var_37_2 ~= " " then
			var_37_2 = self:__get_data(var_0_5.setting_key_list.setting_broken)
		end

		if type(var_37_2) ~= "boolean" then
			var_37_2 = true
		end

		self:__click_borken_event(var_37_2, true)
	end

	function arg_1_0:__set_login_scene_change(arg_38_1)
		var_0_19:setDataByID("open_panorama", "0", arg_38_1 and "true" or "false")

		self._control.main.set_main.always_light_scene_change_main.scene_change_control.txt.text.text = var_0_1:getNowLang((not arg_38_1 or nil) and "settingclose")
		self._control.main.set_main.always_light_scene_change_main.scene_change_control.left.scaleButton.interactable = arg_38_1
		self._control.main.set_main.always_light_scene_change_main.scene_change_control.right.scaleButton.interactable = not arg_38_1
		self._control.main.set_main.always_light_scene_change_main.scene_change.text.text = "3D"
	end

	function arg_1_0:__init_always_light_change()
		local var_39_1 = var_0_4:getKeyData("always_light")

		self:__set_always_light_change((var_39_1 ~= "" or nil) and var_39_1 == var_0_20.NeverSleep)
	end

	function arg_1_0:__set_always_light_change(arg_40_1)
		local var_40_0

		if arg_40_1 then
			var_40_0 = var_0_20.NeverSleep or var_0_20.SystemSetting
		end

		var_0_4:setKeyData("always_light", var_40_0)

		UnityEngine.Screen.sleepTimeout = var_40_0

		local var_40_1 = "settingopen"

		if not arg_40_1 then
			var_40_1 = "settingclose"
		end

		local var_40_2 = self._control.main.set_main.always_light_scene_change_main

		self._control.main.set_main.always_light_scene_change_main.always_light_control.txt.text.text = var_0_1:getNowLang(var_40_1)
		var_40_2.always_light_control.left.scaleButton.interactable = arg_40_1
		var_40_2.always_light_control.right.scaleButton.interactable = not arg_40_1
	end

	function arg_1_0:__set_version_and_uid()
		self._control.main.uid_number.text.text = "UID:" .. self._my_id
		self._control.main.version.text.text = var_0_1:getNowLang("settingversion") .. app:getSystem():getDataVersion()
	end

	function arg_1_0:__set_change_scence(arg_42_1)
		self:__save_data(var_0_5.setting_key_list.setting_scene_change, arg_42_1)

		local var_42_1 = "settingopen"
		local var_42_2 = var_0_2:getInstance("home")

		if not arg_42_1 then
			var_42_1 = "settingclose"

			if var_42_2 then
				var_42_2:getCreate3DScene(false)
				var_42_2._control.background:SetActive(true)
			end
		elseif var_42_2 then
			var_42_2:getCreate3DScene(true)
			var_42_2._control.background:SetActive(false)
		end

		self._control.main.set_main.scene_change_main.txt.text.text = var_0_1:getNowLang(var_42_1)
		self._control.main.set_main.scene_change_main.left.scaleButton.interactable = arg_42_1
		self._control.main.set_main.scene_change_main.right.scaleButton.interactable = not arg_42_1
		self._control.main.set_main.scene_change_main.scene_change.text.text = "3D"
	end

	function arg_1_0:__init_mask_move()
		self._control.main.mask_bg.glow_img.rectTransform.anchoredPosition = var_0_13(-1600, 313)
		self._mail_seq = self:autoKillDOTween(var_0_12.Sequence())

		self._mail_seq:Append(self._control.main.mask_bg.glow_img.transform:DOLocalMove(Vector3.New(725, -420, 0), 5):SetEase(DG.Tweening.Ease.Linear))
		self._mail_seq:SetLoops(-1)
		self._mail_seq:Play()
	end

	function arg_1_0:__register_revise_volume()
		local var_44_0 = self._control.main.set_main.cvvol_main.slider.slider

		self._control.main.set_main.cvvol_main.slider.slider.onValueChanged:RemoveAllListeners()
		self._control.main.set_main.cvvol_main.slider.slider.onValueChanged:AddListener(function()
			self:__show_cv_layer(true)
			self:__save_data(var_0_5.setting_key_list.setting_cv_volume, var_44_0.value)
			var_0_9:set_cv_volume(var_44_0.value)
			self:__set_slider(self._control.main.set_main.cvvol_main, var_44_0.value)
		end)

		local var_44_1 = self._control.main.set_main.bgm_main.slider.slider

		self._control.main.set_main.bgm_main.slider.slider.onValueChanged:RemoveAllListeners()
		self._control.main.set_main.bgm_main.slider.slider.onValueChanged:AddListener(function()
			self:__show_cv_layer(true)
			self:__save_data(var_0_5.setting_key_list.setting_bgm_volum, var_44_1.value)
			var_0_9:set_bgm_volume(var_44_1.value)
			self:__set_slider(self._control.main.set_main.bgm_main, var_44_1.value)
		end)

		local var_44_2 = self._control.main.set_main.sound_main.slider.slider

		self._control.main.set_main.sound_main.slider.slider.onValueChanged:RemoveAllListeners()
		self._control.main.set_main.sound_main.slider.slider.onValueChanged:AddListener(function()
			self:__show_cv_layer(true)
			self:__save_data(var_0_5.setting_key_list.setting_sound_volume, var_44_2.value)
			var_0_9:set_sound_volume(var_44_2.value)
			self:__set_slider(self._control.main.set_main.sound_main, var_44_2.value)
		end)
	end

	function arg_1_0:__init_panel()
		self:__init_ch_or_jp()

		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
		end

		local var_48_0 = app:getSystem():getChannel()

		self:__set_channel_need_use(var_48_0 == var_0_5.channel.android_xiaomi or var_48_0 == var_0_5.channel.android_yyb)
		self:__set_only_setting(var_48_0)

		if var_0_17:isAuditVersion() then
			if var_48_0 == var_0_5.channel.android_xiaomi or var_48_0 == var_0_5.channel.android_yyb then
				self._control.main.contact_us:SetActive(true)
			else
				self._control.main.contact_us:SetActive(false)
			end
		end

		self._my_id = var_0_3:get_account_id()
		self._user_data = var_0_3:get_use_info_data()

		self:__set_now_appversion_num()
		self:__init_picture_indo()
		self:__init_cv_indo()
		self:__init_volume()
		self:__init_framerate()
		self:__init_live2d()
		self:__init_battle_scene_change()
		self:__init_broken_change()
		self:__init_login_scene_change()
		self:__init_always_light_change()
		self:__set_version_and_uid()
		self:__register_revise_volume()
		self:__show_layer(true)
		self._control.shadw:SetActive(true)
		self:__ischina_or_japan()

		self._is_already_init = true

		if var_0_17:isAuditVersion() then
			if var_48_0 == var_0_5.channel.android_xiaomi or var_48_0 == var_0_5.channel.android_yyb then
				self._control.main.set_main.hd_picture_main.picture_select.hd.gameObject:SetActive(true)
			else
				self._control.main.set_main.hd_picture_main.picture_select.hd.gameObject:SetActive(false)
			end
		end

		self._control.main.set_main.app_inquire_main.app_inquire.text.text = "APP备案号：" .. var_0_15.convert_rich_text("^C1C8BE5FF00000000沪ICP备15042440号-4A^C454545FF00000000")
		self._control.main.set_main.app_inquire_main.app_inquire_btn.inquire.text.text = "查 询"
	end

	function arg_1_0:__set_only_setting(arg_49_1)
		self._control.tip3:SetActive(false)

		if arg_49_1 == var_0_5.channel.iOS_cn then
			self._control.main.srescheck:SetActive(false)
		end
	end

	function arg_1_0:__set_channel_need_use(arg_50_1)
		self._control.main.contact_us:SetActive(not arg_50_1)
		self._control.main.set_main.app_inquire_main.app_inquire:SetActive(not arg_50_1)
		self._control.main.set_main.app_inquire_main.app_inquire_btn:SetActive(not arg_50_1)
		self._control.main.set_main.app_inquire_main.app_user:SetActive(arg_50_1)
		self._control.main.set_main.app_inquire_main.app_privacy:SetActive(arg_50_1)
		self._control.main.set_main.app_inquire_main.app_three:SetActive(arg_50_1)
		self._control.main.set_main.app_inquire_main.app_child:SetActive(arg_50_1)
	end

	function arg_1_0:__init_language()
		local var_51_0 = app:getSystem():getChannel()

		self._control.main.settext.text.text = var_0_1:getNowLang("settingtitle")
		self._control.main.set_main.hd_picture_main.picture_select.picture.text.text = var_0_1:getNowLang("picture_set_choose")
		self._control.main.set_main.hd_picture_main.picture_ok.hd_picture.text.text = var_0_1:getNowLang("picture_set")
		self._control.main.set_main.cv_main.cv_ok.good.text.text = var_0_1:getNowLang("settingcvname")
		self._control.main.set_main.cv_main.cv_select.cv.text.text = var_0_1:getNowLang("settingcv")
		self._control.main.set_main.cvvol_main.title.text.text = var_0_1:getNowLang("settingcvvolume")
		self._control.main.set_main.bgm_main.title.text.text = var_0_1:getNowLang("settingmusic")
		self._control.main.set_main.sound_main.title.text.text = var_0_1:getNowLang("settingsound")
		self._control.main.set_main.always_light_scene_change_main.always_light.text.text = var_0_1:getNowLang("screen_brightness_set")
		self._control.main.set_main.live2d_framerate_main.framerate.text.text = var_0_1:getNowLang("settingframerate")
		self._control.main.set_main.battle_scene.battle_scene_txt.text.text = var_0_1:getNowLang("bg_battle_new")
		self._control.main.set_main.battle_scene.broken_txt.text.text = var_0_1:getNowLang("broken_display")
		self._control.main.set_main.live2d_framerate_main.live2d.text.text = var_0_1:getNowLang("settinglive2d")
		self._control.main.sbtnback.txt.text.text = var_0_1:getNowLang("sbtnback")
		self._control.main.srescheck.txt.text.text = var_0_1:getNowLang("srescheck")
		self._control.main.exchange.txt.text.text = var_0_1:getNowLang("settinggc")
		self._control.main.contact_us.txt.text.text = var_0_1:getNowLang("contact")
		self._control.main.settingrule_btn.txt.text.text = (var_51_0 == var_0_5.channel.iOS_jp or var_51_0 == var_0_5.channel.android_jp) and var_0_1:getNowLang("settingrule") or (var_51_0 == var_0_5.channel.hm_android_en or var_51_0 == var_0_5.channel.ios_en) and var_0_1:getNowLang("settingrule") or var_0_1:get("手机绑定")
		self._control.tip.tip_layer.bg_container.title.text.text = var_0_1:getNowLang("refactor_manifest_title")
		self._control.tip.tip_layer.confirm_btn.txt.text.text = var_0_1:getNowLang("ui_cbtn1")
		self._control.tip.tip_layer.cancel_btn.txt.text.text = var_0_1:getNowLang("ui_cbtn2")
		self._control.exchange.bg_container.title.text.text = var_0_1:getNowLang("settingcouponttitle")
		self._control.exchange.bg_container.input.placeholder.text.text = var_0_1:getNowLang("settingcouponcontent")
		self._control.exchange.bg_container.confirm_btn.txt.text.text = var_0_1:getNowLang("confirm")
		self._control.tip2.tip_layer.confirm_btn.txt.text.text = var_0_1:getNowLang("confirm")
		self._control.main.set_main.bind_email_address.live2d.name_level_1.text.text = var_0_1:getNowLang("ui_bindemailgood")
		self._control.main.set_main.bind_email_address.email_address.txt.text.text = var_0_1:getNowLang("ui_bm")
		self._control.email_tip.tip_layer.tip_name.fleet_name.text.text.text = var_0_1:getNowLang("inputmail")
		self._control.tip3.tip_layer.all_btn.repair_data_btn.txt.text.text = var_0_1:getNowLang("resource_tips_1")
		self._control.tip3.tip_layer.all_btn.repair_data2_btn.txt.text.text = var_0_1:getNowLang("resource_tips_2")
		self._control.tip3.tip_layer.all_btn.repair_datahd_btn.txt.text.text = var_0_1:getNowLang("resource_tips_3")
		self._control.tip3.tip_layer.all_btn.repair_datacv_btn.txt.text.text = var_0_1:getNowLang("resource_tips_4")
		self._control.tip3.tip_layer.all_btn.repair_datacv_jp_btn.txt.text.text = var_0_1:getNowLang("resource_tips_5")
	end

	function arg_1_0:_play_into_se(arg_52_1)
		self:playSE(arg_52_1, false)
	end

	function arg_1_0:__init_constant()
		self._main_seq = self._control.main.uITweenSequence
		self._framerate_list = {
			30,
			60
		}
		self._harmonious_rule = {
			-1,
			-1,
			1,
			1,
			-1,
			1,
			-1,
			1
		}
	end

	function arg_1_0:__init_ch_or_jp()
		local var_54_0 = app:getSystem():getChannel()

		self._control.main.settingrule_btn.gameObject:SetActive(true)

		if var_0_17:isAuditVersion() then
			if var_54_0 == var_0_5.channel.iOS_cn then
				self._control.main.settingrule_btn.gameObject:SetActive(false)
				self._control.main.set_main.bind_email_address:SetActive(true)
				self._control.main.set_main.app_inquire_main:SetActive(false)
			end

			if var_54_0 == var_0_5.channel.android_xiaomi or var_54_0 == var_0_5.channel.android_yyb then
				self._control.main.settingrule_btn.gameObject:SetActive(false)
			end
		elseif var_54_0 == var_0_5.channel.hm_android_en or var_54_0 == var_0_5.channel.ios_en or var_54_0 == var_0_5.channel.android_xiaomi or var_54_0 == var_0_5.channel.android_yyb then
			self._control.main.settingrule_btn.gameObject:SetActive(false)
		end

		self._control.main.exchange.gameObject:SetActive(var_54_0 ~= "hm_android_jp" and var_54_0 ~= "hm_ios_jp")
		self._control.main.contact_us.gameObject:SetActive(var_54_0 ~= "hm_android_jp" and var_54_0 ~= "hm_ios_jp")

		if var_0_17:isAuditVersion() then
			self._control.main.exchange.gameObject:SetActive(false)
		end
	end

	function arg_1_0:__show_tip_email()
		var_0_5:play_in_out_animation(self._control.email_tip.uITweenSequence, true, nil)

		self._control.email_tip.tip_layer.tip_name.tip.text.text = var_0_1:getNowLang("ui_mail")
		self._control.email_tip.tip_layer.tip_name.fleet_name.inputField.text = var_0_1:getNowLang("inputmail")
		self._control.email_tip.tip_layer.confirm_btn.txt.text.text = var_0_1:getNowLang("confirm")
	end

	function arg_1_0:edit_team_name()
		local var_56_1 = {
			email = self._control.email_tip.tip_layer.tip_name.fleet_name.inputField.text
		}

		if var_56_1.email == "" or var_56_1.email == nil or var_56_1.email == var_0_1:getNowLang("inputmail") then
			var_0_8:show((var_0_1:getNowLang("nodata")))

			return
		else
			local var_56_3 = var_0_4:getKeyData("Account_UserName")
			local var_56_4 = string.match(var_56_1.email, "[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")

			if not var_56_4 then
				var_0_8:show(var_0_1:getNowLang("signinemailinputerrornotice"))
			else
				self:req_email_change(var_56_3, var_0_4:getKeyData("Account_PassWord"), var_56_4)
				self._control.email_tip:SetActive(false)
			end
		end
	end

	function arg_1_0:req_email_change(arg_57_1, arg_57_2, arg_57_3)
		self._changepwd_data = {
			username = arg_57_1,
			password = arg_57_2,
			mail = arg_57_3
		}

		local var_57_0 = var_0_16:create()

		var_57_0:set_url(var_0_5.bind_mail_url)
		var_57_0:set_fields((var_0_6(self._changepwd_data)))
		var_57_0:set_post()
		var_57_0:set_response_func(function(arg_58_0, arg_58_1)
			local var_58_0 = var_0_7(arg_58_1)

			if var_58_0.error_code == 0 then
				if self._binding_succeed_callback then
					self._binding_succeed_callback(var_58_0)
				end
			else
				self:loadUI("绑定失败"):show(var_0_1:get(var_58_0.error_msg))
			end
		end)
		var_57_0:set_error_func(function(arg_59_0, arg_59_1)
			if self.change_pwd_fail_callback then
				self.change_pwd_fail_callback(arg_59_1)
			end
		end)
		var_57_0:execute()
	end

	function arg_1_0.init(arg_60_0)
		arg_60_0._binding_fail_callback, arg_60_0._binding_succeed_callback = function(arg_62_0)
			arg_60_0:loadUI("register_prompt"):show(var_0_1:getNowLang("errorcode-9995"))
			arg_60_0:__register_faild(arg_62_0)
		end, function(arg_61_0)
			arg_60_0:setVisible(false)
		end
	end

	function arg_1_0.__ischina_or_japan(arg_63_0)
		if var_0_17:isAuditVersion() then
			-- block empty
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_64_0)
	local var_64_0 = var_0_2:class("setting")

	var_64_0._out = "setting"
	var_64_0._user_data = {}
	var_64_0._is_already_init = false
	var_64_0._is_download_chinese_cv = false
	var_64_0._is_download_japanese_cv = false
	var_64_0._is_open_live2d = true
	var_64_0._main_seq = nil
	var_64_0._now_framerate = nil
	var_64_0._framerate_list = nil
	var_64_0._now_lable = nil
	var_64_0._now_cv_type = nil
	var_64_0._my_id = nil
	var_64_0._harmonious_step = {}
	var_64_0._harmonious_rule = {}

	gamecore.extend_obj(var_64_0)

	return var_64_0
end

return var_0_0
