local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_maintop_topmenu_returnbtn()
		self:reset_talk_dialog()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		var_0_4:set_in_bootyshop(false)

		local var_2_0 = var_0_1:createInstance("equip_type_layer")

		self._type_toggle_data = {
			"all"
		}

		var_2_0:show()
		var_2_0:set_listener(self._type_toggle_data[1], function()
			self._type_toggle_data = var_2_0._type_toggle_data

			self:__update_cell()
		end)

		self._control.type_btn.type_txt.text.text = var_0_2:getNowLang("shiptype0")

		var_2_0:setVisible(false)

		local var_2_1 = var_0_1:getInstance("equip_type_layer")

		if var_2_1 then
			var_2_1:__revert_toggle_group_all_set()
		end

		if self._enter_type == var_0_3.go_to_bootyshop.home_go then
			var_0_1:createInstance("home"):show()
		else
			var_0_5.return_home_with_menu_active()
		end

		local var_2_2 = var_0_1:getInstance("home")

		if var_2_2 and var_0_4:get_secretary_info().rand_secretary_flag == 1 then
			var_2_2:updata_model()
		end

		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, false)
		var_0_3:play_in_out_animation(self._now_content.uITweenSequence, false, function()
			if var_2_1 then
				var_2_1:reset_sort_info()
				var_0_1:destroyInstance("equip_type_layer")
			end

			self._filter_name = nil

			var_0_1:destroyInstance("bootyshop")
		end)
	end

	function arg_1_0:__onClick_npc_paintingbtn()
		self:_npc_talk()
	end

	function arg_1_0:__onClick_mainmid_close()
		self._control.mainmid:SetActive(false)
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnone()
		self:__update_search_name()
		self:__select_one("btnone")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btntwo()
		self:__update_search_name()
		self:__select_one("btntwo")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnthree()
		self:__update_search_name()
		self:__select_one("btnthree")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnfour()
		self:__update_search_name()
		self:__select_one("btnfour")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnfive()
		self:__update_search_name()
		self:__select_one("btnfive")
	end

	function arg_1_0.__onClick_mainprops_booty_equipimg_imgbtn(arg_12_0)
		return
	end

	function arg_1_0.__onClick_mainprops_booty_price(arg_13_0)
		return
	end

	function arg_1_0.__onClick_mainprops_booty_pricebtn(arg_14_0)
		return
	end

	function arg_1_0.__onClick_mainprops_main_scrollview_viewport_content_bootyone_equipimg_imgbtn(arg_15_0)
		return
	end

	function arg_1_0.__onClick_mainprops_main_scrollview_viewport_content_bootyone_price(arg_16_0)
		return
	end

	function arg_1_0:__onToggle_mainmid_change_btnone()
		self._control.mainmid:SetActive(false)
		self:_select_buy_one("btnone")
		self:updata_data()
		self:__set_spoils_data(self._data)
		self:__update_cell()
		self:__set__now_data(self._now_label)
	end

	function arg_1_0:__onToggle_mainmid_change_btntwo()
		self._control.mainmid:SetActive(false)
		self:_select_buy_one("btntwo")
		self:updata_data()
		self:__set_spoils_data(self._pc_data)
		self:__update_cell()
		self:__set__now_data(self._now_label)
	end

	function arg_1_0:__onToggle_mainmid_change_btnthree()
		self._control.mainmid:SetActive(false)
		self:_select_buy_one("btnthree")
		self:updata_data()
		self:__set_spoils_data(self._ac_data)
		self:__update_cell()
		self:__set__now_data(self._now_label)
	end

	function arg_1_0:__onToggle_mainmid_change_btnfour()
		self._control.mainmid:SetActive(false)
		self:_select_buy_one("btnfour")
		self:updata_data()
		self:__set_spoils_data(self._can_buy_data)
		self:__update_cell()
		self:__set__now_data(self._now_label)
	end

	function arg_1_0:__onClick_type_btn()
		local var_21_0 = var_0_1:createInstance("equip_type_layer")

		var_21_0:show()

		if self._need_revert then
			var_21_0:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		var_21_0:__save_toggle_group_all_set_data()
	end

	function arg_1_0:__onClick_bg_shadw()
		self._control.bg_shadw.gameObject:SetActive(false)
		self._equip_attr:setVisible(false)
	end

	function arg_1_0:__onClick_change_changebtnone()
		self._control.mainmid:SetActive(true)
	end

	function arg_1_0:__onScaleButtonClick_maintop_topmenu_returnbtn()
		self:__onClick_maintop_topmenu_returnbtn()
	end
end

function var_0_0.extend_obj(arg_25_0)
	return
end

return var_0_0
