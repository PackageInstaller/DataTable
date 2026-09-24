local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_5 = gamecore.prompt
local var_0_6 = gamecore.util_func
local var_0_7 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_content_top_layer_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			var_0_1:destroyInstance("dock_bet")
			var_0_1:createInstance("dock"):show(false)
		end)
	end

	function arg_1_0:__onClick_content_right_layer_log_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		local var_4_0 = 1

		if self._data.type == var_0_3.pool_type.ship_build then
			var_4_0 = var_0_3.build_record_type.ship
		elseif self._data.type == var_0_3.pool_type.equipment_build then
			var_4_0 = var_0_3.build_record_type.equipment
		end

		var_0_1:createInstance("loading"):show(true)
		var_0_2:req_BuildRecord(var_4_0)
	end

	function arg_1_0:__onClick_content_right_layer_fast_btn()
		self:__set_build_config()

		if self._data.type == var_0_3.pool_type.ship_build and self._user_data.max_ship - var_0_6.dict_lenght(var_0_2:get_character_list()) <= 0 then
			var_0_1:createInstance("msgbox"):showthird("shipmaxnobatch", function()
				var_0_1:destroyInstance("msgbox")

				local var_6_0 = var_0_1:getInstance("dock")

				if var_6_0 then
					var_6_0:setVisible(true)
					var_6_0:__onToggle_top_layer_toggle_control_disassemble()
					var_0_1:destroyInstance("dock_bet")
				else
					local var_6_1 = var_0_1:createInstance("dock")

					var_6_1:show(true, "disassemble")
					var_6_1:set_enter_type("home")
					var_6_1:_now__play_bgm()
					var_6_1:__select_one("disassemble", true)
					var_0_1:destroyInstance("dock_bet")
				end
			end, function()
				var_0_1:destroyInstance("msgbox")

				local var_7_0 = var_0_1:getInstance("remake")

				if var_0_1:getInstance("dock") then
					var_0_1:destroyInstance("dock")
				end

				var_0_1:destroyInstance("dock_bet")

				local var_7_1 = var_0_1:getInstance("home")

				if var_7_1 then
					var_7_1:_bgm_play()
				end

				if var_7_0 then
					var_7_0:setVisible(true)
				else
					local var_7_2 = var_0_1:createInstance("remake")

					var_7_2:set_enter_type("home")
					var_7_2:show(true)
				end
			end, function()
				var_0_1:destroyInstance("msgbox")

				local var_8_0 = var_0_1:getInstance("home")

				if var_8_0 then
					var_8_0:_bgm_play()
				end

				var_0_1:destroyInstance("dock_bet")
				var_0_1:destroyInstance("dock")

				local var_8_1 = var_0_1:getInstance("mall_shop")

				if var_8_1 then
					var_8_1:setVisible(true)
					var_8_1:__onToggle_top_layer_top_btn_btnthree()
				else
					var_0_1:createInstance("mall_shop"):show(var_0_3.mall_layer_type.layer_func, var_0_3.mall_enter_type.enter_home)
				end
			end, "", var_0_3.msg_type.ship_full, nil, true)

			return
		end

		if self._data.type == var_0_3.pool_type.equipment_build and self._user_data.max_equip - var_0_2:get_equipment_count() <= 0 then
			var_0_1:createInstance("msgbox"):showforth("equipmaxnobatch", function()
				var_0_1:destroyInstance("msgbox")

				local var_9_0 = var_0_1:getInstance("dock")

				if var_9_0 then
					var_9_0:setVisible(true)
					var_9_0:__onToggle_top_layer_toggle_control_dispose()
					var_0_1:destroyInstance("dock_bet")
				else
					local var_9_1 = var_0_1:createInstance("dock")

					var_9_1:show(true, "dispose")
					var_9_1:set_enter_type("home")
					var_9_1:__select_one("dispose")
					var_0_1:destroyInstance("dock_bet")
				end
			end, nil, function()
				var_0_1:destroyInstance("msgbox")

				local var_10_0 = var_0_1:getInstance("home")

				if var_10_0 then
					var_10_0:_bgm_play()
				end

				var_0_1:destroyInstance("dock_bet")
				var_0_1:destroyInstance("dock")

				local var_10_1 = var_0_1:getInstance("mall_shop")

				if var_10_1 then
					var_10_1:setVisible(true)
					var_10_1:__onToggle_top_layer_top_btn_btnthree()
				else
					var_0_1:createInstance("mall_shop"):show(var_0_3.mall_layer_type.layer_func, var_0_3.mall_enter_type.enter_home)
				end
			end, "", var_0_3.msg_type.equipment_full, nil, true)

			return
		end

		var_0_1:createInstance("dock_batch_pop"):setVisible(true, {
			pos_id = self._data.pos_id,
			pos_type = self._data.type,
			oil = self._build_config_data[1],
			bullet = self._build_config_data[2],
			fe = self._build_config_data[3],
			al = self._build_config_data[4]
		})
	end

	function arg_1_0:__onClick_content_right_layer_build_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self:__set_build_config()

		local var_11_0 = {
			pos_id = self._data.pos_id,
			oil = self._build_config_data[1],
			bullet = self._build_config_data[2],
			fe = self._build_config_data[3],
			al = self._build_config_data[4]
		}

		if self._user_data.oil and var_11_0.oil and self._user_data.oil < var_11_0.oil then
			var_0_5:show(var_0_7:getNowLang("errorcode_011"))

			return
		end

		if self._user_data.bullet and var_11_0.bullet and self._user_data.bullet < var_11_0.bullet then
			var_0_5:show(var_0_7:getNowLang("errorcode_012"))

			return
		end

		if self._user_data.fe and var_11_0.fe and self._user_data.fe < var_11_0.fe then
			var_0_5:show(var_0_7:getNowLang("errorcode_014"))

			return
		end

		if self._user_data.al and var_11_0.al and self._user_data.al < var_11_0.al then
			var_0_5:show(var_0_7:getNowLang("errorcode_013"))

			return
		end

		if self._data.type == var_0_3.pool_type.ship_build and self.num_blue_map == 0 then
			var_0_5:show(var_0_7:getNowLang("errorcode_077"))

			return
		elseif self._data.type == var_0_3.pool_type.equipment_build and self.num_blue_map == 0 then
			var_0_5:show(var_0_7:getNowLang("errorcode_085"))

			return
		end

		self._control.content.right_layer.log_btn:GetComponent("Button").enabled = false
		self._control.content.right_layer.fast_btn:GetComponent("Button").enabled = false

		if self._data.type == var_0_3.pool_type.ship_build then
			var_0_2:req_BuildShip(var_11_0)
		elseif self._data.type == var_0_3.pool_type.equipment_build then
			var_0_2:req_BuildEquipment(var_11_0)
		end
	end

	function arg_1_0:__onScaleButtonClick_content_top_layer_close_btn()
		self:__onClick_content_top_layer_close_btn()
	end

	function arg_1_0:__onClick_content_right_layer_build_info_btn()
		local var_13_0 = {}

		self:__set_build_config()

		if self._data.type == var_0_3.pool_type.ship_build then
			var_13_0 = {
				type = 1,
				oil = self._build_config_data[1],
				bullet = self._build_config_data[2],
				fe = self._build_config_data[3],
				al = self._build_config_data[4]
			}
		elseif self._data.type == var_0_3.pool_type.equipment_build then
			var_13_0 = {
				type = 2,
				oil = self._build_config_data[1],
				bullet = self._build_config_data[2],
				fe = self._build_config_data[3],
				al = self._build_config_data[4]
			}
		end

		if not var_13_0.oil or not var_13_0.bullet or not var_13_0.fe or not var_13_0.al then
			var_0_5:show("operatingfastnotice")
		end

		var_0_2:req_SimulatedBuildReq(var_13_0)
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
