local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = table.sort
local var_0_7 = table.insert
local var_0_8 = gameconfig.furniture_config
local var_0_10 = gamecore.prompt
local var_0_11 = gameconfig.sensitive_words_config
local var_0_12 = gamecore.util_func
local var_0_13

gamecore.UILoader:define("dormitory_record", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:update()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0.__set_alpha(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1.canvasGroup.alpha = arg_4_2 and 1 or 0
		arg_4_1.canvasGroup.blocksRaycasts = arg_4_2
	end

	function arg_1_0:__load_furniture_with_pool(arg_5_1, arg_5_2)
		local var_5_0 = false
		local var_5_1

		for iter_5_0, iter_5_1 in ipairs(self._obj_pool) do
			if iter_5_1.belong_to_layer == self._layer_type.none then
				var_5_0 = true
				var_5_1 = iter_5_1

				break
			end
		end

		if var_5_0 then
			var_5_1.belong_to_layer = arg_5_2

			var_5_1.prefabContorl._panel.transform:SetParent(arg_5_1, false)

			return var_5_1.prefabContorl
		else
			local var_5_2 = self:loadUI("furniture_narrow")

			var_5_2._panel.transform:SetParent(arg_5_1, false)
			var_0_7(self._obj_pool, {
				prefabContorl = var_5_2,
				belong_to_layer = arg_5_2
			})

			return var_5_2
		end
	end

	function arg_1_0:__hide_all_furniture_to_pool(arg_6_1)
		for iter_6_0, iter_6_1 in ipairs(self._obj_pool) do
			if iter_6_1.belong_to_layer == arg_6_1 then
				iter_6_1.prefabContorl._panel.transform:SetParent(self._control.bg.obj_pool_root.transform, false)

				iter_6_1.belong_to_layer = self._layer_type.none
			end
		end
	end

	function arg_1_0.__insert_to_tab(arg_7_0, arg_7_1, arg_7_2)
		var_0_5(arg_7_2, function(arg_8_0, arg_8_1)
			return arg_8_0.point.y > arg_8_1.point.y
		end)

		for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
			var_0_7(arg_7_1, iter_7_1)
		end

		return arg_7_1
	end

	function arg_1_0:__sort_furniture(arg_9_1)
		local var_9_0 = {
			move_forbid_tb = {},
			wall_tb = {},
			ground_tb = {},
			floor_tb = {},
			lean_wall_tb = {},
			ceiling_tb = {}
		}

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			local var_9_1 = var_0_8.find_object_by_cid(iter_9_1.cid)

			if var_9_1.furniture_type == var_0_3.furniture_pos_type.move_forbid then
				var_0_7(var_9_0.move_forbid_tb, iter_9_1)
			elseif var_9_1.furniture_type == var_0_3.furniture_pos_type.wall then
				var_0_7(var_9_0.wall_tb, iter_9_1)
			elseif var_9_1.furniture_type == var_0_3.furniture_pos_type.ground then
				var_0_7(var_9_0.ground_tb, iter_9_1)
			elseif var_9_1.furniture_type == var_0_3.furniture_pos_type.floor then
				var_0_7(var_9_0.floor_tb, iter_9_1)
			elseif var_9_1.furniture_type == var_0_3.furniture_pos_type.lean_wall then
				var_0_7(var_9_0.lean_wall_tb, iter_9_1)
			elseif var_9_1.furniture_type == var_0_3.furniture_pos_type.ceiling then
				var_0_7(var_9_0.ceiling_tb, iter_9_1)
			else
				log.print_r("不存在其他类型")
			end
		end

		return (self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab({}, var_9_0.move_forbid_tb), var_9_0.floor_tb), var_9_0.wall_tb), var_9_0.lean_wall_tb), var_9_0.ground_tb), var_9_0.ceiling_tb))
	end

	function arg_1_0:__show_record_lable()
		for iter_10_0, iter_10_1 in ipairs(var_0_13) do
			if self._now_lable == iter_10_0 then
				self:__set_alpha(iter_10_1.numb, true)
			else
				self:__set_alpha(iter_10_1.numb, false)
			end
		end
	end

	function arg_1_0:__judge_all_furniture_in_warehouse()
		local var_11_0 = false
		local var_11_1 = false
		local var_11_2 = false
		local var_11_3 = true
		local var_11_4 = false

		for iter_11_0, iter_11_1 in pairs((var_0_4:get_furniture_data_by_record_id(self._now_lable))) do
			local var_11_5 = var_0_4:judge_funrniture_belong_to_dormiory(iter_11_1.cid)

			for iter_11_2, iter_11_3 in pairs(var_11_5) do
				if iter_11_3.room ~= self._room_id and iter_11_3.room ~= 0 then
					var_11_0 = true
				elseif iter_11_3.room == self._room_id and iter_11_3.room ~= 0 then
					var_11_1 = true
				elseif iter_11_3.room == 0 then
					var_11_2 = true
				end
			end

			if not next(var_11_5) then
				var_11_4 = true
			end

			if var_11_0 and not var_11_2 and not var_11_1 then
				var_11_3 = false
			end
		end

		return var_11_3, var_11_4
	end

	function arg_1_0:__req_use_record(arg_12_1)
		var_0_4:req_UseRecordReq({
			room_id = self._room_id,
			record_id = self._now_lable,
			move = arg_12_1
		})
	end

	function arg_1_0:__click_left_or_right_btn_event(arg_13_1)
		if self._now_lable + arg_13_1 >= 1 and self._now_lable + arg_13_1 <= 5 then
			self._now_lable = self._now_lable + arg_13_1
		else
			return
		end

		self:__show_layer()
	end

	function arg_1_0:__click_clear_btn_event()
		var_0_4:req_ResetRecordReq({
			id = self._now_lable
		})
	end

	function arg_1_0:__click_save_btn_event()
		if self._not_receive_save_resp then
			return
		end

		self._not_receive_save_resp = true

		var_0_4:req_RecordRoomReq({
			room_id = self._room_id,
			record_id = self._now_lable
		})
	end

	function arg_1_0:__click_use_btn_event()
		local var_16_0, var_16_1 = self:__judge_all_furniture_in_warehouse()

		if var_16_0 and not var_16_1 then
			self:__req_use_record(false)
		else
			self._control.bg.tip_layer2.tip_txt.text.text = var_16_1 and var_0_2:getNowLang("furniturelogusetip") or var_0_2:getNowLang("furniturelogusetip2")

			self:__set_alpha(self._control.bg.tip_layer2, true)
			var_0_3:play_in_out_animation(self._tip_layer2_seq, true, nil)
		end
	end

	function arg_1_0:__click_share_btn_event()
		self._is_share_layer = true
		self._control.bg.share_layer.inputfield.inputField.text = ""

		self:__set_alpha(self._control.bg.share_layer, true)
		self:__show_layer()
	end

	function arg_1_0:__click_confirm_share_btn_event()
		self._control.bg.tip_layer.count_ratio.text.text = self._user_data.record_upload .. "/" .. var_0_3.fixed_data.record_upload

		self:__set_alpha(self._control.bg.tip_layer, true)
	end

	function arg_1_0:__click_confirm_upload_btn_event()
		if self._user_data.level < var_0_3.unlock_level.dorm_upload then
			var_0_10:show((var_0_2:getNowLang("errorcode_015")))

			return
		end

		if self._control.bg.share_layer.inputfield.inputField.text == nil or self._control.bg.share_layer.inputfield.inputField.text == "" or #var_0_4:get_furniture_data_by_record_id(self._now_lable) == 0 then
			var_0_10:show(var_0_2:getNowLang("errorcode_271"))

			return
		elseif self:__check_illegal_string(self._control.bg.share_layer.inputfield.inputField.text) == false then
			var_0_10:show((var_0_2:getNowLang("errorcode-129")))

			return
		end

		if string.len(self._control.bg.share_layer.inputfield.inputField.text) > 30 then
			var_0_10:show(var_0_2:getNowLang("errorcode_270"))

			return
		end

		if self._user_data.record_upload >= var_0_3.fixed_data.record_upload then
			var_0_10:show(var_0_2:getNowLang("upload_tip_3"))

			return
		end

		var_0_4:req_UploadRecordReq({
			id = self._now_lable,
			name = self._control.bg.share_layer.inputfield.inputField.text
		})
	end

	function arg_1_0:upload_record_resp()
		self:__set_alpha(self._control.bg.share_layer, false)
		self:__set_alpha(self._control.bg.tip_layer, false)
	end

	function arg_1_0:save_record_resp()
		self._not_receive_save_resp = false

		self:__show_layer()
	end

	function arg_1_0:reset_record_resp()
		self:__show_layer()
	end

	function arg_1_0:use_record_resp()
		self:__set_alpha(self._control.bg.tip_layer2, false)
	end

	function arg_1_0:__show_layer()
		local var_24_0
		local var_24_1

		if self._is_share_layer then
			var_24_0 = self._control.bg.share_layer

			self:__hide_all_furniture_to_pool(self._layer_type.share_layer)

			var_24_1 = 3
		else
			var_24_0 = self._control.bg

			self:__show_record_lable()
			self:__hide_all_furniture_to_pool(self._layer_type.main_layer)

			var_24_1 = 2
		end

		local var_24_2 = var_0_4:get_furniture_data_by_record_id(self._now_lable)

		self:__set_alpha(var_24_0.default_bg, true)
		self:__set_alpha(var_24_0.furniture_root, #var_24_2 ~= 0)

		for iter_24_0, iter_24_1 in ipairs((self:__sort_furniture(var_24_2))) do
			local var_24_3 = var_0_8.find_object_by_cid(iter_24_1.cid)
			local var_24_4 = self:__load_furniture_with_pool(var_24_0.furniture_root.node.transform, self._layer_type.main_layer)

			var_24_4._panel.transform:SetParent(var_24_0.furniture_root.node.transform, false)

			var_24_4._panel.transform:GetComponent("RectTransform").anchoredPosition = var_24_0.furniture_root.node.rectTransform.anchoredPosition

			var_24_4:show({
				data = iter_24_1,
				config = var_24_3,
				type = var_24_1
			})
		end

		self._is_share_layer = false
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
		end

		self._room_id = var_0_1:getInstance("dormitory"):get_curr_room_index()
		self._now_lable = 1
		self._is_share_layer = false
		self._user_data = var_0_4:get_use_info_data()

		self:__show_layer()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.bg.bg_container.title_node.title.text.text = var_0_2:getNowLang("furnituresave")
		self._control.bg.clear_btn.txt.text.text = var_0_2:getNowLang("clearsave")
		self._control.bg.save_btn.txt.text.text = var_0_2:getNowLang("save")
		self._control.bg.use_btn.txt.text.text = var_0_2:getNowLang("use")
		self._control.bg.share_layer.bg_container.title_node.title.text.text = var_0_2:getNowLang("roomshare")
		self._control.bg.share_layer.tip_txt.text.text = var_0_2:getNowLang("planname")
		self._control.bg.share_layer.inputfield.placeholder.text.text = var_0_2:getNowLang("editplanname")
		self._control.bg.share_layer.confirm_btn.txt.text.text = var_0_2:getNowLang("confirm")
		self._control.bg.tip_layer.bg_container.title_node.title.text.text = var_0_2:getNowLang("planupload")
		self._control.bg.tip_layer.tip_txt_1.text.text = var_0_2:getNowLang("sharetimetip")
		self._control.bg.tip_layer.tip_txt_2.text.text = var_0_2:getNowLang("sharethisweek")
		self._control.bg.tip_layer.confirm_btn.txt.text.text = var_0_2:getNowLang("ensure")
		self._control.bg.tip_layer.cancel_btn.txt.text.text = var_0_2:getNowLang("cancel")
		self._control.bg.tip_layer2.bg_container.title_node.title.text.text = var_0_2:getNowLang("furnitureloguse")
		self._control.bg.tip_layer2.confirm_btn.txt.text.text = var_0_2:getNowLang("ensure")
		self._control.bg.tip_layer2.cancel_btn.txt.text.text = var_0_2:getNowLang("cancel")
	end

	function arg_1_0:__init_constant()
		self._bg_seq = self._control.bg.uITweenSequence
		self._tip_layer2_seq = self._control.bg.tip_layer2.uITweenSequence
		self._layer_type = {
			main_layer = 1,
			share_layer = 2,
			none = 0
		}
		var_0_13 = {
			self._control.bg.point_list.hint_1,
			self._control.bg.point_list.hint_2,
			self._control.bg.point_list.hint_3,
			self._control.bg.point_list.hint_4,
			self._control.bg.point_list.hint_5
		}

		for iter_27_0, iter_27_1 in ipairs(var_0_13) do
			iter_27_1.numb.txt.text.text = tostring(iter_27_0)
		end
	end

	function arg_1_0:_play_into_se(arg_28_1)
		self:playSE(arg_28_1, false)
	end

	function arg_1_0.__check_illegal_string(arg_29_0, arg_29_1)
		local var_29_0 = true

		if arg_29_1 == "" then
			var_0_10:show(var_0_2:getNowLang("errorcode_271"))

			var_29_0 = false
		else
			local var_29_1, var_29_2 = var_0_12.calculate_utf8_char_length(arg_29_1)

			for iter_29_0, iter_29_1 in pairs((var_0_11.get_sequence())) do
				if iter_29_1.word ~= "" and string.find(arg_29_1, iter_29_1.word, 1, true) ~= nil then
					var_29_0 = false

					local var_29_3 = var_0_4:get_account_id()

					var_0_4:req_SensitiveWordsReq({
						type = var_0_3.sensitive_words_type.user_sign,
						sensitive_words = arg_29_1
					})

					break
				end
			end

			var_29_0 = var_29_0 and not var_0_12:filter_spec_chars(arg_29_1)

			if not var_29_0 then
				var_0_10:show((var_0_2:getNowLang("errorcode-129")))

				return var_29_0
			end
		end

		return var_29_0
	end

	function arg_1_0:__onReset()
		self._out = "dormitory_record"
		self._is_already_init = false
		self._obj_pool = {}

		if self._bg_seq then
			self._bg_seq:ResetParts()
		end

		self._bg_seq = nil
		self._now_lable = 0
		self._layer_type = {}
		self._is_share_layer = false
		self._user_data = {}
		self._room_id = 0
		self._tip_layer2_seq = 0
		self._not_receive_save_resp = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_31_0)
	local var_31_0 = var_0_1:class("dormitory_record")

	var_31_0._out = "dormitory_record"
	var_31_0._is_already_init = false
	var_31_0._obj_pool = {}
	var_31_0._bg_seq = nil
	var_31_0._now_lable = 0
	var_31_0._layer_type = {}
	var_31_0._is_share_layer = false
	var_31_0._user_data = {}
	var_31_0._room_id = 0
	var_31_0._tip_layer2_seq = 0

	return var_31_0
end

return var_0_0
