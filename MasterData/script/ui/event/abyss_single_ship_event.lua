local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.Language
local var_0_6 = gameconfig.ship_config
local var_0_7 = table.insert
local var_0_8 = lx.clone_table

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_empty()
		if self._no_click_event then
			return
		end

		if self._tab_type == var_0_1.abyss_dock_team_toggle_type.formation then
			local var_2_0 = var_0_2:getInstance("abyss_select_member") or var_0_2:createInstance("abyss_select_member")

			self:set_abyss_dock_team_visible(false)
			var_2_0:show(nil, nil, nil, function(arg_3_0)
				local var_3_0 = var_0_2:getInstance("abyss_dock_team")

				if var_3_0 then
					local var_3_1 = {}

					for iter_3_0, iter_3_1 in pairs(arg_3_0) do
						if iter_3_1._team_idx then
							var_3_1[iter_3_1._team_idx] = iter_3_1.id
						end
					end

					log.print_r(var_3_1, "cur_team数据是什么")

					if #var_3_1 ~= 0 then
						var_0_3:req_AbyssAbyssSaveTeamReq(var_3_1)
					else
						var_3_0:save_team_info_single(self._index, arg_3_0[1])
					end
				end
			end)

			local var_2_1 = {}

			for iter_2_0, iter_2_1 in pairs((var_0_3:get_abyss_team_info())) do
				var_0_7(var_2_1, iter_2_0, {
					id = iter_2_1
				})
			end

			var_2_0:set_enter_team(var_2_1)
			var_2_0:set_back_func(function()
				self:set_abyss_dock_team_visible(true)
			end)
		end
	end

	function arg_1_0:__onClick_BG_all_layer_item_btn()
		if self._no_click_event then
			return
		end

		if self._tab_type == var_0_1.abyss_dock_team_toggle_type.formation then
			local var_5_0 = var_0_2:getInstance("abyss_select_member") or var_0_2:createInstance("abyss_select_member")

			self:set_abyss_dock_team_visible(false)

			local var_5_1 = {}
			local var_5_2 = self._data
			local var_5_3 = var_0_8(var_0_3:get_abyss_team_info() or {})

			for iter_5_0, iter_5_1 in ipairs(var_5_3) do
				var_0_7(var_5_1, iter_5_0, {
					id = iter_5_1
				})
			end

			var_5_0:show(self._data, nil, nil, function(arg_6_0)
				local var_6_0 = {}

				for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
					if iter_6_1._team_idx then
						var_6_0[iter_6_1._team_idx] = iter_6_1.id
					else
						if var_5_2 then
							for iter_6_2, iter_6_3 in ipairs(var_5_3) do
								if iter_6_3 == var_5_2.id then
									if iter_6_1._is_exit then
										table.remove(var_5_3, iter_6_2)

										break
									end

									for iter_6_4, iter_6_5 in ipairs(var_5_3) do
										if iter_6_5 == iter_6_1.id then
											var_5_3[iter_6_4] = var_5_3[iter_6_2]

											break
										end
									end

									var_5_3[iter_6_2] = iter_6_1.id

									break
								end
							end
						else
							var_0_7(var_5_3, iter_6_1.id)
						end

						var_6_0 = var_5_3

						break
					end
				end

				if #var_6_0 == 0 then
					var_0_4:show(var_0_5:getNowLang("needflagshipinfleet"))
				else
					if arg_6_0[1] then
						for iter_6_6, iter_6_7 in pairs(var_6_0) do
							if iter_6_7 ~= arg_6_0[1].id and var_0_6.find_object_by_cid(var_0_3:find_abyss_character_by_id(iter_6_7).cid).evo_cid == arg_6_0[1].evo_cid then
								var_0_4:show(var_0_5:getNowLang("nosameshipinteam"))

								return
							end
						end
					end

					var_0_3:req_AbyssAbyssSaveTeamReq(var_6_0)
				end
			end)

			local var_5_4 = {}

			for iter_5_2, iter_5_3 in pairs((var_0_3:get_abyss_team_info())) do
				var_0_7(var_5_4, iter_5_2, {
					id = iter_5_3
				})
			end

			var_5_0:set_enter_team(var_5_4)
			var_5_0:set_back_func(function()
				self:set_abyss_dock_team_visible(true)
			end)
		end
	end

	function arg_1_0:__onLongClick_BG_all_layer_item_btn()
		if self._no_click_event then
			return
		end

		local var_8_0 = var_0_2:createInstance("abyss_ship_detail")
		local var_8_1 = var_0_2:getInstance("abyss_dock_team")

		if var_8_1 then
			var_8_1:setVisible(false)
		end

		local var_8_2 = {}

		for iter_8_0, iter_8_1 in pairs(var_0_3:get_abyss_team_info()) do
			var_8_2[iter_8_0] = iter_8_1
		end

		if next(var_8_2) then
			var_8_0:show(var_0_1.enter_ship_detail_type.abyss_dock_team, {
				index = self._index,
				toggle_type = self._tab_type,
				team_data = var_8_2
			})
		end
	end

	function arg_1_0.__onClick_BG_all_layer_drag_layer(arg_9_0)
		return
	end

	function arg_1_0.set_abyss_dock_team_visible(arg_10_0, arg_10_1)
		local var_10_0 = var_0_2:getInstance("abyss_dock_team")

		if var_10_0 then
			var_10_0:setVisible(arg_10_1)
		end
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
