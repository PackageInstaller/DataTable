local var_0_0 = {}
local var_0_2 = gameenum.common_type
local var_0_3 = lx.clone_table

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ConcertoInfoUpdate(arg_2_1)
		local var_2_0
		local var_2_1
		local var_2_2 = false

		for iter_2_0, iter_2_1 in pairs(arg_2_1.info) do
			if iter_2_0 == "recreation_point" then
				local var_2_3 = self:get_concerto_info()

				if var_2_3 and var_2_3.recreation_point then
					var_2_0 = iter_2_1 - var_2_3.recreation_point
				end
			end

			if iter_2_0 == "love" then
				local var_2_4 = self:get_concerto_info()

				if var_2_4 and var_2_4.love then
					var_2_1 = iter_2_1 - var_2_4.love
				end
			elseif iter_2_0 == "member" and iter_2_1[1] == 0 then
				self._fifth_event_data.member = {}
			elseif iter_2_0 == "station" then
				self._station_info = {}

				for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
					self._station_info[iter_2_3.id] = iter_2_3.team
				end

				var_2_2 = true
			elseif iter_2_0 == "task" then
				self._comp_task_info = iter_2_1
			else
				self._fifth_event_data[iter_2_0] = iter_2_1
			end
		end

		if not var_2_2 and self._station_info then
			for iter_2_4, iter_2_5 in pairs(self._station_info) do
				self:set_team_station_state(1, iter_2_5, false)
			end

			self._station_info = {}
		end

		if var_2_0 then
			arg_2_1.info._my_joy_rp_add = var_2_0
		end

		if var_2_1 then
			arg_2_1.info._my_joy_love_add = var_2_1
		end

		self:__set_concerto_info(arg_2_1, var_2_2)
	end

	function arg_1_0:ConcertoMapInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__fifth_map__action(iter_3_1.action, iter_3_1.info)
		end
	end

	function arg_1_0:RecreationMapInfoUpdate(arg_4_1)
		self:__update_joy_map_data(arg_4_1)
	end

	function arg_1_0:RecreationOpenNotify(arg_5_1)
		self._fifth_event_data._is_first_unlock_joy = true
	end

	function arg_1_0:__fifth_map__action(arg_6_1, arg_6_2)
		if arg_6_1 == var_0_2.update_modify then
			self:__fifth_map__update_info(arg_6_2)
		elseif arg_6_1 == var_0_2.update_add then
			self:__fifth_map__add_info(arg_6_2)
		elseif arg_6_1 == var_0_2.update_remove then
			self:__fifth_map__remove_info(arg_6_2)
		end
	end

	function arg_1_0:RecreationShopInfoUpdate(arg_7_1)
		if arg_7_1 and arg_7_1.updates then
			local var_7_0 = self:get_concerto_info()
			local var_7_1 = {
				info = {}
			}

			var_7_1.info.shop_items = not var_7_0.shop_items and {} or var_0_3(var_7_0.shop_items)

			for iter_7_0, iter_7_1 in pairs(arg_7_1.updates) do
				var_7_1.info.shop_items[iter_7_1.info.id] = iter_7_1.info.buy_count
			end

			self:__set_concerto_info(var_7_1)
		end
	end

	function arg_1_0.RecreationBuffRrwardNotify(arg_8_0, arg_8_1)
		log.print_r(arg_8_1, "***************************************************BUFF推送")
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
