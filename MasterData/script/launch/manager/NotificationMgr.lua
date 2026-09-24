local var_0_0 = lx
local var_0_4 = UnityEngine.Application
local var_0_5 = UnityEngine.RuntimePlatform

lx.define_class("NotificationMgr", function(arg_1_0)
	function arg_1_0.show(arg_2_0, arg_2_1)
		print("^^^^^^^^^^")
		print("^^^^^^^^^^")
		print("^^^^^^^^^^")
		print("^^^^^^^^^^")
		print("^^^^^^^^^^")
		print("^^^^^^^^^^")
		print("^^^^^^^^^^")
		print("^^^^^^^^^^")
	end

	function arg_1_0.GetAppStartIntent(arg_3_0)
		if var_0_4.platform == var_0_5.Android then
			return NotifyManager.CheckAppStartIntentAndroid()
		end
	end

	function arg_1_0.ClearAllNotifications(arg_4_0)
		if var_0_4.platform == var_0_5.Android then
			NotifyManager.CancelNotificationAll()
		end
	end

	function arg_1_0.CancelNotificationById(arg_5_0, arg_5_1)
		if var_0_4.platform == var_0_5.Android then
			NotifyManager.CancelNotificationById(arg_5_1)
		end
	end

	function arg_1_0.createChannel(arg_6_0, arg_6_1)
		print("55555555555")
		log.print_r(arg_6_1, "data%%%")
		NotifyManager.CreateChannel(arg_6_1.channel_id, arg_6_1.name, arg_6_1.importance, arg_6_1.desc, arg_6_1.canBypassDnd, arg_6_1.canShowBadge)
		print("666666666")
	end

	function arg_1_0.init_received_handler(arg_7_0)
		print("3333")
		NotifyManager.InitReceivedHandler()
		print("44444")
	end

	function arg_1_0.set_received_handler(arg_8_0, arg_8_1)
		NotifyManager.receivedCallback = arg_8_1
	end

	function arg_1_0:GetChannel()
		return self._channel_id
	end

	function arg_1_0.create_notification(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		log.print_r(arg_10_1, "data")
		log.print_r(arg_10_3, "channel_id")
		log.print_r(arg_10_2, "specific_id")

		return (NotifyManager.CreateAndroidNotification(arg_10_1.title, arg_10_1.text, arg_10_1.time, arg_10_1.autocancel, arg_10_1.small_icon, arg_10_1.big_icon, arg_10_1.intentdata, arg_10_2, arg_10_3))
	end
end)

return function()
	return (var_0_0.class("NotificationMgr"))
end
