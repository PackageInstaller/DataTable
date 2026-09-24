local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameconfig.pve_eighth_task_config
local var_0_3 = gameconfig.pve_eighth_supportfleet_config
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.user

gamecore.UILoader:define("eighth_support_layer", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._task_cell then
			self._task_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._top_title = self._control.top.title.text
		self._top_title.text = var_0_5:getNowLang("place_task")
		self._achievement_task_view_content = self._control.left_node.achievement_task_view.view_port.content
		self._right_node = self._control.right_node
		self._title_lab = self._right_node.title_node.title_lab.text
		self._attr_title_lab = self._right_node.attr_title_lab.text
		self._level_title_lab = self._right_node.level_title_lab.text
		self._exp_lab = self._right_node.exp_lab.text
		self._exp_slider = self._right_node.exp_slider_bg.exp_slider.image
		self._buff_list_node = self._right_node.buff_list

		self:__check_scene_ratio()
		self:__init_panel_data()
		self:__init_task_list()
		self:__update_cell()
		self:__creat_support_level_item()
		self:__init_right_node()
	end

	function arg_1_0:__init_panel_data()
		self._eighth_task_finished = var_0_6:get_eighth_task_finished_table_by_main() or {}

		local var_5_0, var_5_1 = var_0_3.get_sequence()

		self._max_level = var_5_1
		self._now_exp = self:__get_finish_task_point()
		self._now_level = self:__get_task_level_by_exp(self._now_exp)
	end

	function arg_1_0:__init_task_list()
		if self._already_init then
			return
		end

		self:destroy_obj_child(self._achievement_task_view_content)

		self._already_init = true

		if not self._task_cell then
			self._task_cell = gamecore.reusable_cell:create(self, self._achievement_task_view_content.endlessScrollView, self._achievement_task_view_content, "eighth_achievement_task_item", "eighth_support_layer")

			self._task_cell:init()
		end
	end

	function arg_1_0:__update_cell()
		self._task_config, task_num = var_0_2.get_sequence()
		self._task_config = self:__get_task_sort_table(self._task_config)

		self._task_cell:set_data(self._task_config)

		function self._task_cell:_set_func(arg_8_1)
			arg_8_1 = arg_8_1 + 1
			task_info = self._task_config[arg_8_1]
			self.task_name_lab.text.text = task_info.title
			self.task_desc_lab.text.text = var_0_5:convert_rich_text(task_info.condition_desc)
			self.reward_bg.reward_lab.text.text = var_0_5:getNowLang("pvecampaignrewardlabel") .. task_info.supportfleet_exp
			self.reward_bg.exp_lab.text.text = task_info.supportfleet_exp

			self.reward_bg.trophy_star_bg.gameObject:SetActive(false)

			if task_info.award > 0 then
				self.reward_bg.trophy_star_bg.gameObject:SetActive(true)

				self.reward_bg.trophy_star_bg.trophy_star_lab.text.text = task_info.award
			end

			self.reward_bg.complete_img.gameObject:SetActive(false)

			self.bg.image.sprite = self:loadSprite(var_0_4.eighth_achievement_bg_1)

			if self._eighth_task_finished[task_info.id] then
				self.bg.image.sprite = self:loadSprite(var_0_4.eighth_achievement_bg_2)

				self.reward_bg.complete_img.gameObject:SetActive(true)
			end
		end
	end

	function arg_1_0:__creat_task_item()
		self._task_config, task_num = var_0_2.get_sequence()

		for iter_9_0 = 1, task_num do
			local var_9_0, var_9_1 = self:loadUIPrefab("eighth_achievement_task_item", self._achievement_task_view_content.transform)

			var_9_0:setVisible(true)

			self._task_list_controls[iter_9_0] = var_9_1
		end

		self._task_config = self:__get_task_sort_table(self._task_config)

		for iter_9_1, iter_9_2 in ipairs(self._task_config) do
			self._task_list_controls[iter_9_1].task_name_lab.text.text = iter_9_2.title
			self._task_list_controls[iter_9_1].task_desc_lab.text.text = var_0_5:convert_rich_text(iter_9_2.condition_desc)
			self._task_list_controls[iter_9_1].reward_bg.reward_lab.text.text = var_0_5:getNowLang("pvecampaignrewardlabel") .. iter_9_2.supportfleet_exp
			self._task_list_controls[iter_9_1].reward_bg.exp_lab.text.text = iter_9_2.supportfleet_exp

			self._task_list_controls[iter_9_1].reward_bg.trophy_star_bg.gameObject:SetActive(false)

			if iter_9_2.award > 0 then
				self._task_list_controls[iter_9_1].reward_bg.trophy_star_bg.gameObject:SetActive(true)

				self._task_list_controls[iter_9_1].reward_bg.trophy_star_bg.trophy_star_lab.text.text = iter_9_2.award
			end

			self._task_list_controls[iter_9_1].reward_bg.complete_img.gameObject:SetActive(false)

			self._task_list_controls[iter_9_1].bg.image.sprite = self:loadSprite(var_0_4.eighth_achievement_bg_1)

			if self._eighth_task_finished[iter_9_2.id] then
				self._task_list_controls[iter_9_1].bg.image.sprite = self:loadSprite(var_0_4.eighth_achievement_bg_2)

				self._task_list_controls[iter_9_1].reward_bg.complete_img.gameObject:SetActive(true)
			end
		end
	end

	function arg_1_0:__creat_support_level_item()
		self:destroy_obj_child(self._buff_list_node)

		local var_10_0 = 20
		local var_10_1 = 340

		self._buff_list_node.verticalLayoutGroup.spacing = -8

		if self._is_scene_ratio then
			self._buff_list_node.verticalLayoutGroup.spacing = 8
			var_10_0 = 22
			var_10_1 = 350
		end

		local var_10_2, var_10_3 = var_0_3.get_sequence()

		self._max_level = var_10_3

		for iter_10_0 = 1, var_10_3 do
			local var_10_4, var_10_5 = self:loadUIPrefab("eighth_support_level_item", self._buff_list_node.transform)

			var_10_4:setVisible(true)

			self._support_list_controls[iter_10_0] = var_10_5
		end

		for iter_10_1, iter_10_2 in ipairs(var_10_2) do
			self._support_list_controls[iter_10_1].title_lab.text.text = "LV" .. iter_10_2.level .. "."
			self._support_list_controls[iter_10_1].title_lab.text.fontSize = var_10_0
			self._support_list_controls[iter_10_1].desc_lab.text.text = var_0_5:get_chinese_text(iter_10_2.desc)
			self._support_list_controls[iter_10_1].desc_lab.text.fontSize = var_10_0
			self._support_list_controls[iter_10_1].desc_lab.transform.anchoredPosition = Vector2(var_10_1, -19)

			if iter_10_1 <= self._now_level then
				self._support_list_controls[iter_10_1].title_lab.text.color = Color.New(0.1568627450980392, 0.5764705882352941, 0.9764705882352941, 1)
				self._support_list_controls[iter_10_1].desc_lab.text.color = Color.New(0.1568627450980392, 0.5764705882352941, 0.9764705882352941, 1)
			else
				self._support_list_controls[iter_10_1].title_lab.text.color = Color.New(0.6, 0.6, 0.6, 1)
				self._support_list_controls[iter_10_1].desc_lab.text.color = Color.New(0.6, 0.6, 0.6, 1)
			end
		end
	end

	function arg_1_0:__init_right_node()
		local var_11_0, var_11_1 = self:__get_now_exp_and_all_exp()

		self._level_title_lab.text = var_0_5:getNowLang("place_level") .. "<color=#2583E5>" .. "LV" .. self._now_level .. "</color>"

		if self._now_level >= self._max_level then
			self._exp_lab.text = "MAX"
			self._exp_slider.fillAmount = 1
		else
			self._exp_lab.text = var_11_0 .. "/" .. var_11_1
			self._exp_slider.fillAmount = var_11_0 / var_11_1
		end

		self._title_lab.text = var_0_5:getNowLang("place_npc")
		self._attr_title_lab.text = var_0_5:getNowLang("workshop_effect")
	end

	function arg_1_0:__get_finish_task_point()
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in pairs(self._eighth_task_finished) do
			var_12_0 = var_12_0 + var_0_2.find_object_by_id(iter_12_0).supportfleet_exp
		end

		return var_12_0
	end

	function arg_1_0:__get_task_level_by_exp(arg_13_1)
		if arg_13_1 == 0 then
			return 1
		end

		if not self._exp_level_map then
			local var_13_0, var_13_1 = var_0_3.get_sequence()

			self._exp_level_map = {}

			for iter_13_0, iter_13_1 in ipairs(var_13_0) do
				self._exp_level_map[iter_13_1.level] = iter_13_1.exp
			end
		end

		for iter_13_2, iter_13_3 in pairs(self._exp_level_map) do
			if arg_13_1 < iter_13_3 then
				return iter_13_2 - 1
			end

			if iter_13_2 == self._max_level then
				return iter_13_2
			end
		end

		return 1
	end

	function arg_1_0:__get_now_exp_and_all_exp(arg_14_1)
		arg_14_1 = arg_14_1 or self._now_level
		arg_14_1 = math.min(arg_14_1, self._max_level - 1)
		arg_14_1 = math.max(arg_14_1, 1)

		local var_14_0 = var_0_3.find_object_by_level(arg_14_1).exp

		return self._now_exp - var_14_0, var_0_3.find_object_by_level((math.min(arg_14_1 + 1, self._max_level))).exp - var_14_0
	end

	function arg_1_0:__get_task_sort_table(arg_15_1)
		local var_15_0 = {}
		local var_15_1 = {}
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
			if self:__check_task_is_finish(iter_15_1.id) then
				var_15_0[#var_15_0 + 1] = iter_15_1
			else
				var_15_1[#var_15_1 + 1] = iter_15_1
			end
		end

		for iter_15_2, iter_15_3 in ipairs(var_15_1) do
			table.insert(var_15_2, iter_15_3)
		end

		for iter_15_4, iter_15_5 in ipairs(var_15_0) do
			table.insert(var_15_2, iter_15_5)
		end

		return var_15_2
	end

	function arg_1_0:__check_task_is_finish(arg_16_1)
		return self._eighth_task_finished[arg_16_1]
	end

	function arg_1_0:__check_scene_ratio()
		self._is_scene_ratio = UnityEngine.Screen.width / UnityEngine.Screen.height > 1.33 and UnityEngine.Screen.width / UnityEngine.Screen.height < 1.34

		return self._is_scene_ratio
	end

	function arg_1_0:_play_into_se(arg_18_1)
		arg_18_1 = arg_18_1 or var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open)

		self:playSE(arg_18_1, false)
	end

	function arg_1_0:destroy_obj_child(arg_19_1)
		for iter_19_0 = 0, arg_19_1.rectTransform.childCount - 1 do
			self:destroyGameObject(arg_19_1.rectTransform:GetChild(iter_19_0).gameObject)
		end
	end

	function arg_1_0:__onReset()
		self._already_init = false

		self:destroy_obj_child(self._buff_list_node)
		self:destroy_obj_child(self._achievement_task_view_content)
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_21_0)
		arg_21_0._exp_level_map = nil
		arg_21_0._max_level = 1
		arg_21_0._task_list_controls = {}
		arg_21_0._support_list_controls = {}
		arg_21_0._eighth_task_finished = {}
		arg_21_0._is_scene_ratio = false
		arg_21_0._already_init = false
		arg_21_0._task_cell = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_22_0)
	local var_22_0 = var_0_1:class("eighth_support_layer")

	var_22_0:__initia_lize()

	return var_22_0
end

return var_0_0
