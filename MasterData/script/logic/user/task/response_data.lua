local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.user
local var_0_7 = gameconfig.item_config
local var_0_8 = table.insert
local var_0_9 = gameconfig.chat_head_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.CommitTaskResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("task")
			local var_2_1 = {}
			local var_2_2 = {}
			local var_2_3 = {}
			local var_2_4 = {}
			local var_2_5 = {}
			local var_2_6 = {}

			for iter_2_0, iter_2_1 in pairs(arg_2_1.reward) do
				if iter_2_1.type == 4 or iter_2_1.type == 1 then
					var_0_8(var_2_1, iter_2_1)
				elseif iter_2_1.type == 8 then
					var_0_8(var_2_4, iter_2_1)

					arg_2_1.reward[iter_2_0] = nil
				elseif iter_2_1.type == 12 then
					var_0_8(var_2_5, iter_2_1)
				elseif iter_2_1.type == 2 and iter_2_1.id % 100 == 42 or iter_2_1.id % 100 == 43 then
					var_0_8(var_2_6, {
						is_new = false,
						type = 2,
						id = iter_2_1.id,
						count = iter_2_1.count
					})
				end
			end

			local var_2_7 = var_0_1:getInstance("msgbox")

			local function var_2_8()
				if var_2_7 then
					var_2_7:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))
				end

				local function var_3_0()
					if #var_2_6 >= 1 then
						var_0_1:createInstance("mail_box"):show(var_2_6)
					end
				end

				if #var_2_1 ~= 0 then
					local var_3_1 = var_0_1:createInstance("new_ship_or_equip")

					if #var_2_6 ~= 0 then
						var_3_1:show(true, var_2_1[1], var_0_5.enter_get_ship_type.sign_and_task, var_3_0)
					else
						var_3_1:show(true, var_2_1[1], var_0_5.enter_get_ship_type.sign_and_task)
					end
				end

				if #var_2_4 ~= 0 then
					var_0_1:createInstance("reward_tip"):show_by_enter_type(var_0_9.find_object_by_cid(var_2_4[1].id).icon, var_0_5.enter_get_ship_type.task_award)

					if #var_2_6 ~= 0 then
						var_0_1:createInstance("mail_box"):show(var_2_6)
					end
				end

				if #var_2_5 ~= 0 then
					local var_3_2 = var_0_1:createInstance("reward_tip")

					if #var_2_6 >= 1 then
						var_3_2:show_by_enter_type(nil, var_0_5.enter_icon_detail_type.picture_panel, var_3_0, var_2_5[1].id)
					else
						var_3_2:show_by_enter_type(nil, var_0_5.enter_icon_detail_type.picture_panel, nil, var_2_5[1].id)
					end
				end
			end

			if arg_2_1.reward and next(arg_2_1.reward) then
				if var_0_6:get_guide_state() then
					for iter_2_2, iter_2_3 in pairs(arg_2_1.reward) do
						if iter_2_3.type == 4 or iter_2_3.type == 1 then
							var_0_8(var_2_2, iter_2_3)
						else
							var_0_8(var_2_3, iter_2_3)
						end
					end

					if var_2_3 == nil or var_2_3 == {} then
						if #var_2_1 ~= 0 then
							var_0_1:createInstance("new_ship_or_equip"):show(true, var_2_1[1], var_0_5.enter_get_ship_type.sign_and_task)
						end
					else
						var_2_7 = var_2_7 or var_0_1:createInstance("msgbox")

						var_2_7:showOnes(arg_2_1.reward, var_2_8, nil, var_0_2:getNowLang("logget"), var_0_5.msg_type.rewards)
						var_2_7:set_canvas_order(999)
					end
				elseif #var_2_1 ~= 0 and #arg_2_1.reward == 1 then
					var_0_1:createInstance("new_ship_or_equip"):show(true, var_2_1[1], var_0_5.enter_get_ship_type.sign_and_task)
				elseif #arg_2_1.reward == 1 and next(var_2_5) then
					var_2_8()
				elseif #arg_2_1.reward == 1 and next(var_2_5) then
					var_2_8()
				else
					local var_2_9 = {}
					local var_2_10 = {}

					for iter_2_4, iter_2_5 in pairs(arg_2_1.reward) do
						if iter_2_5.type == 2 and iter_2_5.id % 100 ~= 42 then
							var_0_8(var_2_9, iter_2_5)
						end
					end

					if var_2_9 and next(var_2_9) then
						for iter_2_6, iter_2_7 in pairs(var_2_9) do
							if iter_2_7.type ~= 4 and iter_2_7.type ~= 1 and iter_2_7.type ~= 13 and iter_2_7.type ~= 8 and iter_2_7.type ~= 12 then
								var_0_8(var_2_10, iter_2_7)
							end
						end
					end

					if arg_2_1.reward and #var_2_10 > 0 then
						var_2_7 = var_2_7 or var_0_1:createInstance("msgbox")

						var_2_7:showOnes(arg_2_1.reward, var_2_8, nil, var_0_2:getNowLang("logget"), var_0_5.msg_type.rewards)
					else
						var_2_8()
					end
				end
			else
				var_2_8()
			end

			var_2_0:updata_data()
			var_2_0:__set__now_data(var_2_0._now_label)
			var_2_0:_tip_have()
		else
			var_0_4:show(var_0_3:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.CommitTaskAllResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			table.sort(arg_5_1.reward, function(arg_6_0, arg_6_1)
				return arg_6_0.id < arg_6_1.id
			end)

			local var_5_0 = var_0_1:getInstance("task")
			local var_5_1 = {}
			local var_5_4 = {}
			local var_5_5 = {}
			local var_5_6 = {}
			local var_5_7 = {}

			for iter_5_0, iter_5_1 in pairs((var_0_7.get_sequence())) do
				var_0_8(var_5_7, {
					is_new = false,
					count = 0,
					id = iter_5_1.cid,
					type = iter_5_1.type
				})
			end

			for iter_5_2, iter_5_3 in pairs(arg_5_1.reward) do
				if iter_5_3.type == 4 or iter_5_3.type == 1 then
					var_0_8(var_5_1, iter_5_3)
				elseif iter_5_3.type == 8 then
					var_0_8(var_5_4, iter_5_3)

					arg_5_1.reward[iter_5_2] = nil
				elseif iter_5_3.type == 12 then
					var_0_8(var_5_5, iter_5_3)
				elseif iter_5_3.type % 100 == 42 or iter_5_3.type % 100 == 43 then
					var_0_8(var_5_6, {
						is_new = false,
						type = 2,
						id = iter_5_3.id,
						count = iter_5_3.count
					})
				else
					for iter_5_4, iter_5_5 in pairs(var_5_7) do
						if iter_5_5.id == iter_5_3.id then
							iter_5_5.count = iter_5_5.count + iter_5_3.count
							iter_5_5.type = iter_5_3.type
						end
					end
				end
			end

			local var_5_8 = {}

			for iter_5_6, iter_5_7 in pairs(var_5_7) do
				if iter_5_7.count > 0 then
					var_0_8(var_5_8, {
						is_new = false,
						id = iter_5_7.id,
						count = iter_5_7.count,
						type = iter_5_7.type
					})
				end
			end

			local function var_5_9()
				if #var_5_8 >= 1 then
					var_0_1:createInstance("acquire_image"):Show_Info(var_5_8)

					local var_7_0 = var_0_1:getInstance("new_ship_or_equip")

					if var_7_0 then
						var_7_0:__check_layer()
					end
				end
			end

			local function var_5_10()
				if #var_5_4 >= 1 then
					var_0_1:createInstance("reward_tip"):show_by_enter_type(var_0_9.find_object_by_cid(var_5_4[1].id).icon, var_0_5.enter_get_ship_type.task_award, var_5_9)
				else
					var_5_9()
				end
			end

			local function var_5_11()
				if #var_5_5 >= 1 then
					local var_9_0 = var_0_1:createInstance("reward_tip")

					if #var_5_4 >= 1 then
						var_9_0:show_by_enter_type(nil, var_0_5.enter_icon_detail_type.picture_panel, var_5_10, var_5_5[1].id)
					elseif #var_5_8 >= 1 then
						var_9_0:show_by_enter_type(nil, var_0_5.enter_icon_detail_type.picture_panel, var_5_9, var_5_5[1].id)
					else
						var_9_0:show_by_enter_type(nil, var_0_5.enter_icon_detail_type.picture_panel, nil, var_5_5[1].id)
					end
				else
					var_5_10()
				end
			end

			if var_5_1 and next(var_5_1) then
				if #var_5_1 > 1 then
					local var_5_12 = var_0_1:createInstance("new_ship_or_equip")

					if #var_5_5 >= 1 then
						var_5_12:show(true, var_5_1, var_0_5.enter_get_ship_type.sign_and_task, var_5_11)
					elseif #var_5_4 >= 1 then
						var_5_12:show(true, var_5_1, var_0_5.enter_get_ship_type.sign_and_task, var_5_10)
					elseif #var_5_8 >= 1 then
						var_5_12:show(true, var_5_1, var_0_5.enter_get_ship_type.sign_and_task, var_5_9)
					end
				else
					local var_5_13 = var_0_1:createInstance("new_ship_or_equip")

					if #var_5_5 >= 1 then
						var_5_13:show(true, var_5_1[1], var_0_5.enter_get_ship_type.sign_and_task, var_5_11)
					elseif #var_5_4 >= 1 then
						var_5_13:show(true, var_5_1[1], var_0_5.enter_get_ship_type.sign_and_task, var_5_10)
					elseif #var_5_8 >= 1 then
						var_5_13:show(true, var_5_1[1], var_0_5.enter_get_ship_type.sign_and_task, var_5_9)
					end
				end
			else
				var_5_11()
			end

			var_5_0:updata_data()
			var_5_0:__set__now_data(var_5_0._now_label)
			var_5_0:_tip_have()
		else
			var_0_4:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_10_0)
	arg_10_0._item_data = {}
end

return var_0_0
