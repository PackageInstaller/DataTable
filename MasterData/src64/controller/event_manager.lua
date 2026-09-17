local var_0_0 = {}
local network = require("network.network")
local event_data = require("data.event_data")
local item_manager = require("controller.item_manager")

var_0_0.runningEvents = {}

function var_0_0.init(arg_1_0)
	arg_1_0.runningEvents = {}

	network:rpc("get_all_events", nil, function(arg_2_0)
		if arg_2_0.runningEvents then
			for iter_2_0, iter_2_1 in pairs(arg_2_0.runningEvents) do
				if event_data[iter_2_1] then
					arg_1_0.runningEvents[iter_2_1] = {
						eventid = iter_2_1,
						postcardid = event_data[iter_2_1].postcardid,
						order_weight = iter_2_0
					}
				end
			end
		end
	end)
end

function var_0_0.reloadInfoByServer(arg_3_0, arg_3_1)
	arg_3_0.runningEvents = {}

	network:rpc("get_all_events", nil, function(arg_4_0)
		if arg_4_0.runningEvents then
			for iter_4_0, iter_4_1 in pairs(arg_4_0.runningEvents) do
				if event_data[iter_4_1] then
					arg_3_0.runningEvents[iter_4_1] = {
						eventid = iter_4_1,
						postcardid = event_data[iter_4_1].postcardid,
						order_weight = iter_4_0
					}
				end
			end

			if arg_3_1 then
				arg_3_1()
			end
		end
	end)
end

function var_0_0:getEvents()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.runningEvents) do
		table.insert(var_5_0, iter_5_1)
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		return arg_6_0.order_weight > arg_6_1.order_weight
	end)

	return var_5_0
end

function var_0_0:trigger_event_by_server(arg_7_1)
	if arg_7_1 then
		for iter_7_0, iter_7_1 in pairs(arg_7_1) do
			if event_data[iter_7_1] then
				self.runningEvents[iter_7_1] = {
					eventid = iter_7_1,
					postcardid = iter_7_1.postcardid,
					order_weight = table.nums(self.runningEvents) + 1
				}
			end
		end

		if LayerManager:getCurrentLayerName() == "PatrolFightLayer" and PatrolFightLayer.getInstance() then
			PatrolFightLayer.getInstance():updateEventList()
		end
	end
end

function var_0_0.gain_event_award(arg_8_0, arg_8_1, arg_8_2)
	network:rpc("gain_event_award", {
		eventid = arg_8_1
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			local var_9_0 = {}

			if arg_9_0.items then
				for iter_9_0, iter_9_1 in pairs(arg_9_0.items) do
					local var_9_1 = item_manager:setItemByServerItem(iter_9_1)

					if var_9_1 > 0 then
						table.insert(var_9_0, {
							dropid = iter_9_1.itemid,
							dropNum = var_9_1,
							entityid = iter_9_1.entityid
						})
					end
				end
			end

			arg_8_0.runningEvents[arg_8_1] = nil

			if arg_8_2 then
				arg_8_2(arg_9_0.result, var_9_0, arg_9_0.postcardid)
			end
		end
	end)
end

return var_0_0
