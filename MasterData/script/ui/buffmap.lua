local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.tower_buff_stone_config
local var_0_8 = lx.clone_table
local var_0_9 = UnityEngine.RectTransformUtility
local var_0_10 = UnityEngine.Vector4
local var_0_11 = table.sort
local var_0_12 = table.insert
local var_0_13 = UnityEngine.Vector2
local var_0_14
local var_0_15

gamecore.UILoader:define("buffmap", function(arg_1_0)
	function arg_1_0:__close_panel()
		self:play_out_animation_on_complete()
		var_0_2:destroyInstance("buffmap")
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_4_1)
		self:setVisible(true)
		self:init_language()
		self:__init_panel(arg_4_1)
		self:__set_blocks_raycasts(true)
	end

	function arg_1_0:show_mask(arg_5_1, arg_5_2)
		self._control.mask:SetActive(arg_5_1)

		if arg_5_1 and arg_5_2 then
			local var_5_0, var_5_1 = var_0_9.ScreenPointToLocalPointInRectangle(self._panel.transform, arg_5_2.position, nil, nil)
			local var_5_2 = {
				x = var_5_1.x + arg_5_2.rect.width / 2,
				y = var_5_1.y + arg_5_2.rect.height / 2
			}

			self._control.mask.image.material:SetVector("_Center", (var_0_10(var_5_2.x, var_5_2.y, 0, 0)))
			self._control.mask.image.material:SetFloat("_SliderX", arg_5_2.rect.width / 2)
			self._control.mask.image.material:SetFloat("_SliderY", arg_5_2.rect.height / 2)
		else
			self._click_id = nil

			self:__update_reusable_cell(self._current_type)
		end
	end

	function arg_1_0:__init_panel(arg_6_1)
		self:__init_tables()

		self._current_option_state = self._option_state[0]

		local var_6_0 = var_0_3:get_tower_chip_info()

		self._control.fragment_text.text.text = var_6_0.coin
		self._coin_num = var_6_0.coin

		if not self._is_already_init then
			self:__init_buff_list()
		end

		self:__update_reusable_cell(self._current_type)

		self._is_already_init = true

		self._control.msg_box:SetActive(false)
		self._control.type_selection:SetActive(false)
	end

	function arg_1_0:__init_tables()
		self._quality_type_list = {
			[0] = var_0_1:getNowLang("ui_tower_buff_sort_0"),
			var_0_1:getNowLang("ui_tower_buff_sort_1"),
			(var_0_1:getNowLang("ui_tower_buff_sort_2"))
		}
		self._show_type_list = {
			[0] = "全部",
			"未获取",
			"已获取"
		}
		self._option_state = {
			[0] = "类型",
			"显示"
		}
		self._option_btn_list = {
			[0] = self._control.type_selection.type_buttons.type_all,
			self._control.type_selection.type_buttons.type_1,
			self._control.type_selection.type_buttons.type_2
		}
		self._option_pos = {
			[0] = 292,
			476.75
		}
		var_0_15 = {}
		var_0_14 = {}

		if not self._current_type then
			self._current_type = 0
			self._current_show = 0
		end
	end

	function arg_1_0:init_language()
		self._control.title_text.text.text = var_0_1:getNowLang("ui_tower_buff_collection")
		self._control.buff_info.text.text = var_0_1:getNowLang("ui_tower_buff_collection_tip")
	end

	function arg_1_0:__init_buff_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.buff_list.Viewport.edge_mask.Content.endlessScrollView, self._control.buff_list.Viewport.edge_mask.Content, "single_buff_cell", "buffmap", true)

		self._reusable_cell:init()
	end

	function arg_1_0:__set_to_top(arg_10_1)
		self._control.type_selection.transform:SetAsLastSibling()

		if arg_10_1 == 0 then
			self._control.type_btn.transform:SetAsLastSibling()
		elseif arg_10_1 == 1 then
			self._control.show_btn.transform:SetAsLastSibling()
		end
	end

	function arg_1_0:__set_option_buttons_color(arg_11_1)
		arg_11_1 = arg_11_1 or 0
		self._gray = self._gray or UnityEngine.Color(0.1607843137254902, 0.19215686274509805, 0.22745098039215686, 0.8470588235294118)
		self._blue = self._blue or UnityEngine.Color(0.09803921568627451, 0.34901960784313724, 0.5803921568627451, 0.8588235294117647)

		for iter_11_0 = 0, 2 do
			self._option_btn_list[iter_11_0].image.color = iter_11_0 == arg_11_1 and self._blue or self._gray
		end
	end

	function arg_1_0:__set_option_type(arg_12_1)
		self._control.type_selection.type_buttons.type_all.txt.text.text = arg_12_1[0]
		self._control.type_selection.type_buttons.type_1.txt.text.text = arg_12_1[1]
		self._control.type_selection.type_buttons.type_2.txt.text.text = arg_12_1[2]

		if arg_12_1 == self._quality_type_list then
			self:__set_option_buttons_color(self._current_type)
		elseif arg_12_1 == self._show_type_list then
			self:__set_option_buttons_color(self._current_show)
		end
	end

	function arg_1_0:__update_reusable_cell(arg_13_1)
		if arg_13_1 then
			if self._current_option_state == self._option_state[0] then
				self._current_type = arg_13_1
			elseif self._current_option_state == self._option_state[1] then
				self._current_show = arg_13_1
			end
		else
			self._current_type = 0
			self._current_show = 0
		end

		local var_13_0 = self:__sort_buff_list()

		self._reusable_cell:set_data(var_13_0)

		function self._reusable_cell:_set_func(arg_14_1)
			self:show(var_13_0[arg_14_1 + 1], arg_14_1)
		end
	end

	function arg_1_0.__sign_acquired_buff(arg_15_0, arg_15_1)
		if arg_15_1 and arg_15_1 ~= 0 then
			local var_15_0 = var_0_5.find_object_by_id(arg_15_1)

			if var_15_0 then
				var_0_15[arg_15_1] = var_15_0.base_id

				if var_15_0.base_id ~= 0 then
					var_0_14[var_15_0.base_id] = var_15_0.quality
				end
			else
				print("已获取的buffID不对！ID:" .. arg_15_1)
			end
		end
	end

	function arg_1_0:__get_acquired_buff()
		local var_16_0 = var_0_3:get_tower_chip_info()

		var_0_14 = {}
		var_0_15 = {}

		for iter_16_0, iter_16_1 in pairs(var_16_0.slot) do
			self:__sign_acquired_buff(iter_16_1)
		end

		self:__sign_acquired_buff(var_16_0.transient[1])
		self:__sign_acquired_buff(var_16_0.transient[2])
	end

	function arg_1_0._check_buff_show_state(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		return arg_17_2 ~= 0 and (var_0_14[arg_17_2] and (var_0_15[arg_17_1] and var_0_4.buffmap_buff_state.have or var_0_14[arg_17_2] and arg_17_3 >= var_0_14[arg_17_2] and var_0_4.buffmap_buff_state.not_have or var_0_4.buffmap_buff_state.cant_have) or var_0_15[arg_17_1] and var_0_4.buffmap_buff_state.have or var_0_4.buffmap_buff_state.not_have) or var_0_15[arg_17_1] and var_0_4.buffmap_buff_state.have or var_0_4.buffmap_buff_state.not_have
	end

	function arg_1_0:_check_show(arg_18_1)
		local var_18_0
		local var_18_1 = true
		local var_18_2 = arg_18_1.base_id
		local var_18_3 = arg_18_1.quality

		if self._current_show == 1 then
			if var_0_15[arg_18_1.id] then
				var_18_1 = false
			end

			if var_0_14[var_18_2] and var_18_3 <= var_0_14[var_18_2] then
				var_18_1 = false
			end

			if var_18_1 then
				var_18_0 = var_0_4.buffmap_buff_state.not_have
			end
		elseif self._current_show == 2 then
			if var_0_15[arg_18_1.id] == nil then
				var_18_1 = false
			else
				var_18_0 = var_0_4.buffmap_buff_state.have
			end

			if var_0_14[var_18_2] and var_18_3 <= var_0_14[var_18_2] then
				var_18_1 = true
				var_18_0 = var_0_15[arg_18_1.id] and var_0_4.buffmap_buff_state.have or var_0_4.buffmap_buff_state.cant_have
			end
		elseif self._current_show == 0 then
			if arg_18_1 and arg_18_1.id ~= 0 then
				var_18_0 = self:_check_buff_show_state(arg_18_1.id, var_18_2, var_18_3)
			else
				print("错误的config信息！！！")
			end
		end

		return var_18_1, var_18_0
	end

	function arg_1_0:__sort_buff_list()
		local var_19_0 = var_0_8(var_0_5.get_sequence())

		var_0_11(var_19_0, function(arg_20_0, arg_20_1)
			return arg_20_0.id < arg_20_1.id
		end)
		self:__get_acquired_buff()

		self._buff_list = {}

		if self._current_type ~= 0 then
			for iter_19_0, iter_19_1 in ipairs(var_19_0) do
				if iter_19_1.quality == ((self._current_type == 2 or nil) and 4) then
					local var_19_2, var_19_3 = self:_check_show(iter_19_1)

					if var_19_2 then
						iter_19_1.buff_state = var_19_3

						var_0_12(self._buff_list, iter_19_1)
					end
				end
			end
		else
			for iter_19_2, iter_19_3 in ipairs(var_19_0) do
				local var_19_4, var_19_5 = self:_check_show(iter_19_3)

				if var_19_4 then
					iter_19_3.buff_state = var_19_5

					var_0_12(self._buff_list, iter_19_3)
				end
			end
		end

		return self._buff_list
	end

	function arg_1_0:__update_selection_text(arg_21_1)
		if self._current_option_state == self._option_state[0] then
			self:__update_type_selection_text(arg_21_1)
		elseif self._current_option_state == self._option_state[1] then
			self:__update_show_selection_text(arg_21_1)
		else
			print("参数有误！")
		end
	end

	function arg_1_0:__update_type_selection_text(arg_22_1)
		if arg_22_1 then
			self._current_type = arg_22_1
			self._control.type_btn.type.text.text = self._quality_type_list[arg_22_1]
		else
			self._current_type = self._quality_type_list[0]
			self._control.type_btn.type.text.text = -self._quality_type_list[0] - var_0_1:getNowLang(self._quality_type_list[0])
		end
	end

	function arg_1_0:__update_show_selection_text(arg_23_1)
		if arg_23_1 then
			self._current_show = arg_23_1
			self._control.show_btn.type.text.text = self._show_type_list[arg_23_1]
		else
			self._current_show = self._show_type_list[0]
			self._control.show_btn.type.text.text = self._show_type_list[0]
		end
	end

	function arg_1_0:play_out_animation_on_complete()
		self:__play_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
	end

	function arg_1_0:close_map_select(arg_25_1)
		for iter_25_0, iter_25_1 in ipairs(self._buff_list) do
			if iter_25_0 ~= arg_25_1 then
				iter_25_1.select_status = false
			elseif iter_25_1.select_status then
				self._click_id = iter_25_1.id
			end
		end

		self:__update_reusable_cell(self._current_type)
	end

	function arg_1_0:__show_quality_selection(arg_26_1, arg_26_2)
		self._click_id = nil

		self._control.type_selection:SetActive(arg_26_1)

		if arg_26_1 and arg_26_2 then
			if arg_26_2 == 0 then
				self._current_option_state = self._option_state[arg_26_2]

				self:__set_option_type(self._quality_type_list)
			elseif arg_26_2 == 1 then
				self._current_option_state = self._option_state[arg_26_2]

				self:__set_option_type(self._show_type_list)
			end

			self._control.type_selection.type_buttons.transform.localPosition = var_0_13.New(self._option_pos[arg_26_2] or self._option_pos[0], self._control.type_selection.type_buttons.transform.localPosition.y)
		end
	end

	function arg_1_0:__set_blocks_raycasts(arg_27_1)
		self._panel.transform:GetComponent("CanvasGroup").blocksRaycasts = arg_27_1
	end

	function arg_1_0:__purchange_msg_box(arg_28_1)
		if (self._coin_num or 0) < arg_28_1.price then
			gamecore.prompt:show(var_0_1:getNowLang("ui_tower_buff_change_failed_1"))

			return
		end

		local var_28_1 = var_0_2:createInstance("tactical_machine")

		self:__set_blocks_raycasts(false)
		var_28_1:show(arg_28_1)
	end

	function arg_1_0:__set_purchange_active(arg_29_1)
		self._control.msg_box:SetActive(arg_29_1)
	end

	function arg_1_0:__play_se(arg_30_1)
		self:playSE(arg_30_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_31_0)
	local var_31_0 = var_0_2:class("buffmap")

	var_31_0._is_already_init = false
	var_31_0._buff_list = {}
	var_31_0._click_id = nil

	return var_31_0
end

return var_0_0
