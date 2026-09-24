local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = table.sort
local var_0_7 = table.insert
local var_0_8 = gameconfig.furniture_config
local var_0_10 = gamecore.prompt

gamecore.UILoader:define("dormitory_design_detail", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:__load_furniture_with_pool(arg_4_1)
		local var_4_0 = false
		local var_4_1

		for iter_4_0, iter_4_1 in ipairs(self._obj_pool) do
			if not iter_4_1.using then
				var_4_0 = true
				var_4_1 = iter_4_1

				break
			end
		end

		if var_4_0 then
			var_4_1.using = true

			var_4_1.prefabContorl._panel.transform:SetParent(arg_4_1, false)

			return var_4_1.prefabContorl
		else
			local var_4_2 = self:loadUI("furniture_narrow")

			var_4_2._panel.transform:SetParent(arg_4_1, false)
			var_0_7(self._obj_pool, {
				using = true,
				prefabContorl = var_4_2
			})

			return var_4_2
		end
	end

	function arg_1_0:__hide_all_furniture_to_pool()
		for iter_5_0, iter_5_1 in ipairs(self._obj_pool) do
			if iter_5_1.using then
				iter_5_1.prefabContorl._panel.transform:SetParent(self._control.bg.obj_pool_root.transform, false)

				iter_5_1.using = false
			end
		end
	end

	function arg_1_0:__show_btns_by_type(arg_6_1)
		self._control.bg.apply_btn:SetActive(arg_6_1 == 2)
		self._control.bg.cancel_collect_btn:SetActive(arg_6_1 == 2)
		self._control.bg.collect_btn:SetActive(arg_6_1 == 1)
	end

	function arg_1_0:__show_evaluate_stars(arg_7_1)
		self._control.evaluate_layer.bg.star_btn_1.star:SetActive(arg_7_1 >= 1)
		self._control.evaluate_layer.bg.star_btn_2.star:SetActive(arg_7_1 >= 2)
		self._control.evaluate_layer.bg.star_btn_3.star:SetActive(arg_7_1 >= 3)
		self._control.evaluate_layer.bg.star_btn_4.star:SetActive(arg_7_1 >= 4)
		self._control.evaluate_layer.bg.star_btn_5.star:SetActive(arg_7_1 >= 5)

		self._now_score = arg_7_1
	end

	function arg_1_0:__click_collect_btn_event()
		local var_8_0 = 1

		var_8_0 = self._data.is_prefab and var_0_3.dorm_exhibition_type.prefab or var_0_3.dorm_exhibition_type.player

		var_0_4:req_AddExhibitionCollectReq({
			id = self._data.design_data.id,
			type = var_8_0
		})
	end

	function arg_1_0:__click_apply_btn_event()
		self._control.bg.tip_layer.tip_txt.text.text = self._now_exhibitio_integrity and var_0_2:getNowLang("usethedesignornot") or var_0_2:getNowLang("usethedesignornotlack")

		var_0_3:play_in_out_animation(self._tip_layer_seq, true, nil)
	end

	function arg_1_0:__click_confirm_apply_btn_event()
		var_0_4:req_UserExhibitionReq({
			id = self._data.design_data.id,
			room_id = var_0_1:getInstance("dormitory"):get_curr_room_index()
		})
		var_0_3:play_in_out_animation(self._tip_layer_seq, false, nil)
	end

	function arg_1_0:__click_cancel_collect_btn_event()
		if var_0_4:get_exhibition_for_id(self._data.design_data.id, self._data.is_prefab).type == var_0_3.dorm_exhibition_type.myself then
			var_0_10:show(var_0_2:getNowLang("cancel_collect_tip"))

			return
		end

		var_0_4:req_RemoveExhibitionCollectReq({
			id = self._data.design_data.id
		})
	end

	function arg_1_0:__click_evaluate_btn_event()
		self._control.evaluate_layer:SetActive(true)
		self:__show_evaluate_stars(self._now_score)
		var_0_3:play_in_out_animation(self._evaluate_layer_seq, true, nil)
	end

	function arg_1_0:__click_evaluate_confirm_btn_event()
		if var_0_4:get_use_info_data().level < var_0_3.unlock_level.dorm_evaluate then
			var_0_10:show((var_0_2:getNowLang("errorcode_015")))

			return
		end

		var_0_4:req_EvaluateExhibitionReq({
			id = self._data.design_data.id,
			account_id = var_0_4:get_account_id(),
			score = self._now_score
		})
	end

	function arg_1_0:__click_evaluate_close_btn_event()
		var_0_3:play_in_out_animation(self._evaluate_layer_seq, false, function()
			self._control.evaluate_layer:SetActive(false)
		end)
	end

	function arg_1_0:collect_resp()
		self:__show_btns_by_type(2)
	end

	function arg_1_0:cancel_collect_resp()
		self:__show_btns_by_type(1)
	end

	function arg_1_0:evaluate_resp()
		var_0_3:play_in_out_animation(self._evaluate_layer_seq, false, function()
			self._control.evaluate_layer:SetActive(false)
		end)
		var_0_4:req_GetExhibitionReq()
	end

	function arg_1_0:__show_layer()
		local var_20_0 = self._data.design_data
		local var_20_1 = self._data.is_prefab
		local var_20_2 = self._control.bg

		self:__show_btns_by_type(self._data.is_collect and 2 or 1)

		var_20_2.design_name_txt.text.text = var_20_0.title
		var_20_2.designer_name_txt.text.text = var_20_0.username
		self._control.bg.bg_container.title_node.title.text.text = var_20_0.title

		var_20_2.designer_name_txt:SetActive(not var_20_1)
		var_20_2.evaluate_btn:SetActive(not var_20_1)

		for iter_20_0, iter_20_1 in ipairs((var_0_1:getInstance("dormitory_design_list"):__sort_furniture(var_20_0.furniture))) do
			local var_20_3 = var_0_8.find_object_by_cid(iter_20_1.cid)
			local var_20_4 = self:__load_furniture_with_pool(var_20_2.furniture_root.node.transform)

			var_20_4._panel.transform:SetParent(var_20_2.furniture_root.node.transform, false)

			var_20_4._panel.transform:GetComponent("RectTransform").anchoredPosition = var_20_2.furniture_root.node.rectTransform.anchoredPosition

			var_20_4:show({
				type = 2,
				data = iter_20_1,
				config = var_20_3
			})
		end
	end

	function arg_1_0:__update_cell()
		local var_21_0 = self._data.design_data.furniture

		var_0_5(self._data.design_data.furniture, function(arg_22_0, arg_22_1)
			local var_22_0 = var_0_8.find_object_by_cid(arg_22_0.cid)
			local var_22_1 = var_0_8.find_object_by_cid(arg_22_1.cid)

			if var_22_0.type == var_22_1.type then
				return var_22_0.cid < var_22_1.cid
			else
				return var_22_0.type < var_22_1.type
			end
		end)
		self._reusable_cell:set_data(self._data.design_data.furniture)

		function self._reusable_cell:_set_func(arg_23_1)
			local var_23_0 = var_0_8.find_object_by_cid(var_21_0[arg_23_1 + 1].cid)

			self.name_txt.name_txt_1.text.text = var_23_0.title

			self.name_txt:GetComponent("TextHorizonScroller"):SetText(var_23_0.title)

			if var_0_4:have_furniture_for_cid(var_21_0[arg_23_1 + 1].cid, (var_0_1:getInstance("dormitory"):get_curr_room_index())) then
				self.name_txt.name_txt_1.text.color = Color.New(0.27058823529411763, 0.27058823529411763, 0.27058823529411763)
				self.name_txt.name_txt_2.text.color = Color.New(0.27058823529411763, 0.27058823529411763, 0.27058823529411763)
			else
				self._now_exhibitio_integrity = false
				self.name_txt.name_txt_1.text.color = Color.New(0.17647058823529413, 0.6941176470588235, 0.9686274509803922)
				self.name_txt.name_txt_2.text.color = Color.New(0.17647058823529413, 0.6941176470588235, 0.9686274509803922)
			end
		end
	end

	function arg_1_0:__init_panel(arg_24_1)
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__init_reusable_cell()
		end

		self._data = arg_24_1
		self._now_score = 5

		var_0_3:play_in_out_animation(self._bg_seq, true, nil)

		self._now_exhibitio_integrity = true

		self:__show_layer()
		self:__update_cell()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.bg.apply_btn.txt.text.text = var_0_2:getNowLang("loguse")
		self._control.bg.cancel_collect_btn.txt.text.text = var_0_2:getNowLang("unsave")
		self._control.bg.collect_btn.txt.text.text = var_0_2:getNowLang("logfav")
		self._control.bg.used_furniture_txt.text.text = var_0_2:getNowLang("usedfurniture")
		self._control.evaluate_layer.bg.bg_container.title_node.title.text.text = var_0_2:getNowLang("evaluationscoretitle")
		self._control.evaluate_layer.bg.tip_txt.text.text = var_0_2:getNowLang("selectyourscore")
		self._control.evaluate_layer.bg.confirm_btn.txt.text.text = var_0_2:getNowLang("space_confirm")
		self._control.bg.tip_layer.confirm_btn.txt.text.text = var_0_2:getNowLang("ui_cbtn1")
		self._control.bg.tip_layer.cancel_btn.txt.text.text = var_0_2:getNowLang("ui_cbtn2")
		self._control.bg.tip_layer.bg_container.title_node.title.text.text = var_0_2:getNowLang("confirm")

		self:__click_apply_btn_event()
	end

	function arg_1_0:__init_constant()
		self._bg_seq = self._control.bg.uITweenSequence
		self._evaluate_layer_seq = self._control.evaluate_layer.bg.uITweenSequence
		self._tip_layer_seq = self._control.bg.tip_layer.uITweenSequence
	end

	function arg_1_0:__init_reusable_cell()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.bg.scrollview.viewport.content.endlessScrollView, self._control.bg.scrollview.viewport.content, "single_design_detail", "dormitory_design_detail")

			self._reusable_cell:init()
		end
	end

	function arg_1_0.__onReset(arg_28_0)
		arg_28_0._is_already_init = false
		arg_28_0._obj_pool = {}
		arg_28_0._data = {}
		arg_28_0._bg_seq = nil
		arg_28_0._evaluate_layer_seq = nil
		arg_28_0._tip_layer_seq = nil
		arg_28_0._now_score = 5
		arg_28_0._now_exhibitio_integrity = true
	end

	function arg_1_0:_play_into_se(arg_29_1)
		self:playSE(arg_29_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_30_0)
	local var_30_0 = var_0_1:class("dormitory_design_detail")

	var_30_0._is_already_init = false
	var_30_0._reusable_cell = nil
	var_30_0._obj_pool = {}
	var_30_0._data = {}
	var_30_0._bg_seq = nil
	var_30_0._evaluate_layer_seq = nil
	var_30_0._tip_layer_seq = nil
	var_30_0._now_score = 5
	var_30_0._now_exhibitio_integrity = true

	return var_30_0
end

return var_0_0
