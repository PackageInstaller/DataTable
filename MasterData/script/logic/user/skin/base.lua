local var_0_0 = {}
local var_0_2 = table.insert
local var_0_4 = table.sort
local var_0_5 = gameconfig.skin_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:reset_skin_data()
		self._skin_data.skin = {}
	end

	function arg_1_0:get_skin_list()
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(self._skin_data.skin) do
			local var_3_1 = var_0_5.find_object_by_cid(iter_3_1)

			if var_3_1 then
				for iter_3_2, iter_3_3 in pairs(var_3_1.card_cids) do
					if not var_3_0[iter_3_3] or not next(var_3_0[iter_3_3]) then
						var_3_0[iter_3_3] = {}
					end

					var_0_2(var_3_0[iter_3_3], iter_3_1)
				end
			end
		end

		for iter_3_4, iter_3_5 in pairs(var_3_0) do
			if #iter_3_5 > 1 then
				var_0_4(iter_3_5, function(arg_4_0, arg_4_1)
					return arg_4_0 < arg_4_1
				end)
			end
		end

		return var_3_0
	end

	function arg_1_0:skin_have_exist(arg_5_1)
		local var_5_0 = false

		for iter_5_0, iter_5_1 in pairs(self._skin_data.skin) do
			if arg_5_1 == iter_5_1 then
				var_5_0 = true

				break
			end
		end

		return var_5_0
	end

	function arg_1_0:get_latest_skin_id()
		self._latest_skin_id = 0

		return self._latest_skin_id
	end

	function arg_1_0:__skin__update_info(arg_7_1)
		self._skin_data.skin[arg_7_1] = arg_7_1
	end

	function arg_1_0:__skin__add_info(arg_8_1)
		self._skin_data.skin[arg_8_1] = arg_8_1
	end

	function arg_1_0:__skin__remove_info(arg_9_1)
		self._skin_data.skin[arg_9_1] = nil
	end

	function arg_1_0:get_skin_count()
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs(self._skin_data) do
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				if iter_10_3 ~= 0 then
					var_10_0[iter_10_3] = iter_10_3
				end
			end
		end

		local var_10_1 = 0

		for iter_10_4, iter_10_5 in pairs(var_10_0) do
			var_10_1 = var_10_1 + 1
		end

		return var_10_1
	end

	function arg_1_0:get_skin_data_info()
		return self._skin_data.skin
	end

	function arg_1_0:set_skin_data_info(arg_12_1)
		self._skin_data.skin = arg_12_1
	end
end

function var_0_0.extend_obj(arg_13_0)
	arg_13_0._skin_data = {
		skin = {}
	}
	arg_13_0._latest_skin_id = 0
end

return var_0_0
