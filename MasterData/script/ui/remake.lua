local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = gameenum.common_type
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = gamecore.util_func
local var_0_8 = table.insert
local var_0_9 = table.remove
local var_0_11 = gameconfig.ship_config
local var_0_12 = gameconfig.skin_config
local var_0_13 = gameconfig.item_config
local var_0_14 = gameconfig.skill_config
local var_0_15 = gameconfig.workshop_config
local var_0_16 = lx.clone_table
local var_0_17 = {
	skill = "skill",
	evo = "evo",
	strengthen = "strengthen"
}

gamecore.UILoader:define("remake", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.into_remake))
		self:setVisible(true, arg_2_1)
	end

	function arg_1_0:_play_into_se(arg_3_1)
		self:playSE(arg_3_1, false)
	end

	function arg_1_0.set_enter_type(arg_4_0, arg_4_1)
		arg_4_0._enter_type = arg_4_1
	end

	function arg_1_0:get_panel_type()
		return self._cur_type
	end

	function arg_1_0:update_data()
		self._canvas_group.blocksRaycasts = true

		if self._data then
			local var_6_0 = var_0_3:find_character_by_id(self._data.id)

			self._data = var_6_0 and var_0_7.little_clone(var_6_0) or {}

			self:set_ship_info(self._data)
		end
	end

	function arg_1_0.uplevel(arg_7_0, arg_7_1)
		arg_7_0._can_send_req = arg_7_1
	end

	function arg_1_0:get_evo_data()
		if self._data then
			return (var_0_3:find_character_by_id(self._data.id))
		end

		return nil
	end

	function arg_1_0:set_ship_info(arg_9_1)
		self:__set_ship_info(arg_9_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:set_strength_res_data(arg_11_1)
		self._strength_res_data = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			local var_11_0 = var_0_3:find_character_by_id(iter_11_1)

			var_0_8(self._strength_res_data, var_11_0 and var_0_7.little_clone(var_11_0) or {})
		end

		self:__update_reusable_cell()
	end

	function arg_1_0:__onVisible(arg_12_1, arg_12_2)
		if not arg_12_1 then
			return
		end

		self:__init_panel(arg_12_2)

		if arg_12_2 then
			var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true)
		end
	end

	function arg_1_0:__init_panel(arg_13_1)
		self._canvas_group = self._panel.transform:GetComponent("CanvasGroup")
		self._canvas_group.blocksRaycasts = true

		if not self._already_init then
			-- block empty
		end

		self:__init_fixed_value()
		self:__init_select(arg_13_1)
	end

	function arg_1_0:__init_fixed_value()
		if self._already_init then
			return
		end

		self._control.left.shipinfo.ship.detail.hp_layer.title.text.text = var_0_1:getNowLang("hp")
		self._control.top.toggle_control.strengthen.rbtn.text.text = var_0_1:getNowLang("rbt1")
		self._control.top.toggle_control.evo.rbtn.text.text = var_0_1:getNowLang("rbt2")
		self._control.top.toggle_control.skill.rbtn.text.text = var_0_1:getNowLang("rbt3")
		self._control.right.strengthen.detail.attrib.attrib_1.title.text.text = var_0_1:getNowLang("atk")
		self._control.right.strengthen.detail.attrib.attrib_2.title.text.text = var_0_1:getNowLang("torpedo")
		self._control.right.strengthen.detail.attrib.attrib_3.title.text.text = var_0_1:getNowLang("def")
		self._control.right.strengthen.detail.attrib.attrib_4.title.text.text = var_0_1:getNowLang("airdef")

		for iter_14_0 = 1, self._control.right.strengthen.detail.attrib.transform.childCount do
			self._control.right.strengthen.detail.attrib.transform:GetChild(iter_14_0 - 1).gameObject.default:SetActive(true)
			self._control.right.strengthen.detail.attrib.transform:GetChild(iter_14_0 - 1).gameObject.have_value:SetActive(false)
		end

		self:__init_strengthen_attrib_contents()

		self._control.right.strengthen.detail.clear_btn.title.text.text = var_0_1:getNowLang("clearlist")
		self._control.right.strengthen.detail.streng_btn.title.text.text = var_0_1:getNowLang("strengthen")
		self._control.right.evo.evo_info.level_title.text.text = var_0_1:getNowLang("evolevelneed")
		self._control.right.evo.evo_info.left_part.remake_get.text.text = var_0_1:getNowLang("ui_remakeget")
		self._control.right.evo.evo_info.left_part.remake_get_skill.text.text = var_0_1:getNowLang("ui_remakegetskill")
		self._control.right.evo.evo_info.left_part.remake_maybe.text.text = var_0_1:getNowLang("ui_remakemaybe")
		self._control.right.evo.evo_info.left_part.remake_hint.text.text = var_0_1:getNowLang("ui_remakehint")
		self._control.right.evo.evo_info.corelist_btn.title.text.text = var_0_1:getNowLang("evocorelistbtn")
		self._control.right.evo.evo_info.remake_btn.title.text.text = var_0_1:getNowLang("remake")

		for iter_14_1 = 1, self._control.right.evo.evo_info.res.transform.childCount do
			var_0_8(self._evo_res_contents, self._control.right.evo.evo_info.res.transform:GetChild(iter_14_1 - 1).gameObject)
		end

		self:__init_evo()

		self._control.right.skill.skill_left.has_skill_left.need_stren_title.text.text = var_0_1:getNowLang("skillneedstrentitle")
		self._control.right.skill.skill_left.has_skill_left.attrib_1.title.text.text = var_0_1:getNowLang("atk")
		self._control.right.skill.skill_left.has_skill_left.attrib_2.title.text.text = var_0_1:getNowLang("torpedo")
		self._control.right.skill.skill_left.has_skill_left.attrib_3.title.text.text = var_0_1:getNowLang("def")
		self._control.right.skill.skill_left.has_skill_left.attrib_4.title.text.text = var_0_1:getNowLang("airdef")

		self:__init_skill_attrib_contents()

		self._control.right.skill.skill_left.has_skill_left.awake_btn.title.text.text = var_0_1:getNowLang("skillopen")
		self._control.right.skill.skill_left.has_skill_left.upgrade_btn.title.text.text = var_0_1:getNowLang("skillupgrade")
		self._control.right.skill.skill_left.has_skill_left.switch_btn.title.text.text = var_0_1:getNowLang("rsbt2")
		self._control.right.skill.skill_left.no_skill_left.need_stren_title.text.text = var_0_1:getNowLang("skillneedstrentitle")
		self._control.right.skill.skill_left.no_skill_left.attrib_1.title.text.text = var_0_1:getNowLang("atk")
		self._control.right.skill.skill_left.no_skill_left.attrib_2.title.text.text = var_0_1:getNowLang("torpedo")
		self._control.right.skill.skill_left.no_skill_left.attrib_3.title.text.text = var_0_1:getNowLang("def")
		self._control.right.skill.skill_left.no_skill_left.attrib_4.title.text.text = var_0_1:getNowLang("airdef")
		self._control.right.skill.skill_left.no_skill_left.skill_hint.text.text = var_0_1:getNowLang("ui_remakeskillhint")
		self._control.right.skill.has_skill.full_hint.text.text = var_0_1:getNowLang("ui_remakeskillhint")
		self._control.right.skill.no_skill.skill_info.status_title.text.text = var_0_1:getNowLang("status")
		self._control.right.skill.no_skill.skill_info.skill_status.text.text = var_0_1:getNowLang("shiptype98")
		self._control.right.skill.has_skill.skill_info.skill_stage.text.text = var_0_1:getNowLang("shipinfoskillphase")
		self._control.right.skill.has_skill.skill_info.status_title.text.text = var_0_1:getNowLang("status")

		self:__init_skill()
		self:__init_strength_list()

		self._already_init = true
	end

	function arg_1_0:__init_select(arg_15_1)
		if not arg_15_1 then
			return
		end

		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one("strengthen", true)

		self._cur_type = var_0_5.enter_select_member_type.strengthen
		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_16_1, arg_16_2, arg_16_3)
		if self._now_label == arg_16_1 and not arg_16_2 then
			return
		end

		local var_16_0 = var_0_2:getInstance("select_member")

		if var_16_0 then
			var_16_0.content_pos = nil
		end

		if arg_16_1 == "strengthen" then
			self._control.bottom.tip:SetActive(true)

			self._control.bottom.tip.text.text = var_0_1:getNowLang(var_0_4("uihelpinfo_1402_%s", (lan_rand(1, 5))))
		elseif arg_16_1 == "evo" then
			self._control.bottom.tip:SetActive(true)

			self._control.bottom.tip.text.text = var_0_1:getNowLang("uihelpinfo_17_6")
		elseif arg_16_1 == "skill" then
			self._control.bottom.tip:SetActive(true)

			self._control.bottom.tip.text.text = var_0_1:getNowLang("uihelpinfo_skill")
		end

		self._now_label = arg_16_1

		if self._now_content then
			self._last_content = self._now_content

			self:__set_title_style(self._now_content, false)
		end

		self:__set_current_content(arg_16_1)
		self:__set_title_style(self._now_content, true)

		if arg_16_3 then
			self:clear_strengther_res_data()
			self:update_data()

			return
		end

		if self._last_content then
			var_0_5:play_in_out_animation(self._last_content.uITweenSequence, false, function()
				var_0_5:play_in_out_animation(self._now_content.uITweenSequence, true)

				if not arg_16_2 then
					self:set_ship_info()
					self:clear_strengther_res_data()
					self:update_data()
				end
			end)
		else
			var_0_5:play_in_out_animation(self._now_content.uITweenSequence, true)
			self:clear_strengther_res_data()
			self:update_data()
		end

		var_0_2:destroyInstance("select_member")
	end

	function arg_1_0:__set_current_content(arg_18_1)
		if arg_18_1 == var_0_17.strengthen then
			self._now_content = self._control.top.toggle_control.strengthen
		elseif arg_18_1 == var_0_17.evo then
			self._now_content = self._control.top.toggle_control.evo
		elseif arg_18_1 == var_0_17.skill then
			self._now_content = self._control.top.toggle_control.skill
		end
	end

	function arg_1_0.__set_title_style(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_2 then
			arg_19_1.rbtn.text.fontSize = 30
			arg_19_1.rbtn.text.color = Color.New(1, 1, 1)
		else
			arg_19_1.rbtn.text.fontSize = 26
			arg_19_1.rbtn.text.color = Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373)
		end
	end

	function arg_1_0:__updata_res()
		local var_20_0 = var_0_3:get_use_info_data()

		self._control.right.evo.evo_info.res.res_1.self_num.text.text = var_0_7.get_simplify_num(var_20_0.oil)
		self._control.right.evo.evo_info.res.res_2.self_num.text.text = var_0_7.get_simplify_num(var_20_0.bullet)
		self._control.right.evo.evo_info.res.res_3.self_num.text.text = var_0_7.get_simplify_num(var_20_0.fe)
		self._control.right.evo.evo_info.res.res_4.self_num.text.text = var_0_7.get_simplify_num(var_20_0.al)
		self._control.right.evo.evo_info.res.res_1.self_num.text.color = Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)
		self._control.right.evo.evo_info.res.res_2.self_num.text.color = Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)
		self._control.right.evo.evo_info.res.res_3.self_num.text.color = Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)
		self._control.right.evo.evo_info.res.res_4.self_num.text.color = Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)
	end

	function arg_1_0:__init_strengthen_attrib_contents()
		self._strengthen_attrib_contents = {
			atk = self._control.right.strengthen.detail.attrib.attrib_1,
			torpedo = self._control.right.strengthen.detail.attrib.attrib_2,
			def = self._control.right.strengthen.detail.attrib.attrib_3,
			air_def = self._control.right.strengthen.detail.attrib.attrib_4
		}
	end

	function arg_1_0:__init_skill_attrib_contents()
		self._skill_attrib_contents = {
			atk = self._control.right.skill.skill_left.has_skill_left.attrib_1,
			torpedo = self._control.right.skill.skill_left.has_skill_left.attrib_2,
			def = self._control.right.skill.skill_left.has_skill_left.attrib_3,
			air_def = self._control.right.skill.skill_left.has_skill_left.attrib_4
		}
	end

	function arg_1_0:__init_evo()
		for iter_23_0, iter_23_1 in pairs(self._evo_res_contents) do
			iter_23_1.need_num.text.text = "---"
		end

		self._control.right.evo.evo_info.level.text.text = "0/0"

		self._control.right.evo.evo_info.left_part.no_get:SetActive(true)
		self._control.right.evo.evo_info.left_part.have_get:SetActive(false)
		self._control.right.evo.evo_info.left_part.get_skill_1:SetActive(false)
		self._control.right.evo.evo_info.left_part.get_skill_2:SetActive(false)
		self._control.right.evo.evo_info.left_part.no_skill_1:SetActive(true)
		self._control.right.evo.evo_info.left_part.no_skill_2:SetActive(true)
		self._control.right.evo.evo_info.no_info:SetActive(true)
		self._control.right.evo.evo_info.have_info:SetActive(false)
	end

	function arg_1_0:__init_skill()
		self._control.right.skill.skill_left.has_skill_left:SetActive(false)
		self._control.right.skill.skill_left.no_skill_left:SetActive(true)
		self._control.right.skill.has_skill:SetActive(false)
		self._control.right.skill.no_skill:SetActive(true)

		self._can_send_req = true
	end

	function arg_1_0:__show_strengthen_res_ships(arg_25_1, arg_25_2)
		if not arg_25_2 then
			return
		else
			local var_25_0 = var_0_11.find_object_by_cid(arg_25_2.cid)

			var_0_7.little_clone(var_0_11).hp_max = var_0_7:get_ship_attr(arg_25_2, var_25_0).hp

			local var_25_1
			local var_25_2 = var_0_7:use_big_break_painting(arg_25_2, var_0_5.ship_icon_type.model_xm, true)

			var_25_1 = arg_25_2.skin ~= 0 and var_0_5:get_ship_icon(var_25_2, var_0_12.find_object_by_cid(arg_25_2.skin).icon) or var_0_5:get_ship_icon(var_25_2, tostring(var_25_0.pic_id))
			arg_25_1.main_layer.heart.image.sprite = self:loadSprite(var_0_5:get_love_path(arg_25_2))
			arg_25_1.main_layer.icon_layer.icon.image.sprite = self:loadSprite(var_25_1)
			arg_25_1.main_layer.quality.image.sprite = self:loadSprite(var_0_5.ship_quality_s[arg_25_2.star])

			arg_25_1.main_layer.name_layer.name_bg:GetComponent("TextHorizonScroller"):SetText(arg_25_2.name)

			local var_25_3 = var_0_5.ship_hp_slider.ship_hp_l_green

			if arg_25_2.now_hp / var_25_0.hp_max >= 0.25 and arg_25_2.now_hp / var_25_0.hp_max <= 0.5 then
				var_25_3 = var_0_5.ship_hp_slider.ship_hp_l_yellow
			elseif arg_25_2.now_hp / var_25_0.hp_max < 0.25 then
				var_25_3 = var_0_5.ship_hp_slider.ship_hp_l_red
			end

			arg_25_1.main_layer.hp_layer.blood_bar.image.sprite = self:loadSprite(var_25_3)
			arg_25_1.main_layer.hp_layer.blood_bar.image.fillAmount = arg_25_2.now_hp / var_25_0.hp_max
			arg_25_1.main_layer.level_layer.ship_type.text.text = var_0_1:getNowLang(var_0_5:get_ship_type_language_key(var_25_0.type, 1))
			arg_25_1.main_layer.level_layer.country_txt.text.text = var_0_4("(%s)", var_0_1:getNowLang(var_0_5:get_country_language_key(var_25_0.country)))
			arg_25_1.main_layer.level_layer.level.text.text = var_0_4("LV.%d", arg_25_2.level)
			arg_25_1.main_layer.level_layer.level.text.color = arg_25_2.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)

			arg_25_1.main_layer.level_layer.ship_remake:SetActive(var_25_0.evo_class)

			for iter_25_0 = 1, arg_25_1.main_layer.star_layer.transform.childCount do
				if iter_25_0 <= arg_25_2.star then
					arg_25_1.main_layer.star_layer.transform:GetChild(iter_25_0 - 1).gameObject:SetActive(true)
				else
					arg_25_1.main_layer.star_layer.transform:GetChild(iter_25_0 - 1).gameObject:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:__init_strength_list()
		if self._already_init then
			return
		end

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.right.strengthen.scroll.viewport.content.endlessScrollView, self._control.right.strengthen.scroll.viewport.content, "single_dismantle_ship", "remake")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__update_ship_lock(arg_27_1)
		for iter_27_0, iter_27_1 in ipairs(self._strength_res_data) do
			if arg_27_1.id == iter_27_1.id then
				iter_27_1.lock = arg_27_1.lock

				break
			end
		end
	end

	function arg_1_0:__update_reusable_cell()
		self:__has_studying_ship()

		local var_28_0 = self._strength_res_data

		if self._strength_res_data[1] ~= " " then
			var_0_8(self._strength_res_data, 1, " ")
		end

		self:__update_strengthen_info()
		self._reusable_cell:set_data(self._strength_res_data)

		function self._reusable_cell:_set_func(arg_29_1)
			local var_29_0 = arg_29_1 == 0

			self.add_layer:SetActive(arg_29_1 == 0)
			self.main_layer:SetActive(not var_29_0)

			if arg_29_1 ~= 0 then
				self:__show_strengthen_res_ships(self, var_28_0[arg_29_1 + 1])
			end

			self.add_layer.add_btn.button.onClick:RemoveAllListeners()
			self.add_layer.add_btn.button.onClick:AddListener(function()
				self:setVisible(false)
				self:setVisible(true)

				if arg_29_1 == 0 then
					if var_28_0[1] == " " then
						var_0_9(var_28_0, 1)
					end

					local var_30_0 = {}

					for iter_30_0, iter_30_1 in pairs(var_28_0) do
						var_0_8(var_30_0, iter_30_1.id)
					end

					self._canvas_group.blocksRaycasts = false

					var_0_2:createInstance("select_member"):show_by_type(var_0_5.enter_select_member_type.strengthen_res, var_30_0, self._data, nil, nil, nil, function()
						if self._canvas_group then
							self._canvas_group.blocksRaycasts = true
						end
					end)
				end
			end)
			self.main_layer.ship_btn.clickAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.main_layer.ship_btn.clickAndLongClickEvent.onLongClick:AddListener(function()
				self:setVisible(false)

				if var_28_0[1] ~= " " then
					var_0_8(var_28_0, 1, " ")
				end

				var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.remake, var_28_0[arg_29_1 + 1])
			end)

			self.main_layer.cancel_btn.txt.text.text = var_0_1:getNowLang("cancel")

			self.main_layer.cancel_btn.button.onClick:RemoveAllListeners()
			self.main_layer.cancel_btn.button.onClick:AddListener(function()
				var_0_9(var_28_0, arg_29_1 + 1)
				self:__update_reusable_cell()
			end)
		end
	end

	function arg_1_0:reset_strengther_res_data()
		self._strength_res_data = {}

		local var_34_0 = self._data.intensify and var_0_7.little_clone(self._data.intensify) or {}

		for iter_34_0, iter_34_1 in pairs(var_0_3:find_character_by_id(self._data.id).intensify) do
			for iter_34_2, iter_34_3 in pairs(var_34_0) do
				if iter_34_1.attr == iter_34_3.attr and iter_34_1.level == iter_34_3.max_level then
					self:__play_max_animation(iter_34_3.attr, iter_34_3.max_level - iter_34_3.level, iter_34_3.exp)
				end
			end
		end
	end

	function arg_1_0:__play_max_animation(arg_35_1, arg_35_2, arg_35_3)
		self._strengthen_attrib_contents[arg_35_1].have_value.exp.exp_bar.image.fillAmount = arg_35_3 / var_0_11.find_object_by_cid(self._data.cid).strengthen_level_up_exp
		self._strengthen_attrib_contents[arg_35_1].have_value.exp.exp_bar.image.sprite = self:loadSprite(var_0_5.remake_strength_progress.progress)

		local var_35_0 = self:autoKillDOTween(var_0_6.Sequence())

		for iter_35_0 = 1, arg_35_2 do
			var_35_0:Append(self._strengthen_attrib_contents[arg_35_1].have_value.exp.exp_bar.image:DOFillAmount(1, 1 / arg_35_2))
			var_35_0:AppendCallback(function()
				self._strengthen_attrib_contents[arg_35_1].have_value.exp.exp_bar.image.fillAmount = 0
			end)
		end

		var_35_0:AppendCallback(function()
			self._strengthen_attrib_contents[arg_35_1].have_value.exp.exp_bar.image.fillAmount = 1
			self._strengthen_attrib_contents[arg_35_1].have_value.exp.exp_bar.image.sprite = self:loadSprite(var_0_5.remake_strength_progress.progress_p)
		end)
	end

	function arg_1_0:clear_strengther_res_data()
		self._strength_res_data = {}

		self:__update_reusable_cell()
	end

	function arg_1_0:__has_studying_ship()
		self._has_studying = false

		for iter_39_0 = 1, #self._strength_res_data do
			if self._strength_res_data[iter_39_0].all_tactics ~= nil and #self._strength_res_data[iter_39_0].all_tactics > 0 then
				for iter_39_1, iter_39_2 in ipairs(self._strength_res_data[iter_39_0].all_tactics) do
					if iter_39_2.state == var_0_5.stactic_state.study then
						self._has_studying = true

						return
					end
				end
			end
		end
	end

	function arg_1_0:fake_lock()
		self._data.lock = true
		self._control.left.shipinfo.ship.detail.lock_tag.image.sprite = self:loadSprite(var_0_5.ship_lock.ship_lock_l)
	end

	function arg_1_0:__set_ship_info(arg_41_1)
		self._canvas_group.blocksRaycasts = true
		self._data = arg_41_1

		local var_41_0 = self._control.left.shipinfo.ship

		self._cur_show_skill_id = nil

		self:__set_ship_attr()
		self:__update_strength_attribs()

		if self._cur_type == var_0_5.enter_select_member_type.strengthen then
			self:__update_strength_attribs()
		elseif self._cur_type == var_0_5.enter_select_member_type.evo then
			self:__update_evo_info()
		elseif self._cur_type == var_0_5.enter_select_member_type.skill then
			self:__update_skill_info()
		end

		if not arg_41_1 then
			var_41_0:SetActive(false)

			return
		end

		var_41_0:SetActive(true)

		local var_41_1 = var_0_11.find_object_by_cid(self._data.cid)
		local var_41_2 = var_41_1 and var_0_7.little_clone(var_41_1) or {}

		var_41_2.hp_max = var_0_7:get_ship_attr(var_0_3:find_character_by_id(self._data.id), var_41_2).hp

		local var_41_3
		local var_41_4 = var_0_7:use_big_break_painting(self._data, var_0_5.ship_icon_type.model_m, true)

		var_41_3 = self._data.skin ~= 0 and var_0_5:get_ship_icon(var_41_4, var_0_12.find_object_by_cid(self._data.skin).icon) or var_0_5:get_ship_icon(var_41_4, tostring(var_41_2.pic_id))
		self._control.left.shipinfo.ship.up.heart_layer.heart.image.sprite = self:loadSprite(var_0_5:get_love_path(self._data))
		var_41_0.up.icon.image.sprite = self:loadSprite(var_41_3)
		var_41_0.up.quality.image.sprite = self:loadSprite(var_0_4(var_0_5.chef_bg, arg_41_1.star))
		var_41_0.detail.ship_type.text.text = var_0_1:getNowLang(var_0_5:get_ship_type_language_key(var_41_2.type, 1))
		var_41_0.detail.country.text.text = var_0_4("(%s)", var_0_1:getNowLang(var_0_5:get_country_language_key(var_41_2.country)))
		var_41_0.detail.level.text.text = var_0_4("LV.%d", self._data.level)
		var_41_0.detail.level.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
		var_41_0.detail.lock_tag.image.sprite = self._data.lock and self:loadSprite(var_0_5.ship_lock.ship_lock_l) or self:loadSprite(var_0_5.ship_unlock.ship_unlock_l)

		var_41_0.detail.ship_remake:SetActive(var_41_2.evo_class)

		for iter_41_0 = 1, var_41_0.detail.star_layer.transform.childCount do
			if iter_41_0 <= self._data.star then
				var_41_0.detail.star_layer.transform:GetChild(iter_41_0 - 1).gameObject:SetActive(true)
			else
				var_41_0.detail.star_layer.transform:GetChild(iter_41_0 - 1).gameObject:SetActive(false)
			end
		end

		var_41_0.detail.name_layer.name_bg:GetComponent("TextHorizonScroller"):SetText(arg_41_1.name)

		local var_41_6 = var_0_5.ship_hp_slider.ship_hp_l_green

		if arg_41_1.now_hp / var_41_2.hp_max >= 0.25 and arg_41_1.now_hp / var_41_2.hp_max < 0.5 then
			var_41_6 = var_0_5.ship_hp_slider.ship_hp_l_yellow
		elseif arg_41_1.now_hp / var_41_2.hp_max < 0.25 then
			var_41_6 = var_0_5.ship_hp_slider.ship_hp_l_red
		end

		var_41_0.detail.hp_layer.blood_bar.image.sprite = self:loadSprite(var_41_6)
		var_41_0.detail.hp_layer.blood_bar.image.fillAmount = self._data.now_hp / var_41_2.hp_max
		var_41_0.detail.hp_layer.count.text.text = self._data.now_hp .. "/" .. var_41_2.hp_max
	end

	function arg_1_0.__workshop_add(arg_42_0, arg_42_1, arg_42_2)
		for iter_42_0, iter_42_1 in pairs((var_0_3:get_workshop_data())) do
			local var_42_1 = var_0_15.find_object_by_id(iter_42_1.id).effect[1]

			if var_42_1.shipTypes then
				for iter_42_2, iter_42_3 in pairs(var_42_1.shipTypes) do
					if var_42_1.shipTypes[iter_42_2] == arg_42_2.type then
						local var_42_2 = var_0_5:get_attr_name(var_42_1.num4)

						if var_42_1.type == var_0_5.workshop_const.work_type.add_attribute then
							if var_42_1.countrys then
								for iter_42_4, iter_42_5 in pairs(var_42_1.countrys) do
									if iter_42_5 == arg_42_2.country and arg_42_1[var_42_2] then
										arg_42_1[var_42_2] = arg_42_1[var_42_2] + var_42_1.num
									end
								end
							else
								arg_42_1[var_42_2] = arg_42_1[var_42_2] + var_42_1.num
							end
						elseif var_42_1.type == var_0_5.workshop_const.work_type.add_torpedo_damage and arg_42_2[var_42_2] ~= 0 and arg_42_1[var_42_2] then
							arg_42_1[var_42_2] = arg_42_1[var_42_2] + var_42_1.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:__update_strength_attribs()
		for iter_43_0, iter_43_1 in pairs(self._strengthen_attrib_contents) do
			iter_43_1.default:SetActive(not var_43_0)
			iter_43_1.have_value:SetActive(var_43_0)
		end

		if not self._data then
			return
		end

		local var_43_2 = var_0_11.find_object_by_cid(self._data.cid)
		local var_43_3 = var_0_3:get_character_attribute_by_calculate(self._data.id)
		local var_43_4 = var_0_7:get_ship_attr(var_0_3:find_character_by_id(self._data.id), var_43_2)

		for iter_43_2, iter_43_3 in pairs(var_43_4) do
			var_43_4[iter_43_2] = math.floor(iter_43_3)
		end

		for iter_43_4, iter_43_5 in ipairs(var_43_2.strengthen_top) do
			local var_43_5 = self._strengthen_attrib_contents[iter_43_5.name]

			if iter_43_5.value ~= 0 then
				var_43_5.have_value.num.text.text = var_43_4[iter_43_5.name]
			end

			var_43_5.have_value.add_count:SetActive(iter_43_5.value ~= 0)

			if iter_43_5.value ~= 0 then
				var_43_5.have_value.num.text.color = Color.New(0.01568627450980392, 0.6235294117647059, 1)
				var_43_5.have_value.level.text.color = Color.New(0.01568627450980392, 0.6235294117647059, 1)
			else
				var_43_5.have_value.num.text.text = "- -"
				var_43_5.have_value.level.text.text = "Lv.--/--"
				var_43_5.have_value.exp.exp_num.text.text = "EXP  --/--"

				var_43_5.have_value.max:SetActive(false)

				var_43_5.have_value.exp.exp_bar.image.fillAmount = 0
				var_43_5.have_value.num.text.color = Color.New(0.5764705882352941, 0.596078431372549, 0.6039215686274509)
				var_43_5.have_value.level.text.color = Color.New(0.5764705882352941, 0.596078431372549, 0.6039215686274509)
			end

			self._last_ship_attr_exp[iter_43_5.name] = 0

			for iter_43_6, iter_43_7 in pairs(self._data.intensify) do
				if iter_43_5.name == iter_43_7.attr and iter_43_5.value ~= 0 then
					local var_43_6 = iter_43_5.value / var_43_2.strengthen_level_up_exp

					var_43_5.have_value.add_count.text.text = "+ 0"
					var_43_5.have_value.level.text.text = "Lv." .. iter_43_7.exp / var_43_2.strengthen_level_up_exp .. "/" .. var_43_6

					var_43_5.have_value.max:SetActive(iter_43_7.exp / var_43_2.strengthen_level_up_exp == var_43_6)

					if var_43_6 <= iter_43_7.exp / var_43_2.strengthen_level_up_exp then
						var_43_5.have_value.level.text.text = "Lv." .. var_43_6 .. "/" .. var_43_6
						var_43_5.have_value.exp.exp_bar.image.sprite = self:loadSprite(var_0_5.remake_strength_progress.progress_p)
						var_43_5.have_value.exp.exp_bar.image.fillAmount = 1
						var_43_5.have_value.exp.exp_num.text.text = "EXP  --/--"
					else
						local var_43_7 = (iter_43_7.exp - var_43_2.strengthen_level_up_exp * self._ship_attr[iter_43_7.attr].level) % var_43_2.strengthen_level_up_exp

						var_43_5.have_value.exp.exp_bar.image.sprite = self:loadSprite(var_0_5.remake_strength_progress.progress)
						var_43_5.have_value.exp.exp_bar.image.fillAmount = var_43_7 / var_43_2.strengthen_level_up_exp
						var_43_5.have_value.exp.exp_num.text.text = "EXP  " .. var_43_7 .. "/" .. var_43_2.strengthen_level_up_exp
					end

					self._last_ship_attr_exp[iter_43_5.name] = iter_43_7.exp
				end
			end
		end

		self:__update_strengthen_info(true)
	end

	function arg_1_0.__set_work_add(arg_44_0, arg_44_1)
		local var_44_0 = 0

		for iter_44_0, iter_44_1 in pairs((var_0_3:get_workshop_data())) do
			local var_44_1 = var_0_15.find_object_by_id(iter_44_1.id).effect[1]

			if var_44_1.type == var_0_5.workshop_const.work_type.add_intensify_exp and var_44_1.shipTypes then
				for iter_44_2, iter_44_3 in pairs(var_44_1.shipTypes) do
					if var_44_1.shipTypes and arg_44_1 == var_44_1.shipTypes[iter_44_2] then
						var_44_0 = var_44_1.num

						return var_44_1.num
					end
				end
			end
		end

		return var_44_0
	end

	function arg_1_0:__update_strengthen_info(arg_45_1)
		if not self._data then
			return
		end

		local var_45_0 = var_0_16(self._ship_attr)
		local var_45_1 = var_0_11.find_object_by_cid(self._data.cid)

		for iter_45_0 = 2, #self._strength_res_data do
			local var_45_2 = var_0_11.find_object_by_cid(self._strength_res_data[iter_45_0].cid)
			local var_45_3 = self:__set_work_add(var_45_2.type)

			if var_45_2 and var_45_2.strengthen_supply_exp then
				for iter_45_1, iter_45_2 in pairs(var_45_2.strengthen_supply_exp) do
					var_45_0[iter_45_2.name].exp = var_45_0[iter_45_2.name].exp + math.floor(iter_45_2.value + iter_45_2.value * var_45_3 / 100)
				end
			end
		end

		for iter_45_3, iter_45_4 in pairs(var_45_0) do
			local var_45_4 = self._strengthen_attrib_contents[iter_45_4.attr]

			if self:__has_this_attr(iter_45_4.attr) then
				local var_45_5 = iter_45_4.exp
				local var_45_6 = self._ship_attr[iter_45_4.attr].exp
				local var_45_7 = math.floor(iter_45_4.exp / var_45_1.strengthen_level_up_exp)
				local var_45_8 = var_45_0[iter_45_4.attr].max_level

				var_45_7 = var_45_0[iter_45_4.attr].max_level <= var_45_7 and var_45_8 or var_45_7
				var_45_0[iter_45_4.attr].level = var_45_7

				var_45_4.have_value.max:SetActive(var_45_7 == var_45_8)

				if var_45_8 <= var_45_7 then
					var_45_4.have_value.exp.exp_num.text.text = "EXP  --/--"
					var_45_5 = var_45_8 * var_45_1.strengthen_level_up_exp
				else
					var_45_4.have_value.exp.exp_num.text.text = "EXP  " .. var_45_5 % var_45_1.strengthen_level_up_exp .. "/" .. var_45_1.strengthen_level_up_exp
					var_45_4.have_value.exp.exp_bar.image.fillAmount = var_45_5 % var_45_1.strengthen_level_up_exp / var_45_1.strengthen_level_up_exp
				end

				if arg_45_1 then
					local var_45_9 = var_45_5 % var_45_1.strengthen_level_up_exp % var_45_1.strengthen_level_up_exp

					if var_45_5 % var_45_1.strengthen_level_up_exp ~= 0 and var_45_9 == 0 then
						var_45_9 = var_45_1.strengthen_level_up_exp
					end

					if var_45_7 == var_45_8 then
						var_45_9 = var_45_1.strengthen_level_up_exp
					end

					var_45_4.have_value.exp.exp_bar.image.fillAmount = var_45_9 / var_45_1.strengthen_level_up_exp
				else
					var_45_4.have_value.exp.exp_bar.uIFillAmountChangeEffect:SetNum(self._last_ship_attr_exp[iter_45_4.attr], var_45_5, var_45_1.strengthen_level_up_exp)
				end

				var_45_4.have_value.level.text.text = "Lv." .. var_45_7 .. "/" .. var_45_8
				self._last_ship_attr_exp[iter_45_4.attr] = var_45_5
				var_45_4.have_value.add_count.text.text = "+ " .. math.floor(var_45_5 / var_45_1.strengthen_level_up_exp - math.floor(var_45_6 / var_45_1.strengthen_level_up_exp))
			end
		end
	end

	function arg_1_0:__update_evo_info()
		local var_46_0 = (self._data or false) and not not var_0_11.find_object_by_cid(self._data.cid).can_evo
		local var_46_2 = self._control.right.evo.evo_info

		self._control.right.evo.evo_info.have_info:SetActive(nil)
		var_46_2.no_info:SetActive(not var_46_0)
		var_46_2.left_part.no_get:SetActive(not var_46_0)
		var_46_2.left_part.have_get:SetActive(var_46_0)
		var_46_2.left_part.no_skill_1:SetActive(not var_46_0)
		var_46_2.left_part.get_skill_1:SetActive(var_46_0)
		var_46_2.left_part.no_skill_2:SetActive(not var_46_0)
		var_46_2.left_part.get_skill_2:SetActive(var_46_0)

		local var_46_3 = var_0_3:get_use_info_data()

		self:__updata_res()

		if not self._data then
			for iter_46_0, iter_46_1 in pairs(self._evo_res_contents) do
				iter_46_1.need_num.text.text = "---"
			end

			var_46_2.level.text.text = "0/0"

			return
		end

		local var_46_4 = var_0_11.find_object_by_cid(self._data.cid)

		if not var_46_4.can_evo then
			for iter_46_2, iter_46_3 in pairs(self._evo_res_contents) do
				iter_46_3.need_num.text.text = "---"
			end

			var_46_2.level.text.text = "0/0"

			return
		end

		local var_46_5 = var_0_11.find_object_by_cid(var_46_4.evo_to_cid)

		var_46_2.left_part.have_get.ship_name.ship_name_1.text.text = var_46_5.title

		var_46_2.left_part.have_get.ship_name:GetComponent("TextHorizonScroller"):SetText(var_46_5.title)

		var_46_2.left_part.have_get.ship_stage.ship_stage_1.text.text = var_46_5.title_class

		var_46_2.left_part.have_get.ship_stage:GetComponent("TextHorizonScroller"):SetText(var_46_5.title_class)
		var_46_2.left_part.no_skill_1:SetActive(var_46_5.skills[1] == nil)
		var_46_2.left_part.get_skill_1:SetActive(var_46_5.skills[1] ~= nil)
		var_46_2.left_part.no_skill_2:SetActive(var_46_5.skills[2] == nil)
		var_46_2.left_part.get_skill_2:SetActive(var_46_5.skills[2] ~= nil)

		if var_46_5.skills[1] then
			var_46_2.left_part.get_skill_1.skill_name.text.text = var_0_14.find_object_by_skill_type_skill_level(var_46_5.skills[1], self._data.skill_level).title
		end

		if var_46_5.skills[2] then
			var_46_2.left_part.get_skill_2.skill_name.text.text = var_0_14.find_object_by_skill_type_skill_level(var_46_5.skills[2], self._data.skill_level).title
		end

		var_46_2.level.text.text = self._data.level .. "/" .. var_46_4.evo_level
		var_46_2.level.text.color = self._data.level < var_46_4.evo_level and Color.New(0.6470588235294118, 0.6470588235294118, 0.6470588235294118) or Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)

		self:__updata_need_res(var_46_4.evo_need_resource)

		if var_46_4.evo_need_item_cid ~= 0 then
			var_46_2.have_info.icon.image.sprite = self:loadSprite(var_0_4(var_0_5.icon.item_icon, var_46_4.evo_need_item_cid))
		end
	end

	function arg_1_0:__updata_need_res(arg_47_1)
		local var_47_0 = var_0_3:get_use_info_data()
		local var_47_1 = {
			nil,
			0,
			0,
			0,
			[9] = 0,
			[10241] = 0,
			[10441] = 0,
			[10341] = 0,
			[10141] = 0,
			[10541] = 0
		}

		for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
			var_47_1[iter_47_1.id] = iter_47_1.value
		end

		if var_47_1[2] ~= 0 then
			self._evo_res_contents[1].need_num.text.text = var_47_1[2] or "---"
		end

		self._control.right.evo.evo_info.res.res_1.self_num.text.color = var_47_0.oil < var_47_1[2] and Color.New(0.6470588235294118, 0.6470588235294118, 0.6470588235294118) or Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)

		if var_47_1[3] ~= 0 then
			self._evo_res_contents[2].need_num.text.text = var_47_1[3] or "---"
		end

		self._control.right.evo.evo_info.res.res_2.self_num.text.color = var_47_0.bullet < var_47_1[3] and Color.New(0.6470588235294118, 0.6470588235294118, 0.6470588235294118) or Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)

		if var_47_1[4] ~= 0 then
			self._evo_res_contents[3].need_num.text.text = var_47_1[4] or "---"
		end

		self._control.right.evo.evo_info.res.res_3.self_num.text.color = var_47_0.fe < var_47_1[4] and Color.New(0.6470588235294118, 0.6470588235294118, 0.6470588235294118) or Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)

		if var_47_1[9] ~= 0 then
			self._evo_res_contents[4].need_num.text.text = var_47_1[9] or "---"
		end

		self._control.right.evo.evo_info.res.res_4.self_num.text.color = var_47_0.al < var_47_1[9] and Color.New(0.6470588235294118, 0.6470588235294118, 0.6470588235294118) or Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)

		local var_47_6 = self:__need_core(var_47_1)
		local var_47_7 = var_0_3:get_item_count(var_47_6)

		self._control.right.evo.evo_info.have_info.title.text.text = var_0_13.find_object_by_cid(var_47_6).title
		self._control.right.evo.evo_info.have_info.need_num.text.text = var_47_7 .. "/" .. var_47_1[var_47_6]
		self._control.right.evo.evo_info.have_info.need_num.text.color = var_47_7 < var_47_1[var_47_6] and Color.New(0.6470588235294118, 0.6470588235294118, 0.6470588235294118) or Color.New(0.09411764705882353, 0.5450980392156862, 0.9333333333333333)
	end

	function arg_1_0.__need_core(arg_48_0, arg_48_1)
		if arg_48_1[10141] ~= 0 then
			return 10141
		elseif arg_48_1[10241] ~= 0 then
			return 10241
		elseif arg_48_1[10341] ~= 0 then
			return 10341
		elseif arg_48_1[10441] ~= 0 then
			return 10441
		elseif arg_48_1[10541] ~= 0 then
			return 10541
		end

		return false
	end

	function arg_1_0:__update_skill_info()
		local var_49_2 = self._control.right.skill

		self._control.right.skill.has_skill:SetActive((self._data or false) and true)
		var_49_2.no_skill:SetActive(not var_49_0)
		var_49_2.skill_left.no_skill_left:SetActive(not var_49_0)
		var_49_2.skill_left.has_skill_left:SetActive(var_49_0)

		if not self._data then
			return
		end

		self._full_strengthen = true

		for iter_49_0, iter_49_1 in pairs(var_0_11.find_object_by_cid(self._data.cid).strengthen_top) do
			local var_49_3 = self._skill_attrib_contents[iter_49_1.name]

			if iter_49_1.value ~= 0 then
				var_49_3.num.text.color = Color.New(0.07450980392156863, 0.5372549019607843, 0.9058823529411765)
			else
				var_49_3.max:SetActive(false)
				var_49_3.num:SetActive(true)
				var_49_3.progress_bar:SetActive(true)
				var_49_3.progress_full:SetActive(false)

				var_49_3.progress_bar.image.fillAmount = 0
				var_49_3.num.text.text = "--"
				var_49_3.num.text.color = Color.New(0.4549019607843137, 0.47058823529411764, 0.4823529411764706)
			end

			for iter_49_2, iter_49_3 in ipairs(self._data.intensify) do
				if iter_49_1.name == iter_49_3.attr and iter_49_1.value ~= 0 then
					local var_49_4 = iter_49_1.value

					var_49_3.max:SetActive(iter_49_1.value <= iter_49_3.exp)
					var_49_3.num:SetActive(var_49_4 > iter_49_3.exp)
					var_49_3.progress_bar:SetActive(var_49_4 > iter_49_3.exp)
					var_49_3.progress_full:SetActive(var_49_4 <= iter_49_3.exp)

					if var_49_3.num.activeSelf then
						var_49_3.num.text.text = math.floor(iter_49_3.exp * 100 / var_49_4) .. "%"
						var_49_3.num.text.color = Color.New(0.09803921568627451, 0.6196078431372549, 1)
						var_49_3.progress_bar.image.fillAmount = iter_49_3.exp / var_49_4
						self._full_strengthen = false
					end
				end
			end
		end

		local var_49_5

		if self._data.now_skill ~= 0 then
			var_49_5 = self._data.now_skill

			if not self._data.now_skill then
				if self._data.skills[1] ~= 0 then
					var_49_5 = self._data.skills[1] or 0
				end
			end
		end

		local var_49_6 = self._data.now_skill == 0 and self._data.skills[1] ~= 0

		self:__init_skill_up_down_info()
		self:__show_skill_info(var_49_5, var_49_6)

		self._cur_skill_lv = self._data.skill_level

		self:_show_left_or_right_btn()
	end

	function arg_1_0:_show_left_or_right_btn()
		local var_50_0 = var_0_11.find_object_by_cid(self._data.cid)

		if self._cur_skill_lv > var_50_0.max_skill_level then
			self._cur_skill_lv = var_50_0.max_skill_level
		elseif self._cur_skill_lv < 0 then
			self._cur_skill_lv = 0
		end

		if self._cur_skill_lv >= self._data.skill_level + 2 then
			self._control.right.skill.has_skill.skill_info.status_title:SetActive(false)
			self._control.right.skill.has_skill.skill_info.skill_status:SetActive(false)
		else
			self._control.right.skill.has_skill.skill_info.status_title:SetActive(true)
			self._control.right.skill.has_skill.skill_info.skill_status:SetActive(true)
		end

		if self._cur_show_skill_id ~= self._data.now_skill then
			if self._cur_skill_lv ~= self._data.skill_level then
				self._control.right.skill.has_skill.skill_info.status_title:SetActive(false)
				self._control.right.skill.has_skill.skill_info.skill_status:SetActive(false)
			else
				self._control.right.skill.has_skill.skill_info.status_title:SetActive(true)
				self._control.right.skill.has_skill.skill_info.skill_status:SetActive(true)
			end
		end

		local var_50_1 = self._control.right.skill.has_skill.skill_info

		self._control.right.skill.has_skill.skill_info.left_btn:SetActive(self._cur_skill_lv ~= self._data.skill_level)
		var_50_1.right_btn:SetActive(self._cur_skill_lv < var_50_0.max_skill_level)
		var_50_1.next_progress:SetActive(self._cur_skill_lv > self._data.skill_level)

		var_50_1.skill_lv.text.text = "Slv." .. self._cur_skill_lv

		local var_50_2 = self._data.now_skill == 0 and var_0_14.find_object_by_skill_type_skill_level(var_50_0.skill_type, self._cur_skill_lv) or self._cur_show_skill_id ~= nil and var_0_14.find_object_by_skill_type_skill_level(self._cur_show_skill_id, self._cur_skill_lv) or var_0_14.find_object_by_skill_type_skill_level(self._data.now_skill, self._cur_skill_lv)

		if self._cur_skill_lv > self._data.skill_level then
			var_50_1.skill_lv.text.color = Color.New(1, 0.6705882352941176, 0.1568627450980392)
			var_50_1.next_progress.image.sprite = self:loadSprite(var_0_4(var_0_5.remake_skill.skill_orange, self._cur_skill_lv))
			var_50_1.skill_scrollview.content.info_txt.text.text = var_50_2 and var_0_1:getNowLang("shipinfoskilldesc", true) .. (var_0_5.open_broken and var_0_7.convert_rich_text(var_50_2.desc, "FFAB28FF") or var_0_7.convert_rich_text(var_50_2.desc2, "FFAB28FF")) or var_0_1:getNowLang("shipinfoskilldesc", true) .. " "
		else
			var_50_1.skill_lv.text.color = Color.New(0.1568627450980392, 0.7333333333333333, 1)
			var_50_1.skill_scrollview.content.info_txt.text.text = var_50_2 and var_0_1:getNowLang("shipinfoskilldesc", true) .. (var_0_5.open_broken and var_0_7.convert_rich_text(var_50_2.desc) or var_0_7.convert_rich_text(var_50_2.desc2)) or var_0_1:getNowLang("shipinfoskilldesc", true) .. " "
		end
	end

	function arg_1_0:__init_skill_up_down_info()
		local var_51_0 = #self._data.skills

		self._control.right.skill.has_skill.full_hint:SetActive(#self._data.skills <= 1)

		if var_51_0 <= 1 then
			return
		end

		local var_51_1 = self._control.right.skill.has_skill.skill_up
		local var_51_2 = self._control.right.skill.has_skill.skill_down
		local var_51_3 = var_0_14.find_object_by_skill_type_skill_level(self._data.skills[2], self._data.skill_level)

		self._control.right.skill.has_skill.skill_up.skill_name.text.text = var_0_14.find_object_by_skill_type_skill_level(self._data.skills[1], self._data.skill_level).title

		local var_51_4 = var_0_4(var_0_5.skill_icon, self._data.skills[1])
		local var_51_5 = self:findPath(var_51_4) and self:loadSprite(var_51_4) or self:loadSprite(var_0_4(var_0_5.skill_default))
		local var_51_6 = var_0_4(var_0_5.skill_icon, self._data.skills[2])

		var_51_1.skill_icon.image.sprite = var_51_5
		var_51_2.skill_name.text.text = var_51_3.title
		var_51_2.skill_icon.image.sprite = self:findPath(var_51_6) and self:loadSprite(var_51_6) or self:loadSprite(var_0_4(var_0_5.skill_default))

		if self._data.skill_level < var_0_11.find_object_by_cid(self._data.cid).max_skill_level then
			var_51_1.skill_level.text.text = self._data.skills[1] == self._data.now_skill and "Slv." .. self._data.skill_level .. "→" .. "Slv." .. self._data.skill_level + 1 or "Slv." .. self._data.skill_level
			var_51_2.skill_level.text.text = self._data.skills[2] == self._data.now_skill and "Slv." .. self._data.skill_level .. "→" .. "Slv." .. self._data.skill_level + 1 or "Slv." .. self._data.skill_level
		else
			if self._data.skills[1] == self._data.now_skill then
				var_51_1.skill_level.text.text = "Slv." .. self._data.skill_level
				var_51_2.skill_level.text.text = "Slv." .. self._data.skill_level
			end

			if self._data.skills[2] == self._data.now_skill then
				var_51_2.skill_level.text.text = "Slv." .. self._data.skill_level
				var_51_1.skill_level.text.text = "Slv." .. self._data.skill_level
			end
		end

		self:__switch_btn_show_info(self._data.now_skill)
	end

	function arg_1_0:__switch_btn_show_info(arg_52_1)
		if #self._data.skills <= 1 then
			return
		end

		local var_52_0 = var_0_11.find_object_by_cid(self._data.cid)
		local var_52_1 = self._control.right.skill.has_skill.skill_up
		local var_52_2 = self._control.right.skill.has_skill.skill_down

		self._control.right.skill.has_skill.skill_down:SetActive(arg_52_1 == var_52_0.skill_type)
		var_52_1:SetActive(arg_52_1 ~= var_52_0.skill_type)
		self._control.right.skill.has_skill.skill_info.status_title:SetActive(true)
		self._control.right.skill.has_skill.skill_info.skill_status:SetActive(true)

		if var_52_1.activeSelf then
			var_52_1.skill_level.rectTransform.anchoredPosition = Vector2.New(var_52_1.skill_level.rectTransform.sizeDelta.x / 2 + var_52_1.skill_name.textLength:CalculateTextEndX() + 40, var_52_1.skill_level.rectTransform.anchoredPosition.y)
		elseif var_52_2.activeSelf then
			var_52_2.skill_level.rectTransform.anchoredPosition = Vector2.New(var_52_2.skill_level.rectTransform.sizeDelta.x / 2 + var_52_2.skill_name.textLength:CalculateTextEndX() + 40, var_52_2.skill_level.rectTransform.anchoredPosition.y)
		end

		local var_52_3 = self._control.right.skill.has_skill.skill_info

		var_52_3.transform.anchoredPosition = arg_52_1 == var_52_0.skill_type and Vector2.New(var_52_3.transform.anchoredPosition.x, 30.5) or Vector2.New(var_52_3.transform.anchoredPosition.x, -71.5)
		self._cur_show_skill_id = arg_52_1
	end

	function arg_1_0:__show_skill_info(arg_53_1, arg_53_2)
		local var_53_0 = self._control.right.skill
		local var_53_1 = self._control.right.skill.has_skill.skill_info
		local var_53_2 = var_0_11.find_object_by_cid(self._data.cid)
		local var_53_3 = var_0_4(var_0_5.skill_icon, arg_53_1)

		var_53_1.skill_icon.image.sprite = self:findPath(var_53_3) and self:loadSprite(var_53_3) or self:loadSprite(var_0_4(var_0_5.skill_default))

		local var_53_5

		if arg_53_1 == 0 then
			local var_53_6 = var_0_11.find_object_by_cid(self._data.cid)

			if var_53_6.skill_type ~= 0 then
				var_53_5 = var_0_14.find_object_by_skill_type_skill_level(var_53_6.skill_type, self._data.skill_level)
			end
		else
			var_53_5 = var_0_14.find_object_by_skill_type_skill_level(arg_53_1, self._data.skill_level)
		end

		var_53_1.level_progress:SetActive(self._data.skill_level ~= 0)
		var_53_1.left_btn:SetActive(self._cur_skill_lv ~= self._data.skill_level)
		var_53_1.right_btn:SetActive(self._cur_skill_lv < var_53_2.max_skill_level)

		var_53_1.skill_name.text.text = var_53_5.title
		var_53_1.skill_stage.text.text = var_0_1:getNowLang("shipinfoskillphase") .. var_53_5.phase_desc
		var_53_1.skill_scrollview.content.info_txt.text.text = var_0_5.open_broken and var_0_1:getNowLang("shipinfoskilldesc", true) .. var_0_7.convert_rich_text(var_53_5.desc) or var_0_1:getNowLang("shipinfoskilldesc", true) .. var_0_7.convert_rich_text(var_53_5.desc2)

		if self._data.skill_level < var_53_2.max_skill_level then
			var_53_1.skill_level.text.text = (arg_53_1 == self._data.now_skill or arg_53_2) and "Slv." .. self._data.skill_level .. "→" .. "Slv." .. self._data.skill_level + 1 or "Slv." .. self._data.skill_level
			var_53_1.skill_status.text.text = not self._full_strengthen and var_0_1:getNowLang("nofullstrengthen") or var_0_1:getNowLang("canupgrade")
		else
			var_53_1.skill_level.text.text = "Slv." .. self._data.skill_level
			var_53_1.skill_status.text.text = var_0_1:getNowLang("maxlevel")
		end

		if #self._data.skills >= 2 and self._cur_show_skill_id ~= self._data.now_skill then
			var_53_1.skill_status.text.text = not self._full_strengthen and var_0_1:getNowLang("nofullstrengthen") or var_0_1:getNowLang("skill_conversion_state")
		end

		local var_53_8 = var_53_1.skill_level.rectTransform.sizeDelta.x / 2 + var_53_1.skill_name.textLength:CalculateTextEndX() + 40

		var_53_1.skill_level.rectTransform.anchoredPosition = Vector2.New(420, var_53_1.skill_level.rectTransform.anchoredPosition.y)
		var_53_1.skill_lv.text.text = "Slv." .. self._data.skill_level
		var_53_1.skill_lv.text.color = Color.New(0.1568627450980392, 0.7333333333333333, 1)

		var_53_1.next_progress:SetActive(false)
		var_53_1.level_progress:SetActive(self._data.skill_level ~= 0)

		if var_53_1.level_progress.activeSelf then
			var_53_1.level_progress.image.sprite = self:loadSprite(var_0_4(var_0_5.remake_skill.skill_progress, self._data.skill_level))
		end

		var_53_0.skill_left.has_skill_left.switch_btn:SetActive(arg_53_1 ~= self._data.now_skill and not arg_53_2)
		var_53_0.skill_left.has_skill_left.awake_btn:SetActive(arg_53_1 == self._data.now_skill and self._data.skill_level == 0 or arg_53_2)
		var_53_0.skill_left.has_skill_left.upgrade_btn:SetActive(arg_53_1 == self._data.now_skill and self._data.skill_level > 0 and self._data.skill_level < var_53_2.max_skill_level)

		if #self._data.skills <= 1 then
			var_53_0.has_skill.skill_down:SetActive(false)
			var_53_0.has_skill.skill_up:SetActive(false)

			var_53_1.transform.anchoredPosition = Vector2.New(var_53_1.transform.anchoredPosition.x, 30.5)
		end
	end

	function arg_1_0.__check_special_skill(arg_54_0, arg_54_1)
		if var_0_5.special_skill[arg_54_1] then
			return true
		end

		return false
	end

	function arg_1_0:__set_ship_attr()
		if not self._data then
			return
		end

		local var_55_0 = var_0_11.find_object_by_cid(self._data.cid)

		self._no_ship_attr = {}
		self._ship_attr = {}

		for iter_55_0, iter_55_1 in ipairs(var_55_0.strengthen_top) do
			self._ship_attr[iter_55_1.name] = {
				exp = 0,
				level = 0,
				max_level = 0,
				attr = iter_55_1.name
			}

			if iter_55_1.value == 0 then
				var_0_8(self._no_ship_attr, iter_55_1.name)
			end

			for iter_55_2, iter_55_3 in pairs(self._data.intensify) do
				if iter_55_1.name == iter_55_3.attr and iter_55_1.value ~= 0 then
					self._ship_attr[iter_55_3.attr] = iter_55_3
					self._ship_attr[iter_55_3.attr].max_level = iter_55_1.value / var_55_0.strengthen_level_up_exp
				end
			end
		end
	end

	function arg_1_0:__has_this_attr(arg_56_1)
		for iter_56_0, iter_56_1 in ipairs(self._no_ship_attr) do
			if iter_56_1 == arg_56_1 then
				return false
			end
		end

		return true
	end

	function arg_1_0:__set_shipInfo_ship_active()
		self._data = nil
		self._control.left.shipinfo.ship.up.icon.image.sprite = nil

		self._control.left.shipinfo.ship:SetActive(false)
	end

	function arg_1_0.__destroy_panel(arg_58_0)
		var_0_2:destroyInstance("remake")
		var_0_2:destroyInstance("select_member")
		var_0_2:destroyInstance("equip_list")
		var_0_2:destroyInstance("core_list")
		var_0_2:destroyInstance("new_ship_or_equip")
	end

	function arg_1_0:__onReset()
		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self._now_label = nil
		self._cur_type = var_0_5.enter_select_member_type.strengthen
		self._already_init = false

		self:__initialize__strength_res_data()
		self:__init_fixed_value()
		self:__set_shipInfo_ship_active()
	end

	function arg_1_0:__initialize__strength_res_data()
		self._strength_res_data = {}

		if self._reusable_cell then
			self:clear_strengther_res_data()
			self._reusable_cell:update()
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_61_0)
	local var_61_0 = var_0_2:class("remake")

	var_61_0._already_init = false
	var_61_0._last_content = nil
	var_61_0._now_label = nil
	var_61_0._now_content = nil
	var_61_0._strengthen_attrib_contents = {}
	var_61_0._evo_res_contents = {}
	var_61_0._skill_attrib_contents = {}
	var_61_0._reusable_cell = nil
	var_61_0._data = nil
	var_61_0._ship_attr = {}
	var_61_0._no_ship_attr = {}
	var_61_0._last_ship_attr_exp = {}
	var_61_0._strength_res_data = {}
	var_61_0._cur_type = nil
	var_61_0._cur_skill_lv = 0
	var_61_0._full_strengthen = true
	var_61_0._cur_show_skill_id = nil
	var_61_0._enter_type = nil

	return var_61_0
end

return var_0_0
