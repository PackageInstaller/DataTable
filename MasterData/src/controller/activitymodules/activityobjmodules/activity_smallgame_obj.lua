local activity_manager = require("controller.activity_manager")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local activity_bestcombo_conf = require("data.activity_bestcombo_conf")
local hitmouse_conf = require("data.hitmouse_conf")
local musicialnote_conf = require("data.musicialnote_conf")
local giftfall_conf = require("data.giftfall_conf")

function ACTIVITY_OBJ_NEW:activity_smallgame_startgame(arg_1_1, arg_1_2)
	if arg_1_1.gametype == ACTIVITY_SMALLGAME_TYPE_HITMOUSE then
		if item_manager:getItemNumber(hitmouse_conf[self._id].key_item) < 1 then
			global_ShowBlockWords("道具不足!!!")

			return
		end
	elseif arg_1_1.gametype == ACTIVITY_SMALLGAME_TYPE_MUSICIALNOTE then
		if item_manager:getItemNumber(musicialnote_conf[self._id].key_item) < 1 then
			global_ShowBlockWords("道具不足!!!")

			return
		end
	elseif arg_1_1.gametype == ACTIVITY_SMALLGAME_TYPE_GIFTFALL and item_manager:getItemNumber(giftfall_conf[self._id].key_item) < 1 then
		global_ShowBlockWords("道具不足!!!")

		return
	end

	network:rpc("activity_smallgame_startgame", {
		activityid = self._id,
		gametype = arg_1_1.gametype
	}, function(arg_2_0)
		print("activity_smallgame_startgame====", dump(arg_2_0))

		if arg_2_0.result == 1 then
			if arg_2_0.items then
				global_get(arg_2_0)
			end

			if arg_2_0.consumes then
				for iter_2_0, iter_2_1 in pairs(arg_2_0.consumes) do
					item_manager:deleteItem(iter_2_1.entityid, iter_2_1.num)
				end
			end
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords("该玩法暂未开放!!!")
		elseif arg_2_0.result == 3 then
			global_ShowBlockWords("道具不足!!!")
		elseif arg_2_0.result == 4 then
			global_ShowBlockWords("游戏类型上报错误")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_1_2 then
			arg_1_2(arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_smallgame_data_report(arg_3_1, arg_3_2)
	network:rpc("activity_smallgame_data_report", {
		activityid = self._id,
		report_data = arg_3_1,
		gametype = arg_3_1.gametype
	}, function(arg_4_0)
		print("activity_smallgame_data_report====", dump(arg_4_0))

		if arg_4_0.result == 1 then
			if arg_4_0.items then
				if arg_3_1.gametype == ACTIVITY_SMALLGAME_TYPE_MUSICIALNOTE then
					global_get(arg_4_0)
				else
					global_gain(arg_4_0)
				end
			end

			if arg_4_0.consumes then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.consumes) do
					item_manager:deleteItem(iter_4_1.entityid, iter_4_1.num)
				end
			end
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords("该玩法暂未开放!!!")
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords("道具不足!!!")
		elseif arg_4_0.result == 4 then
			global_ShowBlockWords("游戏类型上报错误")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_3_2 then
			arg_3_2(arg_4_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_smallgame_use_speacial_item(arg_5_1, arg_5_2)
	network:rpc("activity_smallgame_use_speacial_item", {
		activityid = self._id,
		gametype = arg_5_1.gametype
	}, function(arg_6_0)
		print("activity_smallgame_use_speacial_item====", dump(arg_6_0))

		if arg_6_0.result == 1 then
			if arg_6_0.items then
				global_gain(arg_6_0)
			end

			if arg_6_0.consumes then
				for iter_6_0, iter_6_1 in pairs(arg_6_0.consumes) do
					item_manager:deleteItem(iter_6_1.entityid, iter_6_1.num)
				end
			end
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords("该玩法暂未开放!!!")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("道具不足!!!")
		elseif arg_6_0.result == 4 then
			global_ShowBlockWords("游戏类型上报错误")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_5_2 then
			arg_5_2(arg_6_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_musicalnote_refresh(arg_7_1)
	network:rpc("activity_musicalnote_refresh", {
		activityid = self._id
	}, function(arg_8_0)
		print("activity_musicalnote_refresh====", dump(arg_8_0))

		if arg_8_0.result == 1 then
			global_ShowBlockWords("刷新成功!!!")
		elseif arg_8_0.result == 2 then
			global_ShowBlockWords("今日次数已用完!!!")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_7_1 then
			arg_7_1(arg_8_0)
		end
	end)
end
