local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = string.format
local var_0_4 = Mathf.Clamp
local var_0_5 = gamecore.util_func
local var_0_6 = UnityEngine.RectTransformUtility
local var_0_7 = UnityEngine.Input
local var_0_8 = {
	"dock_team_btn",
	"dock_btn",
	"remake_btn",
	"restaurant_btn",
	"repair_btn",
	"equipment_btn"
}
local var_0_9 = {
	{
		{
			x = 203.4,
			y = 341
		},
		{
			x = 392,
			y = 10
		},
		{
			x = 77,
			y = 3.5
		},
		{
			x = 42,
			y = 62
		}
	},
	{
		{
			x = 189.7,
			y = 349.6
		},
		{
			x = -191.1,
			y = 349.6
		},
		{
			x = -31.7,
			y = 68.4
		},
		{
			x = 36,
			y = 73.7
		}
	},
	{
		{
			x = -205,
			y = 338
		},
		{
			x = -392.8,
			y = 6
		},
		{
			x = -75,
			y = 8
		},
		{
			x = -43,
			y = 64
		}
	},
	{
		{
			x = -396,
			y = -5
		},
		{
			x = -225,
			y = -339
		},
		{
			x = -43,
			y = -64
		},
		{
			x = -77,
			y = -5
		}
	},
	{
		{
			x = -32.2,
			y = -67
		},
		{
			x = -190,
			y = -350
		},
		{
			x = 192,
			y = -350
		},
		{
			x = 34,
			y = -67
		}
	},
	{
		{
			x = 43,
			y = -66
		},
		{
			x = 210,
			y = -344
		},
		{
			x = 396,
			y = -0.6
		},
		{
			x = 74,
			y = -4
		}
	}
}

