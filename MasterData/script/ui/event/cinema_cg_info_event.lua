local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		var_0_1:destroyInstance("cinema_cg_info")

		self._is_already_init = true

		var_0_1:createInstance("cinema_picture_book"):show(self._back_pages)
	end

	function arg_1_0:__onClick_next_page_btn()
		self.time = 0

		if self.is_have_cg_list[self._now_sort + 1] == nil then
			return
		end

		self:_init_cg_config(self.is_have_cg_list[self._now_sort + 1])
	end

	function arg_1_0:__onClick_last_page_btn()
		self.time = 0

		if self.is_have_cg_list[self._now_sort - 1] == nil then
			return
		end

		self:_init_cg_config(self.is_have_cg_list[self._now_sort - 1])
	end

	function arg_1_0:__onClick_cover()
		self:activation_ui()
	end

	function arg_1_0:__onClick_shrink_btn()
		self:shrink_extend_event(false)
	end

	function arg_1_0:__onClick_extend_btn()
		self:shrink_extend_event(true)
	end

	function arg_1_0:__onClick_get_cover_btn()
		var_0_1:destroyInstance("cinema_cg_info")

		if self._call_fun then
			self._call_fun()
		end

		local var_8_0 = var_0_1:getInstance("strike_awardbox")

		if var_8_0 then
			var_8_0:setVisible(true)
		end

		local var_8_1 = var_0_1:getInstance("mail_box")

		if var_8_1 then
			var_8_1:setVisible(true)
		end
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
