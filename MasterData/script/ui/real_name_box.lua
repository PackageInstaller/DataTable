local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = string.format
local var_0_8 = lx.json_encode
local var_0_9 = lx.http_request
local var_0_10 = lx.json_decode
local var_0_11 = gameenum.launch_common_type
local var_0_12 = gamecore.AuditServerManager
local var_0_13 = gamecore.prompt

gamecore.UILoader:define("real_name_box", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0.__do_real_name_auth(arg_3_0, arg_3_1)
		local var_3_0 = var_0_2:getInstance("enter_game")
		local var_3_1 = var_0_11:channel_back("real_name", var_0_12:isAuditVersion(), arg_3_1.channel)

		log.writelog_debug(var_3_1, "url")

		local var_3_2 = var_0_9:create()

		var_3_2:set_url(var_3_1)
		var_3_2:set_fields((var_0_8({
			token = arg_3_1.token,
			id_card = arg_3_1.id_card,
			name = arg_3_1.name,
			channel = arg_3_1.channel
		})))
		var_3_2:set_post()
		var_3_2:set_response_func(function(arg_4_0, arg_4_1)
			local var_4_0 = var_0_10(arg_4_1)

			if var_4_0.error == 0 then
				arg_3_0._repeat_num = 0

				var_3_0:show_wait(false)
				var_0_2:destroyInstance("real_name_box")
			elseif var_4_0.error == 21014 then
				arg_3_0:__show_error_tip()
			end

			var_0_13:show(var_4_0.errmsg)
		end)
		var_3_2:set_error_func(function(arg_5_0, arg_5_1)
			var_3_0:show_wait(false)

			if arg_3_0._repeat_num < 3 then
				arg_3_0._repeat_num = arg_3_0._repeat_num + 1

				arg_3_0:__do_real_name_auth(arg_3_1)
			else
				var_3_0:show_wait(false)
				var_0_13:show(var_0_1:getNowLang("errorofnetworknoconfirm"))
			end
		end)
		var_3_2:execute()
	end

	function arg_1_0:__init_panel(arg_6_1)
		self:__init_slider_listenter_one()
		self:__init_slider_listenter_two()

		self._control.main.main_text.text.text = "文化部《网络游戏管理暂行办法》要求，网络游戏用户需进行实名认证，请先进行实名认证在进入游戏。实名认证信息提交后不可修改，请慎重填写。未满18岁的用户，在游戏过程将受到防沉迷的提示。"

		if arg_6_1 then
			self._control.main.main_text.text.text = "文化部《网络游戏管理暂行办法》要求，网络游戏用户需进行实名认证，请先进行实名认证在进入游戏。实名认证信息提交后不可修改，请慎重填写。未满18岁的用户，在游戏过程将受到防沉迷的提示。" .. var_0_4("<color=#%s>%s</color>", "FF0000", "\n如您的实名认证信息未能通过验证，还请重新进行认证。")
		end
	end

	function arg_1_0:__show_error_tip()
		self._control.main.main_text.text.text = "文化部《网络游戏管理暂行办法》要求，网络游戏用户需进行实名认证，请先进行实名认证在进入游戏。实名认证信息提交后不可修改，请慎重填写。未满18岁的用户，在游戏过程将受到防沉迷的提示。" .. var_0_4("<color=#%s>%s</color>", "FF0000", "\n如您的实名认证信息未能通过验证，还请重新进行认证。")
	end

	function arg_1_0:__init_slider_listenter_one()
		self._control.main.input_main.inputfield_1.inputField.onEndEdit:RemoveAllListeners()
		self._control.main.input_main.inputfield_1.inputField.onEndEdit:AddListener(function()
			self._real_name = self._control.main.input_main.inputfield_1.inputField.text
		end)
	end

	function arg_1_0:__init_slider_listenter_two()
		self._control.main.input_main.inputfield_2.inputField.onEndEdit:RemoveAllListeners()
		self._control.main.input_main.inputfield_2.inputField.onEndEdit:AddListener(function()
			self._real_code = self._control.main.input_main.inputfield_2.inputField.text
		end)
	end

	function arg_1_0:_play_into_se(arg_12_1)
		self:playSE(arg_12_1, false)
	end

	function arg_1_0.__onReset(arg_13_0)
		arg_13_0._real_name = nil
		arg_13_0._real_code = nil
		arg_13_0._repeat_num = 0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_14_0)
	local var_14_0 = var_0_2:class("real_name_box")

	var_14_0._real_name = nil
	var_14_0._real_code = nil
	var_14_0._repeat_num = 0

	gamecore.extend_obj(var_14_0)

	return var_14_0
end

return var_0_0
