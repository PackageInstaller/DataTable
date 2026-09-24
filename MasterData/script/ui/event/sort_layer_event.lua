local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype1()
		self:set_sort_func(function(arg_4_0, arg_4_1)
			local var_4_0 = var_0_3.find_object_by_cid(arg_4_0.cid).country
			local var_4_1 = var_0_3.find_object_by_cid(arg_4_1.cid).country
			local var_4_2 = arg_4_0.type
			local var_4_3 = arg_4_1.type

			if arg_4_0.type == arg_4_1.type then
				if var_4_0 == var_4_1 then
					if arg_4_0.level == arg_4_1.level then
						return arg_4_0.id > arg_4_1.id
					else
						return arg_4_0.level > arg_4_1.level
					end
				else
					return var_4_1 < var_4_0
				end
			else
				return var_4_3 < var_4_2
			end
		end)
		self:__update_parent_data("sorttypes1", 1)
		self:set_select_panel(1)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype2()
		self:set_sort_func(function(arg_6_0, arg_6_1)
			local var_6_0 = var_0_3.find_object_by_cid(arg_6_0.cid).country
			local var_6_1 = var_0_3.find_object_by_cid(arg_6_1.cid).country
			local var_6_2 = arg_6_0.type
			local var_6_3 = arg_6_1.type

			if arg_6_0.type == arg_6_1.type then
				if var_6_0 == var_6_1 then
					if arg_6_0.level == arg_6_1.level then
						return arg_6_0.id < arg_6_1.id
					else
						return arg_6_0.level < arg_6_1.level
					end
				else
					return var_6_0 < var_6_1
				end
			else
				return var_6_2 < var_6_3
			end
		end)
		self:__update_parent_data("sorttypes2", 2)
		self:set_select_panel(2)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype3()
		self:set_sort_func(function(arg_8_0, arg_8_1)
			if arg_8_0.level == arg_8_1.level then
				if arg_8_0.type == arg_8_1.type then
					return arg_8_0.cid > arg_8_1.cid
				else
					return arg_8_0.type < arg_8_1.type
				end
			else
				return arg_8_0.level > arg_8_1.level
			end
		end)
		self:__update_parent_data("sorttypes3", 3)
		self:set_select_panel(3)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype4()
		self:set_sort_func(function(arg_10_0, arg_10_1)
			if arg_10_0.level == arg_10_1.level then
				if arg_10_0.type == arg_10_1.type then
					return arg_10_0.cid > arg_10_1.cid
				else
					return arg_10_0.type < arg_10_1.type
				end
			else
				return arg_10_0.level < arg_10_1.level
			end
		end)
		self:__update_parent_data("sorttypes4", 4)
		self:set_select_panel(4)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype5()
		self:set_sort_func(function(arg_12_0, arg_12_1)
			if arg_12_0.star == arg_12_1.star then
				if arg_12_0.type == arg_12_1.type then
					return arg_12_0.cid > arg_12_1.cid
				else
					return arg_12_0.type < arg_12_1.type
				end
			else
				return arg_12_0.star > arg_12_1.star
			end
		end)
		self:__update_parent_data("sorttypes5", 5)
		self:set_select_panel(5)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype6()
		self:set_sort_func(function(arg_14_0, arg_14_1)
			if arg_14_0.star == arg_14_1.star then
				if arg_14_0.type == arg_14_1.type then
					return arg_14_0.cid > arg_14_1.cid
				else
					return arg_14_0.type < arg_14_1.type
				end
			else
				return arg_14_0.star < arg_14_1.star
			end
		end)
		self:__update_parent_data("sorttypes6", 6)
		self:set_select_panel(6)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype7()
		self:set_sort_func(function(arg_16_0, arg_16_1)
			if arg_16_0.id == arg_16_1.id then
				if arg_16_0.type == arg_16_1.type then
					return arg_16_0.cid > arg_16_1.cid
				else
					return arg_16_0.type < arg_16_1.type
				end
			else
				return arg_16_0.statistics.create_time > arg_16_1.statistics.create_time
			end
		end)
		self:__update_parent_data("sorttypes7", 7)
		self:set_select_panel(7)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype8()
		self:set_sort_func(function(arg_18_0, arg_18_1)
			if arg_18_0.id == arg_18_1.id then
				if arg_18_0.type == arg_18_1.type then
					return arg_18_0.cid < arg_18_1.cid
				else
					return arg_18_0.type < arg_18_1.type
				end
			else
				return arg_18_0.statistics.create_time < arg_18_1.statistics.create_time
			end
		end)
		self:__update_parent_data("sorttypes8", 8)
		self:set_select_panel(8)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype9()
		self:set_sort_func(function(arg_20_0, arg_20_1)
			if arg_20_0.love == arg_20_1.love then
				if arg_20_0.type == arg_20_1.type then
					return arg_20_0.cid > arg_20_1.cid
				else
					return arg_20_0.type < arg_20_1.type
				end
			else
				return arg_20_0.love > arg_20_1.love
			end
		end)
		self:__update_parent_data("sorttypes9", 9)
		self:set_select_panel(9)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype10()
		self:set_sort_func(function(arg_22_0, arg_22_1)
			if arg_22_0.love == arg_22_1.love then
				if arg_22_0.type == arg_22_1.type then
					return arg_22_0.cid > arg_22_1.cid
				else
					return arg_22_0.type < arg_22_1.type
				end
			else
				return arg_22_0.love < arg_22_1.love
			end
		end)
		self:__update_parent_data("sorttypes10", 10)
		self:set_select_panel(10)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype11()
		self:set_sort_func(function(arg_24_0, arg_24_1)
			local var_24_0 = var_0_3.find_object_by_cid(arg_24_0.cid)
			local var_24_1 = var_0_3.find_object_by_cid(arg_24_1.cid)

			if var_24_0.cost == var_24_1.cost then
				if var_24_0.type == var_24_1.type then
					return var_24_0.cid > var_24_1.cid
				else
					return var_24_0.type < var_24_1.type
				end
			else
				return var_24_0.cost > var_24_1.cost
			end
		end)
		self:__update_parent_data("sorttypes11", 11)
		self:set_select_panel(11)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype12()
		self:set_sort_func(function(arg_26_0, arg_26_1)
			local var_26_0 = var_0_3.find_object_by_cid(arg_26_0.cid)
			local var_26_1 = var_0_3.find_object_by_cid(arg_26_1.cid)

			if var_26_0.cost == var_26_1.cost then
				if var_26_0.type == var_26_1.type then
					return var_26_0.cid > var_26_1.cid
				else
					return var_26_0.type < var_26_1.type
				end
			else
				return var_26_0.cost < var_26_1.cost
			end
		end)
		self:__update_parent_data("sorttypes12", 12)
		self:set_select_panel(12)
	end

	function arg_1_0:__update_parent_data(arg_27_1, arg_27_2)
		self:__change_img(arg_27_2)

		local var_27_0 = var_0_1:getInstance("select_member")

		if var_27_0 then
			var_27_0:__update_edge_mask()
		end

		if self._click_listener then
			self._click_listener(self._source_data, arg_27_1)
		end
	end

	function arg_1_0:__change_img(arg_28_1)
		self._control.bg.sort_btn_group["sorttype" .. self._sort_id].image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)

		self:set_sort_id(arg_28_1)

		self._control.bg.sort_btn_group["sorttype" .. self._sort_id].image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)

		self:setVisible(false)
	end

	function arg_1_0:set_select_panel(arg_29_1)
		for iter_29_0 = 1, 12 do
			if iter_29_0 == arg_29_1 then
				self._control.bg.sort_btn_group["sorttype" .. arg_29_1].image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)
			else
				self._control.bg.sort_btn_group["sorttype" .. iter_29_0].image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)
			end
		end
	end
end

function var_0_0.extend_obj(arg_30_0)
	return
end

return var_0_0
