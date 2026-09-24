local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_7 = table.insert
local var_0_9 = gameconfig.achievement_config
local var_0_10 = table.sort
local var_0_11 = gameconfig.ship_config
local var_0_13 = UnityEngine.Vector2
local var_0_14 = gameconfig.ship_level_config
local var_0_15 = {
	btnthree = "btnthree",
	btnfour = "btnfour",
	btnone = "btnone",
	btntwo = "btntwo"
}

gamecore.UILoader:define("gradeprogress", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:updata_data()
		self._rank_data = var_0_3:get_rank_list()
		self._rank_data_array = {}

		for iter_3_0, iter_3_1 in pairs(self._rank_data) do
			var_0_7(self._rank_data_array, iter_3_1)
		end

		local var_3_0 = {}
		local var_3_1 = {}
		local var_3_2 = {}
		local var_3_3 = {}

		for iter_3_2, iter_3_3 in pairs(self._rank_data_array) do
			if iter_3_3.state == 1 then
				var_0_7(var_3_1, iter_3_3)
			else
				var_0_7(var_3_0, iter_3_3)
			end
		end

		for iter_3_4, iter_3_5 in pairs(var_3_1) do
			var_0_7(var_3_2, var_0_9.find_object_by_id(iter_3_5.id))
		end

		for iter_3_6, iter_3_7 in pairs(var_3_0) do
			var_0_7(var_3_3, var_0_9.find_object_by_id(iter_3_7.id))
		end

		var_0_10(var_3_2, function(arg_4_0, arg_4_1)
			if arg_4_0.award == arg_4_1.award then
				return arg_4_0.id < arg_4_1.id
			else
				return arg_4_0.award < arg_4_1.award
			end
		end)
		var_0_10(var_3_3, function(arg_5_0, arg_5_1)
			if arg_5_0.award == arg_5_1.award then
				return arg_5_0.id < arg_5_1.id
			else
				return arg_5_0.award < arg_5_1.award
			end
		end)

		for iter_3_8, iter_3_9 in pairs(var_3_3) do
			var_0_7(var_3_2, iter_3_9)
		end

		self:__set_log_data(var_3_2)

		self._control.maintop.topmenu.now.num.text.text = var_0_3:get_now_rank_point().rank_point
	end

	function arg_1_0:show()
		self:setVisible(true)
	end

	function arg_1_0:__onVisible(arg_7_1)
		if not arg_7_1 then
			return
		end

		self:updata_data()
		self:__init_panel()

		self._already_init = true
	end

	function arg_1_0:__init_panel()
		self:__init_rank_list()

		self._control.maintop.topmenu.topbtn.btnone.text.text.text = var_0_1:getNowLang("ui_achievement_tab_1")
		self._control.maintop.topmenu.topbtn.btntwo.text.text.text = var_0_1:getNowLang("shipyard")
		self._control.maintop.topmenu.topbtn.btnthree.text.text.text = var_0_1:getNowLang("outfight")
		self._control.maintop.topmenu.topbtn.btnfour.text.text.text = var_0_1:getNowLang("achievement_other")
		self._control.maintop.topmenu.now.nowtext.text.text = var_0_1:getNowLang("ui_achievement_count")
		self._control.maintop.topmenu.now.num.text.text = var_0_3:get_now_rank_point().rank_point

		self:__init_select()
		var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	function arg_1_0:__init_select()
		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one("btnone", true)

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_10_1, arg_10_2)
		if self._now_label == arg_10_1 and not arg_10_2 then
			return
		end

		self._now_label = arg_10_1

		if self._now_content then
			self._last_content = self._now_content

			self:__set_title_style(self._now_content, false)
		end

		self:__set_current_content(arg_10_1)
		self:__set_title_style(self._now_content, true)
		self:__set__now_data(self._now_label)
	end

	function arg_1_0:__set_current_content(arg_11_1)
		if arg_11_1 == var_0_15.btnone then
			self._now_content = self._control.maintop.topmenu.topbtn.btnone
		elseif arg_11_1 == var_0_15.btntwo then
			self._now_content = self._control.maintop.topmenu.topbtn.btntwo
		elseif arg_11_1 == var_0_15.btnthree then
			self._now_content = self._control.maintop.topmenu.topbtn.btnthree
		elseif arg_11_1 == var_0_15.btnfour then
			self._now_content = self._control.maintop.topmenu.topbtn.btnfour
		end
	end

	function arg_1_0.__set_title_style(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_2 then
			arg_12_1.text.text.fontSize = 30
			arg_12_1.text.text.color = Color.New(1, 1, 1)
		else
			arg_12_1.text.text.fontSize = 26
			arg_12_1.text.text.color = Color.New(0.34901960784313724, 0.3803921568627451, 0.44313725490196076)
		end
	end

	function arg_1_0:__set__now_data(arg_13_1)
		if arg_13_1 == var_0_15.btnone then
			self:__get_data_by_index(1)
		elseif arg_13_1 == var_0_15.btntwo then
			self:__get_data_by_index(2)
		elseif arg_13_1 == var_0_15.btnthree then
			self:__get_data_by_index(3)
		elseif arg_13_1 == var_0_15.btnfour then
			self:__get_data_by_index(4)
		end

		self:__update_cell()

		self._control.overview.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_13(6.6, 0)
	end

	function arg_1_0:__init_rank_list()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.overview.scrollview.viewport.content.endlessScrollView, self._control.overview.scrollview.viewport.content, "gradecell", "gradeprogress")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell()
		self:updata_data()

		local var_15_0 = self:__reorder_task_data()

		self._reusable_cell:set_data(var_15_0)

		function self._reusable_cell:_set_func(arg_16_1)
			self.gradename.text.text = var_15_0[arg_16_1 + 1].title
			self.introduce.text.text = var_0_1:convert_rich_text(var_15_0[arg_16_1 + 1].desc)
			self.gradeicon.awardnum.text.text = "x" .. var_15_0[arg_16_1 + 1].award
			self.gradeicon.completeness.text.text = var_0_1:getNowLang("ui_achievement_complete_percent")

			self.gradeicon.gameObject:SetActive(true)
			self.finish.gameObject:SetActive(false)

			if var_15_0[arg_16_1 + 1].finished then
				self.gradeicon.gameObject:SetActive(false)
				self.finish.gameObject:SetActive(true)

				self.finish.completedword.text.text = var_0_1:getNowLang("questfinished")
			else
				self.gradeicon.num.text.text = var_15_0[arg_16_1 + 1].completion .. "%"
			end
		end
	end

	function arg_1_0:__reorder_task_data()
		local var_17_0 = lx.clone_table(self._now_data)
		local var_17_1 = var_0_3:get_character_list()
		local var_17_2 = 0
		local var_17_3 = 0

		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			local var_17_4 = var_0_14.find_object_by_level(iter_17_1.level)

			var_17_3 = var_17_3 + iter_17_1.exp + var_0_14.get_total_exp_set()[iter_17_1.level] + (var_17_4.exp == 0 and 71800 or var_17_4.exp)
			var_17_2 = var_17_2 + 1
		end

		local var_17_5 = var_0_3:get_equipment_count()
		local var_17_6 = var_0_3:get_user_info()
		local var_17_7 = #var_0_3:get_cardbook_ship_list()
		local var_17_8 = var_17_6.map_win
		local var_17_9 = var_17_6.maneuver_win
		local var_17_10 = var_17_6.expedition_total
		local var_17_11 = var_0_3:get_skin_count()
		local var_17_12 = var_0_3:get_dormitory_furniture()
		local var_17_13 = var_0_3:get_use_info_data()
		local var_17_14 = self._rank_data_array
		local var_17_15 = var_0_3:get_rank_list()

		local function var_17_16(arg_18_0)
			local var_18_0

			if var_17_15[arg_18_0.id] and var_17_15[arg_18_0.id].state == 2 then
				return 100
			end

			if arg_18_0.id >= 1101172 and arg_18_0.id <= 1101572 then
				for iter_18_0 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_0].id then
						var_18_0 = math.floor(var_17_13.level * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1102172 and arg_18_0.id <= 1102472 then
				for iter_18_1 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_1].id then
						var_18_0 = math.floor(var_17_2 * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1103172 and arg_18_0.id <= 1103672 then
				for iter_18_2 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_2].id then
						var_18_0 = math.floor(var_17_5 * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1104172 and arg_18_0.id <= 1104572 then
				for iter_18_3 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_3].id then
						var_18_0 = math.floor(var_17_7 * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1105172 and arg_18_0.id <= 1105572 then
				for iter_18_4 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_4].id then
						var_18_0 = math.floor(var_17_8 * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1106172 and arg_18_0.id <= 1106472 then
				for iter_18_5 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_5].id then
						var_18_0 = math.floor(var_17_9 * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1107172 and arg_18_0.id <= 1107572 then
				for iter_18_6 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_6].id then
						var_18_0 = math.floor(var_17_10 * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1108172 and arg_18_0.id <= 1108572 then
				for iter_18_7 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_7].id then
						var_18_0 = math.floor(var_17_3 / var_0_5.cardbook_const.ship_strength_param * 100 / arg_18_0.condition[2])

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id == 1109172 then
				var_18_0 = not var_0_3:is_map_pass(304) and 0 or 100
			elseif arg_18_0.id == 1109272 then
				var_18_0 = not var_0_3:is_map_pass(404) and 0 or 100
			elseif arg_18_0.id == 1109372 then
				var_18_0 = not var_0_3:is_map_pass(505) and 0 or 100
			elseif arg_18_0.id == 1109472 then
				var_18_0 = not var_0_3:is_map_pass(604) and 0 or 100
			elseif arg_18_0.id == 1109572 then
				var_18_0 = not var_0_3:is_map_pass(705) and 0 or 100
			elseif arg_18_0.id == 1109672 then
				var_18_0 = not var_0_3:is_map_pass(805) and 0 or 100
			elseif arg_18_0.id >= 1110172 and arg_18_0.id <= 1110472 then
				for iter_18_8 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_8].id then
						local var_18_1 = {}

						for iter_18_9, iter_18_10 in pairs(var_17_1) do
							if iter_18_10.level >= arg_18_0.condition[3] then
								var_0_7(var_18_1, iter_18_10.level)
							end
						end

						var_18_0 = math.floor(#var_18_1 * 100 / math.ceil(arg_18_0.condition[2]))

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id == 1111172 then
				local var_18_2 = {}

				for iter_18_11, iter_18_12 in pairs(var_17_1) do
					if iter_18_12.level == 110 and iter_18_12.type == 1 then
						var_0_7(var_18_2, iter_18_12.level)
					end
				end

				var_18_0 = math.floor(#var_18_2 * 100 / math.ceil(arg_18_0.condition[2]))

				if var_18_0 >= 100 then
					var_18_0 = 100
				end
			elseif arg_18_0.id == 1111272 then
				local var_18_3 = {}

				for iter_18_13, iter_18_14 in pairs(var_17_1) do
					if iter_18_14.level == 110 and iter_18_14.type == 2 then
						var_0_7(var_18_3, iter_18_14.level)
					end
				end

				var_18_0 = math.floor(#var_18_3 * 100 / math.ceil(arg_18_0.condition[2]))

				if var_18_0 >= 100 then
					var_18_0 = 100
				end
			elseif arg_18_0.id == 1111372 then
				local var_18_4 = {}

				for iter_18_15, iter_18_16 in pairs(var_17_1) do
					if iter_18_16.level == 110 and iter_18_16.type == 4 then
						var_0_7(var_18_4, iter_18_16.level)
					end
				end

				var_18_0 = math.floor(#var_18_4 * 100 / math.ceil(arg_18_0.condition[2]))

				if var_18_0 >= 100 then
					var_18_0 = 100
				end
			elseif arg_18_0.id == 1111472 then
				local var_18_5 = {}

				for iter_18_17, iter_18_18 in pairs(var_17_1) do
					if iter_18_18.level == 110 and iter_18_18.type == 7 then
						var_0_7(var_18_5, iter_18_18.level)
					end
				end

				var_18_0 = math.floor(#var_18_5 * 100 / math.ceil(arg_18_0.condition[2]))

				if var_18_0 >= 100 then
					var_18_0 = 100
				end
			elseif arg_18_0.id == 1111572 then
				local var_18_6 = {}

				for iter_18_19, iter_18_20 in pairs(var_17_1) do
					if iter_18_20.level == 110 and iter_18_20.type == 10 then
						var_0_7(var_18_6, iter_18_20.level)
					end
				end

				var_18_0 = math.floor(#var_18_6 * 100 / math.ceil(arg_18_0.condition[2]))

				if var_18_0 >= 100 then
					var_18_0 = 100
				end
			elseif arg_18_0.id == 1111672 then
				local var_18_7 = {}

				for iter_18_21, iter_18_22 in pairs(var_17_1) do
					if iter_18_22.level == 110 and iter_18_22.type == 12 then
						var_0_7(var_18_7, iter_18_22.level)
					end
				end

				var_18_0 = math.floor(#var_18_7 * 100 / math.ceil(arg_18_0.condition[2]))

				if var_18_0 >= 100 then
					var_18_0 = 100
				end
			elseif arg_18_0.id == 1111772 then
				local var_18_8 = {}

				for iter_18_23, iter_18_24 in pairs(var_17_1) do
					if iter_18_24.level == 110 and iter_18_24.type == 14 then
						var_0_7(var_18_8, iter_18_24.level)
					end
				end

				var_18_0 = math.floor(#var_18_8 * 100 / math.ceil(arg_18_0.condition[2]))

				if var_18_0 >= 100 then
					var_18_0 = 100
				end
			elseif arg_18_0.id >= 1112172 and arg_18_0.id <= 1112472 then
				for iter_18_25 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_25].id then
						local var_18_9 = {}

						for iter_18_26, iter_18_27 in pairs(var_17_1) do
							if var_0_11.find_object_by_cid(iter_18_27.cid).evo_class then
								var_0_7(var_18_9, iter_18_27.cid)
							end
						end

						var_18_0 = math.floor(#var_18_9 * 100 / math.ceil(arg_18_0.condition[2]))

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1113172 and arg_18_0.id <= 1113772 then
				for iter_18_28 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_28].id then
						var_18_0 = math.floor(var_17_11 * 100 / math.ceil(arg_18_0.condition[2]))

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1114172 and arg_18_0.id <= 1114672 then
				for iter_18_29 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_29].id then
						local var_18_10 = {}

						for iter_18_30, iter_18_31 in pairs(var_17_1) do
							if iter_18_31.marry then
								var_0_7(var_18_10, iter_18_31.level)
							end
						end

						var_18_0 = math.floor(#var_18_10 * 100 / math.ceil(arg_18_0.condition[2]))

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			elseif arg_18_0.id >= 1115172 and arg_18_0.id <= 1115672 then
				for iter_18_32 = 1, #var_17_14 do
					if arg_18_0.id == var_17_14[iter_18_32].id then
						var_18_0 = math.floor(#var_17_12 * 100 / math.ceil(arg_18_0.condition[2]))

						if var_18_0 >= 100 then
							var_18_0 = 100
						end
					end
				end
			end

			return var_18_0
		end

		local var_17_17 = {}
		local var_17_18 = {}

		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			local var_17_19 = var_17_16(iter_17_3)

			for iter_17_4 = 1, #self._rank_data_array do
				if var_17_19 ~= nil and var_17_19 >= 100 and self._rank_data_array[iter_17_4].state == 2 and not var_17_0[iter_17_2].finished then
					var_17_0[iter_17_2].finished = true

					var_0_7(var_17_17, iter_17_3)
				end
			end

			var_17_0[iter_17_2].completion = var_17_19

			if not var_17_0[iter_17_2].finished then
				var_0_7(var_17_18, iter_17_3)
			end
		end

		if var_17_17 then
			for iter_17_5, iter_17_6 in pairs(var_17_17) do
				var_0_7(var_17_18, iter_17_6)
			end
		end

		return var_17_18
	end

	function arg_1_0.__set_log_data(arg_19_0, arg_19_1)
		local var_19_0 = {}
		local var_19_1 = {}
		local var_19_2 = {}

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			if iter_19_1.type == 1 then
				var_0_7(var_19_0, iter_19_1)
			elseif iter_19_1.type == 2 then
				var_0_7(var_19_1, iter_19_1)
			elseif iter_19_1.type == 3 then
				var_0_7(var_19_2, iter_19_1)
			end
		end

		arg_19_0._data_by_type = {
			arg_19_1,
			var_19_0,
			var_19_1,
			var_19_2
		}
	end

	function arg_1_0:__get_data_by_index(arg_20_1)
		self._now_data = self._data_by_type[arg_20_1]

		return self._now_data
	end

	function arg_1_0:_play_into_se(arg_21_1)
		self:playSE(arg_21_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_22_0)
	local var_22_0 = var_0_2:class("gradeprogress")

	var_22_0._already_init = false
	var_22_0._last_content = nil
	var_22_0._now_label = nil
	var_22_0._now_content = nil
	var_22_0._reusable_cell = nil
	var_22_0._rank_data = {}
	var_22_0._data_by_type = {}
	var_22_0._now_data = {}
	var_22_0._rank_table = nil
	var_22_0._rank_type = nil
	var_22_0._rank_timelimits = {}
	var_22_0._rank_use = {}
	var_22_0._rank_one = nil
	var_22_0._rank_array_id = nil
	var_22_0._rank_progresses = nil
	var_22_0._data = {}
	var_22_0._data_table = nil
	var_22_0._rank_data_array = {}

	return var_22_0
end

return var_0_0
