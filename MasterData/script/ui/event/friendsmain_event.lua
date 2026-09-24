local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_7 = gamecore.prompt
local var_0_8 = gamecore.Language
local var_0_9 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnone()
		self:updata_data()

		self._is_play = true

		if not self._current_panel_index or self._current_panel_index ~= 1 then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

			self._current_panel_index = 1
		end

		self:__select_one("btnone")
		self._control.maintop.friendsinfo:SetActive(true)
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btntwo()
		self:updata_data()

		self._is_play = true

		if not self._current_panel_index or self._current_panel_index ~= 2 then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
			self:__select_one("btntwo")
			self._control.maintop.friendsinfo:SetActive(false)

			if #self._now_data == 0 or not self._now_data then
				var_0_7:show(var_0_8:getNowLang("noapplicantlabel"))
			end

			self._current_panel_index = 2
		end

		self:updata_data()
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnthree()
		self:updata_data()

		self._is_play = true

		if not self._current_panel_index or self._current_panel_index ~= 3 then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		end

		self:__select_one("btnthree")
		self._control.maintop.friendsinfo:SetActive(false)

		self._current_panel_index = 3
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnfour()
		self:updata_data()

		self._is_play = true

		if not self._current_panel_index or self._current_panel_index ~= 4 then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

			if self._now_label == "btnfour" then
				return
			end

			self._current_panel_index = 4

			var_0_9:req_getrecommendlist()
			self:__select_one("btnfour")
			self._control.maintop.friendsinfo:SetActive(false)
		end
	end

	function arg_1_0.__onToggle_all_do_makefriends_addfriends_main_toggle(arg_6_0, arg_6_1)
		if arg_6_1 ~= var_0_9:get_use_recommend_off() then
			return
		end

		local var_6_0 = var_0_9:get_use_info_data()

		var_0_9:req_getrecommendreq()
	end

	function arg_1_0.__onClick_friendinfo_main_close(arg_7_0)
		return
	end

	function arg_1_0.__onClick_friendinfo_main_delfriend(arg_8_0)
		return
	end

	function arg_1_0.__onClick_friendinfo_main_visit(arg_9_0)
		return
	end

	function arg_1_0.__onToggle_makefriends_addfriends_main_toggle(arg_10_0)
		return
	end

	function arg_1_0:__onScaleButtonClick_maintop_topmenu_returnbtn()
		self._is_play_bg = true

		var_0_1:destroyInstance("friendinfo")
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		var_0_2:play_in_out_animation(self._now_content.uITweenSequence, false, function()
			var_0_1:destroyInstance("friendsmain")

			if self._enter_type == "home" then
				local var_12_0 = var_0_1:getInstance("home")

				var_12_0:setVisible(true)
				var_12_0:show()
				var_12_0:update_friend_float()
			else
				local var_12_1 = var_0_1:createInstance("main_menu")

				var_12_1:reset()
				var_12_1:show(false)
				var_12_1:set_home_active(true)

				local var_12_2 = var_0_1:getInstance("home")

				if var_12_2 then
					var_12_2:setVisible(true)
					var_12_2:show()
					var_12_2:updata_model()
				end
			end
		end)
		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false)
	end

	function arg_1_0:__onScaleButtonClick_makefriends_addfriends_main_send()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

		self._friend_uid = self._control.makefriends.addfriends.main.inputfieldmaybe.inputField.text

		if self._button_isuse == false then
			return
		end

		local var_13_0 = var_0_9:get_account_id()

		self._button_isuse = false

		if not self._friend_uid or self._friend_uid == "" then
			var_0_7:show(var_0_8:getNowLang("friendnonentity"))
			self:button_flag(true)
		elseif self._user_have_friends ~= nil and #self._user_have_friends >= 60 then
			var_0_7:show(var_0_8:getNowLang("friend_full"))
			self:button_flag(true)
		elseif tonumber(self._friend_uid) == var_13_0 then
			var_0_7:show(var_0_8:getNowLang("addselferr"))
			self:button_flag(true)
		elseif type(tonumber(self._friend_uid)) ~= "number" then
			var_0_7:show(var_0_8:getNowLang("friendnonentity"))
			self:button_flag(true)
		else
			var_0_9:req_addfriendreq(self._friend_uid)
		end
	end

	function arg_1_0:__onScaleButtonClick_mainapplyfor_undealwith_allrefuse()
		if #self._addfriend_array ~= 0 then
			var_0_1:createInstance("msgbox"):show(var_0_8:getNowLang("refusealllabel"), function()
				var_0_9:req_removeallfriendreq()
			end, nil, var_0_8:getNowLang("refuseall"), var_0_2.msg_type.tip)
		else
			var_0_7:show(var_0_8:getNowLang("noapplicantlabel"))
		end
	end

	function arg_1_0:__onScaleButtonClick_maintop_refresh_refreshbtn()
		if self._button_isuse == false then
			return
		end

		self._button_isuse = false

		var_0_9:req_getrecommendlist()
		self:updata_data()
	end
end

function var_0_0.extend_obj(arg_17_0)
	return
end

return var_0_0
