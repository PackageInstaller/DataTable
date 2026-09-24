local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onScaleButtonClick_bg_container_back_btn(arg_2_0)
		var_0_1:destroyInstance("research_ship_equip")
		var_0_1:getInstance("equip_type_layer"):__revert_toggle_group_all_set()
	end

	function arg_1_0.__onClick_equip_content_type_btn(arg_3_0)
		local var_3_0 = var_0_1:createInstance("equip_type_layer")

		var_3_0:show()
		var_3_0:__save_toggle_group_all_set_data()
	end

	function arg_1_0.__onClick_equip_content_ok_btn(arg_4_0)
		var_0_1:createInstance("msgbox"):show(var_0_2:getNowLang("submit_equipment"), function()
			if #arg_4_0._dispose_data > 0 then
				var_0_5:req_ResearchEquipSubmitReq(var_0_5:get_research_equip_id(), arg_4_0._task_id, arg_4_0._dispose_data)
			end
		end, nil, var_0_2:getNowLang("submit_confirm"))
	end

	function arg_1_0:__onClick_tip_layer()
		self:__show_equip_attr_panel(false)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
