local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = UnityEngine.Application
local var_0_3 = UnityEngine.RuntimePlatform
local var_0_4 = gamecore.NotificationMgr
local var_0_5 = gameenum.common_type

gamecore.UILoader:define("notify_text_panel", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0.__init_panel(arg_4_0, arg_4_1)
		if var_0_2.platform == var_0_3.Android and app:getSystem():getChannel() == "hm_android" and var_0_5:get_now_appversion_num() > var_0_5.version_init_num then
			var_0_4:init_received_handler()
			var_0_4:set_received_handler(function(arg_5_0)
				print("通知触发回调")
				print(arg_5_0)
			end)
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_7_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_1:class("notify_text_panel")

	var_8_0:__initia_lize()

	return var_8_0
end

return var_0_0
