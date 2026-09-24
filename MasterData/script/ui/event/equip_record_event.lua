local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.prompt
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_container_close_btn()
		self:setVisible(false)

		local var_2_0 = var_0_1:getInstance("ship_detail")

		if var_2_0 then
			var_2_0:setVisible(true)
			var_2_0:update_data()
		end
	end

	function arg_1_0:__onToggle_content_content_toggle_group_tog_one()
		self:__select_one("tog_one")
	end

	function arg_1_0:__onToggle_content_content_toggle_group_tog_two()
		self:__select_one("tog_two")
	end

	function arg_1_0:__onToggle_content_content_toggle_group_tog_three()
		self:__select_one("tog_three")
	end

	function arg_1_0:__onToggle_content_content_toggle_group_tog_four()
		self:__select_one("tog_four")
	end

	function arg_1_0.__onClick_content_content_record_btn(arg_7_0)
		var_0_1:createInstance("msgbox"):show(var_0_3:getNowLang("equiprecordtip"), function()
			arg_7_0:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
			var_0_2:req_ShipEquipRecord({
				id = arg_7_0._data.id,
				index = arg_7_0._now_record.index
			})
		end, function()
			arg_7_0:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))
		end, var_0_3:getNowLang("equiprecordtiptitle"))
	end

	function arg_1_0:__onClick_content_content_use_btn()
		if self._data.state == var_0_5.ship_state.station then
			var_0_4:show(var_0_3:getNowLang("guard_tip"))

			return
		end

		local var_10_0 = true
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(self._data.equips) do
			if iter_10_1.id and iter_10_1.id ~= 0 then
				var_10_1[iter_10_1.id] = var_10_1[iter_10_1.id] and var_10_1[iter_10_1.id] + 1 or 1
			end
		end

		local var_10_2 = 0
		local var_10_3 = 0
		local var_10_4 = 0
		local var_10_5 = 0
		local var_10_6 = 0
		local var_10_7 = 0
		local var_10_8 = 0
		local var_10_9 = 0

		for iter_10_2, iter_10_3 in pairs(self._now_record.equips) do
			if iter_10_3 ~= 0 and iter_10_3 == self._now_record.equips[1] then
				var_10_2 = var_10_2 + 1
				var_10_6 = self._now_record.equips[1]
			end

			if iter_10_3 ~= 0 and iter_10_3 == self._now_record.equips[2] then
				var_10_3 = var_10_3 + 1
				var_10_7 = self._now_record.equips[2]
			end

			if iter_10_3 ~= 0 and iter_10_3 == self._now_record.equips[3] then
				var_10_4 = var_10_4 + 1
				var_10_8 = self._now_record.equips[3]
			end

			if iter_10_3 ~= 0 and iter_10_3 == self._now_record.equips[4] then
				var_10_5 = var_10_5 + 1
				var_10_9 = self._now_record.equips[4]
			end
		end

		local var_10_10 = 0
		local var_10_11 = 0
		local var_10_12 = 0
		local var_10_13 = 0

		for iter_10_4, iter_10_5 in pairs(var_10_1) do
			if iter_10_4 == self._now_record.equips[1] then
				var_10_10 = iter_10_5
			end

			if iter_10_4 == self._now_record.equips[2] then
				var_10_11 = iter_10_5
			end

			if iter_10_4 == self._now_record.equips[3] then
				var_10_12 = iter_10_5
			end

			if iter_10_4 == self._now_record.equips[4] then
				var_10_13 = iter_10_5
			end
		end

		for iter_10_6, iter_10_7 in pairs((var_0_2:get_equipment_list())) do
			if iter_10_7.id == var_10_6 and var_10_2 > iter_10_7.num + var_10_10 then
				var_10_0 = false
			end

			if iter_10_7.id == var_10_7 and var_10_3 > iter_10_7.num + var_10_11 then
				var_10_0 = false
			end

			if iter_10_7.id == var_10_8 and var_10_4 > iter_10_7.num + var_10_12 then
				var_10_0 = false
			end

			if iter_10_7.id == var_10_9 and var_10_5 > iter_10_7.num + var_10_13 then
				var_10_0 = false
			end
		end

		for iter_10_8, iter_10_9 in pairs(self._now_record.equips) do
			if iter_10_9 ~= 0 and not var_0_2:find_equipment_by_id(iter_10_9) then
				if not var_10_1 or not var_10_1[iter_10_9] or var_10_1[iter_10_9] == 0 then
					var_10_0 = false

					break
				else
					var_10_1[iter_10_9] = var_10_1[iter_10_9] - 1
				end
			end
		end

		if not var_10_0 then
			var_0_1:createInstance("msgbox"):show(var_0_3:getNowLang("equipnotenough"), function()
				var_0_2:req_UseEquipRecord({
					id = self._data.id,
					index = self._now_record.index
				})
			end, nil, var_0_3:getNowLang("equiplost"))
		else
			var_0_2:req_UseEquipRecord({
				id = self._data.id,
				index = self._now_record.index
			})
		end
	end

	function arg_1_0:__onScaleButtonClick_bg_container_close_btn()
		self:__onClick_bg_container_close_btn()
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
