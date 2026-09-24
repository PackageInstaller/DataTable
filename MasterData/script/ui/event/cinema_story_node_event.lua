local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = 1
local var_0_3 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_close_btn()
		var_0_3:set_now_story()
		self:reset_story_node()
		self:setVisible(false)

		if var_0_1:getInstance("mix_main_map") then
			var_0_2 = 1

			return
		end

		if var_0_1:getInstance("eighth_main_map") then
			var_0_2 = 1

			return
		end

		if var_0_1:getInstance("fearlessness_sea") then
			var_0_2 = 1

			return
		end

		if var_0_1:getInstance("ninth_main_map") then
			var_0_2 = 1

			return
		end

		if not self.from_event then
			var_0_1:createInstance("cinema_review"):show(1)

			var_0_2 = 1
		else
			var_0_2 = 1
		end

		var_0_3:set_now_small_story_panel(false)
	end

	function arg_1_0:__onClick_handover_btn(arg_3_1)
		var_0_3:set_now_small_story_panel(false)

		self._control.scrollview_1:GetComponent("ScrollRect").enabled = false
		self._control.scrollview_2:GetComponent("ScrollRect").enabled = false
		self._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_1:GetComponent("ScrollRect").enabled = true
		self._control.scrollview_2:GetComponent("ScrollRect").enabled = true

		if arg_3_1 == 1 then
			self._control.scrollview_2:SetActive(true)
			self:show_now_scrollview(true)
			self:show_now_handover_1(true)
			self._control.cover_2:SetActive(true)

			var_0_2 = 2

			return
		end

		if arg_3_1 == 2 then
			self._control.scrollview_1:SetActive(true)
			self:show_now_scrollview(false)
			self:show_now_handover_2(true)
			self._control.cover_2:SetActive(true)

			var_0_2 = 1

			return
		end

		if var_0_2 == 1 then
			self._control.scrollview_2:SetActive(true)
			self:show_now_scrollview(true)
			self:show_now_handover_1(true)
			self._control.cover_2:SetActive(true)

			var_0_2 = 2

			return
		end

		if var_0_2 == 2 then
			self._control.scrollview_1:SetActive(true)
			self:show_now_scrollview(false)
			self:show_now_handover_2(true)
			self._control.cover_2:SetActive(true)

			var_0_2 = 1

			return
		end

		self._control.scrollview_1.viewport.content:GetComponent("GridLayoutGroup").constraintCount = 1
		self._control.scrollview_2.viewport.content:GetComponent("GridLayoutGroup").constraintCount = 1
	end

	function arg_1_0.__onClick_cover(arg_4_0)
		return
	end

	function arg_1_0.__onClick_cover_2(arg_5_0)
		return
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
