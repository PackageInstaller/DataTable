local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = string.format
local var_0_5 = UnityEngine.Vector3
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.ship_config
local var_0_9 = gameconfig.skin_config
local var_0_10 = gamecore.util_func
local var_0_11 = gameconfig.tactics_config

gamecore.UILoader:define("class_info_view", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		self:setVisible(true)
		self:__init_panel()

		self._tactics_config_data = var_0_11.find_object_by_cid(arg_2_1.cid)
		self._now_tactics_cid = arg_2_1.cid
		self._now_info_cid = arg_2_1.cid
		self._now_info_max_level = self._tactics_config_data.max_level
		self._now_tactics_data = arg_2_1
		self._enter_panel = arg_2_2

		self:__change_show_info(false)

		self._now_class = arg_2_3
		self._ship_info = arg_2_4
		self._now_teacher = arg_2_5

		self:__update_study_btn_state()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
		end

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.detail_panel.tuition.text.text = var_0_2:getNowLang("tacticscost")
		self._control.stop_study_layer.title.text.text = var_0_2:getNowLang("stopstudy")
		self._control.stop_study_layer.main_text.text.text = var_0_2:getNowLang("stoptacticstip")
		self._control.stop_study_layer.confirmbtn.text.text.text = var_0_2:getNowLang("ui_cbtn1")
		self._control.stop_study_layer.quitbtn.text.text.text = var_0_2:getNowLang("ui_cbtn2")
		self._control.item_bg.point.item_des.text.text = var_0_2:getNowLang("progress")
	end

	function arg_1_0:__change_show_info(arg_5_1)
		local var_5_0 = var_0_11.find_object_by_cid(self._now_info_cid)
		local var_5_1 = self._tactics_config_data.level

		if not self._enter_panel then
			var_5_1 = 0

			self._control.detail_panel.show_ship_study_btn:SetActive(true)

			self._control.detail_panel.show_ship_study_btn.show_ship_study_txt.text.text = var_0_2:getNowLang("tactics_view")
		else
			self._control.detail_panel.show_ship_study_btn:SetActive(false)
		end

		if var_5_0 then
			self._control.detail_panel.left_btn:SetActive(var_5_1 < var_5_0.level)
			self._control.detail_panel.right_btn:SetActive(var_5_0.level < self._now_info_max_level)
			self:__init_single_item_panel(var_5_0, arg_5_1)
		end
	end

	function arg_1_0:__init_single_item_panel(arg_6_1, arg_6_2)
		local var_6_0 = self._control.detail_panel

		self._control.item_bg.icon.image.sprite = self:loadSprite(var_0_4(var_0_7.college_tactics, arg_6_1.tactics_id))
		var_6_0.skill_title.text.text = arg_6_1.title

		local var_6_1 = var_0_2:convert_rich_text(arg_6_1.desc)

		if arg_6_1.level ~= self._tactics_config_data.level and self._enter_panel then
			var_6_1 = var_0_10.convert_rich_text(arg_6_1.desc, "FFAB28FF")
			var_6_0.skill_att_mask.skill_att.text.text = var_6_1
			var_6_0.tactics_mask.skill_att.text.text = var_6_1
			self._control.detail_panel.tactics_level.text.color = Color(1, 0.67, 0.15)
		else
			var_6_0.skill_att_mask.skill_att.text.text = var_6_1
			var_6_0.tactics_mask.skill_att.text.text = var_6_1
			self._control.detail_panel.tactics_level.text.color = Color(0.14, 0.63, 0.96)
		end

		var_6_0.skill_des.text.text = arg_6_1.desc2
		var_6_0.tuition.icon.image.sprite = self:loadSprite(var_0_4(var_0_7.college_study_tactics, arg_6_1.need_res.id))
		var_6_0.tuition.item_name.text.text = gameconfig.item_config.find_object_by_cid(arg_6_1.need_res.id).title
		var_6_0.tuition.tuition_num.text.text = "X" .. arg_6_1.need_res.value

		if self._now_tactics_data.sid or self._now_tactics_data.id then
			self._control.base_panel.top.tactic_bg2:SetActive(true)
			self._control.base_panel.top.name_bg:SetActive(true)

			local var_6_2 = {}

			var_6_2 = self._now_tactics_data.sid and var_0_1:find_character_by_id(self._now_tactics_data.sid) or var_0_1:find_character_by_id(self._now_tactics_data.id)

			self._control.base_panel.top.name_bg:GetComponent("TextHorizonScroller"):SetText(var_6_2.name)

			self._control.base_panel.top.ship_headpic_area.ship_headpic.image.sprite = var_6_2.skin == 0 and self:loadSprite(var_0_7:get_ship_icon(var_0_7.ship_icon.model_normal_s, var_0_8.find_object_by_cid(var_6_2.cid).pic_id)) or self:loadSprite(var_0_7:get_ship_icon(var_0_7.ship_icon.model_normal_s, var_0_9.find_object_by_cid(var_6_2.skin).skin_id))

			self._control.base_panel.top.ship_headpic_area.ship_headpic:SetActive(true)
		else
			self._control.base_panel.top.tactic_bg2:SetActive(false)
			self._control.base_panel.top.name_bg:SetActive(false)
			self._control.base_panel.top.ship_headpic_area.ship_headpic:SetActive(false)
		end

		local var_6_3 = var_6_0.skill_att_mask:GetComponent("TextHorizonScroller")
		local var_6_4 = var_6_0.tactics_mask:GetComponent("TextHorizonScroller")

		if #var_0_2:get_chinese_text(arg_6_1.desc) > 73 then
			var_6_3.isRich = true
			var_6_3.scrollSpeed = 0.6

			var_6_3:SetText(var_6_1)

			var_6_4.isRich = true
			var_6_4.scrollSpeed = 0.6

			var_6_4:SetText(var_6_1)
		else
			var_6_0.skill_att_mask.skill_att_1.text.text = ""
			var_6_3.scrollSpeed = 0

			local var_6_5 = var_6_0.skill_att_mask.skill_att:GetComponent("RectTransform")

			var_6_5.localPosition = var_0_5(0, var_6_5.localPosition.y, 0)
			var_6_0.tactics_mask.skill_att_1.text.text = ""
			var_6_4.scrollSpeed = 0

			local var_6_6 = var_6_0.tactics_mask.skill_att:GetComponent("RectTransform")

			var_6_6.localPosition = var_0_5(0, var_6_6.localPosition.y, 0)
		end

		if not arg_6_2 then
			self._control.item_bg.point.gameObject:SetActive(false)
			self._control.base_panel.vertical_bar:SetActive(true)

			if not self._enter_panel then
				self:__set_tactics_describe_state(true)

				self._control.detail_panel.tactics_level.text.text = "Lv." .. arg_6_1.level
			else
				self:__set_tactics_describe_state(false)
			end
		else
			self:__set_tactics_describe_state(true)

			self._control.detail_panel.tactics_level.text.text = "Lv." .. arg_6_1.level
		end
	end

	function arg_1_0:__update_study_btn_state()
		local var_7_0 = self._control.detail_panel

		self._control.detail_panel.study_btn.gameObject:SetActive(false)
		var_7_0.tuition:SetActive(true)

		if self._enter_panel == "selectshipfirst" then
			local var_7_1
			local var_7_2

			if self._now_tactics_data.sid then
				var_7_1, var_7_2 = self:__get_select_tactis_state(self._now_tactics_cid, self._now_tactics_data.sid)
			else
				var_7_1, var_7_2 = self:__get_select_tactis_state(self._now_tactics_cid, self._now_tactics_data.id)
			end

			if var_7_1 == 1 then
				self._now_tactics_data.exp = var_7_2
				var_7_0.study_btn.txt.text.text = var_0_2:getNowLang("continuestudy")
			else
				var_7_0.study_btn.txt.text.text = var_0_2:getNowLang("startstudy")
			end

			var_7_0.study_btn.gameObject:SetActive(self._tactics_config_data.level ~= self._tactics_config_data.max_level)
			self:__set_tactics_describe_state(true)
			self:__show_study_progress()
		elseif self._enter_panel == "school" then
			var_7_0.study_btn.txt.text.text = var_0_2:getNowLang("stopstudy")

			var_7_0.study_btn.gameObject:SetActive(self._tactics_config_data.level ~= self._tactics_config_data.max_level)
			self:__set_tactics_describe_state(true)
			self:__show_study_progress()
			self._control.base_panel.vertical_bar:SetActive(false)
		elseif self._enter_panel == "tactics_panel" then
			local var_7_3
			local var_7_4

			if self._now_tactics_data.sid then
				var_7_3, var_7_4 = self:__get_select_tactis_state(self._now_tactics_cid, self._now_tactics_data.sid)
			else
				var_7_3, var_7_4 = self:__get_select_tactis_state(self._now_tactics_cid, self._now_tactics_data.id)
			end

			local var_7_5 = var_0_1:get_now_statics_seat()

			if var_7_3 == 2 then
				self._now_tactics_data.exp = var_7_4
				var_7_0.study_btn.txt.text.text = var_0_2:getNowLang("stopstudy")
			elseif var_7_4 < 500 then
				var_7_0.study_btn.txt.text.text = var_0_2:getNowLang("continuestudy")
			else
				var_7_0.tuition:SetActive(false)
				var_7_0.study_btn:SetActive(false)
			end

			var_7_0.study_btn.gameObject:SetActive(self._tactics_config_data.level ~= self._tactics_config_data.max_level)
			self:__set_tactics_describe_state(true)
			self:__show_study_progress()
		end

		var_7_0.tuition:SetActive(self._tactics_config_data.level ~= self._tactics_config_data.max_level)
	end

	function arg_1_0:__set_tactics_describe_state(arg_8_1)
		self._control.detail_panel.skill_att_mask:SetActive(not arg_8_1)
		self._control.detail_panel.tactics_mask:SetActive(arg_8_1)
		self._control.detail_panel.tactics_level:SetActive(arg_8_1)
	end

	function arg_1_0:__show_study_progress()
		local var_9_0 = 0

		if self._now_tactics_data.exp then
			var_9_0 = self._now_tactics_data.exp
		end

		local var_9_1, var_9_2, var_9_3 = var_0_7:__get_tactis_config_level(var_9_0, self._now_tactics_cid)

		self._control.item_bg.point.item_progress.text.text = var_9_0 .. "/" .. var_9_2
		self._control.detail_panel.tactics_level.text.text = "Lv." .. self._tactics_config_data.level

		self._control.item_bg.point.gameObject:SetActive(self._tactics_config_data.level ~= self._tactics_config_data.max_level)
	end

	function arg_1_0.__get_select_tactis_state(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = var_0_1:find_character_by_id(arg_10_2)
		local var_10_1 = 0
		local var_10_2 = 0

		if var_10_0.all_tactics and #var_10_0.all_tactics ~= 0 then
			for iter_10_0, iter_10_1 in pairs(var_10_0.all_tactics) do
				if iter_10_1.id == arg_10_1 then
					var_10_1 = iter_10_1.state
					var_10_2 = iter_10_1.exp
				end
			end
		end

		return var_10_1, var_10_2
	end

	function arg_1_0:_play_into_se(arg_11_1)
		self:playSE(arg_11_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_3:class("class_info_view")

	var_12_0._is_already_init = false
	var_12_0._enter_panel = nil
	var_12_0._now_tactics_cid = nil
	var_12_0._now_info_cid = nil
	var_12_0._now_info_max_level = 0
	var_12_0._tactics_config_data = {}
	var_12_0._now_tactics_data = {}
	var_12_0._now_class = nil
	var_12_0._ship_info = nil
	var_12_0._now_teacher = 1

	return var_12_0
end

return var_0_0
