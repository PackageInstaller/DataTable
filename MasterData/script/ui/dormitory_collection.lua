local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = gameconfig.furniture_config
local var_0_6 = gameconfig.furniture_collection_config
local var_0_7 = table.sort
local var_0_8 = table.insert
local var_0_10 = string.format
local var_0_11 = gameconfig.item_config
local var_0_12 = gamecore.util_func

gamecore.UILoader:define("dormitory_collection", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell_1 then
			self._reusable_cell_1:update()
		end

		if self._reusable_cell_2 then
			self._reusable_cell_2:update()
		end
	end

	function arg_1_0:__show_head_layer(arg_4_1)
		var_0_3:play_in_out_animation(self._bg_seq, arg_4_1, function()
			if not arg_4_1 then
				var_0_1:destroyInstance(self._out)
			end
		end)
	end

	function arg_1_0:__updata_collection_cell(arg_6_1, arg_6_2)
		self._reusable_cell_2:set_data(arg_6_1)

		function self._reusable_cell_2:_set_func(arg_7_1)
			local var_7_0 = var_0_5.find_object_by_cid(arg_6_1[arg_7_1 + 1])
			local var_7_1 = false

			for iter_7_0, iter_7_1 in pairs(arg_6_2) do
				if arg_6_1[arg_7_1 + 1] == iter_7_1 then
					var_7_1 = true

					break
				end
			end

			self.put_dorm:SetActive(false)
			self.lock:SetActive(false)

			local var_7_3 = ""

			if var_7_1 then
				self.frame.image.sprite = self:loadSprite(var_0_3.common_icon.room_furniture_frame.blue)
				var_7_3 = var_0_10(var_0_3.furniture_bg, var_7_0.star)
				self.bg.icon.image.material = nil
			else
				self.frame.image.sprite = self:loadSprite(var_0_3.common_icon.room_furniture_frame.gray)
				var_7_3 = var_0_10(var_0_3.furniture_bg, 1)
				self.bg.icon.image.material = self:loadMaterial(var_0_3.common_icon.furniture_gray_material)
			end

			self.bg.image.sprite = self:loadSprite(var_7_3)
			self.bg.icon.image.sprite = self:loadSprite(var_0_10(var_0_3.furniture_s_img, var_7_0.icon, var_7_0.icon))

			self.bg.icon.image:SetNativeSize()
			self.name_mask.textScroller:SetText(var_7_0.title)
		end
	end

	function arg_1_0:__set_award_info(arg_8_1, arg_8_2, arg_8_3)
		self._control.bg.award.frame.icon.image.sprite = self:loadSprite(var_0_10(var_0_3.icon.item_icon, arg_8_1.award))

		self._control.bg.award.frame.icon.image:SetNativeSize()

		self._control.bg.award.desc_layer.desc.text.text = arg_8_1.desc

		self._control.bg.award.desc_layer:SetActive(true)

		if arg_8_2.get ~= nil then
			local var_8_0 = not arg_8_2.get and arg_8_3

			self._control.bg.award.desc_layer:SetActive(not (not arg_8_2.get and arg_8_3))
			self._control.bg.award.btn:SetActive(var_8_0)
		end
	end

	function arg_1_0:__sort_by_rule()
		local var_9_0 = {}
		local var_9_1 = {}
		local var_9_2 = var_0_4:get_dormitory_collect()

		for iter_9_0, iter_9_1 in ipairs(self._furniture_collection_config) do
			local var_9_3

			for iter_9_2, iter_9_3 in pairs(var_9_2) do
				if iter_9_1.id == iter_9_3.id then
					var_9_3 = iter_9_3
				end
			end

			if var_9_3 == nil then
				var_0_8(var_9_0, iter_9_1)
			else
				if var_9_3.furniture then
					if (#var_9_3.furniture or 0) == #iter_9_1.furniture_cids then
						var_0_8(var_9_1, iter_9_1)

						goto label_9_0
					end
				end

				var_0_8(var_9_0, iter_9_1)
			end

			::label_9_0::
		end

		return var_0_12.concat_array(var_9_0, var_9_1)
	end

	function arg_1_0:__show_award_info()
		local var_10_0 = var_0_11.find_object_by_cid(self._now_click_collect_data.award)

		self._control.bg.icon_tip.content.text.text = var_10_0.desc
		self._control.bg.icon_tip.title.text.text = var_10_0.title

		self:__show_tip_layer(true)
	end

	function arg_1_0:__show_tip_layer(arg_11_1)
		self._control.bg.icon_tip:SetActive(arg_11_1)
	end

	function arg_1_0:__req_get_award()
		var_0_4:req_getFurnitureCoollectRewardReq({
			id = self._now_click_collect_data.id
		})
	end

	function arg_1_0:get_award_resp()
		self:__updata_collection_txt_cell()
		self._control.bg.award.desc_layer:SetActive(true)
		self._control.bg.award.btn:SetActive(false)

		local var_13_0 = var_0_11.find_object_by_cid(self._now_click_collect_data.award)
		local var_13_1 = var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")

		var_13_1._panel.transform:GetComponent("Canvas").sortingOrder = var_0_3.dormitory_const.dorm_collection_layer + 1

		var_13_1:showOne({
			url = var_0_10(var_0_3.normal_str, var_13_0.cid),
			reward_name = var_13_0.title
		}, function()
			(var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox"))._panel.transform:GetComponent("Canvas").sortingOrder = 100
		end, nil, var_0_2:getNowLang("logget"), var_0_3.msg_type.reward)
		var_0_1:getInstance("dormitory"):judge_collect_reward()
	end

	function arg_1_0:__updata_collection_txt_cell(arg_15_1)
		local var_15_0 = var_0_4:get_dormitory_collect()
		local var_15_1 = self:__sort_by_rule()

		self._reusable_cell_1:set_data(var_15_1)

		function self._reusable_cell_1:_set_func(arg_16_1)
			local var_16_0 = false

			for iter_16_0, iter_16_1 in pairs(self._left_cell_list) do
				if iter_16_1 == self then
					var_16_0 = true

					break
				end
			end

			if not var_16_0 then
				var_0_8(self._left_cell_list, self)
			end

			local var_16_1 = var_15_1[arg_16_1 + 1]
			local var_16_2 = {}

			for iter_16_2, iter_16_3 in pairs(var_15_0) do
				if var_16_1.id == iter_16_3.id then
					var_16_2 = iter_16_3

					break
				end
			end

			self.name_txt.text.text = var_16_1.title

			local var_16_3

			if var_16_2.furniture then
				var_16_3 = #var_16_2.furniture

				local var_16_5
				local var_16_4

				if not #var_16_2.furniture then
					var_16_3 = 0
					var_16_4 = var_16_3 == #var_16_1.furniture_cids
					var_16_5 = self.count_txt.text
				end
			end

			var_16_5.text = var_16_3 .. "/" .. #var_16_1.furniture_cids

			self.red:SetActive(false)

			if var_16_2.get ~= nil then
				self.red:SetActive(var_16_4 and not var_16_2.get)
			end

			self:__select_state(self, arg_16_1 == self._now_click_collect_index)
			self.btn.button.onClick:RemoveAllListeners()
			self.btn.button.onClick:AddListener(function()
				self._now_click_collect_index = arg_16_1

				for iter_17_0, iter_17_1 in pairs(self._left_cell_list) do
					self:__select_state(iter_17_1, false)
				end

				self:__select_state(self, true)

				self._now_click_collect_data = var_16_1

				self:__set_award_info(var_16_1, var_16_2, var_16_4)
				self:__updata_collection_cell(var_16_1.furniture_cids, (var_16_2.furniture or nil) and (var_16_2.furniture or {}))
			end)

			if self._default_click_first then
				return
			end

			local var_16_6 = lx.clone_table(var_16_1)
			local var_16_7 = lx.clone_table(var_16_2)
			local var_16_8 = 0

			if not var_16_2.furniture or not var_16_2.furniture then
				-- block empty
			end

			if arg_15_1 then
				var_16_6 = arg_15_1

				for iter_16_4, iter_16_5 in pairs(var_15_1) do
					if arg_15_1.id == iter_16_5.id then
						var_16_8 = iter_16_4 - 1

						break
					end
				end

				for iter_16_6, iter_16_7 in pairs(var_15_0) do
					if arg_15_1.id == iter_16_7.id then
						var_16_7 = iter_16_7

						break
					end
				end
			end

			self._now_click_collect_data = var_16_1

			self:__set_award_info(var_16_6, var_16_7, var_16_4)
			self:__updata_collection_cell(var_16_6.furniture_cids, (var_16_7.furniture or nil) and (var_16_7.furniture or {}))

			if arg_16_1 == var_16_8 then
				self._now_click_collect_index = arg_16_1

				self:__select_state(self, true)

				self._default_click_first = true
			end
		end
	end

	function arg_1_0:__select_state(arg_18_1, arg_18_2)
		local var_18_0
		local var_18_1 = ""

		if arg_18_2 then
			var_18_0 = Color.New(0.1568627450980392, 0.5882352941176471, 1)
			var_18_1 = var_0_3.common_icon.arrow_2
		else
			var_18_0 = Color.New(0.27058823529411763, 0.27058823529411763, 0.27058823529411763)
			var_18_1 = var_0_3.common_icon.arrow_1
		end

		arg_18_1.name_txt.text.color = var_18_0
		arg_18_1.count_txt.text.color = var_18_0
		arg_18_1.arrow.image.sprite = self:loadSprite(var_18_1)
	end

	function arg_1_0:__init_panel(arg_19_1)
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__init_reusable_cell()
		end

		self:__updata_collection_txt_cell(arg_19_1)

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.bg.bg_container.title.text.text = var_0_2:getNowLang("furniturecollectiontitle")
		self._control.bg.award.btn.txt.text.text = var_0_2:getNowLang("marketingfirstpaygetbtn")
	end

	function arg_1_0:__init_constant()
		self._bg_seq = self._control.bg.uITweenSequence
		self._furniture_collection_config = var_0_6.get_sequence()

		var_0_7(self._furniture_collection_config, function(arg_22_0, arg_22_1)
			return arg_22_0.id < arg_22_1.id
		end)
	end

	function arg_1_0:__init_reusable_cell()
		if not self._reusable_cell_1 then
			self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.bg.left_scrollview.viewport.content.endlessScrollView, self._control.bg.left_scrollview.viewport.content, "single_item_txt", "dormitory_collection")

			self._reusable_cell_1:init()
		end

		if not self._reusable_cell_2 then
			self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.bg.right_scrollview.viewport.content.endlessScrollView, self._control.bg.right_scrollview.viewport.content, "single_furniture", "dormitory_collection")

			self._reusable_cell_2:init()
		end
	end

	function arg_1_0.__set_listener(arg_24_0, arg_24_1)
		arg_24_0._callback_listener = arg_24_1
	end

	function arg_1_0:_play_into_se(arg_25_1)
		self:playSE(arg_25_1, false)
	end

	function arg_1_0:__onReset()
		self._out = "dormitory_collection"
		self._is_already_init = false

		self._bg_seq:ResetParts()

		self._bg_seq = nil
		self._furniture_collection_config = nil
		self._now_click_collect_index = nil
		self._now_click_collect_data = {}
		self._default_click_first = false
		self._callback_listener = nil
		self._left_cell_list = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_27_0)
	local var_27_0 = var_0_1:class("dormitory_collection")

	var_27_0._out = "dormitory_collection"
	var_27_0._is_already_init = false
	var_27_0._reusable_cell_1 = nil
	var_27_0._reusable_cell_2 = nil
	var_27_0._bg_seq = nil
	var_27_0._furniture_collection_config = nil
	var_27_0._now_click_collect_index = nil
	var_27_0._now_click_collect_data = {}
	var_27_0._default_click_first = false
	var_27_0._callback_listener = nil
	var_27_0._left_cell_list = {}

	return var_27_0
end

return var_0_0
