local activity_manager = require("controller.activity_manager")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local activity_bestcombo_conf = require("data.activity_bestcombo_conf")

function ACTIVITY_OBJ_NEW:alchemy_gameend(arg_1_1, arg_1_2)
	network:rpc("activity_alchemy_gameend", {
		activityid = self._id,
		score = arg_1_1
	}, function(arg_2_0)
		print("activity_alchemy_gameend====", dump(arg_2_0))

		if arg_2_0.result == 1 then
			-- block empty
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_1_2 then
			arg_1_2(arg_2_0)
		end
	end)
end
