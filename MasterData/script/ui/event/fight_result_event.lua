local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.expedition_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_close_btn(arg_2_0)
		var_0_1:createInstance("msgbox_image_simlpe"):Show_Info(var_0_2:getNowLang("continueexplorecontent"), function()
			local var_3_0 = app:getSystem():getChannel()
			local var_3_1 = var_0_4:get_now_appversion_num()

			print("发送22211")
			log.print_r(var_3_0, "channel渠道名字")
			log.print_r(var_3_1, "version_num版本号数")

			if var_3_0 == "hm_android" and var_3_1 > var_0_4.version_init_num then
				NotifyManager.InitReceivedHandler()

				function NotifyManager.receivedCallback(arg_4_0)
					print("通知触发回调")
				end

				local var_3_2 = var_0_5.find_object_by_id(arg_2_0._expedition_id)

				print("发送22222222")
				NotifyManager.CreateAndroidNotification("提督大人", string.format(var_0_2:getNowLang("expeditioncompleted"), arg_2_0._team_id, var_3_2.title), var_3_2.need_time, true, "", "icon_1", "", arg_2_0._team_id, var_3_0)
			end

			var_0_3:req_ExpeditionStartReq({
				team_id = arg_2_0._team_id,
				id = arg_2_0._expedition_id
			})
			arg_2_0:play_out_animation(function()
				var_0_1:destroyInstance("fight_result")
				;(var_0_1:getInstance("gotofight") or var_0_1:createInstance("gotofight")):show({
					toggle_index = 3
				}, true)
			end)
		end, function()
			arg_2_0:play_out_animation(function()
				var_0_1:destroyInstance("fight_result")
				;(var_0_1:getInstance("gotofight") or var_0_1:createInstance("gotofight")):show({
					toggle_index = 3
				}, true)
			end)
		end, var_0_2:getNowLang("continueexplore"))
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
