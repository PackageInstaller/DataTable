return {
	extend_method = function(arg_1_0)
		function arg_1_0:ResearchUpdate(arg_2_1)
			if arg_2_1 and next(arg_2_1) then
				self:set_all_research_ship_info(arg_2_1)
			end
		end

		function arg_1_0:set_all_research_ship_info(arg_3_1)
			if self._equip_task and next(self._equip_task) then
				if arg_3_1.equipTask and next(arg_3_1.equipTask) then
					for iter_3_0, iter_3_1 in pairs(arg_3_1.equipTask) do
						if arg_3_1.equipTask[iter_3_0] and next(arg_3_1.equipTask[iter_3_0]) then
							for iter_3_2, iter_3_3 in pairs(self._equip_task) do
								if iter_3_1.id == iter_3_3.id then
									iter_3_3.status = iter_3_1.status
									iter_3_3.task_num_1 = iter_3_1.task_num_1
									iter_3_3.task_num_2 = iter_3_1.task_num_2
									iter_3_3.task_num_3 = iter_3_1.task_num_3
								end
							end
						end
					end
				end

				if arg_3_1.unlockEquips then
					self._unlock_equips = arg_3_1.unlockEquips
				end
			else
				self._equip_task = arg_3_1.equipTask

				if arg_3_1.unlockEquips then
					self._unlock_equips = arg_3_1.unlockEquips
				end
			end

			if self._ship_task and next(self._ship_task) then
				for iter_3_4, iter_3_5 in pairs(arg_3_1.shipTask) do
					if arg_3_1.shipTask and next(arg_3_1.shipTask) then
						for iter_3_6, iter_3_7 in pairs(self._ship_task) do
							if iter_3_5.id == iter_3_7.id then
								iter_3_7.status = iter_3_5.status
								iter_3_7.task_num_1 = iter_3_5.task_num_1
								iter_3_7.task_num_2 = iter_3_5.task_num_2
								iter_3_7.task_num_3 = iter_3_5.task_num_3
								iter_3_7.complete_time = iter_3_5.complete_time
							end
						end
					end
				end

				if arg_3_1.unlockShips then
					self._unlock_ship = arg_3_1.unlockShips
				end
			else
				self._ship_task = arg_3_1.shipTask

				if arg_3_1.unlockShips then
					self._unlock_ship = arg_3_1.unlockShips
				end
			end

			if self:have_index(arg_3_1, "shipResearchId") and arg_3_1.shipResearchId then
				self._init_ship_research_id = arg_3_1.shipResearchId
			end
		end

		function arg_1_0.have_index(arg_4_0, arg_4_1, arg_4_2)
			for iter_4_0, iter_4_1 in pairs(arg_4_1) do
				if iter_4_0 == arg_4_2 then
					return true
				end
			end

			return false
		end
	end,
	extend_obj = function(arg_5_0)
		return
	end
}
