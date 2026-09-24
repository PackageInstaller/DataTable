local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.UILoader
local var_0_5 = gameconfig.ship_pve_active_config
local var_0_6 = gamecore.prompt
local var_0_7 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_middle_page_main_last_btn()
		self:init_weather(-1)
	end

	function arg_1_0:__onClick_main_middle_page_main_next_btn()
		self:init_weather(1)
	end

	function arg_1_0:__onClick_main_middle_reward_btn()
		self:show_weather(false)
		self:show_reward_box()
	end

	function arg_1_0:__onClick_main_top_return()
		self:return_to_home()
	end

	function arg_1_0:__onClick_main_bottom_btns_explain_btn()
		self:show_weather(false)
		self:show_strike_guide()
	end

	function arg_1_0:__onClick_main_bottom_btns_story_btn()
		var_0_1:req_SolidMaxScoreLevelPassReq()
		self:setVisible(false)

		local var_7_0 = var_0_3:getInstance("ninth_honor_list")

		if var_7_0 then
			var_7_0:show(var_0_2.pve_active_type.strike_event)
		else
			var_0_3:createInstance("ninth_honor_list"):show(var_0_2.pve_active_type.strike_event)
		end
	end

	function arg_1_0:__onClick_main_bottom_start_btn()
		local var_8_0 = var_0_5.find_object_by_id(45)

		if lx.ServerTime:getUtcTime() >= var_8_0.end_time and lx.ServerTime:getUtcTime() < var_8_0.award_time then
			var_0_6:show(var_0_7:getNowLang("active_outtime_tip"))

			return
		end

		self:show_weather(false)
		self:show_strike_detail()
		var_0_1:req_SolidExtendBuffNumReq()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.waring))
	end

	function arg_1_0:__onClick_strike_guide_main_close()
		self:show_weather(true)
		self:close_strike_guide()
	end

	function arg_1_0:__onClick_strike_detail_main_close()
		self:show_weather(true)
		self:close_strike_detail()
	end

	function arg_1_0:__onClick_strike_detail_main_bottom_import_btn()
		self:strike_execute(true)
	end

	function arg_1_0:__onClick_strike_detail_main_bottom_export_btn()
		self:strike_execute(false)
	end

	function arg_1_0:__onClick_main_middle_reward_btn_2()
		self:show_weather(false)
		self:show_reward_box()
	end

	function arg_1_0.__onClick_main_middle_weather_bg(arg_14_0)
		var_0_3:getInstance("strike_weather"):show_weather()
	end

	function arg_1_0:__onClick_main_bottom_btns_special_buff()
		self:show_weather(false)
		var_0_1:req_SolidExtendBuffNumReq()
		self:show_strike_whole_buff()
	end

	function arg_1_0:__onClick_strike_whole_buff_main_close()
		self:show_weather(true)
		self:close_strike_whole_buff()
	end

	function arg_1_0:__onClick_strike_whole_buff_main_active_btn()
		if var_0_1:get_whole_buff_state() then
			self._control.strike_whole_buff.main.active_btn.image.sprite = self:loadSprite(var_0_2.strike_whole_close)

			self._control.strike_whole_buff.main.active_btn.open_text.gameObject:SetActive(false)
			self._control.strike_whole_buff.main.active_btn.close_text.gameObject:SetActive(true)
			var_0_1:req_SolidExtendBuffStatusReq(0)
		else
			self._control.strike_whole_buff.main.active_btn.image.sprite = self:loadSprite(var_0_2.strike_whole_open)

			self._control.strike_whole_buff.main.active_btn.open_text.gameObject:SetActive(true)
			self._control.strike_whole_buff.main.active_btn.close_text.gameObject:SetActive(false)
			var_0_1:req_SolidExtendBuffStatusReq(1)
		end
	end
end

function var_0_0.extend_obj(arg_18_0)
	return
end

return var_0_0
