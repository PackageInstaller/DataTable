local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = table.insert
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.ship_config
local var_0_9 = gameconfig.equip_config
local var_0_11 = table.sort
local var_0_12 = {
	tog_2 = "tog_2",
	all_tog = "all_tog",
	tog_1 = "tog_1",
	tog_4 = "tog_4",
	tog_3 = "tog_3"
}

gamecore.UILoader:define("dock_log", function(arg_1_0)
	function arg_1_0:play_ui_animation(arg_2_1, arg_2_2)
		var_0_7:play_in_out_animation(self._control.bg.uITweenSequence, arg_2_1, arg_2_2)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_4_1)
		self:setVisible(true)
		self:__set_data(arg_4_1)
		self:__init_panel()
	end

	function arg_1_0:update_data()
		self:__set_data(self._type)
	end

	function arg_1_0:__init_panel()
		self:__init_fixed_value()
		self:__init_select()
		var_0_7:play_in_out_animation(self._control.bg.uITweenSequence, true, function()
			self:__init_mask_move()
		end)

		if self._type == var_0_7.pool_type.ship_build then
			self._control.content.bg_layer.title_bg.title.text.text = var_0_1:getNowLang("logshipfactorytitle")
		elseif self._type == var_0_7.pool_type.equipment_build then
			self._control.content.bg_layer.title_bg.title.text.text = var_0_1:getNowLang("logequipfactorytitle")
		end

		self._control.content.fav_tog.toggle.onValueChanged:AddListener(function(arg_8_0)
			if arg_8_0 then
				self:__set_now_data(self._now_label)
			else
				self:__set_now_data(self._now_label)
			end
		end)
	end

	function arg_1_0.sort_rule(arg_9_0, arg_9_1)
		var_0_11(arg_9_1, function(arg_10_0, arg_10_1)
			return arg_10_0.time > arg_10_1.time
		end)

		return arg_9_1
	end

	function arg_1_0:__set_data(arg_11_1)
		self._type = arg_11_1
		self._data_list = var_0_3:get_records_by_type(arg_11_1) or {}
		self._collect_data_list = var_0_3:get_collect_record_by_type(arg_11_1) or {}

		self:sort_rule(self._data_list)
		self:sort_rule(self._collect_data_list)

		local var_11_0 = {}
		local var_11_1 = {}
		local var_11_2 = {}
		local var_11_3 = {}
		local var_11_4 = {}
		local var_11_5 = {}
		local var_11_6 = {}
		local var_11_7 = {}

		for iter_11_0, iter_11_1 in pairs(self._data_list) do
			local var_11_8

			if arg_11_1 == var_0_7.pool_type.ship_build then
				var_11_8 = var_0_8.find_object_by_cid(iter_11_1.cid)
			elseif arg_11_1 == var_0_7.pool_type.equipment_build then
				var_11_8 = var_0_9.find_object_by_cid(iter_11_1.cid)
			end

			if var_11_8.star <= 3 then
				var_0_5(var_11_0, iter_11_1)

				if self:__get_in_collect(iter_11_1.id) then
					var_0_5(var_11_4, iter_11_1)
				end
			elseif var_11_8.star == 4 then
				var_0_5(var_11_1, iter_11_1)

				if self:__get_in_collect(iter_11_1.id) then
					var_0_5(var_11_5, iter_11_1)
				end
			elseif var_11_8.star == 5 then
				var_0_5(var_11_2, iter_11_1)

				if self:__get_in_collect(iter_11_1.id) then
					var_0_5(var_11_6, iter_11_1)
				end
			elseif var_11_8.star == 6 then
				var_0_5(var_11_3, iter_11_1)

				if self:__get_in_collect(iter_11_1.id) then
					var_0_5(var_11_7, iter_11_1)
				end
			end
		end

		self._fav_data_by_star = {}
		self._data_by_star = {}
		self._data_by_star = {
			self._data_list,
			var_11_0,
			var_11_1,
			var_11_2,
			var_11_3
		}
		self._fav_data_by_star = {
			self._collect_data_list,
			var_11_4,
			var_11_5,
			var_11_6,
			var_11_7
		}
	end

	function arg_1_0:__get_in_collect(arg_12_1)
		for iter_12_0, iter_12_1 in pairs(self._collect_data_list) do
			if iter_12_1.id == arg_12_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__init_mask_move()
		self._control.content.bg_layer.mask.glow:SetActive(true)

		self._control.content.bg_layer.mask.glow.rectTransform.anchoredPosition = Vector2(-684, 422)
		self._seq = self:autoKillDOTween(var_0_6.Sequence())

		self._seq:Append(self._control.content.bg_layer.mask.glow.transform:DOBlendableLocalMoveBy(Vector3.New(1368, -945), 3):SetEase(DG.Tweening.Ease.Linear))
		self._seq:SetLoops(-1)
		self._seq:Play()
	end

	function arg_1_0:__pause_mask_move()
		self._control.content.bg_layer.mask.glow:SetActive(false)
	end

	function arg_1_0:__init_fixed_value()
		if self._already_init then
			return
		end

		self._control.content.up_btns.log_fav_btn.title.text.text = var_0_1:getNowLang("logfav")
		self._control.content.up_btns.log_builder_btn.title.text.text = var_0_1:getNowLang("logbuilder")
		self._control.content.up_btns.log_cost_btn.title.text.text = var_0_1:getNowLang("logcost")
		self._control.content.up_btns.log_get_btn.title.text.text = var_0_1:getNowLang("logget")
		self._control.content.fav_tog.title.text.text = var_0_1:getNowLang("logtypefav")
		self._control.content.toggle_group.all_tog.title.text.text = var_0_1:getNowLang("logtype0")
		self._control.content.toggle_group.tog_1.title.text.text = var_0_1:getNowLang("logtype1")
		self._control.content.toggle_group.tog_2.title.text.text = var_0_1:getNowLang("logtype2")
		self._control.content.toggle_group.tog_3.title.text.text = var_0_1:getNowLang("logtype3")
		self._control.content.toggle_group.tog_4.title.text.text = var_0_1:getNowLang("logtype4")

		self:__init_log_list()

		self._already_init = true
	end

	function arg_1_0:__init_select()
		if self._now_content then
			self._now_content.toggle.isOn = false
			self._now_label = ""
		end

		self:__select_one("all_tog")

		self._control.content.fav_tog.toggle.isOn = false
		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_17_1)
		if self._now_label == arg_17_1 then
			return
		end

		self._now_label = arg_17_1

		self:__set_current_content(arg_17_1)
		self:__set_now_data(self._now_label)

		self._control.content.scroll.Viewport.Content.rectTransform.anchoredPosition = Vector2.New(0, 0)
	end

	function arg_1_0:__set_current_content(arg_18_1)
		if arg_18_1 == var_0_12.all_tog then
			self._now_content = self._control.content.toggle_group.all_tog
		elseif arg_18_1 == var_0_12.tog_1 then
			self._now_content = self._control.content.toggle_group.tog_1
		elseif arg_18_1 == var_0_12.tog_2 then
			self._now_content = self._control.content.toggle_group.tog_2
		elseif arg_18_1 == var_0_12.tog_3 then
			self._now_content = self._control.content.toggle_group.tog_3
		elseif arg_18_1 == var_0_12.tog_4 then
			self._now_content = self._control.content.toggle_group.tog_4
		end
	end

	function arg_1_0:__set_now_data(arg_19_1)
		if arg_19_1 == var_0_12.all_tog then
			self:__get_data_by_index(1)
		elseif arg_19_1 == var_0_12.tog_1 then
			self:__get_data_by_index(2)
		elseif arg_19_1 == var_0_12.tog_2 then
			self:__get_data_by_index(3)
		elseif arg_19_1 == var_0_12.tog_3 then
			self:__get_data_by_index(4)
		elseif arg_19_1 == var_0_12.tog_4 then
			self:__get_data_by_index(5)
		end

		self:__update_cell()
	end

	function arg_1_0:__init_log_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.content.scroll.Viewport.Content.endlessScrollView, self._control.content.scroll.Viewport.Content, "single_dock_log", "dock_log")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell()
		local var_21_0 = self._now_data

		self._reusable_cell:set_data(self._now_data)

		function self._reusable_cell:_set_func(arg_22_1)
			self.user_name.text.text = var_21_0[arg_22_1 + 1].name
			self.use_btn.text.text.text = var_0_1:getNowLang("loguse")

			local var_22_0 = self:__get_in_collect(var_21_0[arg_22_1 + 1].id)

			self.selected:SetActive(var_22_0)

			self.user_name.text.color = var_22_0 and Color.New(0, 0.6078431372549019, 0.9607843137254902) or Color.New(0.22745098039215686, 0.22745098039215686, 0.22745098039215686)
			self.time.text.color = var_22_0 and Color.New(0, 0.6078431372549019, 0.9607843137254902) or Color.New(0.596078431372549, 0.5764705882352941, 0.5764705882352941)
			self.item_1.num.text.text = var_21_0[arg_22_1 + 1].oil
			self.item_2.num.text.text = var_21_0[arg_22_1 + 1].bullet
			self.item_3.num.text.text = var_21_0[arg_22_1 + 1].fe
			self.item_4.num.text.text = var_21_0[arg_22_1 + 1].al
			self.time.text.text = os.date("%Y-%m-%d", var_21_0[arg_22_1 + 1].time)

			self.model.mask.icon:SetActive(self._type == var_0_7.pool_type.ship_build)
			self.model.mask.equip_icon:SetActive(self._type == var_0_7.pool_type.equipment_build)

			local var_22_3

			if self._type == var_0_7.pool_type.ship_build then
				var_22_3 = var_0_8.find_object_by_cid(var_21_0[arg_22_1 + 1].cid)
				self.model.type_layer.type.text.text = var_0_1:getNowLang(var_0_7:get_ship_type_language_key(var_22_3.type, 1))
				self.model.mask.icon.image.sprite = self:loadSprite(var_0_7:get_ship_icon(var_0_7.ship_icon.model_normal_s, var_22_3.pic_id))
			elseif self._type == var_0_7.pool_type.equipment_build then
				var_22_3 = var_0_9.find_object_by_cid(var_21_0[arg_22_1 + 1].cid)
				self.model.type_layer.type.text.text = ""
				self.model.mask.equip_icon.image.sprite = self:loadSprite(var_0_4(var_0_7.equip_icon.large, var_22_3.pic_id))
			end

			self.model.type_layer.country_name.text.text = var_22_3.title
			self.model.bg.image.sprite = self:loadSprite(var_0_4(var_0_7.equip_back.equip_back_normal, var_22_3.star))

			self.select_btn.button.onClick:RemoveAllListeners()
			self.select_btn.button.onClick:AddListener(function()
				local var_23_0 = self:__get_in_collect(var_21_0[arg_22_1 + 1].id)

				self.selected:SetActive(not var_23_0)

				self.user_name.text.color = var_23_0 and Color.New(0.22745098039215686, 0.22745098039215686, 0.22745098039215686) or Color.New(0, 0.6078431372549019, 0.9607843137254902)
				self.time.text.color = var_23_0 and Color.New(0.596078431372549, 0.5764705882352941, 0.5764705882352941) or Color.New(0, 0.6078431372549019, 0.9607843137254902)

				if not var_23_0 then
					var_0_3:req_CollectBuildRecord({
						type = self._type,
						record = var_21_0[arg_22_1 + 1]
					})
				elseif var_23_0 then
					var_0_3:req_DeleteBuildRecord({
						id = var_21_0[arg_22_1 + 1].id,
						type = self._type
					})
				end
			end)
			self.use_btn.scaleButton.onClick:RemoveAllListeners()
			self.use_btn.scaleButton.onClick:AddListener(function()
				self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.task_goto))

				local var_24_0 = {
					var_21_0[arg_22_1 + 1].oil,
					var_21_0[arg_22_1 + 1].bullet,
					var_21_0[arg_22_1 + 1].fe,
					var_21_0[arg_22_1 + 1].al
				}
				local var_24_1 = var_0_2:getInstance("dock_bet")

				if var_24_1 then
					var_24_1:set_roll_scroll(var_24_0)
				else
					var_0_2:createInstance("dock_bet"):set_roll_scroll(var_24_0)
				end

				self:__pause_mask_move()
				self:setVisible(false)
			end)
		end
	end

	function arg_1_0:__get_data_by_index(arg_25_1)
		self._now_data = {}
		self._now_data = self._control.content.fav_tog.toggle.isOn and self._fav_data_by_star[arg_25_1] or self._data_by_star[arg_25_1]

		return self._now_data
	end

	function arg_1_0:_play_into_se(arg_26_1)
		self:playSE(arg_26_1, false)
	end

	function arg_1_0.__onReset(arg_27_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_28_0)
	local var_28_0 = var_0_2:class("dock_log")

	var_28_0._already_init = false
	var_28_0._reusable_cell = nil
	var_28_0._now_label = nil
	var_28_0._now_content = nil
	var_28_0._now_data = {}
	var_28_0._data = {}
	var_28_0._data_list = {}
	var_28_0._collect_data_list = {}
	var_28_0._fav_data = {}
	var_28_0._data_by_star = {}
	var_28_0._fav_data_by_star = {}
	var_28_0._seq = nil
	var_28_0._type = nil

	return var_28_0
end

return var_0_0
