local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.insert
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = string.format
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.teacher_config
local var_0_9 = gameconfig.tactics_config

gamecore.UILoader:define("change_instructor_view", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._now_teacher_index = arg_2_1

		self:__init_panel()
	end

	function arg_1_0:update_teacher_data()
		self._teacher_data = var_0_1:get_teacher_total_info()

		self:__set_teacher_state()
	end

	function arg_1_0:update_teacher_teach_state()
		local var_4_0 = self._control.chat
		local var_4_1, var_4_2 = var_0_1:get_teacher_state_by_cid(self._teacher_config_data[self._now_teacher_index].cid)

		var_4_0.des_text:SetActive(not var_4_1)

		if var_4_1 then
			if var_4_2 ~= 0 then
				var_4_0.describe:SetActive(true)
				var_4_0.set_teach:SetActive(false)
			else
				var_4_0.describe:SetActive(false)
				var_4_0.set_teach:SetActive(true)
			end

			var_4_0.image.sprite = self:loadSprite(var_0_5(var_0_7.college_talk_bg, 1))
		else
			var_4_0.image.sprite = self:loadSprite(var_0_5(var_0_7.college_talk_bg, 2))

			var_4_0.describe:SetActive(false)
			var_4_0.set_teach:SetActive(false)
		end
	end

	function arg_1_0:update_now_teacher_data()
		self._attack_tactics_table = {}
		self._defense_tactics_table = {}
		self._special_tactics_table = {}

		for iter_5_0, iter_5_1 in pairs(self._teacher_config_data[self._now_teacher_index].tactics) do
			local var_5_0 = var_0_9.find_object_by_cid(iter_5_1)

			if var_5_0.type == 1 then
				var_0_2(self._attack_tactics_table, var_5_0)
			elseif var_5_0.type == 2 then
				var_0_2(self._defense_tactics_table, var_5_0)
			elseif var_5_0.type == 3 then
				var_0_2(self._special_tactics_table, var_5_0)
			end
		end

		self:__reset_item_state()
		self:__update_now_item_data()
		self:__set_ship_chat_state()
		self:update_teacher_teach_state()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_teacher_scroll_view()
			self:__init_tactis_item_list()
			self:__init_images()
		end

		self:__init_teacher_config_data()
		self:__set_drag_ship_index()
		self:update_now_teacher_data()
		self:update_teacher_data()

		self._is_already_init = true
	end

	function arg_1_0:__init_images()
		self._control.chat.describe.image.sprite = self:loadSprite(var_0_5(var_0_7.tactics_normal, "teaching"))
	end

	function arg_1_0:__init_language()
		self._control.baseboard.title.text.text = var_0_4:getNowLang("changeteacher")
		self._control.chat.des_text.text.text = var_0_4:getNowLang("medaltypeungain")
		self._control.chat.set_teach.des.text.text = var_0_4:getNowLang("settinginstructor")
		self._control.attack_des.text.text = var_0_4:getNowLang("attacktactics")
		self._control.defense_des.text.text = var_0_4:getNowLang("defendtactics")
		self._control.special_des.text.text = var_0_4:getNowLang("specialtactics")
	end

	function arg_1_0:__init_teacher_scroll_view()
		self._teacherScrollViewObj, self._teacherScrollViewControl = self:loadUIPrefab("teacher_scroll_view", self._control.bg.transform)

		self._teacherScrollViewObj:setVisible(true)

		self._teachItemControlList = {}

		for iter_9_0 = 1, 3 do
			local var_9_0, var_9_1 = self:loadUIPrefab("teacher_item_view", self._teacherScrollViewControl.role_scroll_view.viewport.content.transform)

			var_9_0:setVisible(true)

			self._teachItemControlList[#self._teachItemControlList + 1] = var_9_1

			if iter_9_0 == 1 then
				self._teacherScrollViewControl.role_scroll_view.latticeScrollRect:InitItemWidth(var_9_0._panel)
			end
		end

		self._teacherScrollViewControl.role_scroll_view.latticeScrollRect:SetContentWidthWithMapCount(3)
		self._control.chat.transform:SetAsLastSibling()
	end

	function arg_1_0:__init_tactis_item_list()
		self._tactics_item_panel = {}

		for iter_10_0 = 1, 9 do
			local var_10_0, var_10_1 = self:loadUIPrefab("tactics_item_view", self._control.item_parent.transform)

			var_10_0:setVisible(false)

			var_10_1.select.image.sprite = self:loadSprite(var_0_7.college_select_bg)
			self._tactics_item_panel[#self._tactics_item_panel + 1] = {
				obj = var_10_0,
				control = var_10_1
			}
		end
	end

	function arg_1_0:__set_teacher_state()
		for iter_11_0 = 1, #self._teachItemControlList do
			local var_11_0, var_11_1 = var_0_1:get_teacher_state_by_cid(self._teacher_config_data[iter_11_0].cid)

			self._teachItemControlList[iter_11_0].teacher_detail.teacher_image.image.sprite = self:loadSprite(var_0_5((var_11_0 or nil) and (var_0_7.college_teacher_bg or var_0_7.college_default_bg), self._teacher_config_data[iter_11_0].cid))
			self._teachItemControlList[iter_11_0].teacher_detail.role_name.image.sprite = self:loadSprite(var_0_5(var_0_7.college_name_bg, self._teacher_config_data[iter_11_0].cid))

			self._teachItemControlList[iter_11_0].teacher_detail.role_name.image:SetNativeSize()
		end
	end

	function arg_1_0.__init_teacher_config_data(arg_12_0)
		local var_12_0, var_12_1 = var_0_8:get_sequence()

		arg_12_0._teacher_config_data = var_12_0
	end

	function arg_1_0:__set_drag_ship_index()
		self._teacherScrollViewControl.role_scroll_view.latticeScrollRect:SetTargetItemIndex(self._now_teacher_index - 1)

		local var_13_0 = self._teacherScrollViewControl.role_scroll_view.latticeScrollRect

		self._teacherScrollViewControl.role_scroll_view.latticeScrollRect.onDrag:RemoveAllListeners()
		self._teacherScrollViewControl.role_scroll_view.latticeScrollRect.onDrag:AddListener(function()
			self._now_teacher_index = var_13_0.m_ShowItemIndex + 1

			self:update_now_teacher_data()
		end)
	end

	function arg_1_0:__update_now_item_data()
		for iter_15_0 = 1, #self._attack_tactics_table do
			self._tactics_item_panel[iter_15_0].obj:setVisible(true)

			self._tactics_item_panel[iter_15_0].control.icon.image.sprite = self:loadSprite(var_0_5(var_0_7.college_tactics, self._attack_tactics_table[iter_15_0].tactics_id))
			self._tactics_item_panel[iter_15_0].control.icondes.text.text = self._attack_tactics_table[iter_15_0].title

			self:__set_tactis_click_listener(iter_15_0)
		end

		for iter_15_1 = 4, #self._defense_tactics_table + 3 do
			self._tactics_item_panel[iter_15_1].obj:setVisible(true)

			self._tactics_item_panel[iter_15_1].control.icon.image.sprite = self:loadSprite(var_0_5(var_0_7.college_tactics, self._defense_tactics_table[iter_15_1 - 3].tactics_id))
			self._tactics_item_panel[iter_15_1].control.icondes.text.text = self._defense_tactics_table[iter_15_1 - 3].title

			self:__set_tactis_click_listener(iter_15_1)
		end

		for iter_15_2 = 7, #self._special_tactics_table + 6 do
			self._tactics_item_panel[iter_15_2].obj:setVisible(true)

			self._tactics_item_panel[iter_15_2].control.icon.image.sprite = self:loadSprite(var_0_5(var_0_7.college_tactics, self._special_tactics_table[iter_15_2 - 6].tactics_id))
			self._tactics_item_panel[iter_15_2].control.icondes.text.text = self._special_tactics_table[iter_15_2 - 6].title

			self:__set_tactis_click_listener(iter_15_2)
		end
	end

	function arg_1_0:__reset_item_state()
		for iter_16_0 = 1, #self._tactics_item_panel do
			self._tactics_item_panel[iter_16_0].obj:setVisible(false)
			self._tactics_item_panel[iter_16_0].control.select:SetActive(false)
			self._tactics_item_panel[iter_16_0].control.limit_des:SetActive(false)
			self._tactics_item_panel[iter_16_0].control.complete_icon:SetActive(false)
			self._tactics_item_panel[iter_16_0].control.tips:SetActive(false)
		end
	end

	function arg_1_0:__set_ship_chat_state()
		for iter_17_0 = 1, self._control.chat.line.transform.childCount do
			self._control.chat.line.transform:GetChild(iter_17_0 - 1).gameObject:SetActive(iter_17_0 == self._now_teacher_index)
		end
	end

	function arg_1_0:__set_tactis_click_listener(arg_18_1)
		self._tactics_item_panel[arg_18_1].control.tactics_btn.button.onClick:RemoveAllListeners()
		self._tactics_item_panel[arg_18_1].control.tactics_btn.button.onClick:AddListener(function()
			self:__set_now_select_ship_data(arg_18_1)
		end)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_20_0)
	local var_20_0 = var_0_3:class("change_instructor_view")

	var_20_0._is_already_init = false
	var_20_0._teacher_config_data = {}
	var_20_0._now_teacher_index = 1
	var_20_0._teacher_data = nil
	var_20_0._attack_tactics_table = {}
	var_20_0._defense_tactics_table = {}
	var_20_0._special_tactics_table = {}
	var_20_0._teachItemControlList = {}
	var_20_0._teacherScrollViewObj = nil
	var_20_0._teacherScrollViewControl = nil
	var_20_0._tactics_item_panel = {}

	return var_20_0
end

return var_0_0
