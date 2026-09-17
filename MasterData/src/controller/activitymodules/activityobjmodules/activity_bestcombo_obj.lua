local activity_manager = require("controller.activity_manager")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local activity_bestcombo_conf = require("data.activity_bestcombo_conf")

function ACTIVITY_OBJ_NEW:set_bestcombo_combo(arg_1_1, arg_1_2)
	network:rpc("set_activity_bestcombo_combo", {
		activityid = self._id,
		combo = arg_1_1
	}, function(arg_2_0)
		print("set_activity_bestcombo_combo====", dump(arg_2_0))

		if arg_2_0.result == 1 then
			if arg_2_0.items then
				global_get(arg_2_0)
			end

			if arg_2_0.consumes then
				for iter_2_0, iter_2_1 in pairs(arg_2_0.consumes) do
					item_manager:deleteItem(iter_2_1.entityid, iter_2_1.num)
				end
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_BESTCOMBO_RESULT, arg_2_0)
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords("该玩法暂未开放!!!")
		elseif arg_2_0.result == 3 then
			global_ShowBlockWords("组合出错了!!!")
		elseif arg_2_0.result == 4 then
			global_ShowBlockWords("有重复的魂器哦!!!")
		elseif arg_2_0.result == 5 then
			global_ShowBlockWords("道具不足!!!")
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_1_2 then
			arg_1_2(arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_bestcombo_conf()
	return activity_bestcombo_conf[self._id]
end
