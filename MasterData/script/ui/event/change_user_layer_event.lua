local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.error_type
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.sensitive_words_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_main_confirmbtn()
		self._user_name = var_0_1:get_name()

		local var_2_0 = self._control.main.InputField:GetComponent("InputField").text

		if var_2_0 == "" or not self:__check_illegal_string(var_2_0) then
			var_0_2:show(var_0_4:getNowLang("not_name"))
		elseif self._user_name == var_2_0 then
			var_0_2:show(var_0_6:get_err_msg(37))
		else
			local var_2_1 = app:getSystem():getChannel()

			if (var_2_1 == var_0_7.channel.android_jp or var_2_1 == var_0_7.channel.iOS_jp) and var_0_5.calculate_utf8_char_length(var_2_0) > 40 then
				var_0_2:show(var_0_4:getNowLang("pre_formation_rename_tips"))

				return
			elseif var_2_1 ~= var_0_7.channel.android_jp and var_2_1 ~= var_0_7.channel.iOS_jp and var_0_5.calculate_utf8_char_length(var_2_0) > 16 then
				var_0_2:show(var_0_4:getNowLang("pre_formation_rename_tips"))

				return
			end

			var_0_3:createInstance("shop_bounced"):show({
				title = self._now_change_data.title,
				price = self._now_change_data.price,
				type = self._now_change_data.type,
				id = self._now_change_data.id,
				name = var_2_0,
				lang_title = var_0_4:getNowLang("renamerequire")
			}, var_0_7.buy_enter_type.mall_shop)
			self:setVisible(false)
		end
	end

	function arg_1_0:__onScaleButtonClick_main_closebtn()
		self:setVisible(false)
	end

	function arg_1_0.__check_illegal_string(arg_4_0, arg_4_1)
		local var_4_0 = true
		local var_4_1, var_4_2 = var_0_5.calculate_utf8_char_length(arg_4_1)

		for iter_4_0, iter_4_1 in pairs((var_0_8.get_sequence())) do
			if iter_4_1.word ~= "" and string.find(arg_4_1, iter_4_1.word, 1, true) ~= nil then
				var_4_0 = false

				local var_4_3 = var_0_1:get_account_id()

				var_0_1:req_SensitiveWordsReq({
					type = var_0_7.sensitive_words_type.user_name,
					sensitive_words = arg_4_1
				})

				break
			end
		end

		var_4_0 = var_4_0 and not var_0_5:filter_spec_chars(arg_4_1)

		if not var_4_0 then
			var_0_2:show((var_0_4:getNowLang("errorcode-129")))
		end

		return var_4_0
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