gamecore.UILoader:define("shortcut_menu", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__set_content_position(arg_2_1)
		self:__init_panel()
	end

	function arg_1_0:__onUpdate()
		if not self._in_check then
			return
		end

		local var_3_0 = self:__check_mouse_local_pos()

		if var_3_0 then
			self:__change_btn_hight_light_by_part((self:__get_part_index_by_mouse_pos(var_3_0)))
		end
	end

	function arg_1_0:__check_mouse_move()
		if not self._last_mouse_pos or var_0_7.mousePosition == self._last_mouse_pos then
			return false
		end

		self._last_mouse_pos = var_0_7.mousePosition

		return var_0_7.mousePosition
	end

	function arg_1_0:__get_all_menu_graphical_max_and_min_xy()
		self._menu_max_min_xy_list = {}

		for iter_5_0 = 1, #var_0_9 do
			self._menu_max_min_xy_list[iter_5_0] = self:__get_max_and_min_xy(var_0_9[iter_5_0])
		end
	end

	function arg_1_0.__get_max_and_min_xy(arg_6_0, arg_6_1)
		if not arg_6_1 or #arg_6_1 <= 1 then
			return
		end

		local var_6_4 = arg_6_1[1].x
		local var_6_5 = arg_6_1[1].y
		local var_6_6 = arg_6_1[1].x
		local var_6_7 = arg_6_1[1].y

		for iter_6_0 = 2, #arg_6_1 do
			var_6_4 = arg_6_1[iter_6_0].x < var_6_4 and arg_6_1[iter_6_0].x or var_6_4
			var_6_5 = arg_6_1[iter_6_0].y < var_6_5 and arg_6_1[iter_6_0].y or var_6_5
			var_6_6 = var_6_6 < arg_6_1[iter_6_0].x and arg_6_1[iter_6_0].x or var_6_6
			var_6_7 = var_6_7 < arg_6_1[iter_6_0].y and arg_6_1[iter_6_0].y or var_6_7
		end

		return {
			min_x = var_6_4,
			min_y = var_6_5,
			max_x = var_6_6,
			max_y = var_6_7
		}
	end

	function arg_1_0:__get_part_index_by_mouse_pos(arg_7_1)
		for iter_7_0 = 1, #var_0_9 do
			if self:__check_pos_if_in_graphical(iter_7_0, arg_7_1) then
				return iter_7_0
			end
		end

		return 0
	end

	function arg_1_0:__check_pos_if_in_graphical(arg_8_1, arg_8_2)
		if not arg_8_1 or arg_8_1 <= 0 or arg_8_1 > #var_0_9 then
			return
		end

		local var_8_0 = var_0_9[arg_8_1]
		local var_8_1 = arg_8_2.x
		local var_8_2 = arg_8_2.y

		if var_0_5.num_clamp(arg_8_2.x, self._menu_max_min_xy_list[arg_8_1].max_x, self._menu_max_min_xy_list[arg_8_1].min_x) ~= arg_8_2.x or var_0_5.num_clamp(arg_8_2.y, self._menu_max_min_xy_list[arg_8_1].max_y, self._menu_max_min_xy_list[arg_8_1].min_y) ~= arg_8_2.y then
			return false
		end

		local var_8_3 = #var_8_0
		local var_8_4 = 0

		for iter_8_0 = 1, #var_8_0 do
			if iter_8_0 < var_8_3 then
				local var_8_5 = iter_8_0 + 1
				local var_8_6

				if not (iter_8_0 + 1) then
					var_8_5 = 1
					var_8_6 = var_8_1 >= var_8_0[var_8_5].x and var_8_1 < var_8_0[iter_8_0].x
				end

				if (var_8_1 >= var_8_0[iter_8_0].x and var_8_1 < var_8_0[var_8_5].x or var_8_6) and var_8_2 < (var_8_0[var_8_5].y - var_8_0[iter_8_0].y) / (var_8_0[var_8_5].x - var_8_0[iter_8_0].x) * (var_8_1 - var_8_0[iter_8_0].x) + var_8_0[iter_8_0].y then
					var_8_4 = var_8_4 + 1
				end
			end
		end

		return var_8_4 ~= 0 and var_8_4 % 2 ~= 0
	end

	function arg_1_0.__calculate_part_by_angle(arg_9_0, arg_9_1, arg_9_2)
		return math.ceil(arg_9_1 / arg_9_2)
	end

	function arg_1_0:__change_btn_hight_light_by_part(arg_10_1)
		if self._current_part == arg_10_1 then
			return
		end

		self._current_part = arg_10_1

		self:high_light_effect((arg_10_1 > 0 or nil) and (var_0_8[self:__get_name_index_by_part(arg_10_1)] or ""))
	end

	function arg_1_0:__check_mouse_local_pos()
		local var_11_0 = self:__check_mouse_move()

		if not var_11_0 then
			return
		end

		self._ui_camera = self._ui_camera or var_0_5.get_ui_camera()
		self._check_rect = self._check_rect or self._control.content.rectTransform

		local var_11_1, var_11_2 = var_0_6.ScreenPointToLocalPointInRectangle(self._check_rect, var_11_0, self._ui_camera, nil)

		return var_11_2
	end

	function arg_1_0:__get_name_index_by_part(arg_12_1)
		self._image_index_table = self._image_index_table or {
			2,
			1,
			3,
			5,
			4,
			6
		}

		if arg_12_1 > 0 and arg_12_1 < 7 then
			return self._image_index_table[arg_12_1]
		end

		return 0
	end

	function arg_1_0:high_light_effect(arg_13_1)
		for iter_13_0, iter_13_1 in pairs(var_0_8) do
			if arg_13_1 == iter_13_1 then
				if self._now_lable then
					self:__reset_last_icon()
				end

				self._now_lable = arg_13_1
				self._control.content[self._now_lable].image.sprite = self:loadSprite(var_0_3(var_0_2.extra.main_btn_b, iter_13_0))
				self._is_hight_light = true

				return
			end
		end
	end

	function arg_1_0:click_event(arg_14_1)
		for iter_14_0, iter_14_1 in pairs(var_0_8) do
			if arg_14_1 == iter_14_1 and self._is_hight_light == true then
				self["__onClick_content_" .. arg_14_1](self)
			end
		end
	end

	function arg_1_0:__init_panel()
		self._last_mouse_pos = Vector2.zero
		self._in_check = true
		self._current_part = 0

		self:__reset_last_icon()
		self:__init_last_icon()
		var_0_2:play_in_out_animation(self._control.content.uITweenSequence, true)

		if not self._menu_max_min_xy_list then
			self:__get_all_menu_graphical_max_and_min_xy()
		end
	end

	function arg_1_0:__set_content_position(arg_16_1)
		arg_16_1.x = var_0_4(arg_16_1.x * self._panel.transform.sizeDelta.x, self._control.content.rectTransform.sizeDelta.x / 2, self._panel.transform.sizeDelta.x - self._control.content.rectTransform.sizeDelta.x / 2)
		arg_16_1.y = var_0_4(arg_16_1.y * self._panel.transform.sizeDelta.y, self._control.content.rectTransform.sizeDelta.y / 2, self._panel.transform.sizeDelta.y - self._control.content.rectTransform.sizeDelta.y / 2)
		self._control.content.rectTransform.anchoredPosition = arg_16_1
	end

	function arg_1_0:__reset_last_icon()
		if self._now_lable then
			for iter_17_0, iter_17_1 in pairs(var_0_8) do
				if self._now_lable == iter_17_1 then
					self._control.content[self._now_lable].image.sprite = self:loadSprite(var_0_3(var_0_2.extra.main_btn_a, iter_17_0))
					self._is_hight_light = false
				end
			end
		end
	end

	function arg_1_0:__init_last_icon()
		for iter_18_0, iter_18_1 in pairs(var_0_8) do
			self._control.content[iter_18_1].image.sprite = self:loadSprite(var_0_3(var_0_2.extra.main_btn_a, iter_18_0))
			self._is_hight_light = false
			self._control.content[iter_18_1].image.alphaHitTestMinimumThreshold = 0.1
		end
	end

	function arg_1_0:__init_language()
		if gamecore.util_func.check_channel_is_en() then
			gamecore.util_func.setTextHorizonInfo(self._control.content.dock_team_btn.title_mask, Language:getNowLang("fleet_battle"))
			gamecore.util_func.setTextHorizonInfo(self._control.content.dock_btn.title_mask, Language:getNowLang("btnbuild"))
			gamecore.util_func.setTextHorizonInfo(self._control.content.remake_btn.title_mask, Language:getNowLang("strengthen"))
			gamecore.util_func.setTextHorizonInfo(self._control.content.restaurant_btn.title_mask, Language:getNowLang("canteen"))
			gamecore.util_func.setTextHorizonInfo(self._control.content.repair_btn.title_mask, Language:getNowLang("bath_house"))
			gamecore.util_func.setTextHorizonInfo(self._control.content.equipment_btn.title_mask, Language:getNowLang("te"))
		end
	end

	function arg_1_0.__onReset(arg_20_0)
		arg_20_0._in_check = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_21_0)
	local var_21_0 = var_0_1:class("shortcut_menu")

	var_21_0._now_lable = ""
	var_21_0._is_hight_light = false

	return var_21_0
end

return var_0_0
