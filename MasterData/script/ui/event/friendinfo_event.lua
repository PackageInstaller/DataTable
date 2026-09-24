local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.prompt
local var_0_9 = gamecore.AudioManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_close()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:setVisible(false)
	end

	function arg_1_0:__onClick_main_delfriend()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		local var_3_0 = var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")
		local var_3_1 = var_0_1:createInstance("friendsmain")

		var_3_0:show(string.format(var_0_6:getNowLang("delfriendwarn"), self._friends_data[self._friends_index + 1].name), function()
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
			var_0_4:req_removeallfriend(self._friends_data[self._friends_index + 1].account_id)
			var_3_1:updata_data()
			self:setVisible(false)
		end, function()
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		end, var_0_6:getNowLang("delfriendtitle"), var_0_3.msg_type.tip, nil)
	end

	function arg_1_0:__onClick_main_visit()
		var_0_9:destroyCV()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		local var_6_0 = var_0_1:getInstance("friendsmain")

		if self._is_frineds then
			if var_0_1:getInstance("friendinfo") then
				var_0_1:destroyInstance("friendinfo")
			end

			if var_6_0 then
				var_6_0._is_play_bg = true

				var_6_0:setVisible(false)
			end

			var_0_1:createInstance("show_room"):show(self._friends_data[self._friends_index + 1].account_id, var_0_3.show_room_enter_type.friend, true)
		else
			local var_6_1 = var_0_4:get_cardbook_user_info(self._friends_data.account_id)

			if var_6_1 then
				var_0_1:createInstance("show_room"):show(lx.json_decode(var_6_1.json_data), var_0_3.show_room_enter_type.cardbook_and_no_friend, true)
				self:setVisible(false)
			else
				var_0_7:show(var_0_6:getNowLang("no_friend"))
			end
		end
	end

	function arg_1_0:__onClick_main_top_stick()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		var_0_4:req_topfriendstatereq(self._friends_data[self._friends_index + 1].account_id)
		self:setVisible(false)
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
