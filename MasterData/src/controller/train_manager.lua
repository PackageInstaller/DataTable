local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local skillup_cos_data = require("data.skillup_cos_data")
local servant_data = require("data.servant_data")
local fitness_data = require("data.fitness_data")
local item_manager = require("controller.item_manager")

var_0_0.trainRoomConfig = {}

function var_0_0.getTrainInfos(arg_1_0, arg_1_1)
	print("get_train_infos")
	network:rpc("get_train_infos", nil, function(arg_2_0)
		for iter_2_0, iter_2_1 in pairs(arg_2_0.trainInfos) do
			arg_1_0.trainRoomConfig[iter_2_0] = iter_2_1
		end

		arg_1_1(arg_2_0)

		return arg_2_0
	end)
end

function var_0_0.unlockTrainStation(arg_3_0, arg_3_1)
	print("unlock_train_station")
	network:rpc("unlock_train_station", {}, function(arg_4_0)
		print(dump(arg_4_0))

		if arg_4_0.result == 1 then
			arg_3_1(arg_4_0)
			AnalyticManager.trainRoomFinish({
				trainRoomNum = arg_4_0.trainInfo.roomid
			})
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords(L_ROOM_NUM_LIMIT)
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords(L_DIAMOND_LACK)
		elseif arg_4_0.result == 4 then
			global_ShowBlockWords(L_GOLD_LACK)
			arg_3_1(arg_4_0)
		elseif arg_4_0.result == 5 then
			global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
			arg_3_1(arg_4_0)
		end
	end)
end

