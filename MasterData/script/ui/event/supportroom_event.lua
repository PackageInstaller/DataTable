local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.AudioManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_back()
		var_0_3:destroyCV()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		var_0_1:destroyInstance("supportroom")

		local var_2_0 = var_0_1:createInstance("living_areas")

		var_2_0._already_init = true

		var_2_0:show(true)
	end

	function arg_1_0.__onClick_main_supportmap(arg_3_0)
		var_0_1:createInstance("supportlist"):show(true)
	end

	function arg_1_0.__onClick_main_supportbtn(arg_4_0)
		var_0_1:createInstance("supportlist"):show(true)
	end

	function arg_1_0.__onClick_main_grademap(arg_5_0)
		var_0_1:createInstance("gradeprogress"):show(true)
	end

	function arg_1_0.__onClick_main_gradebtn(arg_6_0)
		var_0_1:createInstance("gradeprogress"):show(true)
	end

	function arg_1_0.__onClick_menu_main_bubblezu_bubble(arg_7_0)
		return
	end

	function arg_1_0:__onClick_menu_main_bubblezu_support()
		self._control.menu.gameObject:SetActive(false)
		var_0_1:createInstance("supportlist"):show(true)
	end

	function arg_1_0:__onClick_menu_main_bubblezu_grade()
		self._control.menu.gameObject:SetActive(false)
		var_0_1:createInstance("gradeprogress"):show(true)
	end

	function arg_1_0.__onClick_main_btn(arg_10_0)
		return
	end

	function arg_1_0.__onClick_main_menubtn(arg_11_0)
		return
	end

	function arg_1_0:__onClick_menu_main_btn()
		self._control.menu.gameObject:SetActive(false)
	end

	function arg_1_0.__onClick_btn(arg_13_0)
		return
	end

	function arg_1_0:__onClick_menubtn()
		self._control.menu.gameObject:SetActive(true)
		self:show_btn_list_layer(self._control.menu.activeSelf)
	end

	function arg_1_0.__onPointerUp_main_supportmap(arg_15_0)
		return
	end

	function arg_1_0.__onPointerUp_main_grademap(arg_16_0)
		return
	end

	function arg_1_0:__onPointerDown_main_supportmap()
		self._control.main.supportmap.transform:SetAsLastSibling()
	end

	function arg_1_0:__onPointerDown_main_grademap()
		self._control.main.grademap.transform:SetAsLastSibling()
	end

	function arg_1_0.__onPointerClick_main_supportmap(arg_19_0)
		return
	end

	function arg_1_0.__onPointerClick_main_grademap(arg_20_0)
		return
	end

	function arg_1_0:__onClick_home_back()
		var_0_3:destroyCV()
		var_0_1:destroyInstance("supportroom")
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))

		local var_21_0 = var_0_1:createInstance("home")

		var_21_0:show(true)
		var_21_0:__init_panel()
		var_21_0:into_home_bgm()
	end
end

function var_0_0.extend_obj(arg_22_0)
	return
end

return var_0_0
