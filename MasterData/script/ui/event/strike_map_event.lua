local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = table.remove
local var_0_7 = gameconfig.ship_rule_config
local var_0_8 = gameconfig.strike_map_config
local var_0_9 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_top_return()
		if self._in_import then
			return
		end

		self._control.msgbox:SetActive(true)
	end

	function arg_1_0:__onClick_main_top_show_btn()
		if self.__btn_state == 1 then
			self._control.main.top.show_btn.image.sprite = self:loadSprite(var_0_5.forth_show_button.state2)
			self.__btn_state = 2
		elseif self.__btn_state == 2 then
			self._control.main.top.show_btn.image.sprite = self:loadSprite(var_0_5.forth_show_button.state1)
			self.__btn_state = 1
		end

		self:__init_buff_pos()
	end

	function arg_1_0:__onClick_main_bottom_import_btn()
		if not self._can_click then
			return
		end

		local var_4_0
		local var_4_1

		self._control.main.top.return_btn.button.enabled = false

		if self._strike_info.point_id == self._now_map_info.id then
			var_4_0 = self._map_data.init_node_id
			var_4_1 = self._now_map_info.next_node_id
		else
			var_4_0 = self._strike_info.point_id
			var_4_1 = self._strike_info.next_point_id
		end

		if var_0_1:getInstance("strike_map") then
			local var_4_2 = var_0_4:get_strike_point_info()

			if var_4_2 and next(var_4_2) and not var_0_4:get_return_type() and var_4_2.buffs and next(var_4_2.buffs) then
				for iter_4_0, iter_4_1 in pairs(var_4_2.buffs) do
					if iter_4_1.point_id == var_4_2.next_point_id then
						var_0_6(var_4_2.buffs, iter_4_0)
					end
				end
			end
		end

		self:_is_have_change_buff(var_4_0, var_4_1)
	end

	function arg_1_0.__onClick_msgbox_main_confirmbtn(arg_5_0)
		if var_0_1:getInstance("campaign_select") then
			var_0_1:destroyInstance("campaign_select")
		end

		var_0_4:req_SolidQuitMapReq()
	end

	function arg_1_0:__onClick_msgbox_main_cancelbtn()
		self._control.msgbox:SetActive(false)
	end

	function arg_1_0:__onClick_strongattack_string_node1()
		self:_buff_button_move(1, self._strike_info.point_id, self._strike_info.next_point_id, self._data_buff_num)
		var_0_4:set_return_type(false)
		var_0_4:set_strike_first_get_in(false)
		var_0_4:record_strike_enter_battle_nunber()
	end

	function arg_1_0:__onClick_strongattack_string_node2()
		self:_buff_button_move(2, self._strike_info.point_id, self._strike_info.next_point_id, self._data_buff_num)
		var_0_4:set_return_type(false)
		var_0_4:set_strike_first_get_in(false)
		var_0_4:record_strike_enter_battle_nunber()
	end

	function arg_1_0:__onClick_strongattack_string_node4()
		self:_buff_button_move(4, self._strike_info.point_id, self._strike_info.next_point_id, self._data_buff_num)
		var_0_4:set_return_type(false)
		var_0_4:set_strike_first_get_in(false)
		var_0_4:record_strike_enter_battle_nunber()
	end

	function arg_1_0:__onClick_strongattack_string_node3()
		self:_buff_button_move(3, self._strike_info.point_id, self._strike_info.next_point_id, self._data_buff_num)
		var_0_4:set_return_type(false)
		var_0_4:set_strike_first_get_in(false)
		var_0_4:record_strike_enter_battle_nunber()
	end

	function arg_1_0:__onClick_strongattack_string_node5()
		self:_buff_button_move(5, self._strike_info.point_id, self._strike_info.next_point_id, self._data_buff_num)
		var_0_4:set_return_type(false)
		var_0_4:set_strike_first_get_in(false)
		var_0_4:record_strike_enter_battle_nunber()
	end

	function arg_1_0:__onClick_strongattack_exit()
		self._control.strongattack.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_strongattack_confirm()
		if self._save_buff_change_num[1] and self._save_buff_change_num[2] == nil then
			if self._buff_select_limit == 2 then
				self:__show_not_selected_all_buff_page(true, self._save_buff_data[1])
			else
				self._control.strongattack.gameObject:SetActive(false)
				var_0_4:req_SoildChooseBuffReq({
					self._save_buff_data[1].id
				})
				self:__fight_prepare_show(self.page_id, self.config, self.flag)
			end
		elseif self._save_buff_change_num[1] and self._save_buff_change_num[2] then
			self._control.strongattack.gameObject:SetActive(false)

			if #self._save_buff_data == 1 then
				var_0_4:req_SoildChooseBuffReq({
					self._save_buff_data[1].id
				})
			elseif #self._save_buff_data == 2 then
				var_0_4:req_SoildChooseBuffReq({
					self._save_buff_data[1].id,
					self._save_buff_data[2].id
				})
			end

			self:__fight_prepare_show(self.page_id, self.config, self.flag)
		elseif self._save_buff_change_num[1] == nil and self._save_buff_change_num[2] then
			if self._buff_select_limit == 2 then
				self:__show_not_selected_all_buff_page(true, self._save_buff_data[2])
			else
				self._control.strongattack.gameObject:SetActive(false)
				var_0_4:req_SoildChooseBuffReq({
					self._save_buff_data[2].id
				})
				self:__fight_prepare_show(self.page_id, self.config, self.flag)
			end
		else
			var_0_2:show(var_0_3:getNowLang("ui_select_at_least_a_buff"))

			return
		end
	end

	function arg_1_0:__onClick_strongattack_replace_replace_confirm()
		self:__confirm_replace_buff()
	end

	function arg_1_0:__onClick_strongattack_replace_replace_return()
		self:__show_replace_buff_page(false)
	end

	function arg_1_0:__onClick_main_back_difficult_btn()
		self._control.main.back_difficult_btn:SetActive(false)

		local var_16_0 = var_0_4:get_strike_cur_page_index()

		if not self.easy_or_hard then
			local var_16_1 = false

			for iter_16_0, iter_16_1 in pairs((var_0_4:get_strike_data())) do
				if iter_16_0 == self._map_id and iter_16_1.state == 2 and iter_16_1.score >= var_0_8.find_object_by_id(self._map_id).point1 then
					var_16_1 = true
				end
			end

			if var_16_1 then
				self._control.strike_difficult:SetActive(true)
				self._control.npc:SetActive(false)

				local var_16_2 = self:autoKillDOTween(var_0_9.Sequence())

				var_16_2:AppendInterval(2)
				var_16_2:AppendCallback(function()
					self._control.npc:SetActive(true)
					self._control.strike_difficult:SetActive(false)
					self:show_new_result(nil, nil, true)
				end)
				var_16_2:Play()
			else
				self:__destroy_pool()
				var_0_1:destroyInstance("strike_map")
				var_0_1:createInstance("strike_main"):show(var_16_0, var_0_7.find_object_by_id(17).content.activeId)
			end
		else
			self:__destroy_pool()
			var_0_1:destroyInstance("strike_map")
			var_0_1:createInstance("strike_main"):show(var_16_0, var_0_7.find_object_by_id(17).content.activeId)
		end
	end

	function arg_1_0.__onClick_npc_paintingbtn(arg_18_0)
		return
	end

	function arg_1_0:__onClick_main_back_main_btn()
		self._control.main.back_main_btn:SetActive(false)
		self:__destroy_pool()
		var_0_1:destroyInstance("strike_map")

		local var_19_0 = var_0_1:createInstance("strike_main")

		if var_19_0 then
			var_19_0:show(var_0_4:get_strike_cur_page_index(), var_0_7.find_object_by_id(17).content.activeId)
		end
	end

	function arg_1_0:__onClick_main_top_return_btn()
		if self._in_import then
			return
		end

		self._control.msgbox:SetActive(true)
	end

	function arg_1_0:__onClick_strongattack_not_selected_all_replace_return()
		self:__show_not_selected_all_buff_page(false)
	end

	function arg_1_0:__onClick_strongattack_not_selected_all_replace_confirm()
		if self._save_buff_data[1] then
			self:__confirm_not_selected_all_buff(self._save_buff_data[1])
		else
			self:__confirm_not_selected_all_buff(self._save_buff_data[2])
		end
	end
end

function var_0_0.extend_obj(arg_23_0)
	arg_23_0._in_import = false
end

return var_0_0
