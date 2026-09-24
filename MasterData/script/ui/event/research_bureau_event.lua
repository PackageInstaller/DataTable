local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_4 = gameconfig.ship_research_config
local var_0_5 = gamecore.Language
local var_0_6 = lx.UserData

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_research_bureau_bg_top_return_btn()
		var_0_1:destroyInstance("research_bureau")
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		self:__initia_lize()

		local var_2_0 = var_0_1:getInstance("home") or var_0_1:createInstance("home")

		var_2_0:into_home_bgm()
		var_2_0:show()

		local var_2_1 = var_0_1:createInstance("main_menu")

		var_2_1:reset()
		var_2_1:show(true)
		self:destroyChildren("research_development_item")
	end

	function arg_1_0:__onClick_research_bureau_bg_down_start_btn()
		local var_3_0 = self:get_research_max_status(var_0_2:get_now_research_ship_id())
		local var_3_1 = var_0_2:get_account_id()

		self._now_click_ship_id = self:get_research_max_status(self._now_click_ship_id)
		self._now_click_ship_id = self:get_research_max_status(self._now_click_ship_id)

		local var_3_2 = var_0_4.find_object_by_id(self._now_click_ship_id)

		if not var_3_0 then
			var_0_6:setKeyData("first_research_ship_id", self._now_click_ship_id .. var_3_1)
		end

		if not var_3_0 then
			local var_3_3 = var_0_6:getKeyData("first_research_ship_id")

			var_3_0 = var_3_3 and (string.sub(var_3_1, -5) == string.sub(var_3_3, -5) and self:get_research_max_status(tonumber((string.sub(var_3_3, 1, 6)))) or self._now_click_ship_id) or self._now_click_ship_id
		else
			local var_3_4 = var_0_4.find_object_by_id(var_3_0)

			if not var_3_4 or var_3_2.ship_id ~= var_3_4.ship_id then
				var_3_0 = self._now_click_ship_id
			end
		end

		local var_3_5 = var_0_4.find_object_by_id(var_3_0).ship_id

		local function var_3_6()
			var_0_2:set_come_in(false)
			self:setVisible(false)

			local var_4_0 = var_0_1:getInstance("research_development")

			if var_4_0 then
				self:__initia_lize()

				if var_3_0 then
					var_0_6:setKeyData("first_research_ship_id", var_3_0 .. var_3_1)

					if self:__is_finish_all_equip_and_finish_ship_task(var_3_0) then
						var_0_2:req_ResearchBoatIdReq(var_3_0)
						var_0_2:set_now_research_ship_id(var_3_0)
					end

					var_0_2:set_come_in_nums(1)
					var_4_0:show(var_3_0)
				else
					var_0_6:setKeyData("first_research_ship_id", self._now_click_ship_id .. var_3_1)

					if self:__is_finish_all_equip_and_finish_ship_task(self._now_click_ship_id) then
						var_0_2:req_ResearchBoatIdReq(self._now_click_ship_id)
						var_0_2:set_now_research_ship_id(self._now_click_ship_id)
					end

					var_0_2:set_come_in_nums(1)
					var_4_0:show(self._now_click_ship_id)
				end
			else
				self:__initia_lize()

				if var_3_0 then
					var_0_6:setKeyData("first_research_ship_id", var_3_0 .. var_3_1)
					var_0_2:set_come_in_nums(1)

					if self:__is_finish_all_equip_and_finish_ship_task(var_3_0) then
						var_0_2:req_ResearchBoatIdReq(var_3_0)
						var_0_2:set_now_research_ship_id(var_3_0)
					end

					var_0_1:createInstance("research_development"):show(var_3_0)
				else
					var_0_6:setKeyData("first_research_ship_id", self._now_click_ship_id .. var_3_1)
					var_0_2:set_come_in_nums(1)

					if self:__is_finish_all_equip_and_finish_ship_task(self._now_click_ship_id) then
						var_0_2:req_ResearchBoatIdReq(self._now_click_ship_id)
						var_0_2:set_now_research_ship_id(self._now_click_ship_id)
					end

					var_0_1:createInstance("research_development"):show(self._now_click_ship_id)
				end
			end

			self:destroyChildren("research_development_item")
		end

		local var_3_7 = 0

		if var_0_2:get_now_research_ship_id() then
			var_3_7 = var_0_4.find_object_by_id(var_0_2:get_now_research_ship_id())
		end

		if var_3_7 ~= 0 and var_3_7.ship_id ~= var_3_2.ship_id and not self:is_have_finish_ship(var_3_0) then
			local var_3_8 = var_0_1:createInstance("msgbox")

			if var_3_8 then
				var_3_8:show(var_0_5:getNowLang("whether_research_desc"), var_3_6, nil, var_0_5:getNowLang("whether_research"), nil, nil, true)
			end
		else
			var_3_6()
		end
	end

	function arg_1_0:is_have_finish_ship(arg_5_1)
		local var_5_0 = false

		if self:__is_finish_all_equip_and_finish_ship_task(arg_5_1) == false or self:__is_finish_all_equip_and_finish_ship_task(self._now_click_ship_id) == false then
			var_5_0 = true

			return true
		end

		return var_5_0
	end

	function arg_1_0.__onClick_research_bureau_bg_left_up_image(arg_6_0)
		arg_6_0._set_up_btn = true
	end

	function arg_1_0.__onClick_research_bureau_bg_left_down_image(arg_7_0)
		local var_7_2 = var_0_2:get_ship_task_info()

		if var_7_2 and next(var_7_2) then
			arg_7_0.down_pos = (#var_7_2 / 3 - 4 + 1) * 136
		end

		arg_7_0._set_down_btn = true
	end

	function arg_1_0:_set_left_ship_down_pos()
		if self._set_down_btn then
			if self._control.research_bureau_bg.left.left_scrollview.viewport.content.rectTransform.anchoredPosition.y < self.down_pos then
				self._control.research_bureau_bg.left.left_scrollview.viewport.content.rectTransform.anchoredPosition = Vector2(-7, self._control.research_bureau_bg.left.left_scrollview.viewport.content.rectTransform.anchoredPosition.y + 100)
			else
				self._set_down_btn = false
			end
		end
	end

	function arg_1_0:_set_left_ship_up_pos()
		if self._set_up_btn then
			if self._control.research_bureau_bg.left.left_scrollview.viewport.content.rectTransform.anchoredPosition.y > 0 then
				self._control.research_bureau_bg.left.left_scrollview.viewport.content.rectTransform.anchoredPosition = Vector2(-7, self._control.research_bureau_bg.left.left_scrollview.viewport.content.rectTransform.anchoredPosition.y - 100)
			else
				self._set_up_btn = false
			end
		end
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
