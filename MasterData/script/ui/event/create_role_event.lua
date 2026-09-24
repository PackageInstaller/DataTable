local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_5 = gamecore.user
local var_0_6 = gameenum.config_data
local var_0_7 = gamecore.prompt
local var_0_8 = gameconfig.role_name_config
local var_0_9 = gameenum.common_type
local var_0_10 = lan_rand
local var_0_11 = gamecore.util_func
local var_0_12 = gameconfig.sensitive_words_config
local var_0_13 = gameenum.config_data.init_chatacter[4]

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_select_role_select_role_toggle_createrolename1()
		self._control.role.role_image.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.create_role_icon, tostring(1)))
		self._control.role.desc_bg.text.text.text = var_0_2:getNowLang("initshipdesc1")
		self._control.ship_type_detail.ship_role_name.text.text = var_0_2:getNowLang("createrolename1")
		self._control.ship_type_detail.ship_type_name.text.text = var_0_2:getNowLang("shiptypedetail12")
		var_0_13 = var_0_6.init_chatacter[4]
	end

	function arg_1_0:__onToggle_select_role_select_role_toggle_createrolename2()
		self._control.role.role_image.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.create_role_icon, tostring(2)))
		self._control.role.desc_bg.text.text.text = var_0_2:getNowLang("initshipdesc2")
		self._control.ship_type_detail.ship_role_name.text.text = var_0_2:getNowLang("createrolename2")
		self._control.ship_type_detail.ship_type_name.text.text = var_0_2:getNowLang("shiptypedetail12")
		var_0_13 = var_0_6.init_chatacter[3]
	end

	function arg_1_0:__onToggle_select_role_select_role_toggle_createrolename3()
		self._control.role.role_image.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.create_role_icon, tostring(3)))
		self._control.role.desc_bg.text.text.text = var_0_2:getNowLang("initshipdesc3")
		self._control.ship_type_detail.ship_role_name.text.text = var_0_2:getNowLang("createrolename3")
		self._control.ship_type_detail.ship_type_name.text.text = var_0_2:getNowLang("shiptypedetail12")
		var_0_13 = var_0_6.init_chatacter[2]
	end

	function arg_1_0:__onToggle_select_role_select_role_toggle_createrolename4()
		self._control.role.role_image.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.create_role_icon, tostring(4)))
		self._control.role.desc_bg.text.text.text = var_0_2:getNowLang("initshipdesc4")
		self._control.ship_type_detail.ship_role_name.text.text = var_0_2:getNowLang("createrolename4")
		self._control.ship_type_detail.ship_type_name.text.text = var_0_2:getNowLang("shiptypedetail12")
		var_0_13 = var_0_6.init_chatacter[1]
	end

	function arg_1_0:__onClick_select_role_create_next_btn()
		var_0_9:play_in_out_animation(self._control.select_role.uITweenSequence, true, function()
			var_0_9:play_in_out_animation(self._control.input_name.uITweenSequence, true, nil)
		end)

		self._control.title.signinselectshipconfirm.text.text = var_0_2:getNowLang("inputnickname")
		self._control.role.desc_bg.text.text.text = var_0_2:getNowLang("signinselectnametitle")
	end

	function arg_1_0:__onClick_select_role_account_merge_btn()
		self._control.account_merge:SetActive(true)
	end

	function arg_1_0:__onClick_input_name_random_btn()
		self._control.input_name.InputField.inputField.text = self:__get_name()
	end

	function arg_1_0:__onClick_input_name_start_game_btn()
		local var_10_0 = self._control.input_name.InputField.Text.text.text
		local var_10_1 = app:getSystem():getChannel()

		if (var_10_1 == var_0_9.channel.android_jp or var_10_1 == var_0_9.channel.iOS_jp) and var_0_11.calculate_utf8_char_length(var_10_0) > 40 then
			var_0_7:show(var_0_2:getNowLang("pre_formation_rename_tips"))

			return
		elseif var_10_1 ~= var_0_9.channel.android_jp and var_10_1 ~= var_0_9.channel.iOS_jp and var_0_11.calculate_utf8_char_length(var_10_0) > 16 then
			var_0_7:show(var_0_2:getNowLang("pre_formation_rename_tips"))

			return
		end

		if not self:__check_illegal_string(var_10_0) then
			return
		end

		for iter_10_0, iter_10_1 in pairs(var_0_6.init_chatacter) do
			if iter_10_1 == var_0_13 then
				self._start_ship = iter_10_0
			end
		end

		if not self._start_ship then
			log.errorlog("角色列表中没有该id")
		end

		var_0_5:req_ChangePlayerName(var_10_0)
	end

	function arg_1_0:__onClick_account_merge_merge_frame_content_close_btn()
		self._control.account_merge:SetActive(false)
	end

	function arg_1_0.__onClick_account_merge_merge_frame_content_confirm_btn(arg_12_0)
		return
	end

	function arg_1_0.__check_illegal_string(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = true

		if arg_13_1 == "" then
			var_0_7:show((var_0_2:getNowLang("errorcode-119")))

			var_13_0 = false
		else
			local var_13_1, var_13_2 = var_0_11.calculate_utf8_char_length(arg_13_1)

			for iter_13_0, iter_13_1 in pairs((var_0_12.get_sequence())) do
				if iter_13_1.word ~= "" and string.find(arg_13_1, iter_13_1.word, 1, true) ~= nil then
					var_13_0 = false

					local var_13_3 = var_0_5:get_account_id()

					var_0_5:req_SensitiveWordsReq({
						type = var_0_9.sensitive_words_type.user_name,
						sensitive_words = arg_13_1
					})

					break
				end
			end

			var_13_0 = var_13_0 and not var_0_11:filter_spec_chars(arg_13_1)

			if not var_13_0 or arg_13_2 then
				var_0_7:show((var_0_2:getNowLang("errorcode-129")))
			end
		end

		return var_13_0
	end

	function arg_1_0:__get_name_by_country(arg_14_1)
		local var_14_0, var_14_1 = var_0_8.get_sequence()
		local var_14_2 = var_0_8.find_object_by_id(var_14_0[var_0_10(1, #var_14_0)].id)

		if var_14_2.country == arg_14_1.country and var_14_2.first ~= arg_14_1.first then
			return var_14_2.rolename
		else
			return self:__get_name_by_country(arg_14_1)
		end
	end

	function arg_1_0:__get_name()
		local var_15_0, var_15_1 = var_0_8.get_sequence()
		local var_15_2 = var_0_8.find_object_by_id(var_15_0[var_0_10(1, #var_15_0)].id)
		local var_15_3 = ""
		local var_15_4 = ""

		if var_15_2.first == 1 then
			var_15_3 = var_15_2.rolename
			var_15_4 = self:__get_name_by_country(var_15_2)
		else
			var_15_3 = self:__get_name_by_country(var_15_2)
			var_15_4 = var_15_2.rolename
		end

		return var_15_3 .. var_15_4
	end
end

function var_0_0.extend_obj(arg_16_0)
	return
end

return var_0_0
