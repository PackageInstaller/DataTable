local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.SubPatchManager
local var_0_4 = gamecore.user
local var_0_5 = gamecore.prompt
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.SceneManager
local var_0_8 = gamecore.AuditServerManager
local var_0_9 = HMSDKManager.Instance
local var_0_10 = lx.UserData

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_main_close()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		var_0_1:play_in_out_animation(self._main_seq, false, function()
			var_0_2:destroyInstance("setting")
		end)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_cv_main_cv_select_japanesecv()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))

		self._now_lable = 1

		if var_0_3:getIsDownloadPatch("cv_jp") then
			var_0_3:setSelectCV("cv_jp")
			self:__show_cv_layer(true)
		else
			self:__click_cv_event(var_0_1.now_cv_language.japanese_cv)
		end
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_cv_main_cv_select_chinese()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))

		self._now_lable = 1

		if var_0_3:getIsDownloadPatch("cv_cn") then
			var_0_3:setSelectCV("cv_cn")
			self:__show_cv_layer(true)
		else
			self:__click_cv_event(var_0_1.now_cv_language.chinses_cv)
		end
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_cv_main_cv_ok_uibm()
		if var_0_8:isAuditVersion() then
			local var_6_0 = app:getSystem():getChannel()

			if var_6_0 ~= var_0_1.channel.android_xiaomi and var_6_0 ~= var_0_1.channel.android_yyb then
				return
			end
		end

		self:__reset_harmonious_step()
		self:__show_cv_layer(false)
	end

	function arg_1_0:__onScaleButtonClick_main_srescheck()
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))
		self._control.shadw:SetActive(false)
		self._control.main:SetActive(false)

		self._now_lable = 2

		local var_7_0 = app:getSystem():getChannel()

		if var_7_0 == var_0_1.channel.iOS_cn or var_7_0 == var_0_1.channel.iOS_jp or var_7_0 == var_0_1.channel.android_jp then
			self:__show_tip_layer_by_index(true)
		else
			self:__show_repair_page()
		end
	end

	function arg_1_0:__onScaleButtonClick_main_sbtnback()
		local var_8_0 = var_0_2:getInstance("home")

		if var_8_0 then
			var_8_0:destroy_live2d()
		end

		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:__show_layer(false)
		var_0_4:set_cur_click_team_index(1)
		self:__return_login()
	end

	function arg_1_0:__onScaleButtonClick_main_exchange()
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))
		self:__show_exchange_layer(true)
	end

	function arg_1_0:__onClick_shadw()
		self:__show_cv_layer(true)
	end

	function arg_1_0:__onClick_tip_tip_layer_confirm_btn()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))

		if self._now_lable == 1 then
			if self._now_cv_type == var_0_1.now_cv_language.chinses_cv then
				self:setVisible(false)
				var_0_3:downLoadSubPatch("cv_cn")
			elseif self._now_cv_type == var_0_1.now_cv_language.japanese_cv then
				self:setVisible(false)
				var_0_3:downLoadSubPatch("cv_jp")
			end
		elseif self._now_lable == 2 then
			var_0_7:restart()
		elseif self._now_lable == 3 then
			-- block empty
		end
	end

	function arg_1_0:__onClick_tip_tip_layer_cancel_btn()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		self:__show_tip_layer_by_index(false)

		if self._now_lable == 2 then
			self:setVisible(false)
		end
	end

	function arg_1_0:__onScaleButtonClick_exchange_bg_container_close_btn()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		self:__show_exchange_layer(false)
	end

	function arg_1_0:__onClick_exchange_bg_container_confirm_btn()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))

		local var_14_0 = self:__get_input_redeem_code()

		if var_14_0 == "" then
			var_0_5:show(var_0_6:getNowLang("errorcode-1201"))

			return
		end

		var_0_4:req_RedeemCodeReq((string.gsub(var_14_0, "^%s+", "")))
	end

	function arg_1_0:__onClick_tip2_tip_layer_confirm_btn()
		var_0_3:downLoadSubPatch("data2")
		self._control.tip2:SetActive(false)
		var_0_2:destroyInstance("setting")
	end

	function arg_1_0.__onScaleButtonClick_main_settingrule_btn(arg_16_0)
		local var_16_0 = app:getSystem():getChannel()

		if var_16_0 == var_0_1.channel.iOS_jp or var_16_0 == var_0_1.channel.android_jp then
			var_0_2:destroyInstance("setting")
			var_0_2:createInstance("jp_setting_rule_page"):show()
		elseif var_16_0 == var_0_1.channel.hm_android_en or var_16_0 == var_0_1.channel.ios_en then
			-- block empty
		else
			var_0_2:createInstance("phone_binding"):show()
		end
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_bind_email_address_email_address()
		self._control.shadw:SetActive(false)
		self._control.main:SetActive(false)
		self:__show_tip_email()
	end

	function arg_1_0:__onClick_email_tip_tip_layer_confirm_btn()
		self:edit_team_name()
	end

	function arg_1_0:__onClick_email_tip_tip_layer_cancel_btn()
		self._control.email_tip:SetActive(false)
	end

	function arg_1_0.__onScaleButtonClick_main_set_main_hd_picture_main_select_definition(arg_20_0)
		return
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_always_light_scene_change_main_always_light_control_left()
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:__set_always_light_change(false)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_always_light_scene_change_main_always_light_control_right()
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:__set_always_light_change(true)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_always_light_scene_change_main_scene_change_control_left()
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:__set_login_scene_change(false)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_always_light_scene_change_main_scene_change_control_right()
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:__set_login_scene_change(true)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_live2d_framerate_main_live2d_control_left()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:__click_live2d_event(false, false)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_live2d_framerate_main_live2d_control_right()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__show_cv_layer(true)
		self:__reset_harmonious_step()
		self:__click_live2d_event(true, false)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_live2d_framerate_main_framerate_control_left()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__show_cv_layer(true)
		self:__click_framerate_event(-1)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_live2d_framerate_main_framerate_control_right()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__show_cv_layer(true)
		self:__click_framerate_event(1)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_hd_picture_main_picture_select_normal()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))
		var_0_3:setSelectPictureDefinition("picture_normal")
		self:__click_picture_event(var_0_1.now_picture_type.normal)

		if var_0_1.open_hd_picture then
			var_0_2:createInstance("launch_msgbox"):show(var_0_6:getNowLang("picture_set_normal"), function()
				app:restart()
			end)
		end
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_hd_picture_main_picture_select_hd()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))

		if var_0_3:isDataHDNeedUpdate() then
			var_0_3:setSelectPictureDefinition("picture_hd")
			var_0_3:downloadDataHD()
			self:setVisible(false)
		else
			var_0_3:setSelectPictureDefinition("picture_hd")
			self:__show_picture_layer(true)

			if not var_0_1.open_hd_picture then
				var_0_2:createInstance("launch_msgbox"):show(var_0_6:getNowLang("picture_set_hd"), function()
					app:restart()
				end)
			end
		end
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_hd_picture_main_picture_ok_uibm()
		if var_0_8:isAuditVersion() then
			local var_33_0 = app:getSystem():getChannel()

			if var_33_0 ~= var_0_1.channel.android_xiaomi and var_33_0 ~= var_0_1.channel.android_yyb then
				return
			end
		end

		self:__reset_harmonious_step()
		self:__show_picture_layer(false)
	end

	function arg_1_0:__onScaleButtonClick_main_contact_us()
		self:__reset_harmonious_step()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))
		var_0_2:createInstance("msgbox"):showOne(var_0_6:getNowLang("contact_desc"), function()
			self._control.tip:SetActive(false)
		end, (var_0_6:getNowLang("signininvitecodebtn")))
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_battle_scene_battle_scene_control_left()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__reset_harmonious_step()
		self:__click_battle_scene_event(false, false)
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_battle_scene_battle_scene_control_right()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__reset_harmonious_step()
		self:__click_battle_scene_event(true, false)
	end

	function arg_1_0.__onClick_tip1_tip_layer_confirm_btn(arg_38_0)
		return
	end

	function arg_1_0.__onClick_tip1_tip_layer_cancel_btn(arg_39_0)
		return
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_battle_scene_broken_control_left()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__reset_harmonious_step()
		self:__click_borken_event(false, false)
		var_0_9:SignOutNowPlayer()
	end

	function arg_1_0:__onScaleButtonClick_main_set_main_battle_scene_broken_control_right()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:__reset_harmonious_step()
		self:__click_borken_event(true, false)
		var_0_9:SignOutNowPlayer()
	end

	function arg_1_0.__onScaleButtonClick_main_set_main_cv_main_app_inquire_btn(arg_42_0)
		return
	end

	function arg_1_0.__onScaleButtonClick_main_set_main_app_inquire_main_app_inquire_btn(arg_43_0)
		UnityEngine.Application.OpenURL("https://beian.miit.gov.cn/")
	end

	function arg_1_0.__onClick_tip3_tip_layer_all_btn_repair_data_btn(arg_44_0)
		local var_44_0 = app:getSystem():getDataVersion()

		if var_0_10:getKeyData("save_first_dataversion") == "" then
			var_0_5:show(var_0_6:getNowLang("记录丢失，无法校验"))

			return
		end

		if var_0_10:getKeyData("save_first_dataversion") == var_44_0 then
			app:restart()
		elseif var_44_0 ~= var_0_10:getKeyData("save_first_dataversion") then
			var_0_3:deleteDataMain()
			var_0_7:restart()
		end
	end

	function arg_1_0.__onClick_tip3_tip_layer_all_btn_repair_data2_btn(arg_45_0)
		var_0_3:deleteDataTwo()
		var_0_7:restart()
	end

	function arg_1_0.__onClick_tip3_tip_layer_all_btn_repair_datahd_btn(arg_46_0)
		var_0_3:deleteDataHD()
		var_0_7:restart()
	end

	function arg_1_0:__onClick_tip3_tip_layer_all_btn_cancel_btn()
		self._control.main:SetActive(true)
		self._control.tip3:SetActive(false)
		self._control.shadw:SetActive(true)
	end

	function arg_1_0.__onClick_tip3_tip_layer_all_btn_repair_datacv_btn(arg_48_0)
		var_0_3:deleteDataCv()
		var_0_7:restart()
	end

	function arg_1_0.__onClick_tip3_tip_layer_all_btn_repair_datacv_jp_btn(arg_49_0)
		var_0_3:deleteDataCvJp()
		var_0_7:restart()
	end

	function arg_1_0.__onScaleButtonClick_main_set_main_app_inquire_main_app_user(arg_50_0)
		var_0_2:createInstance("msgbox_agreement_cn"):show(1)
	end

	function arg_1_0.__onScaleButtonClick_main_set_main_app_inquire_main_app_privacy(arg_51_0)
		var_0_2:createInstance("msgbox_agreement_cn"):show(2)
	end

	function arg_1_0.__onScaleButtonClick_main_set_main_app_inquire_main_app_three(arg_52_0)
		var_0_2:createInstance("msgbox_agreement_cn"):show(3)
	end

	function arg_1_0.__onScaleButtonClick_main_set_main_app_inquire_main_app_child(arg_53_0)
		var_0_2:createInstance("msgbox_agreement_cn"):show(4)
	end
end

function var_0_0.extend_obj(arg_54_0)
	return
end

return var_0_0
