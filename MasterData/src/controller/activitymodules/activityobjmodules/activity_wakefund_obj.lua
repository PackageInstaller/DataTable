function ACTIVITY_OBJ_NEW:buyWakeFundVip(arg_1_1)
	net:rpc("buy_wake_fund_vip", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			global_get(arg_2_0)

			if arg_2_0.consumes then
				for iter_2_0, iter_2_1 in ipairs(arg_2_0.consumes) do
					itemManager:deleteItem(iter_2_1.entityid, iter_2_1.num)
				end
			end

			global_update_gold_stone_diamond(arg_2_0.gold, nil, itemManager:getItemNumber(CURRENCY_DIAMOND))

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		elseif arg_1_1 then
			arg_1_1(arg_2_0)
		end
	end)
end
