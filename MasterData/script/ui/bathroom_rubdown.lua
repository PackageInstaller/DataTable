local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = table.insert
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.skin_config
local var_0_14 = math.abs
local var_0_16
local var_0_17
local var_0_18

gamecore.UILoader:define("bathroom_rubdown", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
		self:set_bathroom_can_click(false)
		self:_set_stop_bathroom_mouse()
	end

	function arg_1_0:_set_stop_bathroom_mouse()
		self._open_bathroom_rubdown = var_0_2:getInstance("bathroom")

		if self._open_bathroom_rubdown then
			self._open_bathroom_rubdown._allow_mouse_move = false
			self._open_bathroom_rubdown._room_end_pos = nil
			self._open_bathroom_rubdown._room_start_pos = nil
		end
	end

	function arg_1_0.set_bathroom_can_click(arg_4_0, arg_4_1)
		local var_4_0 = var_0_2:getInstance("bathroom")

		if var_4_0 then
			var_4_0:set_graphic_raster(arg_4_1)
		end
	end

	function arg_1_0:__onUpdate(arg_5_1)
		if self._progress_update then
			if self._mouse_update then
				if UnityEngine.Input.GetMouseButtonDown(0) then
					self._start_pos = UnityEngine.Input.mousePosition
				end

				if UnityEngine.Input.GetMouseButtonUp(0) then
					self._end_pos = UnityEngine.Input.mousePosition

					if self._start_pos and self._end_pos then
						self:__mouse_up_event()
					end
				end
			end

			self:__update_time_progress(arg_5_1)
		end
	end

	function arg_1_0:__set_time_progress(arg_6_1)
		self._control.rubdown_game_layer.girl_wash_layer.timeline.fill.image.fillAmount = arg_6_1
	end

	function arg_1_0.__play_animation(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		arg_7_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_7_2, arg_7_3)
	end

	function arg_1_0.__play_animation_2(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		if arg_8_4 then
			local var_8_0 = arg_8_1.AnimationState.Complete

			local function var_8_1()
				arg_8_4()

				arg_8_1.AnimationState.Complete = var_8_0
			end

			var_8_0 = arg_8_1.AnimationState.Complete + var_8_1
			arg_8_1.AnimationState.Complete = arg_8_1.AnimationState.Complete + var_8_1
			var_8_0 = var_8_0 - var_8_1
		end

		arg_8_1.AnimationState:SetAnimation(0, arg_8_2, arg_8_3)
	end

	function arg_1_0:__init_ske(arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = var_0_3:find_character_by_id(arg_10_2)
		local var_10_1 = var_0_6.find_object_by_cid(var_10_0.cid).pic_id

		arg_10_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_4:get_ship_spine(var_0_4.common_icon.common_ship_q_asset, (var_10_0.skin ~= 0 or nil) and var_0_7.find_object_by_cid(var_10_0.skin).icon))
		arg_10_1.skeletonGraphic.initialSkinName = arg_10_3

		arg_10_1.skeletonGraphic:Initialize(true)
	end

	function arg_1_0:__init_ske_2(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		arg_11_1.skeletonGraphic.initialSkinName = arg_11_2

		arg_11_1.skeletonGraphic:Initialize(true)
		self:__play_animation(arg_11_1, arg_11_3, arg_11_4)
	end

	function arg_1_0:__show_layer_by_state(arg_12_1)
		self._control.rubdown_game_layer:SetActive(arg_12_1 == 1)
		self._control.rubdown_cancel_btn:SetActive(arg_12_1 == 1)
		self._control.rubdown_result:SetActive(arg_12_1 == 2)
	end

	function arg_1_0:__random_arraw_list()
		self._arrow_list = {}

		for iter_13_0 = 1, 6 do
			var_0_5(self._arrow_list, lan_rand(1, 10000) % 4)
		end

		for iter_13_1, iter_13_2 in ipairs(self._arrow_list) do
			var_0_16[iter_13_1].arrow_spine.transform.localEulerAngles = Vector3.New(0, 0, iter_13_2 * -90)

			self:__play_animation(var_0_16[iter_13_1].arrow_spine, var_0_17.mini_game_arrow_off, true)
		end
	end

	function arg_1_0:__update_time_progress(arg_14_1)
		self._game_start_time = self._game_start_time or arg_14_1

		local var_14_0 = var_0_4.bathroom_const.rubdown_time - (arg_14_1 - self._game_start_time)

		self:__set_time_progress((var_0_4.bathroom_const.rubdown_time - (arg_14_1 - self._game_start_time)) / var_0_4.bathroom_const.rubdown_time)

		if var_14_0 <= 0 then
			self._progress_update = false

			self:__show_result_layer(false)

			self._game_start_time = nil
		end
	end

	function arg_1_0:__mouse_up_event()
		self._mouse_update = false

		if var_0_14(self._end_pos.x - self._start_pos.x) > 10 or var_0_14(self._end_pos.y - self._start_pos.y) > 10 then
			if var_0_14(self._end_pos.x - self._start_pos.x) > var_0_14(self._end_pos.y - self._start_pos.y) then
				if self._end_pos.x - self._start_pos.x > 0 then
					self:__on_rubdown_once(1)
				else
					self:__on_rubdown_once(3)
				end
			elseif var_0_14(self._end_pos.x - self._start_pos.x) < var_0_14(self._end_pos.y - self._start_pos.y) then
				if self._end_pos.y - self._start_pos.y > 0 then
					self:__on_rubdown_once(0)
				else
					self:__on_rubdown_once(2)
				end
			end
		end

		self._end_pos = nil
		self._start_pos = nil
		self._mouse_update = true
	end

	function arg_1_0:__on_rubdown_once(arg_16_1)
		local var_16_0 = 0

		for iter_16_0, iter_16_1 in ipairs(self._arrow_list) do
			if iter_16_1 >= 0 then
				var_16_0 = iter_16_0

				break
			end
		end

		if arg_16_1 == self._arrow_list[var_16_0] then
			if var_16_0 >= #self._arrow_list then
				self:__show_result_layer(true)

				return
			end

			self:__play_animation(var_0_16[var_16_0].arrow_spine, var_0_17.mini_game_arrow_on, false)
			var_0_16[var_16_0].bubble_spine:SetActive(true)
			self:__play_animation(var_0_16[var_16_0].bubble_spine, var_0_17.mini_game_bubble, false)

			self._arrow_list[var_16_0] = -1
		end

		if self._arrow_list[#self._arrow_list] == -1 then
			self:__show_result_layer(true)
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.tip_one))
	end

	function arg_1_0:__show_result_layer(arg_17_1)
		self._progress_update = false

		self:__show_layer_by_state(2)

		self._control.rubdown_result.girl_box.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.bathroom_const.rubdown_box_bg, self._now_style_index))

		self:__init_ske(self._control.rubdown_result.role, self._now_character_data.id, var_0_4.ship_spine_skin_name_list.bathroom)
		self._control.rubdown_result.bathroomsavetime:SetActive(arg_17_1)

		local var_17_0 = ""
		local var_17_1 = ""

		if arg_17_1 then
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.victory_b))

			var_17_0 = var_0_4.ship_spine_anim_name_list.SP_shy
			var_17_1 = var_0_4.bathroom_const.rubdown_result_succ

			var_0_2:getInstance("bathroom"):show_role_heart(self._now_rub_role_index, true)

			self._now_character_data = var_0_3:find_character_by_id(self._now_character_data.id)

			if self._now_character_data.repair and self._can_req then
				self._can_req = false

				var_0_3:req_RubBackReq(self._now_character_data.id)
			end
		else
			var_17_0 = var_0_4.ship_spine_anim_name_list.SP_surprise
			var_17_1 = var_0_4.bathroom_const.rubdown_result_fail
		end

		self:__play_animation_2(self._control.rubdown_result.role.skeletonGraphic, var_17_0, false, function()
			self:__play_animation_2(self._control.rubdown_result.role.skeletonGraphic, var_0_4.ship_spine_anim_name_list.stand1, true, nil)
		end)

		self._control.rubdown_result.result_tip.image.sprite = self:loadSprite(var_17_1)
	end

	function arg_1_0:__reset_arraw()
		for iter_19_0, iter_19_1 in ipairs(var_0_16) do
			var_0_16[iter_19_0].bubble_spine:SetActive(false)
		end

		self._can_req = true
		self._progress_update = false
		self._mouse_update = false
		self._end_pos = nil
		self._start_pos = nil
		self._game_start_time = nil

		self:__set_time_progress(1)

		self._open_bathroom_rubdown._allow_mouse_move = true

		self:set_bathroom_can_click(true)
		self:setVisible(false)
	end

	function arg_1_0:__init_rubdown_layer()
		self:__show_layer_by_state(1)

		self._control.rubdown_game_layer.girl_wash_layer.girl_box_bg.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.bathroom_const.rubdown_box_bg, self._now_style_index))

		self:__init_ske(self._control.rubdown_game_layer.girl_wash_layer.role, self._now_character_data.id, var_0_4.ship_spine_skin_name_list.bathroom)
		self:__play_animation_2(self._control.rubdown_game_layer.girl_wash_layer.role.skeletonGraphic, (self._now_character_data.now_hp / self._now_character_data.hp < var_0_4.health_sprite_rule.red.max_value or nil) and var_0_4.ship_spine_anim_name_list.bathroom_sit_down, true, nil)
		self:__init_ske_2(self._control.rubdown_game_layer.girl_wash_layer.rub_spine, var_0_18[lan_rand(1, 10000) % 4 + 1], "normal", true)
		self:__random_arraw_list()

		self._start_time = lx.ServerTime:getUtcTime()
		self._mouse_update = true
		self._progress_update = true
	end

	function arg_1_0:__init_panel(arg_21_1)
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
		end

		local var_21_0 = var_0_2:getInstance("bathroom")

		self._now_style_index = arg_21_1.now_style_index

		if var_21_0 then
			self._now_style_index = var_21_0._now_bathroom_style_index
		end

		self._now_rub_role_index = arg_21_1.now_rub_role_index
		self._now_character_data = arg_21_1.countdown_data.character_data

		self:__init_rubdown_layer()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.rubdown_game_layer.girl_wash_layer.rubdowninfo.text.text = var_0_1:getNowLang("rubdowninfo")
		self._control.rubdown_cancel_btn.nightwarcancel.text.text = var_0_1:getNowLang("nightwarcancel")
		self._control.rubdown_result.bathroomsavetime.text.text = var_0_1:getNowLang("bathroomsavetime")
	end

	function arg_1_0:__init_constant()
		var_0_16 = {
			self._control.rubdown_game_layer.girl_wash_layer.arrow_inspector.arrow_1,
			self._control.rubdown_game_layer.girl_wash_layer.arrow_inspector.arrow_2,
			self._control.rubdown_game_layer.girl_wash_layer.arrow_inspector.arrow_3,
			self._control.rubdown_game_layer.girl_wash_layer.arrow_inspector.arrow_4,
			self._control.rubdown_game_layer.girl_wash_layer.arrow_inspector.arrow_5,
			self._control.rubdown_game_layer.girl_wash_layer.arrow_inspector.arrow_6
		}
		var_0_17 = {
			mini_game_arrow_off = "mini_game_arrow_off",
			mini_game_bubble = "mini_game_bubble",
			mini_game_arrow_on = "mini_game_arrow_on"
		}
		var_0_18 = {
			"A",
			"B",
			"C",
			"D"
		}
	end

	function arg_1_0:_play_into_se(arg_24_1)
		self:playSE(arg_24_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_25_0)
	local var_25_0 = var_0_2:class("bathroom_rubdown")

	var_25_0._is_already_init = false
	var_25_0._now_character_data = {}
	var_25_0._now_rub_role_index = {}
	var_25_0._now_style_index = {}
	var_25_0._mouse_update = false
	var_25_0._progress_update = false
	var_25_0._start_pos = nil
	var_25_0._end_pos = nil
	var_25_0._arrow_list = {}
	var_25_0._start_time = 0
	var_25_0._can_req = true
	var_25_0._game_start_time = nil

	gamecore.extend_obj(var_25_0)

	return var_25_0
end

return var_0_0