function var_0_0.selectServantTrain(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	print("select_servnat_train")
	print("roomid==", arg_5_1, arg_5_2, type(arg_5_1), type(arg_5_2))
	network:rpc("select_servnat_train", {
		roomid = arg_5_1,
		servantid = arg_5_2
	}, function(arg_6_0)
		print(dump(arg_6_0))

		if arg_6_0.result == 1 then
			if arg_5_0.trainRoomConfig[arg_5_1] then
				arg_5_0.trainRoomConfig[arg_5_1].servantid = arg_5_2
			else
				arg_5_0.trainRoomConfig[arg_5_1] = {}
				arg_5_0.trainRoomConfig[arg_5_1].servantid = arg_5_2
			end

			arg_5_3(arg_6_0)
			AnalyticManager.trainDispatch({
				servantId = arg_5_2
			})
		elseif arg_6_0.result == 2 then
			cclog("训练室id不正确")
		elseif arg_6_0.result == 6 then
			cclog("训练室状态不对")
		elseif arg_6_0.result == 3 then
			cclog("魂姬未解锁")
		elseif arg_6_0.result == 4 then
			cclog("魂姬正在中")
		elseif arg_6_0.result == 0 then
			cclog("空id")
		end
	end)
end

function var_0_0.beginTrain(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	print("begin_training")
	network:rpc("begin_training", {
		roomid = arg_7_1,
		packageid = arg_7_2
	}, function(arg_8_0)
		print(dump(arg_8_0))

		if arg_8_0.result == 1 then
			if arg_7_3 then
				arg_7_3(arg_8_0)
			end

			AnalyticManager.trainSuccess({
				servantId = arg_8_0.trainInfo.servantid
			})
		elseif arg_8_0.result == 2 then
			cclog("训练室id不正确")
		elseif arg_8_0.result == 3 then
			cclog("训练室没有魂姬")
		elseif arg_8_0.result == 4 then
			cclog("训练室状态不对")
		elseif arg_8_0.result == 5 then
			cclog("训练套餐不存在")
		elseif arg_8_0.result == 6 then
			cclog("电力不足")
		elseif arg_8_0.result == 8 then
			cclog("已到等级上限")
		end
	end)
end

function var_0_0.finishTrain(arg_9_0, arg_9_1, arg_9_2)
	print("finish_training")
	network:rpc("finish_training", {
		roomid = arg_9_1
	}, function(arg_10_0)
		print(dump(arg_10_0))

		if arg_10_0.result == 1 then
			arg_9_2(arg_10_0)
			AnalyticManager.trainFinish({
				servantId = arg_10_0.trainInfo.servantid
			})

			playermodel.strengthpoint = playermodel.strengthpoint + arg_10_0.returnsp

			global_update_strengthpoint()
		elseif arg_10_0.result == 2 then
			cclog("训练室id不正确")
		elseif arg_10_0.result == 3 then
			cclog("训练时间未结束")
		elseif arg_10_0.result == 4 then
			cclog("无法升级skilup_cos_")
		end
	end)
end

function var_0_0.quickFinishTrain(arg_11_0, arg_11_1, arg_11_2)
	print("quick_finish_training")
	network:rpc("quick_finish_training", {
		roomid = arg_11_1
	}, function(arg_12_0)
		print(dump(arg_12_0))

		if arg_12_0.result == 1 then
			playermodel.gold = playermodel.gold - arg_12_0.cost_gold

			global_update_gold_stone_diamond(arg_12_0.cost_gold)

			local core_data = require("data.core_data")

			arg_11_2(arg_12_0)
			AnalyticManager.trainQuick({
				servantId = arg_12_0.trainInfo.servantid
			})

			playermodel.strengthpoint = playermodel.strengthpoint + arg_12_0.returnsp

			global_update_strengthpoint()
		elseif arg_12_0.result == 2 then
			cclog("训练室id不正确")
		elseif arg_12_0.result == 3 then
			cclog("训练状态不对")
		elseif arg_12_0.result == 4 then
			cclog(L_GOLD_LACK)
		end
	end)
end

function var_0_0.cancelTrain(arg_13_0, arg_13_1, arg_13_2)
	print("cancel_training")
	network:rpc("cancel_training", {
		roomid = arg_13_1
	}, function(arg_14_0)
		print(dump(arg_14_0))

		if arg_14_0.result == 1 then
			if arg_13_2 then
				arg_13_2(arg_14_0)
			end
		elseif arg_14_0.result == 2 then
			cclog("训练室id不正确")
		elseif arg_14_0.result == 3 then
			cclog("无法升级")
		end
	end)
end

function var_0_0.remove_servant_train(arg_15_0, arg_15_1, arg_15_2)
	print("remove_servant_train")
	network:rpc("remove_servant_train", {
		roomid = arg_15_1
	}, function(arg_16_0)
		print(dump(arg_16_0))

		if arg_16_0.result == 1 then
			if arg_15_2 then
				arg_15_2(arg_16_0)
			end

			AnalyticManager.removeTrain({
				servantId = arg_15_0.trainRoomConfig[arg_15_1].servantid
			})

			arg_15_0.trainRoomConfig[arg_15_1].servantid = nil
		elseif arg_16_0.result == 2 then
			cclog("训练室id不正确")
		elseif arg_16_0.result == 3 then
			cclog("没有魂姬")
		elseif arg_16_0.result == 0 then
			cclog("空房间id")
		end
	end)
end

function var_0_0.set_time_scale(arg_17_0, arg_17_1)
	print("set_time_scale")
	network:rpc("set_time_scale", {
		scale = arg_17_1
	}, function(arg_18_0)
		print(dump(arg_18_0))
	end)
end

function var_0_0.quick_finish_train_unlock(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	print("quick_finish_train_unlock")

	if arg_19_1 == "diamond" then
		arg_19_1 = CURRENCY_DIAMOND
	end

	network:rpc("quick_finish_train_unlock", {
		itemid = arg_19_1,
		num = arg_19_2
	}, function(arg_20_0)
		print(dump(arg_20_0))

		if arg_20_0.result == 1 then
			if arg_19_1 == CURRENCY_GOLD then
				playermodel.gold = playermodel.gold - arg_20_0.cost_num
			elseif arg_19_1 == CURRENCY_DIAMOND then
				playermodel.diamond = playermodel.diamond - arg_20_0.cost_num
			else
				item_manager:deleteItem(arg_19_1, arg_20_0.cost_num)
			end

			global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)

			if arg_19_3 then
				arg_19_3(arg_20_0)
			end
		elseif arg_19_3 then
			arg_19_3(arg_20_0)
		end
	end)
end

function var_0_0.return_train_material(arg_21_0, arg_21_1, arg_21_2)
	print("return_train_material")
	network:rpc("return_train_material", {
		roomid = arg_21_1
	}, function(arg_22_0)
		print(dump(arg_22_0))

		if arg_22_0.result == 1 then
			global_get({
				items = arg_22_0.items
			})

			if arg_21_2 then
				arg_21_2(arg_22_0)
			end
		elseif arg_21_2 then
			arg_21_2(arg_22_0)
		end
	end)
end

function var_0_0.getSwimInfos(arg_23_0, arg_23_1)
	network:rpc("get_swim_infos", nil, function(arg_24_0)
		arg_23_1(arg_24_0)
	end)
end

function var_0_0.unlockSwimPool(arg_25_0, arg_25_1, arg_25_2)
	network:rpc("unlock_swim_pool", {
		slotid = arg_25_1
	}, function(arg_26_0)
		if arg_26_0.result == 1 then
			playermodel.diamond = playermodel.diamond - arg_26_0.cost_diamond

			global_update_gold_stone_diamond(nil, nil, arg_26_0.cost_diamond)
			arg_25_2(arg_26_0.result)
		elseif arg_26_0.result == 2 then
			cclog("游泳池id不对")
		elseif arg_26_0.result == 3 then
			cclog("游泳馆状态不对")
		elseif arg_26_0.result == 4 then
			cclog(L_DIAMOND_LACK)
			arg_25_2(arg_26_0.result)
		end
	end)
end

function var_0_0.selectSoulSwim(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	network:rpc("select_soul_swim", {
		slotid = arg_27_1,
		soulid = arg_27_2
	}, function(arg_28_0)
		if arg_28_0.result == 1 then
			arg_27_3()
		elseif arg_28_0.result == 2 then
			cclog("游泳池id不对")
		elseif arg_28_0.result == 3 then
			cclog("游泳馆状态不对")
		elseif arg_28_0.result == 4 then
			cclog("魂姬未解锁")
		elseif arg_28_0.result == 5 then
			cclog("魂姬正在游泳中")
		elseif arg_28_0.result == 6 then
			cclog("魂姬体能已满级")
		end
	end)
end

function var_0_0.beginSwimming(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	network:rpc("begin_swimming", {
		slotid = arg_29_1
	}, function(arg_30_0)
		if arg_30_0.result == 1 then
			playermodel.gold = playermodel.gold - (fitness_data[playermodel.fitness[arg_29_2].fitnesslevel].cost_gold or 0)

			local var_30_1 = fitness_data[playermodel.fitness[arg_29_2].fitnesslevel].cost_num or 1
			local var_30_2 = fitness_data[playermodel.fitness[arg_29_2].fitnesslevel].cost_item
			local var_30_3

			for iter_30_0, iter_30_1 in pairs(playermodel.items) do
				if iter_30_1.itemid == var_30_2 then
					var_30_3 = iter_30_0
				end
			end

			item_manager:deleteItem(var_30_3, var_30_1)
			arg_29_3()
		elseif arg_30_0.result == 2 then
			cclog("游泳池id不对")
		elseif arg_30_0.result == 3 then
			cclog("没有魂姬待命")
		elseif arg_30_0.result == 4 then
			cclog("魂姬体能已满级")
		elseif arg_30_0.result == 5 then
			cclog(L_GOLD_LACK)
		elseif arg_30_0.result == 6 then
			cclog("材料不足")
		end
	end)
end

function var_0_0.getSwimMaxLevel(arg_31_0)
	return #fitness_data
end

function var_0_0.finishSwimming(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	network:rpc("finish_swimming", {
		slotid = arg_32_1
	}, function(arg_33_0)
		if arg_33_0.result == 1 then
			if arg_33_0.fitnesslevel <= var_0_0:getSwimMaxLevel() then
				playermodel.fitness[arg_32_2].fitnesslevel = arg_33_0.fitnesslevel
			end

			if arg_33_0.sanvalue then
				playermodel.souls_sanvalue[arg_32_2] = arg_33_0.sanvalue
			end

			arg_32_3()
		elseif arg_33_0.result == 2 then
			cclog("游泳池id不对")
		elseif arg_33_0.result == 3 then
			cclog("游泳池状态不对")
		elseif arg_33_0.result == 4 then
			cclog("魂姬体能已满级")
		end
	end)
end

function var_0_0.quickFinishSwimming(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	network:rpc("quick_finish_swimming", {
		slotid = arg_34_1
	}, function(arg_35_0)
		if arg_35_0.result == 1 then
			if arg_35_0.fitnesslevel <= var_0_0:getSwimMaxLevel() then
				playermodel.fitness[arg_34_2].fitnesslevel = arg_35_0.fitnesslevel
			end

			if arg_35_0.sanvalue then
				playermodel.souls_sanvalue[arg_34_2] = arg_35_0.sanvalue
			end

			arg_34_3()
		elseif arg_35_0.result == 2 then
			cclog("游泳池id不对")
		elseif arg_35_0.result == 3 then
			cclog("游泳池状态不对")
		elseif arg_35_0.result == 4 then
			cclog("魂姬体能已满级")
		elseif arg_35_0.result == 5 then
			cclog(L_DIAMOND_LACK)
		end
	end)
end

function var_0_0.cancelSwimming(arg_36_0, arg_36_1, arg_36_2)
	network:rpc("cancel_swimming", {
		slotid = arg_36_1
	}, function(arg_37_0)
		if arg_37_0.result == 1 then
			for iter_37_0, iter_37_1 in pairs(arg_37_0.items) do
				if iter_37_1.itemtype == 21 then
					if playermodel.items[iter_37_1.entityid] then
						playermodel.items[iter_37_1.entityid].number = playermodel.items[iter_37_1.entityid].number + iter_37_1.itemcount
					else
						playermodel.items[iter_37_1.entityid] = {
							entityid = iter_37_1.entityid,
							itemid = iter_37_1.itemid,
							number = iter_37_1.itemcount,
							itemtype = iter_37_1.itemtype
						}
					end
				end
			end

			arg_36_2()
		elseif arg_37_0.result == 2 then
			cclog("游泳池id不对")
		end
	end)
end

return var_0_0
