local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = gameconfig.tactics_config
local var_0_7 = table.insert
local var_0_8 = gamecore.prompt
local var_0_9 = gamecore.user

gamecore.UILoader:define("change_tactics", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true, arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell_atk then
			self._reusable_cell_atk:update()
		end

		if self._reusable_cell_def then
			self._reusable_cell_def:update()
		end

		if self._reusable_cell_special then
			self._reusable_cell_special:update()
		end
	end

	function arg_1_0:update_data(arg_4_1)
		self:__set_data(arg_4_1)
		self:__init_panel(true)
	end

	function arg_1_0:__onVisible(arg_5_1, arg_5_2)
		if not arg_5_1 then
			return
		end

		self:__set_data(arg_5_2)
		self:__init_panel()
	end

	function arg_1_0:__init_panel(arg_6_1)
		self:__init_fixed_value()
		self:__refresh_ui()

		if arg_6_1 then
			return
		end

		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	function arg_1_0:__init_fixed_value()
		if self._is_already_init then
			return
		end

		self._control.content.title.text.text = var_0_1:getNowLang("changetactics")
		self._control.content.atk.title.text.text = var_0_1:getNowLang("attacktactics")
		self._control.content.def.title.text.text = var_0_1:getNowLang("defendtactics")
		self._control.content.special.title.text.text = var_0_1:getNowLang("specialtactics")
		self._control.content.tactics_info.text.text = var_0_1:getNowLang("changetacticsinfo")
		self._control.content.goto_school.text.text = var_0_1:getNowLang("gotoschool")

		local var_7_0 = var_0_9:get_character_level_data()

		self._control.content.goto_school:SetActive(var_7_0)
		self._control.content.goto_image:SetActive(var_7_0)
		self:__init_atk_list()
		self:__init_def_list()
		self:__init_special_list()

		self._is_already_init = true
	end

	function arg_1_0:__refresh_ui()
		if self._data.level < var_0_3.tactics_unlock_level.atk then
			self._control.content.atk.no_skill:SetActive(true)

			self._control.content.atk.no_skill.title.text.text = var_0_5(var_0_1:getNowLang("tacticslevel", true), var_0_3.tactics_unlock_level.atk)
		else
			self._control.content.atk.no_skill:SetActive(#self._atk_data == 0)

			if self._data.tactics[1] == 0 then
				self._control.content.atk.no_skill.title.text.text = var_0_1:getNowLang("notactics")
			end
		end

		if self._data.level < var_0_3.tactics_unlock_level.def then
			self._control.content.def.no_skill:SetActive(true)

			self._control.content.def.no_skill.title.text.text = var_0_5(var_0_1:getNowLang("tacticslevel", true), var_0_3.tactics_unlock_level.def)
		else
			self._control.content.def.no_skill:SetActive(#self._def_data == 0)

			if self._data.tactics[2] == 0 then
				self._control.content.def.no_skill.title.text.text = var_0_1:getNowLang("notactics")
			end
		end

		if self._data.level < var_0_3.tactics_unlock_level.special then
			self._control.content.special.no_skill:SetActive(true)

			self._control.content.special.no_skill.title.text.text = var_0_5(var_0_1:getNowLang("tacticslevel", true), var_0_3.tactics_unlock_level.special)
		else
			self._control.content.special.no_skill:SetActive(#self._special_data == 0)

			if self._data.tactics[3] == 0 then
				self._control.content.special.no_skill.title.text.text = var_0_1:getNowLang("notactics")
			end
		end

		self:__update_reusable_cell_atk()
		self:__update_reusable_cell_def()
		self:__update_reusable_cell_special()
	end

	function arg_1_0:__set_data(arg_9_1)
		self._data = arg_9_1
		self._atk_data = {}
		self._def_data = {}
		self._special_data = {}

		for iter_9_0, iter_9_1 in pairs(self._data.all_tactics or {}) do
			local var_9_0 = var_0_6.find_object_by_cid(iter_9_1.id)

			if var_9_0.type == var_0_3.tactics_type.atk then
				var_0_7(self._atk_data, iter_9_1)
			elseif var_9_0.type == var_0_3.tactics_type.def then
				var_0_7(self._def_data, iter_9_1)
			elseif var_9_0.type == var_0_3.tactics_type.special then
				var_0_7(self._special_data, iter_9_1)
			end
		end
	end

	function arg_1_0:__init_atk_list()
		if self._already_init then
			return
		end

		self._reusable_cell_atk = gamecore.reusable_cell:create(self, self._control.content.atk.scroll.viewport.content.endlessScrollView, self._control.content.atk.scroll.viewport.content, "single_tactics", "change_tactics")

		self._reusable_cell_atk:init()
	end

	function arg_1_0:__update_reusable_cell_atk()
		table.sort(self._atk_data, function(arg_12_0, arg_12_1)
			return arg_12_0.id < arg_12_1.id
		end)

		local var_11_0 = self._atk_data

		self._reusable_cell_atk:set_data(self._atk_data)

		function self._reusable_cell_atk:_set_func(arg_13_1)
			self:__refresh_tactics_info(self, var_11_0[arg_13_1 + 1], self._data.tactics[1])
			self.select_btn.button.onClick:RemoveAllListeners()
			self.select_btn.button.onClick:AddListener(function()
				local var_14_0

				local function var_14_1()
					return
				end

				local var_14_2 = var_0_6.find_object_by_cid(var_11_0[arg_13_1 + 1].id)

				if var_11_0[arg_13_1 + 1].state == var_0_3.stactic_state.study then
					return
				elseif var_11_0[arg_13_1 + 1].state == var_0_3.stactic_state.normal and var_14_2.level ~= 0 then
					var_14_0 = var_0_2:createInstance("loading")

					function var_14_1()
						var_0_9:req_ShipChangeTactics({
							id = self._data.id,
							type = var_14_2.type,
							tactics_id = var_11_0[arg_13_1 + 1].id
						})
					end
				else
					var_0_8:show(var_0_1:getNowLang("cannotequipnotlearn"))

					self._cur_atk_select = -1
				end

				if var_14_0 then
					var_14_0:show(true, var_14_1, true)
				end
			end)
		end

		self._reusable_cell_atk:update()
	end

	function arg_1_0:__init_def_list()
		if self._already_init then
			return
		end

		self._reusable_cell_def = gamecore.reusable_cell:create(self, self._control.content.def.scroll.viewport.content.endlessScrollView, self._control.content.def.scroll.viewport.content, "single_tactics", "change_tactics")

		self._reusable_cell_def:init()
	end

	function arg_1_0:__update_reusable_cell_def()
		table.sort(self._def_data, function(arg_19_0, arg_19_1)
			return arg_19_0.id < arg_19_1.id
		end)

		local var_18_0 = self._def_data

		self._reusable_cell_def:set_data(self._def_data)

		function self._reusable_cell_def:_set_func(arg_20_1)
			self:__refresh_tactics_info(self, var_18_0[arg_20_1 + 1], self._data.tactics[2])
			self.select_btn.button.onClick:RemoveAllListeners()
			self.select_btn.button.onClick:AddListener(function()
				self._cur_def_select = arg_20_1

				local var_21_0

				local function var_21_1()
					return
				end

				local var_21_2 = var_0_6.find_object_by_cid(var_18_0[arg_20_1 + 1].id)

				if var_18_0[arg_20_1 + 1].state == var_0_3.stactic_state.study then
					return
				elseif var_18_0[arg_20_1 + 1].state == var_0_3.stactic_state.normal and var_21_2.level ~= 0 then
					var_21_0 = var_0_2:createInstance("loading")

					function var_21_1()
						var_0_9:req_ShipChangeTactics({
							id = self._data.id,
							type = var_21_2.type,
							tactics_id = var_18_0[arg_20_1 + 1].id
						})
					end
				else
					self._cur_def_select = -1

					var_0_8:show(var_0_1:getNowLang("cannotequipnotlearn"))
				end

				if var_21_0 then
					var_21_0:show(true, var_21_1, true)
				end
			end)
		end

		self._reusable_cell_def:update()
	end

	function arg_1_0:__init_special_list()
		if self._already_init then
			return
		end

		self._reusable_cell_special = gamecore.reusable_cell:create(self, self._control.content.special.scroll.viewport.content.endlessScrollView, self._control.content.special.scroll.viewport.content, "single_tactics", "change_tactics")

		self._reusable_cell_special:init()
	end

	function arg_1_0:__update_reusable_cell_special()
		table.sort(self._special_data, function(arg_26_0, arg_26_1)
			return arg_26_0.id < arg_26_1.id
		end)

		local var_25_0 = self._special_data

		self._reusable_cell_special:set_data(self._special_data)

		function self._reusable_cell_special:_set_func(arg_27_1)
			self:__refresh_tactics_info(self, var_25_0[arg_27_1 + 1], self._data.tactics[3])
			self.select_btn.button.onClick:RemoveAllListeners()
			self.select_btn.button.onClick:AddListener(function()
				local var_28_0

				local function var_28_1()
					return
				end

				local var_28_2 = var_0_6.find_object_by_cid(var_25_0[arg_27_1 + 1].id)

				if var_25_0[arg_27_1 + 1].state == var_0_3.stactic_state.study then
					return
				elseif var_25_0[arg_27_1 + 1].state == var_0_3.stactic_state.normal and var_28_2.level ~= 0 then
					var_28_0 = var_0_2:createInstance("loading")

					function var_28_1()
						var_0_9:req_ShipChangeTactics({
							id = self._data.id,
							type = var_28_2.type,
							tactics_id = var_25_0[arg_27_1 + 1].id
						})
					end
				else
					self._cur_spe_select = -1

					var_0_8:show(var_0_1:getNowLang("cannotequipnotlearn"))
				end

				if var_28_0 then
					var_28_0:show(true, var_28_1, true)
				end
			end)
		end

		self._reusable_cell_special:update()
	end

	function arg_1_0:__refresh_tactics_info(arg_31_1, arg_31_2, arg_31_3)
		local var_31_0 = var_0_6.find_object_by_cid(arg_31_2.id)

		arg_31_1.skill_bg.image.sprite = self:loadSprite(var_0_5(var_0_3.college_tactics, var_31_0.icon))
		arg_31_1.level.text.text = "Lv " .. var_31_0.level
		arg_31_1.state_exp.text.text = var_31_0.level == var_31_0.max_level and arg_31_2.exp .. "/" .. var_31_0.level_exp[var_31_0.level] or arg_31_2.exp .. "/" .. var_31_0.level_exp[var_31_0.level + 1]

		arg_31_1.state_txt:SetActive(var_31_0.level ~= var_31_0.max_level)

		if arg_31_2.state == var_0_3.stactic_state.study then
			arg_31_1.state_txt.text.text = var_0_1:getNowLang("studying")
			arg_31_1.state.image.sprite = self:loadSprite(var_0_5(var_0_3.tactics_bg, 2))
		elseif var_31_0.level == var_31_0.max_level then
			arg_31_1.state.image.sprite = self:loadSprite(var_0_5(var_0_3.tactics_bg, 3))
			arg_31_1.state_exp.text.text = var_0_1:getNowLang("equiped")

			arg_31_1.state:SetActive(arg_31_2.id == arg_31_3)
			arg_31_1.state_exp:SetActive(arg_31_2.id == arg_31_3)
		else
			arg_31_1.state.image.sprite = self:loadSprite(var_0_5(var_0_3.tactics_bg, 5))
			arg_31_1.state_txt.text.text = var_0_1:getNowLang("notfinish")

			arg_31_1.state:SetActive(true)
			arg_31_1.state_exp:SetActive(true)
		end

		arg_31_1.name_txt.text.text = var_31_0.title
	end

	function arg_1_0.__find_studying(arg_32_0, arg_32_1, arg_32_2)
		for iter_32_0, iter_32_1 in pairs(arg_32_1) do
			if iter_32_1.id == arg_32_2 then
				if iter_32_1.state == var_0_3.stactic_state.study then
					return true
				end

				return false
			end
		end

		return false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_33_0)
	local var_33_0 = var_0_2:class("change_tactics")

	var_33_0._is_already_init = false
	var_33_0._data = {}
	var_33_0._atk_data = {}
	var_33_0._def_data = {}
	var_33_0._special_data = {}
	var_33_0._single_tactics = {}
	var_33_0._enter_type = {}
	var_33_0._reusable_cell_atk = {}
	var_33_0._reusable_cell_def = {}
	var_33_0._reusable_cell_special = {}

	return var_33_0
end

return var_0_0
