local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnone()
		self:__select_one("btnone")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btntwo()
		self:__select_one("btntwo")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnthree()
		self:__select_one("btnthree")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnfour()
		self:__select_one("btnfour")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnfive()
		self:__select_one("btnfive")
	end

	function arg_1_0:__onScaleButtonClick_maintop_topmenu_returnbtn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))

		if self._enter_type == var_0_3.combat_shop_enter_type.home then
			var_0_5.return_home_with_menu_active()
			var_0_3:play_in_out_animation(self.__now_content.uITweenSequence, false, function()
				var_0_1:destroyInstance("combat_shop")
			end)

			local var_7_0 = var_0_1:getInstance("home")

			if var_7_0 and var_0_4:get_secretary_info().rand_secretary_flag == 1 then
				var_7_0:updata_model()
			end
		else
			local var_7_1 = var_0_1:getInstance("six_year_main_interface")

			var_0_3:play_in_out_animation(self.__now_content.uITweenSequence, false, function()
				var_0_1:destroyInstance("combat_shop")
				var_7_1:setVisible(true)
			end)
		end

		self:__set_scroll_to_top()
		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, false)
	end

	function arg_1_0:__onClick_bg_shadow()
		self._control.bg_shadow.gameObject:SetActive(false)
		self._equip_attr:setVisible(false)
	end

	function arg_1_0.__onClick_shop_bounced_main_confirmbtn(arg_11_0)
		return
	end

	function arg_1_0:__onClick_shop_bounced_main_quitbtn()
		self._control.shop_bounced:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
