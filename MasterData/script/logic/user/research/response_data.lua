local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.ship_research_config
local var_0_7 = gameconfig.research_equip_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.ResearchTaskSubmitResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("research_development")

			if var_2_0 then
				var_2_0:update_set_research_ship_task_info(arg_2_1.research_id)

				local var_2_1 = var_0_6.find_object_by_id(arg_2_1.research_id)
				local var_2_2

				if arg_2_1.task_id == 1 then
					var_2_2 = var_2_1.task1
				elseif arg_2_1.task_id == 2 then
					var_2_2 = var_2_1.task2
				elseif arg_2_1.task_id == 3 then
					var_2_2 = var_2_1.task3
				end

				var_0_3:show(var_0_4:getNowLang("submit_success"))
				var_2_0:__initia_lize()
				var_2_0._control.submit_core_bg:SetActive(false)
				var_2_0:update_core_task_info(var_2_2)
				var_2_0:update_blueprint_task_info(var_2_2)
				var_2_0:update_ship_build_task_info(var_2_2)
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0:GetResearchShipRewardResp(arg_3_1)
		if arg_3_1.result == 0 then
			var_0_1:createInstance("new_ship_or_equip"):show(true, arg_3_1.reward, var_0_5.enter_get_ship_type.sign_and_task)
			var_0_1:getInstance("research_development"):update_set_research_ship_task_info(self.now_research_ship_id)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.ResearchEquipSubmitResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			if var_0_1:getInstance("research_ship_equip") then
				var_0_1:destroyInstance("research_ship_equip")
			end

			var_0_3:show(var_0_4:getNowLang("submit_success"))

			local var_4_0 = var_0_1:getInstance("research_development")

			if var_4_0 then
				var_4_0:__initia_lize()
				var_4_0._control.submit_core_bg:SetActive(false)
				var_4_0:update_equip_task_info((var_0_7.find_object_by_id(arg_4_1.research_id)))
				var_4_0:set_init_info(arg_4_1.research_id)
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.GetResearchEquipRewardResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("research_development")

			if var_5_0 then
				var_5_0:updata_equip_show_state()
				var_5_0:set_init_info()
			end

			var_0_1:createInstance("new_ship_or_equip"):show(true, arg_5_1.reward)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:ResearchBoatIdResp(arg_6_1)
		if arg_6_1.result == 0 then
			self.now_research_ship_id = arg_6_1.research_id

			self:set_now_research_ship_id(self.now_research_ship_id)
			self:set_come_in_nums(2)

			if var_0_1:getInstance("fight_prepare") then
				-- block empty
			end
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
