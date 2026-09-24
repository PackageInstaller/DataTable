local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_bg_container_back_btn()
		self:setVisible(false)

		self._enter_ship = nil
		self._is_fast_formation = false
		self._show_detail_state = 1

		if self._back_func then
			self._back_func()
		end
	end

	function arg_1_0:__onClick_fast_btn()
		self._is_fast_formation = not self._is_fast_formation

		self:update_content()
	end

	function arg_1_0:__onClick_detail_btn()
		self._show_detail_state = self._show_detail_state + 1

		if self._show_detail_state > 3 then
			self._show_detail_state = 1
		end

		self:__update_reusable_cell()
	end

	function arg_1_0:__onClick_sort_order_btn()
		if self._sort_layer then
			self._sort_layer:show(true)
		end
	end

	function arg_1_0:__onClick_sort_type_btn()
		if self._type_layer then
			self._type_layer:show(true)
		end
	end

	function arg_1_0:__onClick_confirm_btn()
		if self._is_fast_formation then
			self:setVisible(false)

			self._is_fast_formation = false
			self._show_detail_state = 1

			if self._callback then
				if not next(self._fast_team_list) then
					var_0_2:show(var_0_4:getNowLang("needflagshipinfleet"))
				else
					self._callback(self._fast_team_list or {})
				end
			end

			if self._back_func then
				self._back_func()
			end
		end

		log.print_r(self._is_abyss_dock_team_synthesis, "@@@@@@@@@@@@@@@@@@@@@")
		log.print_r(self._synthesis_team_list, "####################")

		if self._is_abyss_dock_team_synthesis then
			self:setVisible(false)

			self._is_abyss_dock_team_synthesis = false
			self._show_detail_state = 1

			if not self._callback or not next(self._synthesis_team_list) then
				-- block empty
			else
				self._callback(self._synthesis_team_list or {})
			end

			if self._back_func then
				if next(self._synthesis_team_list) == nil or self._synthesis_team_list == nil then
					var_0_1:set_need_clear_panel_info(true)
				else
					var_0_1:set_need_clear_panel_info(false)
				end

				self._back_func()
			end
		end
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
