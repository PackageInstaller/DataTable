local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_content_return()
		self:__destroy_panel()
	end

	function arg_1_0:__onClick_main_content_fight_btn()
		if not self._concerto_station then
			local var_3_0 = var_0_2:createInstance("fight_prepare")
			local var_3_1 = math.modf(self._level_cfg.id / 100)
			local var_3_2 = math.fmod(self._level_cfg.id, 100)
			local var_3_3

			if self._level_cfg.is_main then
				var_3_3 = var_0_3.fight_type.war_concerto or var_0_3.fight_type.war_concerto_play
			end

			local var_3_4 = {
				fight_prepare_type = var_3_3,
				fight_type = var_3_3,
				go_to_map_id = self._level_cfg.id,
				init_chapter_index = var_3_1,
				init_map_index = var_3_2
			}

			self:__destroy_panel()
			var_3_0:show(var_3_4)
		else
			local var_3_5 = var_0_4:get_team_by_id(self._concerto_station)
			local var_3_6 = var_0_2:createInstance("captainroom_fleet")

			if not var_3_6 then
				return
			end

			var_3_6:show(var_0_5:getNowLang("ui_activitydefendfleet"), var_3_5.members, var_0_5:getNowLang("ui_activitydefendcancel"), "", function()
				local var_4_0 = var_0_2:createInstance("msgbox")

				if not var_4_0 then
					return
				end

				var_4_0:show(var_0_5:getNowLang("ui_activitydefendcanceltip"), function()
					var_4_0:setVisible(false)
					var_0_4:req_ConcertoStationExitReq(self._concerto_station)
					var_0_2:destroyInstance("captainroom_fleet")
					self:setVisible(false)
				end, function()
					var_4_0:setVisible(false)
				end, var_0_5:getNowLang("ui_activitydefendcancel"))
			end, var_0_3.station_type.fifth_event)
		end
	end

	function arg_1_0:__onClick_main_content_main_side1_detail_btn()
		self:__set_control_layer(self._control.main.detail_layer, true)
		var_0_3:play_in_out_animation(self._bg_seq, true, nil)
	end

	function arg_1_0:__onClick_main_detail_layer_bg_close_btn()
		var_0_3:play_in_out_animation(self._bg_seq, false, function()
			self:__set_control_layer(self._control.main.detail_layer, false)
		end)
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
