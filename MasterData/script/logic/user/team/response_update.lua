local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = gameenum.common_type
local var_0_4 = rawget

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:TeamInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self._team_data[iter_2_1.info.team_type] = self._team_data[iter_2_1.info.team_type] or {}

			local var_2_0 = {
				id = iter_2_1.info.id,
				team_type = iter_2_1.info.team_type
			}

			var_2_0.members = iter_2_1.info.members or {}
			var_2_0.name = iter_2_1.info.name
			var_2_0.station_point = iter_2_1.info.station_point
			var_2_0.station = iter_2_1.info.station or false

			if iter_2_1.action == var_0_3.update_add then
				self._team_data[iter_2_1.info.team_type][iter_2_1.info.id] = var_2_0

				self:__team__add_team_group(iter_2_1.info)
			elseif iter_2_1.action == var_0_3.update_remove or iter_2_1.action == var_0_3.update_modify then
				local var_2_1 = 0

				for iter_2_2, iter_2_3 in pairs(self._team_data[iter_2_1.info.team_type]) do
					if iter_2_3.id == iter_2_1.info.id then
						var_2_1 = iter_2_2
					end
				end

				if var_2_1 > 0 then
					if iter_2_1.action == var_0_3.update_remove then
						table.remove(self._team_data[iter_2_1.info.team_type], var_2_1)
						self:__team__remove_team_group(iter_2_1.info)
					else
						self._team_data[iter_2_1.info.team_type][var_2_1] = var_2_0

						self:__team__update_team_group(iter_2_1.info)
					end
				end
			end
		end
	end

	function arg_1_0:CampaignInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			local var_3_0 = false

			for iter_3_2, iter_3_3 in pairs(self._campaign_info) do
				if iter_3_1.info.id == iter_3_3.info.id then
					iter_3_3.info = iter_3_1.info
					var_3_0 = true
				end
			end

			if not var_3_0 then
				var_0_1(self._campaign_info, iter_3_1)
			end
		end

		local var_3_1 = var_0_4(arg_3_1, "count")

		if var_3_1 then
			self._campaign_count = var_3_1
		end

		local var_3_2 = var_0_4(arg_3_1, "time")

		if var_3_2 then
			self._campaign_time = var_3_2
		end

		self._campaign_refresh_time = lx.ServerTime:getUtcTime()
	end

	function arg_1_0:BVRAttackChangeUpdate(arg_4_1)
		self:set_bvr_state(arg_4_1.state)
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
