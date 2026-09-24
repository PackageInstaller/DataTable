local var_0_0 = {}
local var_0_1 = gamecore.AccountPlatform
local var_0_3 = gamecore.prompt
local var_0_5 = gamecore.util_func
local var_0_6 = gamecore.Language
local var_0_7 = {
	taptap = "taptap",
	hm_android_go_ios_small = "hm_android_to_ios",
	hm_android_jp = "hm_android_jp",
	hm_ios = "hm_sdk_ios",
	android_cbt = "android_cbt",
	default_self = "hm_sdk_lan",
	hm_android_go_ios = "hm_android_to_ios",
	ios_cbt = "hm_sdk_ios",
	hm_ios_jp = "hm_ios_jp",
	yyb = "yyb",
	xiaomi = "xiaomi",
	hm_android_small = "hm_sdk_android",
	hm_android = "hm_sdk_android"
}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_main_input_main_btn()
		local var_2_0 = app:getSystem():getChannel()
		local var_2_1

		for iter_2_0, iter_2_1 in pairs(var_0_7) do
			if var_2_0 == iter_2_0 then
				var_2_1 = iter_2_1
			end
		end

		local var_2_2 = var_0_1:getToken()

		if var_0_5.utf8len(self._real_code) ~= 18 or var_0_5.utf8len(self._real_name) == 0 then
			var_0_3:show(var_0_6:getNowLang("verify_error"))
		elseif var_2_1 and var_2_2 and self._real_code and self._real_name and var_0_5.check_card_str_valid(self._real_name) then
			self:__do_real_name_auth({
				channel = var_2_1,
				token = var_2_2,
				id_card = self._real_code,
				name = self._real_name
			})
		else
			var_0_3:show(var_0_6:getNowLang("verify_error"))
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
