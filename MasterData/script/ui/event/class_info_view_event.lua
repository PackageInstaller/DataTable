local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.util_func
local var_0_6 = gameconfig.tactics_config
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.teacher_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_base_panel_return_btn()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_detail_panel_study_btn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))

		local var_3_0 = var_0_3:getInstance("school")

		if self._enter_panel == "selectshipfirst" then
			if self:__show_study_prompt(self._now_tactics_cid) then
				local var_3_1 = var_0_3:getInstance("select_tactis_view"):get_curr_select_ship_info()

				if var_3_1.state == var_0_7.ship_state.expedition then
					var_0_2:show(var_0_4:getNowLang("shipexpedition"))
				elseif var_3_1.state == var_0_7.ship_state.station then
					var_0_2:show(var_0_4:getNowLang("noticeshipisinguard"))
				else
					var_0_1:req_BeginToStudyReq({
						class = var_3_0._now_class,
						tactics = self._now_tactics_cid,
						ship = var_3_1.id,
						seat = var_3_0._now_seat_index
					})
				end
			else
				var_0_2:show(var_0_4:getNowLang("item_no_enough"))
			end
		elseif self._enter_panel == "school" then
			self._control.stop_study_layer.gameObject:SetActive(true)
		else
			local var_3_2
			local var_3_3

			if self._now_tactics_data.sid then
				var_3_2, var_3_3 = self:__get_select_tactis_state(self._now_tactics_cid, self._now_tactics_data.sid)
			else
				var_3_2, var_3_3 = self:__get_select_tactis_state(self._now_tactics_cid, self._now_tactics_data.id)
			end

			local var_3_4 = var_0_1:get_now_statics_seat()
			local var_3_5 = self:get_teacher_class(var_0_1:get_teacher_total_info(), var_0_7.tactics_teacher[self._now_teacher])
			local var_3_6, var_3_7 = self:_is_have_seat((self:get_class_info(var_0_1:get_class_total_info(), var_3_5)))

			if var_3_2 == 2 then
				self._control.stop_study_layer.gameObject:SetActive(true)
			elseif var_3_3 < 500 and var_3_7 and next(var_3_7) then
				if self:__show_study_prompt(self._now_tactics_cid) then
					local var_3_8 = self:get_now_tactics()
					local var_3_9 = var_3_8 and next(var_3_8) and {
						class = var_3_5,
						tactics = var_3_8[1],
						ship = self._ship_info.id,
						seat = var_3_7[1]
					} or {
						class = var_3_5,
						tactics = self._tactics_config_data.tactics_id * 10,
						ship = self._ship_info.id,
						seat = var_3_7[1]
					}
					local var_3_10 = var_0_1:find_character_by_id(self._ship_info.id)

					if self._ship_info.state == var_0_7.ship_state.expedition then
						var_0_2:show(var_0_4:getNowLang("shipexpedition"))
					elseif self._ship_info.state == var_0_7.ship_state.station then
						var_0_2:show(var_0_4:getNowLang("noticeshipisinguard"))
					else
						local var_3_11

						if var_3_0 then
							var_0_3:destroyInstance("school")

							var_3_11 = false
						end

						if var_0_5.have_data(var_0_8.find_object_by_cid(var_0_7.tactics_teacher[self._now_teacher]).tactics, self._tactics_config_data.tactics_id * 10) then
							var_3_11 = true
						end

						local var_3_13 = self:_have_data(var_0_1:find_character_by_id(self._ship_info.id).all_tactics)

						if not var_3_11 then
							var_0_2:show(var_0_4:getNowLang("tactics_teacher_leisure"))

							return
						end

						if var_3_13 then
							var_0_2:show(var_0_4:getNowLang("cannotequiplearning"))

							return
						end

						if var_3_11 then
							var_0_1:req_BeginToStudyReq(var_3_9)
						end
					end
				end
			else
				var_0_2:show(var_0_4:getNowLang("tactics_max"))
			end
		end
	end

	function arg_1_0:get_now_tactics()
		local var_4_0 = {}

		if self._ship_info.all_tactics and next(self._ship_info.all_tactics) then
			for iter_4_0, iter_4_1 in ipairs(self._ship_info.all_tactics) do
				if iter_4_1.id == self._now_tactics_cid or iter_4_1.id == self._now_tactics_cid + 1 or iter_4_1.id == self._now_tactics_cid + 2 or iter_4_1.id == self._now_tactics_cid + 3 then
					table.insert(var_4_0, iter_4_1.id)
				end
			end
		end

		if var_4_0 and next(var_4_0) then
			table.sort(var_4_0, function(arg_5_0, arg_5_1)
				return arg_5_0.id > arg_5_1.id
			end)
		end

		return var_4_0
	end

	function arg_1_0._have_data(arg_6_0, arg_6_1)
		local var_6_0 = false

		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			if iter_6_1.state == 2 then
				var_6_0 = true

				return true
			end
		end

		return var_6_0
	end

	function arg_1_0.get_teacher_class(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = 1

		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			if iter_7_1.id == arg_7_2 then
				var_7_0 = iter_7_1.class

				return iter_7_1.class
			end
		end

		return var_7_0
	end

	function arg_1_0.get_class_info(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			if iter_8_1.id == arg_8_2 then
				var_8_0 = iter_8_1.seat

				return iter_8_1.seat
			end
		end

		return var_8_0
	end

	function arg_1_0._is_have_seat(arg_9_0, arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			if iter_9_1 == 0 then
				table.insert(var_9_0, iter_9_0)
			end
		end

		return (var_9_0 and next(var_9_0) or nil) and true, var_9_0
	end

	function arg_1_0:__onClick_stop_study_layer_quitbtn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
		self._control.stop_study_layer.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_stop_study_layer_confirmbtn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))

		if self._enter_panel == "tactics_panel" then
			local var_11_0 = {}

			for iter_11_0 = 1, var_0_1:get_now_class_seat(self._now_class) do
				if var_0_1:get_student_by_seat_id(self._now_class, iter_11_0) == self._ship_info.id then
					table.insert(var_11_0, iter_11_0)
				end
			end

			self._seat_list = var_11_0

			var_0_1:req_StopStudyReq({
				class = self:get_teacher_class(var_0_1:get_teacher_total_info(), var_0_7.tactics_teacher[self._now_teacher]),
				ship = self._ship_info.id
			})
			self._control.stop_study_layer.gameObject:SetActive(false)
		else
			local var_11_1 = var_0_3:getInstance("school")

			var_0_1:req_StopStudyReq({
				class = var_11_1._now_class,
				ship = var_11_1._now_stop_study_id
			})
			self._control.stop_study_layer.gameObject:SetActive(false)
		end
	end

	function arg_1_0.__show_study_prompt(arg_12_0, arg_12_1)
		local var_12_0 = var_0_6.find_object_by_cid(arg_12_1)

		if var_0_1:get_item_count(var_12_0.need_res.id) >= var_12_0.need_res.value then
			return true
		end

		return false
	end

	function arg_1_0:__onClick_detail_panel_left_btn()
		self._now_info_cid = self._now_info_cid - 1

		self:__change_show_info(true)
	end

	function arg_1_0:__onClick_detail_panel_right_btn()
		self._now_info_cid = self._now_info_cid + 1

		self:__change_show_info(true)
	end

	function arg_1_0:__onClick_detail_panel_show_ship_study_btn()
		local var_15_0 = var_0_3:getInstance("tactics_select_member")
		local var_15_1 = var_0_3:getInstance("change_instructor_view")
		local var_15_2 = var_0_3:getInstance("school")

		if var_15_1 then
			var_15_1:setVisible(false)
		end

		local var_15_3 = var_15_2._now_class

		if var_15_2 then
			var_15_2:setVisible(false)
			var_0_3:destroyInstance("school")
		end

		var_0_1:set_statics_common_state(true)

		if var_15_0 then
			var_15_0:show(self._now_tactics_data, var_15_1._now_select_bg_index, var_15_1._now_teacher_index)
			self:setVisible(false)
		else
			var_0_3:createInstance("tactics_select_member"):show(self._now_tactics_data, var_15_1._now_select_bg_index, var_15_1._now_teacher_index, var_15_3)
			self:setVisible(false)
		end
	end
end

function var_0_0.extend_obj(arg_16_0)
	arg_16_0._now_index = 1
	arg_16_0._seat_list = {}
end

return var_0_0
