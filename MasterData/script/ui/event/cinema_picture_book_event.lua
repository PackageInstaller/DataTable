local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameconfig.ship_cg_config

function var_0_0.extend_method(arg_1_0)
	local var_1_0 = 0

	function arg_1_0:__onClick_return_btn()
		self:__exit()

		var_1_0 = 0
		self._book_pages = 1

		var_0_1:destroyInstance("cinema_picture_book")
		var_0_1:createInstance("cinema"):setVisible(true)
	end

	function arg_1_0.__onClick_cg_1_btn(arg_3_0)
		return
	end

	function arg_1_0.__onClick_cg_2_btn(arg_4_0)
		return
	end

	function arg_1_0.__onClick_cg_3_btn(arg_5_0)
		return
	end

	function arg_1_0.__onClick_cg_4_btn(arg_6_0)
		return
	end

	function arg_1_0.__onClick_cg_5_btn(arg_7_0)
		return
	end

	function arg_1_0.__onClick_cg_6_btn(arg_8_0)
		return
	end

	function arg_1_0.__onClick_cg_7_btn(arg_9_0)
		return
	end

	function arg_1_0.__onClick_cg_8_btn(arg_10_0)
		return
	end

	function arg_1_0.__onClick_cg_9_btn(arg_11_0)
		return
	end

	function arg_1_0:__onClick_next_page_btn()
		local var_12_0, var_12_1 = var_0_2:get_sequence()

		var_1_0 = var_1_0 == math.ceil(var_12_1 / 9) - 1 and 0 or var_1_0 + 1
		self._book_pages = var_1_0 + 1

		self:__init_cg_config(var_1_0)
		self:__control_label("change")
		self:__select_mode(true)

		if self._is_picking then
			self:__select_mode(false)
		end
	end

	function arg_1_0:__onClick_last_page_btn()
		local var_13_0, var_13_1 = var_0_2:get_sequence()

		var_1_0 = var_1_0 == 0 and math.ceil(var_13_1 / 9) - 1 or var_1_0 - 1
		self._book_pages = var_1_0 + 1

		self:__init_cg_config(var_1_0)
		self:__control_label("change")
		self:__select_mode(true)

		if self._is_picking then
			self:__select_mode(false)
		end
	end

	function arg_1_0:__onClick_editor_btn()
		self._control.editor_btn:SetActive(false)
		self._control.save_btn:SetActive(true)
		self._control.reset_btn:SetActive(true)

		self._is_picking = true

		self:__select_mode(false)
		self:__control_label("choose")
	end

	function arg_1_0:__onClick_save_btn()
		self._control.editor_btn:SetActive(true)
		self._control.save_btn:SetActive(false)
		self._control.reset_btn:SetActive(false)

		self._is_picking = false

		self:__select_mode(true)
		self:__save_req()
		self:__control_label("save")
	end

	function arg_1_0:__onClick_reset_btn()
		self._selected_picture = {}

		self:__control_label("change")
	end

	function arg_1_0:__onClick_cg_1_select_btn()
		self:__press_select_btn(1)
	end

	function arg_1_0:__onClick_cg_2_select_btn()
		self:__press_select_btn(2)
	end

	function arg_1_0:__onClick_cg_3_select_btn()
		self:__press_select_btn(3)
	end

	function arg_1_0:__onClick_cg_4_select_btn()
		self:__press_select_btn(4)
	end

	function arg_1_0:__onClick_cg_5_select_btn()
		self:__press_select_btn(5)
	end

	function arg_1_0:__onClick_cg_6_select_btn()
		self:__press_select_btn(6)
	end

	function arg_1_0:__onClick_cg_7_select_btn()
		self:__press_select_btn(7)
	end

	function arg_1_0:__onClick_cg_8_select_btn()
		self:__press_select_btn(8)
	end

	function arg_1_0:__onClick_cg_9_select_btn()
		self:__press_select_btn(9)
	end
end

function var_0_0.extend_obj(arg_26_0)
	return
end

return var_0_0
