local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = string.format
local var_0_6 = gamecore.user
local var_0_7 = gameconfig.sixth_combat_buff_config

gamecore.UILoader:define("tactics_collection", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:update_data()
		self:__update_cell_list()
	end

	function arg_1_0:get_buff_card_by_buff_id(arg_5_1)
		for iter_5_0, iter_5_1 in pairs(self._show_buff_list) do
			if iter_5_1.buff_id == arg_5_1 then
				return iter_5_1
			end
		end

		return nil
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_cell()
		end

		self:__set_buff_data_list()

		self._is_already_init = true
	end

	function arg_1_0:__set_buff_data_list()
		self._show_buff_list = {}

		local var_7_0, var_7_1 = var_0_7.get_sequence()

		self._card_data = var_0_6:get_cardbook_sixth_buff_list()

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if iter_7_1.level == 4 then
				table.insert(self._show_buff_list, iter_7_1)
			end
		end

		for iter_7_2, iter_7_3 in ipairs(self._show_buff_list) do
			iter_7_3.type = self:__judge_own_card(self._card_data, iter_7_3.buff_id) and 1 or 0
		end

		self:update_data()
	end

	function arg_1_0:__init_language()
		self._control.bg_container.select_team_basic.text.text = var_0_1:getNowLang("tactical_map")
	end

	function arg_1_0:__init_cell()
		if self._already_init then
			return
		end

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.all_card.viewport.edge_mask.content.endlessScrollView, self._control.all_card.viewport.edge_mask.content, "single_tactics_collection", "tactics_collection")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__update_cell_list()
		local var_10_0 = self._show_buff_list

		self._reusable_cell:set_data(self._show_buff_list)

		function self._reusable_cell:_set_func(arg_11_1)
			if var_10_0[arg_11_1 + 1].is_open then
				self.bg.name_layer:SetActive(false)
				self.bg.not_open_layer:SetActive(true)
				self.bg.not_active_layer:SetActive(false)
			elseif var_10_0[arg_11_1 + 1].type == 0 then
				self.bg.name_layer:SetActive(false)
				self.bg.not_open_layer:SetActive(false)
				self.bg.not_active_layer:SetActive(true)

				self.bg.not_active_layer.not_open_txt.text.text = var_10_0[arg_11_1 + 1].buff_id
			else
				self.bg.name_layer:SetActive(true)
				self.bg.not_open_layer:SetActive(false)
				self.bg.not_active_layer:SetActive(false)

				self.bg.name_layer.name_txt.name_txt_1.text.text = var_10_0[arg_11_1 + 1].title

				self.bg.name_layer.name_txt:GetComponent("TextHorizonScroller"):SetText(var_10_0[arg_11_1 + 1].title)

				local var_11_0 = var_0_4(var_0_3.tactics_buff, var_10_0[arg_11_1 + 1].buff_id)

				self.bg.name_layer.tactics_bg.image.sprite = self:findPath(var_11_0) and self:loadSprite(var_11_0) or self:loadSprite(var_0_4(var_0_3.tactics_buff, "1"))

				self.bg.name_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.bg.name_layer.detail_btn.button.onClick:AddListener(function()
					var_0_2:createInstance("tactics_detail"):show(var_10_0[arg_11_1 + 1], arg_11_1 + 1)
				end)
			end
		end
	end

	function arg_1_0:__get_max_index(arg_13_1)
		self._max_index = #arg_13_1

		return self._max_index
	end

	function arg_1_0:__show_capacity()
		local var_14_0 = 0

		for iter_14_0, iter_14_1 in pairs(self._show_buff_list) do
			var_14_0 = var_14_0 + iter_14_1.num
		end

		self._control.content.equip_capacity.amount_txt.text.text = var_14_0 .. "/" .. var_0_6:get_use_info_data().max_card
	end

	function arg_1_0.__judge_own_card(arg_15_0, arg_15_1, arg_15_2)
		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			if iter_15_1 == arg_15_2 then
				return true
			end
		end

		return false
	end

	function arg_1_0.__show_layer(arg_16_0, arg_16_1)
		return
	end

	function arg_1_0.__init_constant(arg_17_0)
		return
	end

	function arg_1_0.__onVisible(arg_18_0, arg_18_1)
		if not arg_18_1 then
			arg_18_0._show_buff_list = {}

			return
		end
	end

	function arg_1_0.__onReset(arg_19_0)
		arg_19_0._show_buff_list = {}
		arg_19_0._is_already_init = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_20_0)
	local var_20_0 = var_0_2:class("tactics_collection")

	var_20_0._show_buff_list = {}
	var_20_0._is_already_init = false
	var_20_0._reusable_cell = nil
	var_20_0._show_buff_list = {}
	var_20_0._max_index = 0

	gamecore.extend_obj(var_20_0)

	return var_20_0
end

return var_0_0
