local var_0_0 = {}
local var_0_1 = UnityEngine.Color
local var_0_2 = gamecore.NotificationMgr

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_shadow_android_chanel_creat_chanel_button()
		local var_2_0 = self._control.bg_shadow.android_chanel.desc.desc_text.InputField.desc_text_2.text.text
		local var_2_1 = self._control.bg_shadow.android_chanel.can_by_pass_dnd.can_by_pass_dnd_text.InputField.can_by_pass_dnd_text_2.text.text == "true"
		local var_2_2 = self._control.bg_shadow.android_chanel.can_show_badge.can_show_badge_text.InputField.can_show_badge_text_2.text.text == "true"
		local var_2_3 = {
			channel_id = self._control.bg_shadow.android_chanel.chanel.chanel_text.InputField.chanel_text_2.text.text,
			name = self._control.bg_shadow.android_chanel.chanel_name.chanel_name_text.InputField.chanel_name_text_2.text.text
		}

		var_2_3.importance = tonumber(self._control.bg_shadow.android_chanel.importance.importance_text.InputField.importance_text_2.text.text) or 3
		var_2_3.desc = var_2_0
		var_2_3.canBypassDnd = var_2_1
		var_2_3.canShowBadge = var_2_2

		log.print_r(var_2_3, "channel_config###########")
		var_0_2:createChannel(var_2_3)
	end

	function arg_1_0:__onClick_bg_shadow_android_notification_creat_chanel_button()
		local var_3_0
		local var_3_1 = self._control.bg_shadow.android_notification
		local var_3_2 = self._control.bg_shadow.android_notification.title.title_text.InputField.title_text_2.text.text
		local var_3_3 = self._control.bg_shadow.android_notification.content.content_text.InputField.content_text_2.text.text
		local var_3_4 = self._control.bg_shadow.android_notification.date_time.date_time_text.InputField.date_time_text_2.text.text
		local var_3_5 = self._control.bg_shadow.android_notification.autocancel.autocancel_text.InputField.autocancel_text_2.text.text == "true"
		local var_3_6 = self._control.bg_shadow.android_notification.small_icon.small_icon_text.InputField.small_icon_text_2.text.text

		if self._control.bg_shadow.android_notification.color.color_text.InputField.color_text_2.text.text ~= "" then
			var_3_0 = var_0_1[self._control.bg_shadow.android_notification.color.color_text.InputField.color_text_2.text.text] or nil
		end

		local var_3_7 = var_3_1.channel_2.channel_2_text.InputField.channel_2_text_2.text.text
		local var_3_8 = {
			title = var_3_2,
			text = var_3_3,
			time = tonumber(var_3_4),
			autocancel = var_3_5,
			small_icon = var_3_6,
			big_icon = self._control.bg_shadow.android_notification.big_icon.big_icon_text.InputField.big_icon_text_2.text.text,
			intentdata = self._control.bg_shadow.android_notification.intentdata.intentdata_text.InputField.intentdata_text_2.text.text,
			color = var_3_0
		}

		log.print_r(var_3_8, "notify_config")
		log.print_r(var_3_7, "channel2")
		log.print_r(var_3_1.specificid.specificid_text.InputField.specificid_text_2.text.text, "specificId")
		log.print_r(app:getSystem():getChannel(), "channel#######")
		var_0_2:create_notification(var_3_8, var_3_1.specificid.specificid_text.InputField.specificid_text_2.text.text, var_3_7)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
