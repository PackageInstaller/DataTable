local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = string.format
local var_0_5 = gamecore.user
local var_0_6 = gameconfig.skin_config
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.equip_config
local var_0_9 = gameconfig.skill_config
local var_0_10 = gameconfig.ship_level_config
local var_0_11 = gameconfig.tactics_config
local var_0_12 = gameconfig.item_config
local var_0_13 = gameconfig.cook_book_config
local var_0_14 = UnityEngine.Vector2
local var_0_15 = gamecore.prompt
local var_0_16 = gamecore.util_func
local var_0_18 = math.floor
local var_0_19 = gameconfig.sensitive_words_config
local var_0_20 = DG.Tweening.DOTween
local var_0_21 = gameconfig.furniture_config
local var_0_22 = gameconfig.workshop_config
local var_0_24 = UnityEngine.Input
local var_0_25 = UnityEngine.Time
local var_0_26 = gameenum.config_data
local var_0_27 = table.insert
local var_0_28 = UnityEngine.TouchPhase
local var_0_30 = gameconfig.robot_config
local var_0_32 = gameconfig.monster_config
local var_0_33
local var_0_34
local var_0_35
local var_0_36
local var_0_37
local var_0_38
local var_0_39
local var_0_40
local var_0_41
local var_0_42 = 2.5
local var_0_43 = 1
local var_0_44
local var_0_45 = {
	"E",
	"D",
	"C",
	"B",
	"A",
	"S",
	"SS"
}

gamecore.UILoader:define("ship_detail", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
		self:setVisible(true)

		self._enter_type = arg_2_1
		self._now_label = arg_2_5
		self._is_robot = arg_2_3
		self._is_unlock = arg_2_6
		self._is_tactics_panel = arg_2_7

		self:__judge_use_broken()
		self:__init_variate()
		self:__init_languagee()

		self._special_enter_type = var_0_5:get_enter_ship_detail_type()
		self._select_cell = arg_2_4 and arg_2_4 or nil

		self:set_data(arg_2_2 and var_0_16.little_clone(arg_2_2) or {})
		self:__show_by_mall_shop()

		local var_2_0 = var_0_2:getInstance("pre_formation")

		if var_2_0 then
			var_2_0:setVisible(false)
		end

		local var_2_1 = var_0_2:getInstance("enemy_ship_detail")

		if var_2_1 then
			var_2_1:setVisible(false)
		end

		local var_2_2 = var_0_2:getInstance("ninth_awardbox")

		if var_2_2 then
			var_2_2:setVisible(false)
		end

		self:__init_panel()

		self._save_data_to_marry = {
			_enter_type = arg_2_1,
			_data = self._data,
			_is_robot = arg_2_3,
			_select_cell = arg_2_4
		}
		self.is_marry = false
	end

	function arg_1_0:hide()
		self:setVisible(false)
	end

	function arg_1_0:__onUpdate()
		if self._isStart then
			if self._timer > self._aniTotalTime then
				self._timer = 0
				self._isStart = false

				return
			end

			self._timer = self._timer + var_0_25.deltaTime

			self:playAni(self._timer)
		end

		if self._isReverse then
			if self._timer > self._aniTotalTime then
				self._timer = 0
				self._isReverse = false
				self._isSetScaleBeforePlay = false

				return
			end

			self._timer = self._timer + var_0_25.deltaTime

			self:reverseAni(self._timer)
		end

		if self._ui_close_state then
			self:refresh_view_scale()
		end
	end

	function arg_1_0.playViewAni(arg_5_0)
		arg_5_0._isStart = true
		arg_5_0._isReverse = false
		arg_5_0._timer = 0
	end

	function arg_1_0:playReverseAni()
		self._isReverse = true
		self._isStart = false
		self._timer = 0
		self._control.left.ship_role.transform.localScale = self._init_picture_scale
	end

	function arg_1_0:playAni(arg_7_1)
		self._control.left.ship_role.rectTransform.anchoredPosition = var_0_14.Lerp(self._anchoredPosition, self._anchoredPosition + self._offsetVec, arg_7_1 * 3)
		self._control.left.ship_role.transform.localEulerAngles = Vector3.Lerp(Vector3.zero, Vector3(0, 0, 90), arg_7_1 * 3)
	end

	function arg_1_0:reverseAni(arg_8_1)
		self._control.left.ship_role.rectTransform.anchoredPosition = var_0_14.Lerp(self._finalPos, self._anchoredPosition, arg_8_1 * 3)
		self._control.left.ship_role.transform.localEulerAngles = Vector3.Lerp(Vector3(0, 0, 90), Vector3.zero, arg_8_1 * 3)
	end

	function arg_1_0:update_data()
		if not self._is_team then
			self:update_character_data()
			self:set_data(self._data)
		elseif not var_0_44 then
			self:set_data_by_index(self._index)
		else
			self:update_character_data()

			self._now_ship_data = self:__get_ship_cfg(self._data.cid)

			self:set_data_by_index(self._index)
		end

		self:__init_panel()
	end

	function arg_1_0:update_character_data(arg_10_1)
		local var_10_0 = var_0_5:get_other_info()
		local var_10_1 = var_10_0 and var_0_16.little_clone(var_10_0) or {}

		if next(var_10_1) and var_10_1.robot then
			if arg_10_1 and var_10_1.robot and arg_10_1 > 0 then
				local var_10_2 = var_0_30.find_object_by_id(var_10_1.id).npc_formation
				local var_10_3 = var_0_32.find_object_by_id(arg_10_1)

				if var_10_3 and next(var_10_3) then
					self._all_exercise_info = {
						robot = true,
						exercise_id = var_10_3.formation
					}

					local var_10_4 = var_0_32.find_object_by_id(arg_10_1)
					local var_10_5 = lx.clone_table(var_10_4)

					var_10_5.equips = var_10_4.equipment
					var_10_5.equipment_num = #var_10_5.equips
					var_10_5.exercise_info = self._all_exercise_info
					var_10_5.members = {}
					var_10_5.index = self._index
					self._data = lx.clone_table(var_10_5)
				end
			end

			return
		elseif var_10_1 and next(var_10_1) and not var_10_1.robot then
			if arg_10_1 and self._members and next(self._members) then
				local var_10_6 = lx.clone_table(self._members[arg_10_1])

				self._all_exercise_info = {
					robot = false,
					exercise_id = self._members
				}

				local var_10_7 = lx.clone_table(var_0_7.find_object_by_cid(var_10_6.cid))

				var_10_6.lock = false
				var_10_6.name = var_10_7.title
				var_10_6.star = var_10_7.star
				var_10_6.hp = var_10_7.hp
				var_10_6.equipment_num = var_10_7.equipment_num
				var_10_6.exercise_info = self._all_exercise_info
				var_10_6.index = arg_10_1
				self._data = var_10_6
			end

			return
		end

		local var_10_8 = self._data.id

		if arg_10_1 then
			var_10_8 = arg_10_1
		end

		if var_10_8 then
			local var_10_9 = var_0_5:find_character_by_id(var_10_8)

			if var_10_9 and next(var_10_9) then
				self._data = var_0_16.little_clone(var_10_9)
			end
		end
	end

	function arg_1_0:update_lock()
		self._data = lx.clone_table(var_0_5:find_character_by_id(self._data.id))

		if not self._is_team then
			self:update_character_data()
			self:set_data(self._data)
		else
			self:set_data_by_index(self._index)
		end

		if self._data.lock then
			var_0_15:show(var_0_1:getNowLang("errorcode-320"))
		elseif self._is__ship_have_medal == false then
			var_0_15:show(var_0_1:getNowLang("errorcode-321"))
		end

		local var_11_0 = var_0_2:getInstance("remake")

		if var_11_0 and not var_11_0._panel.activeSelf then
			var_11_0:__update_ship_lock(self._data)
			var_11_0:__update_reusable_cell()
		end
	end

	function arg_1_0:update_secretary()
		if not self._is_team then
			self:update_character_data()
			self:set_data(self._data)
		else
			self:set_data_by_index(self._index)
		end

		local var_12_0 = var_0_5:get_secretary_id()

		if self._data.id == var_12_0 and self._control.left.ship_btns.leader_toggle.toggle.isOn then
			var_0_15:show(var_0_1:getNowLang("setsecrataryok"))
		else
			var_0_15:show(var_0_1:getNowLang("resetsecrataryok"))
		end

		self:set_ship_bgm(var_12_0)
	end

	function arg_1_0:set_ship_bgm(arg_13_1)
		local var_13_0 = var_0_5:find_character_by_id(arg_13_1)
		local var_13_1 = var_0_2:createInstance("home")
		local var_13_2 = var_0_5:get_use_info_data()

		if not var_13_0 then
			return
		end

		if self._enter_type == var_0_3.enter_ship_detail_type.fight_team or self._enter_type == var_0_3.enter_ship_detail_type.sixth_select or self._enter_type == var_0_3.enter_ship_detail_type.sixth_fight_prepare or self._enter_type == var_0_3.enter_ship_detail_type.strike_fight_prepare or self._enter_type == var_0_3.enter_ship_detail_type.secretary_info_ship or self._enter_type == var_0_3.enter_ship_detail_type.war_concerto_play or self._enter_type == var_0_3.enter_ship_detail_type.ocean_select or self._enter_type == var_0_3.enter_ship_detail_type.strike_fight_select then
			return
		end

		local var_13_3 = var_13_1._sp_bgm

		if (var_13_0.cid == 10000113 or var_13_0.cid == 11000113) and var_13_0.skin == 1000010251 then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.Hood))

			var_13_1._sp_bgm = true
		elseif (var_13_0.cid == 10000613 or var_13_0.cid == 11000613) and var_13_0.skin == 1000060151 then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.Bismarck))

			var_13_1._sp_bgm = true
		elseif (var_13_0.cid == 10022413 or var_13_0.cid == 11022413) and var_13_0.skin == 1002240151 then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.formidable))

			var_13_1._sp_bgm = true
		elseif (var_13_0.cid == 10022313 or var_13_0.cid == 11022313) and var_13_0.skin == 1002230151 then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.shinano))

			var_13_1._sp_bgm = true
		elseif var_13_3 then
			var_13_1:_bgm_play()

			var_13_1._sp_bgm = false
		end
	end

	function arg_1_0:change_skin()
		self._control.left.ship_btns.dress_toggle.toggle.isOn = false

		self:update_data()
	end

	function arg_1_0:reset_current_panel(arg_15_1)
		if self._is_mall_change_init then
			self:setVisible(arg_15_1)
		else
			var_0_2:getInstance("mall_shop"):setVisible(arg_15_1)
		end
	end

	function arg_1_0:play_in_out_animation(arg_16_1, arg_16_2, arg_16_3)
		arg_16_3 = arg_16_3 or self._control.bg.uITweenSequence

		if arg_16_1 then
			arg_16_3:Play(function()
				if arg_16_2 then
					arg_16_2()
				end
			end)
		else
			arg_16_3:PlayReverse(function()
				if arg_16_2 then
					arg_16_2()
				end
			end)
		end
	end

	function arg_1_0:set_data(arg_19_1)
		self._is_marry = arg_19_1.marry
		self._is_single = self._enter_type == var_0_3.enter_ship_detail_type.single_ship or self._enter_type == var_0_3.enter_ship_detail_type.remake or self._enter_type == var_0_3.enter_ship_detail_type.dock or self._enter_type == var_0_3.enter_ship_detail_type.sixth_select
		self._is_team = self._enter_type == var_0_3.enter_ship_detail_type.dock_team or self._enter_type == var_0_3.enter_ship_detail_type.fight_team or self._enter_type == var_0_3.enter_ship_detail_type.pre_formation or self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip or self._enter_type == var_0_3.enter_ship_detail_type.sixth_fight_prepare or self._enter_type == var_0_3.enter_ship_detail_type.strike_fight_prepare or self._enter_type == var_0_3.enter_ship_detail_type.secretary_info_ship or self._enter_type == var_0_3.enter_ship_detail_type.abyss_fight_prepare

		if self._is_single then
			self._data = arg_19_1
			self._now_ship_data = self:__get_ship_cfg(arg_19_1.cid)
			self._now_character_data = arg_19_1

			if self._special_enter_type and self._special_enter_type == var_0_3.enter_ship_detail_type.captainroom_fleet then
				if arg_19_1.exercise_info and arg_19_1.exercise_info then
					self._is_team = true
					self._members = {}
					self._index = arg_19_1.index
					self._members = arg_19_1.exercise_info.exercise_id
				elseif self._enter_type then
					self._is_team = true
					self._members = var_0_16.little_clone((var_0_5:get_captainroom_garrison()))
				end
			elseif self._special_enter_type and self._special_enter_type == var_0_3.enter_ship_detail_type.robot_ship then
				if arg_19_1.exercise_info and arg_19_1.exercise_info then
					self._is_team = true
					self._members = {}
					self._index = arg_19_1.index
					self._members = arg_19_1.exercise_info.exercise_id
				end
			elseif self._special_enter_type and (self._special_enter_type == var_0_3.enter_ship_detail_type.show_room or self._special_enter_type == var_0_3.enter_ship_detail_type.captainroom_friend_fleet) then
				if arg_19_1.exercise_info and arg_19_1.exercise_info then
					self._is_team = true
					self._members = {}
					self._index = arg_19_1.index
					self._members = arg_19_1.exercise_info
				end
			else
				local var_19_0 = var_0_2:getInstance("captainroom_fleet")

				if var_19_0 and not var_0_2:getInstance("select_member") then
					if self._enter_type == var_0_3.enter_ship_detail_type.single_ship then
						self._is_team = true
						self._members = var_0_16.little_clone(var_19_0._enter_team)
					end
				elseif self._enter_type == var_0_3.enter_ship_detail_type.single_ship or self._enter_type == var_0_3.enter_ship_detail_type.sixth_select or self._enter_type == var_0_3.enter_ship_detail_type.dock then
					self._is_team = true

					local var_19_1 = var_0_5:get_all_select_member_list()

					self._members = var_0_16.little_clone((self._is_tactics_panel or nil) and var_0_5:get_tactics_all_select_member_list())
				end
			end
		elseif self._is_team then
			self._index = arg_19_1.index

			if arg_19_1.toggle_type then
				self._toggle_type = arg_19_1.toggle_type
			end

			local var_19_2 = true

			if self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip or self._enter_type == var_0_3.enter_ship_detail_type.dock_team then
				local var_19_3 = var_0_2:getInstance("dock_team")
				local var_19_4 = var_0_2:getInstance("fight_prepare")

				if var_19_3 then
					local var_19_5 = var_19_3:get_current_team_index()

					if not var_19_5 or var_19_5 == 0 or var_19_5 == 5 then
						var_19_2 = false
						var_0_44 = true
					end
				elseif var_19_4 then
					local var_19_6 = var_19_4:get_current_team_index()

					if not var_19_6 or var_19_6 == 0 or var_19_6 == 5 then
						var_19_2 = false
						var_0_44 = true
					end
				end
			end

			if arg_19_1.team_data then
				if arg_19_1.team_data.members and #arg_19_1.team_data.members > 0 and var_19_2 then
					self._members = arg_19_1.team_data.members

					if self._enter_type ~= var_0_3.enter_ship_detail_type.secretary_info_ship then
						self._team_id = arg_19_1.team_data.id
					end
				else
					self._data = arg_19_1.team_data
					self._members = {}
					self._now_ship_data = self:__get_ship_cfg(self._data.cid)
					self._team_id = 1
					self._now_character_data = arg_19_1.team_data
				end
			end

			if self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip then
				self._is_team = true

				local var_19_7 = var_0_5:get_all_select_member_list()

				self._members = var_19_7 and next(var_19_7) and var_0_16.little_clone(var_19_7) or arg_19_1.team_data.members
			end

			self:set_data_by_index(self._index)
		else
			self._now_ship_data = arg_19_1
			self._now_character_data = arg_19_1
		end

		self._now_skin_data = var_0_5:get_skin_list()
	end

	function arg_1_0:set_data_by_index(arg_20_1)
		if #self._members == 0 or not self._members[arg_20_1] then
			return
		end

		local var_20_0 = var_0_5:get_other_info()

		if var_20_0 and next(var_20_0) and not var_20_0.robot then
			self:update_character_data(arg_20_1)
		else
			self:update_character_data(self._members[arg_20_1])
		end

		self._is_marry = self._data.marry
		self._now_ship_data = self:__get_ship_cfg(self._data.cid)
		self._now_character_data = self._data
	end

	function arg_1_0:show_ship_icon(arg_21_1, arg_21_2)
		self._save_now_pic = arg_21_1
		self._control.left.ship_role.transform.localScale = Vector3.New(1, 1, 1)

		local var_21_0 = self._now_skin_page and self._now_skin_page == 2 and var_0_16:use_big_break_painting(self._now_character_data, var_0_3.ship_icon_type.model_l, not self._is_open_broken) or var_0_16:use_big_break_painting(self._now_character_data, var_0_3.ship_icon_type.model_l, self._is_open_broken)
		local var_21_1, var_21_2 = self:loadSprite(var_0_3:get_ship_icon(var_21_0, arg_21_1))

		self._control.left.ship_role.image.sprite = var_21_1

		if var_21_2 then
			var_0_3:hd_sprite_half_scale(self._control.left.ship_role.transform)

			self._is_picture_hd = true
			self._init_scale = 0.5
		else
			self._is_picture_hd = false
			self._init_scale = 1
		end

		self._normal_paint_url = var_0_3:get_ship_icon(var_21_0, arg_21_1)
		self._fight_normal_url = var_0_3:get_ship_icon(var_0_16:use_big_break_painting(self._now_character_data, var_0_3.ship_icon_type.model_l, true), arg_21_1)
	end

	function arg_1_0.reset_all_panel(arg_22_0)
		var_0_33:SetActive(false)
		var_0_34:SetActive(false)
		var_0_35:SetActive(false)
		var_0_36:SetActive(false)
		var_0_37:SetActive(false)
	end

	function arg_1_0.set_level(arg_23_0, arg_23_1)
		for iter_23_0 = 1, var_0_34.star_layer.transform.childCount do
			if iter_23_0 <= arg_23_1 then
				var_0_34.star_layer.transform:GetChild(iter_23_0 - 1).gameObject:SetActive(true)
			else
				var_0_34.star_layer.transform:GetChild(iter_23_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:word_is_conform()
		local var_24_0 = app:getSystem():getChannel()

		if var_24_0 ~= var_0_3.channel.android_xiaomi and var_24_0 ~= var_0_3.channel.android_yyb then
			return
		end

		if self._special_enter_type then
			return
		end

		local var_24_2

		if not self:__check_illegal_string(self._data.name) then
			var_24_2 = self._data.cid and var_0_7.find_object_by_cid(self._data.cid).title or "001"

			var_0_5:req_ShipRename({
				id = self._data.id,
				name = var_24_2
			})
		end
	end

	function arg_1_0:init_ship_info()
		var_0_34.name_txt:GetComponent("TextHorizonScroller"):SetText(self._now_ship_data.title)

		var_0_34.country_txt.text.text = var_0_1:getNowLang(var_0_3:get_country_language_key(self._now_ship_data.country))

		self:set_level(self._now_ship_data.star)

		var_0_36.ship_layer_ship_id.text.text = "NO." .. self._now_ship_data.pic_id
		var_0_36.ship_type.text.text = var_0_1:getNowLang(var_0_3:get_ship_type_language_key(self._now_ship_data.type, 1))

		if self._now_ship_data then
			var_0_36.ship_name_mask:GetComponent("TextHorizonScroller"):SetText(self._now_ship_data.class_no)
		else
			var_0_36.ship_name_mask.ship_name.text.text = self._now_ship_data.class_no
			var_0_36.ship_name_mask.ship_name_move.text.text = self._now_ship_data.class_no
		end

		var_0_36.scrollview.content.info_txt.text.text = self._now_ship_data.desc

		self:set_ship_attr(self._now_ship_data)

		local var_25_0 = {}

		if #self._now_ship_data.skins > 0 then
			for iter_25_0, iter_25_1 in pairs(self._now_ship_data.skins) do
				var_0_27(var_25_0, iter_25_1)
			end

			for iter_25_2, iter_25_3 in ipairs(var_25_0) do
				if not self._now_ship_data.evo_class and (iter_25_3 - 1000000000) % 10000 % 1000 / 100 < 0.9 then
					table.remove(var_25_0, iter_25_2)
				end
			end
		end

		var_0_33.clothes_btn:SetActive(#var_25_0 > 0)
		self._control.left.alone_view_btn:SetActive(true)
		var_0_36.display_bg.ship_girl:SetActive(true)
		self:__ship_map_ship_girl(self._now_ship_data)
	end

	function arg_1_0:init_ship_detail_info()
		self:__set_left_ship_detail()

		if self._now_ship_data then
			var_0_40.ship_title.ship_id.text.text = "NO." .. self._now_ship_data.pic_id
			var_0_40.ship_title.ship_level.text.text = "Lv." .. self._data.level
			var_0_40.ship_title.ship_level.text.color = self._data.level == 110 and Color.New(0.9137254901960784, 0.9137254901960784, 0.03529411764705882) or Color.New(1, 1, 1)
			var_0_40.ship_title.ship_name.text.text = self._data.name
			self._default_name = self._data.name

			var_0_40.ship_title.ship_name_move:GetComponent("TextHorizonScroller"):SetText(self._data.name)

			if self._data.level < self._now_ship_data.max_level then
				local var_26_0 = var_0_10.find_object_by_level(self._data.level).exp

				var_0_40.ship_title.exp_num.text.text = self._data.exp .. "/" .. var_26_0
				var_0_40.ship_title.ship_exp.exp_bar.image.fillAmount = self._data.exp / var_26_0
			else
				var_0_40.ship_title.ship_exp.exp_bar.image.fillAmount = 1
				var_0_40.ship_title.exp_num.text.text = "MAX"
			end
		else
			var_0_40.ship_title.ship_id.text.text = "NO.0"
			var_0_40.ship_title.ship_level.text.text = "Lv." .. self._data.level
			var_0_40.ship_title.ship_level.text.color = self._data.level == 110 and Color.New(0.9137254901960784, 0.9137254901960784, 0.03529411764705882) or Color.New(1, 1, 1)
			var_0_40.ship_title.ship_name.text.text = self._data.title
			var_0_40.ship_title.ship_name_move.ship_name.text.text = self._data.title
			var_0_40.ship_title.exp_num.text.text = "MAX"
			var_0_40.ship_title.ship_exp.exp_bar.image.fillAmount = 1
		end

		if self._special_enter_type == var_0_3.enter_ship_detail_type.robot_ship and self._data.level < 110 then
			var_0_40.ship_title.exp_num.text.text = "0/0"
			var_0_40.ship_title.ship_exp.exp_bar.image.fillAmount = 0
		end

		self._is_my_ship = var_0_5:get_other_info()

		if self:__is_special_type(2) and self._is_my_ship then
			self:__set_ship_detail_for_friend(var_0_40.detail_info.detail)
		else
			self:__set_ship_detail(var_0_40.detail_info.detail)
		end

		local var_26_1 = var_0_40.detail_info.detail.ship_skill

		var_0_40.detail_info.detail.ship_skill:SetActive(self._data.now_skill ~= 0)

		local var_26_3 = not self._data.now_skill and var_0_9.find_object_by_skill_id(self._data.skill_id) or var_0_9.find_object_by_skill_type_skill_level(self._data.now_skill, self._data.skill_level)

		if self._data.now_skill and self._data.now_skill == 0 or not var_26_3 then
			local var_26_4 = var_0_7.find_object_by_cid(self._data.cid)

			if var_26_4 and var_26_4.skill_type ~= 0 then
				var_26_1:SetActive(true)

				var_26_3 = var_0_9.find_object_by_skill_type_skill_level(var_26_4.skill_type, self._data.skill_level)
				var_0_40.detail_info.detail.skill_name.text.text.text = var_26_3.title

				if var_0_40.detail_info.detail.skill_name.textHorizonScroller then
					var_0_40.detail_info.detail.skill_name.textHorizonScroller:SetText(var_26_3.title)
				end

				var_26_1.skill_level.text.text = "Slv:" .. (self._data.skill_level or 1)
				var_26_1.skill_stage.text.text = var_0_1:getNowLang("shipinfoskillphase")
				var_26_1.skill_phase.skill_phase_1.text.text = var_26_3.phase_desc

				var_26_1.skill_phase:GetComponent("TextHorizonScroller"):SetText(var_26_3.phase_desc)

				if var_0_3.open_broken then
					var_26_1.scrollview.content.skill_desc.text.text = var_0_16.convert_rich_text(var_26_3.desc)

					self:__long_skill_dese_show(var_26_1, var_0_16.convert_rich_text(var_26_3.desc))
				else
					var_26_1.scrollview.content.skill_desc.text.text = var_0_16.convert_rich_text(var_26_3.desc2)

					self:__long_skill_dese_show(var_26_1, var_0_16.convert_rich_text(var_26_3.desc2))
				end

				var_26_1.scrollview.content.skill_desc.skill_desc_2:SetActive(false)
			else
				var_0_40.detail_info.detail.skill_name.text.text.text = var_0_1:getNowLang("noskill")

				if var_0_40.detail_info.detail.skill_name.textHorizonScroller then
					var_0_40.detail_info.detail.skill_name.textHorizonScroller:SetText(var_0_1:getNowLang("noskill"))
				end

				var_26_1.skill_level.text.text = ""
				var_26_1.skill_stage.text.text = ""
				var_26_1.skill_phase.skill_phase_1.text.text = ""
				var_26_1.scrollview.content.skill_desc.text.text = ""

				var_26_1.scrollview.content.skill_desc.skill_desc_2:SetActive(false)
			end
		else
			var_0_40.detail_info.detail.skill_name.text.text.text = var_26_3.title

			if var_0_40.detail_info.detail.skill_name.textHorizonScroller then
				var_0_40.detail_info.detail.skill_name.textHorizonScroller:SetText(var_26_3.title)
			end

			var_26_1.skill_level.text.text = "Slv:" .. (self._data.skill_level or 1)
			var_26_1.skill_stage.text.text = var_0_1:getNowLang("shipinfoskillphase")
			var_26_1.skill_phase.skill_phase_1.text.text = var_26_3.phase_desc

			var_26_1.skill_phase:GetComponent("TextHorizonScroller"):SetText(var_26_3.phase_desc)

			if var_0_3.open_broken then
				var_26_1.scrollview.content.skill_desc.text.text = var_0_16.convert_rich_text(var_26_3.desc)

				self:__long_skill_dese_show(var_26_1, var_0_16.convert_rich_text(var_26_3.desc))
			else
				var_26_1.scrollview.content.skill_desc.text.text = var_0_16.convert_rich_text(var_26_3.desc2)

				self:__long_skill_dese_show(var_26_1, var_0_16.convert_rich_text(var_26_3.desc2))
			end

			var_26_1.scrollview.content.skill_desc.skill_desc_2:SetActive(false)
		end
	end

	function arg_1_0.__long_skill_dese_show(arg_27_0, arg_27_1, arg_27_2)
		if UnityEngine.Screen.width / UnityEngine.Screen.height < 1.4 then
			arg_27_1.scrollview:SetActive(false)
			arg_27_1.long_scrollview:SetActive(true)

			arg_27_1.long_scrollview.long_content.long_skill_desc.text.text = arg_27_2
		end
	end

	function arg_1_0:init_ship_equip_detail_info()
		self:__set_left_ship_detail()

		var_0_41.ship_equip_detail_content.ship_equip.ship_id.text.text = "NO." .. self._now_ship_data.pic_id
		var_0_41.ship_equip_detail_content.ship_equip.ship_name.text.text = self._data.name
		var_0_41.ship_equip_detail_content.ship_equip.ship_type.text.text = self._now_ship_data.class_no

		self:__set_ship_detail(var_0_41.ship_equip_detail_content.detail_2)
	end

	function arg_1_0.set_ship_attr(arg_29_0, arg_29_1)
		var_0_36.detail_item_1.level_txt.text.text = var_0_45[arg_29_1.show_attribute[1]]
		var_0_36.detail_item_2.level_txt.text.text = var_0_45[arg_29_1.show_attribute[2]]
		var_0_36.detail_item_3.level_txt.text.text = var_0_45[arg_29_1.show_attribute[3]]
		var_0_36.detail_item_4.level_txt.text.text = var_0_45[arg_29_1.show_attribute[5]]
		var_0_36.detail_item_5.level_txt.text.text = var_0_45[arg_29_1.show_attribute[6]]
		var_0_36.detail_item_6.level_txt.text.text = var_0_45[arg_29_1.show_attribute[4]]
	end

	function arg_1_0:__workshop_add(arg_30_1)
		local var_30_0 = var_0_7.find_object_by_cid(self._data.cid)

		for iter_30_0, iter_30_1 in pairs((var_0_5:get_workshop_data())) do
			local var_30_1 = var_0_22.find_object_by_id(iter_30_1.id).effect[1]

			if var_30_1.shipTypes then
				for iter_30_2, iter_30_3 in pairs(var_30_1.shipTypes) do
					if var_30_1.shipTypes and var_30_1.shipTypes[iter_30_2] == var_30_0.type then
						local var_30_2 = var_0_3:get_attr_name(var_30_1.num4)

						if var_30_1.type == var_0_3.workshop_const.work_type.add_attribute then
							if var_30_1.countrys then
								for iter_30_4, iter_30_5 in pairs(var_30_1.countrys) do
									if iter_30_5 == var_30_0.country and arg_30_1[var_30_2] then
										arg_30_1[var_30_2] = arg_30_1[var_30_2] + var_30_1.num
									end
								end
							else
								arg_30_1[var_30_2] = arg_30_1[var_30_2] + var_30_1.num
							end
						elseif var_30_1.type == var_0_3.workshop_const.work_type.add_torpedo_damage and var_30_0[var_30_2] ~= 0 and arg_30_1[var_30_2] then
							arg_30_1[var_30_2] = arg_30_1[var_30_2] + var_30_1.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:__workshop_add_friends(arg_31_1)
		local var_31_0 = self._now_ship_data

		for iter_31_0, iter_31_1 in pairs(var_0_5:get_other_info().workshop_buff or {}) do
			local var_31_1 = var_0_22.find_object_by_id(iter_31_1).effect[1]

			if var_31_1.shipTypes then
				for iter_31_2, iter_31_3 in pairs(var_31_1.shipTypes) do
					if var_31_1.shipTypes and var_31_1.shipTypes[iter_31_2] == var_31_0.type then
						local var_31_2 = var_0_3:get_attr_name(var_31_1.num4)

						if var_31_1.type == var_0_3.workshop_const.work_type.add_attribute then
							if var_31_1.countrys then
								for iter_31_4, iter_31_5 in pairs(var_31_1.countrys) do
									if iter_31_5 == var_31_0.country and arg_31_1[var_31_2] then
										arg_31_1[var_31_2] = arg_31_1[var_31_2] + var_31_1.num
									end
								end
							end
						elseif var_31_1.type == var_0_3.workshop_const.work_type.add_torpedo_damage and var_31_0[var_31_2] ~= 0 and arg_31_1[var_31_2] then
							arg_31_1[var_31_2] = arg_31_1[var_31_2] + var_31_1.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:__special_equip_add(arg_32_1, arg_32_2)
		if next(arg_32_2) then
			for iter_32_0, iter_32_1 in pairs(arg_32_2) do
				if next(iter_32_1.exclusive_cid) then
					for iter_32_2, iter_32_3 in pairs(iter_32_1.exclusive_cid) do
						if self._data and iter_32_3 == self._data.cid then
							for iter_32_4, iter_32_5 in pairs(iter_32_1.exclusive_buff) do
								if iter_32_5.type == 1 then
									local var_32_0 = var_0_3:get_attr_name(iter_32_5.num4)

									if arg_32_1[var_32_0] then
										arg_32_1[var_32_0] = arg_32_1[var_32_0] + iter_32_5.num
									end
								end
							end
						end
					end
				elseif next(iter_32_1.exclusive_buff) then
					for iter_32_6, iter_32_7 in pairs(iter_32_1.exclusive_buff) do
						if iter_32_7.type == 1 then
							local var_32_1 = var_0_3:get_attr_name(iter_32_7.num4)

							if arg_32_1[var_32_1] then
								arg_32_1[var_32_1] = arg_32_1[var_32_1] + iter_32_7.num
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:__special_equip_friends_add(arg_33_1, arg_33_2)
		if next(arg_33_2) then
			for iter_33_0, iter_33_1 in pairs(arg_33_2) do
				if next(iter_33_1.exclusive_cid) then
					for iter_33_2, iter_33_3 in pairs(iter_33_1.exclusive_cid) do
						if self._data and iter_33_3 == self._data.cid then
							for iter_33_4, iter_33_5 in pairs(iter_33_1.exclusive_buff) do
								if iter_33_5.type == 1 then
									local var_33_0 = var_0_3:get_attr_name(iter_33_5.num4)

									if arg_33_1[var_33_0] then
										arg_33_1[var_33_0] = arg_33_1[var_33_0] + iter_33_5.num
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0.__match_collection_ship_type(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_1 == nil or arg_34_1 == 0 then
			return true
		end

		if type(arg_34_1) == "table" then
			if not next(arg_34_1) then
				return true
			end

			for iter_34_0, iter_34_1 in pairs(arg_34_1) do
				if iter_34_1 == 0 or iter_34_1 == arg_34_2 then
					return true
				end
			end

			return false
		end

		return arg_34_1 == arg_34_2
	end

	function arg_1_0:__add_collections(arg_35_1)
		local var_35_0 = self._now_ship_data

		for iter_35_0, iter_35_1 in pairs(var_0_5:get_other_info().collection_buff or {}) do
			local var_35_1 = var_0_12.find_object_by_cid(iter_35_1)

			if var_35_1 then
				if self:__match_collection_ship_type(var_35_1.buff_effect.ship_type, var_35_0.type) and (var_35_1.buff_effect.country == 0 or var_35_1.buff_effect.country == var_35_0.country) and arg_35_1[var_35_1.buff_effect.attr] then
					arg_35_1[var_35_1.buff_effect.attr] = arg_35_1[var_35_1.buff_effect.attr] + var_35_1.buff_effect.val

					if self._detail_attr_content[var_35_1.buff_effect.attr] then
						self._detail_attr_content[var_35_1.buff_effect.attr].tip_icon:SetActive(true)
						self._detail_attr_content[var_35_1.buff_effect.attr].attr_bg:SetActive(true)

						self._detail_attr_content[var_35_1.buff_effect.attr].attr_num.text.color = Color.New(1, 1, 1)
					end
				end
			end
		end
	end

	function arg_1_0:__set_ship_detail(arg_36_1)
		arg_36_1.attr_capacity.attr_num.text.text = self._data.capacity or 0
		arg_36_1.attr_speed.attr_num.text.text = self._data.speed

		local var_36_0
		local var_36_1
		local var_36_2
		local var_36_3 = {}

		if not self._now_ship_data then
			for iter_36_0, iter_36_1 in pairs(self._data.equips) do
				var_36_2 = var_0_8.find_object_by_cid(iter_36_1)
			end

			var_36_0 = self._data
		else
			var_36_2 = var_0_5:get_attribute_effect_by_equip(self._data.id)
			var_36_0 = var_0_5:get_character_attribute_by_calculate(self._data.id)
			var_36_1 = var_0_5:get_character_attribute_by_calculate_no_equips(self._data.id)
		end

		for iter_36_2, iter_36_3 in pairs(self._data.equips) do
			var_0_27(var_36_3, type(iter_36_3) ~= "number" and var_0_8.find_object_by_cid(iter_36_3.id) or var_0_8.find_object_by_cid(iter_36_3))
		end

		local var_36_5 = {}

		if var_36_2 then
			for iter_36_4, iter_36_5 in pairs(var_36_2) do
				if self._detail_attr_content[iter_36_4] then
					local var_36_6 = iter_36_5 ~= 0 and iter_36_4 ~= "range"

					self._detail_attr_content[iter_36_4].tip_icon:SetActive(iter_36_5 ~= 0 and iter_36_4 ~= "range")
					self._detail_attr_content[iter_36_4].attr_bg:SetActive(var_36_6)

					self._detail_attr_content[iter_36_4].attr_num.text.color = var_36_6 and Color.New(1, 1, 1) or Color.New(0.23529411764705882, 0.6196078431372549, 1)

					if iter_36_5 > 0 and iter_36_4 ~= "range" then
						self._detail_attr_content[iter_36_4].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_up)
						self._detail_attr_content[iter_36_4].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_blud)
					elseif iter_36_5 < 0 and iter_36_4 ~= "range" then
						self._detail_attr_content[iter_36_4].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_down)
						self._detail_attr_content[iter_36_4].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_red)
						var_36_5[iter_36_4] = iter_36_5
					end
				end
			end
		end

		if var_0_7.find_object_by_cid(self._data.cid) == nil then
			for iter_36_6, iter_36_7 in pairs(self._data.equipment) do
				local var_36_8 = var_0_8.find_object_by_cid(iter_36_7)

				if var_36_8 then
					for iter_36_8, iter_36_9 in pairs(var_0_3.equip_attribute) do
						var_36_8[iter_36_9] = var_36_8[iter_36_9] or 0
						var_36_0[iter_36_9] = var_36_0[iter_36_9] or 0

						if iter_36_9 == "range" then
							if var_36_8[iter_36_9] > var_36_0[iter_36_9] then
								var_36_0[iter_36_9] = var_36_8[iter_36_9] or var_36_0[iter_36_9]
							end
						else
							var_36_0[iter_36_9] = var_36_0[iter_36_9] + var_36_8[iter_36_9]
						end
					end
				end
			end

			for iter_36_10, iter_36_11 in pairs(var_36_0) do
				if self._detail_attr_content[iter_36_10] then
					if iter_36_10 == "speed" then
						local var_36_10 = self._detail_attr_content[iter_36_10].attr_bg.rectTransform.sizeDelta
						local var_36_11

						self._detail_attr_content[iter_36_10].attr_num.text.text, var_36_11 = var_0_16.convert_resert_decimals(iter_36_11)
						self._detail_attr_content[iter_36_10].attr_num.text.text = self._detail_attr_content[iter_36_10].attr_num.text.text .. var_0_1:getNowLang("speedtext")
						var_36_10 = var_36_11 > 0 and var_0_14(78, var_36_10.y) or var_0_14(55, var_36_10.y)
						self._detail_attr_content[iter_36_10].attr_bg.rectTransform.sizeDelta = var_36_10
					else
						self._detail_attr_content[iter_36_10].attr_num.text.text = var_0_18(tonumber(iter_36_11))
					end

					if iter_36_10 == "range" then
						iter_36_11 = math.floor(iter_36_11) > 4 and 4 or math.floor(iter_36_11)
						self._detail_attr_content[iter_36_10].attr_num.text.text = var_0_3:get_shoot_type_name(iter_36_11)
					end
				end
			end

			self._control.right.ship_detail.detail_info.detail.ship_star.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail.star, self._data.star))

			if self._now_ship_data then
				self._control.right.ship_detail.detail_info.detail.change_icon:SetActive(self._now_ship_data.evo_class)
			else
				self._control.right.ship_detail.detail_info.detail.change_icon:SetActive(false)
			end

			return
		end

		local var_36_13

		if self._now_ship_data then
			self:__workshop_add(var_36_0)
			self:__special_equip_add(var_36_0, var_36_3)

			local var_36_14 = self:__get_ship_cfg(self._data.cid)

			for iter_36_12, iter_36_13 in pairs((var_0_5:get_player_desk_collection_data())) do
				local var_36_15 = var_0_12.find_object_by_cid(iter_36_13.id)

				if var_36_15 then
					local var_36_16 = var_36_15.buff_effect.attr

					if self:__match_collection_ship_type(var_36_15.buff_effect.ship_type, var_36_14.type) and (var_36_15.buff_effect.country == 0 or var_36_15.buff_effect.country == var_36_14.country) and var_36_0[var_36_16] then
						var_36_0[var_36_16] = var_36_0[var_36_16] + var_36_15.buff_effect.val

						if self._detail_attr_content[var_36_16] then
							self._detail_attr_content[var_36_16].tip_icon:SetActive(true)
							self._detail_attr_content[var_36_16].attr_bg:SetActive(true)

							if next(var_36_5) then
								for iter_36_14, iter_36_15 in pairs(var_36_5) do
									if var_36_16 == iter_36_14 then
										if var_36_15.buff_effect.val + iter_36_15 > 0 then
											self._detail_attr_content[var_36_16].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_up)
											self._detail_attr_content[var_36_16].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_blud)
										elseif var_36_15.buff_effect.val + iter_36_15 < 0 then
											self._detail_attr_content[var_36_16].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_down)
											self._detail_attr_content[var_36_16].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_red)
										end
									end
								end
							else
								self._detail_attr_content[var_36_16].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_up)
								self._detail_attr_content[var_36_16].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_blud)
							end

							self._detail_attr_content[var_36_16].attr_num.text.color = Color.New(1, 1, 1)
						end
					end
				end
			end

			local var_36_17 = var_0_5:get_restaurant_cookbook_buff()

			if var_36_17 and lx.ServerTime:getUtcTime() < var_36_17.end_time then
				local var_36_18 = var_0_13.find_object_by_cid(var_36_17.id)
				local var_36_19 = var_36_18.effect.attr

				if var_36_0[var_36_18.effect.attr] and self._detail_attr_content[var_36_19] and var_36_17.end_time >= lx.ServerTime:getUtcTime() and (var_36_18.effect.type == 5 or var_36_18.effect.type == 6) then
					local var_36_21 = var_36_18.effect.country or 0
					local var_36_22 = var_36_18.effect.ship_type or 0
					local var_36_23 = var_36_18.effect.ship_ton or 0

					if (var_36_22 == 0 or var_36_22 == var_36_14.type) and (var_36_21 == 0 or var_36_21 == var_36_14.country) and (var_36_23 == 0 or var_36_23 == var_36_14.ship_ton) then
						var_36_0[var_36_19] = var_36_0[var_36_19] + var_36_18.effect.value

						self._detail_attr_content[var_36_19].tip_icon:SetActive(true)
						self._detail_attr_content[var_36_19].attr_bg:SetActive(true)

						self._detail_attr_content[var_36_19].attr_num.text.color = Color.New(1, 1, 1)
					end
				end
			end

			local var_36_24 = var_0_5:get_dormitory_race_buff()

			if var_36_24 then
				if (lx.ServerTime:getUtcTime() or 0) < var_36_24.end_time then
					local var_36_25 = var_0_21.find_object_by_cid(var_36_24.id).buff
					local var_36_26 = var_36_25.ship_type or 0
					local var_36_27 = var_36_25.shipTon or 0
					local var_36_28 = var_0_3:get_attr_name(var_36_25.num4)

					if var_36_25.type == 1 and (var_36_26 == 0 or var_36_26 == var_36_14.type) and (var_36_24.country == 0 or var_36_24.country == var_36_14.country) and (var_36_27 == 0 or var_36_27 == var_36_14.ship_ton) then
						var_36_0[var_36_28] = var_36_0[var_36_28] + var_36_25.num

						if self._detail_attr_content[var_36_28] then
							self._detail_attr_content[var_36_28].tip_icon:SetActive(true)
							self._detail_attr_content[var_36_28].attr_bg:SetActive(true)

							self._detail_attr_content[var_36_28].attr_num.text.color = Color.New(1, 1, 1)
						end
					end
				end
			end

			local var_36_29 = not self._data.now_skill and var_0_9.find_object_by_skill_id(self._data.skill_id) or var_0_9.find_object_by_skill_type_skill_level(self._data.now_skill, self._data.skill_level)
			local var_36_30
			local var_36_31

			var_36_13 = {}

			for iter_36_16, iter_36_17 in pairs(self._detail_attr_content) do
				var_36_13[iter_36_16] = var_36_0[iter_36_16]
			end

			if var_36_29 and var_36_29.effect[1] then
				for iter_36_18, iter_36_19 in pairs(var_36_29.effect) do
					if var_36_29.effect[iter_36_18].type == 1 and var_36_29.effect[iter_36_18].stage[1] == 1 then
						for iter_36_20, iter_36_21 in pairs(var_36_29.effect[iter_36_18].effect) do
							if iter_36_21.type == 3 then
								for iter_36_22, iter_36_23 in pairs(self._detail_attr_table) do
									if iter_36_21[self._detail_attr_table[iter_36_22]] then
										var_36_30 = self._detail_attr_table[iter_36_22]
										var_36_31 = iter_36_21[self._detail_attr_table[iter_36_22]]
									end
								end

								if var_36_30 and var_36_31 and var_36_0[var_36_30] and self._detail_attr_content[var_36_30] then
									var_36_31 = var_36_31 * var_0_16.get_attr_multiple_by_config(var_36_29, self._data, iter_36_18)
									var_36_0[var_36_30] = var_36_0[var_36_30] + var_36_31
								end
							elseif iter_36_21.type == 4 then
								for iter_36_24, iter_36_25 in pairs(iter_36_21) do
									if iter_36_24 ~= "type" then
										var_36_0[iter_36_24] = var_36_0[iter_36_24] or 1
										var_36_0[iter_36_24] = var_36_0[iter_36_24] + var_36_0[iter_36_24] * iter_36_25
									end
								end
							elseif iter_36_21.type == 5 then
								if var_36_0[self._detail_attr_table[iter_36_21.attribute]] and var_36_0[self._detail_attr_table[iter_36_21.attribute2]] then
									var_36_0[self._detail_attr_table[iter_36_21.attribute2]] = var_36_0[self._detail_attr_table[iter_36_21.attribute2]] + var_36_0[self._detail_attr_table[iter_36_21.attribute]] * iter_36_21.rate
								end
							elseif iter_36_21.type == 94 then
								if var_36_0.range >= iter_36_21.num then
									var_36_0.range = var_36_0.range or iter_36_21.num
								end
							elseif iter_36_21.type == 49 then
								for iter_36_26, iter_36_27 in ipairs(self._data.equips) do
									if iter_36_27.id and iter_36_27.id > 0 then
										for iter_36_28, iter_36_29 in pairs((var_0_8.find_object_by_cid(iter_36_27.id))) do
											if iter_36_28 ~= "range" and iter_36_28 ~= "hp" and self._detail_attr_content[iter_36_28] and iter_36_29 ~= 0 then
												var_36_0[iter_36_28] = var_36_0[iter_36_28] + iter_36_29 * iter_36_21.rate
											end
										end
									end
								end
							elseif iter_36_21.type == 50 then
								for iter_36_30, iter_36_31 in ipairs(self._data.equips) do
									if iter_36_31.id and iter_36_31.id > 0 then
										local var_36_33 = var_0_8.find_object_by_cid(iter_36_31.id)

										if var_36_0[self._detail_attr_table[iter_36_21.attribute]] and var_36_33[self._detail_attr_table[iter_36_21.attribute]] and var_36_0[self._detail_attr_table[iter_36_21.attribute2]] then
											var_36_0[self._detail_attr_table[iter_36_21.attribute2]] = var_36_0[self._detail_attr_table[iter_36_21.attribute2]] + var_36_33[self._detail_attr_table[iter_36_21.attribute]] * iter_36_21.rate
										end
									end
								end
							elseif iter_36_21.type == 51 then
								local var_36_34 = 0

								for iter_36_32, iter_36_33 in ipairs(self._data.equips) do
									if iter_36_33.id and iter_36_33.id > 0 then
										for iter_36_34, iter_36_35 in pairs(iter_36_21.equipment_type) do
											local var_36_35 = var_0_8.find_object_by_cid(iter_36_33.id)

											if var_36_35 and var_36_35.bore_type == iter_36_35 then
												var_36_34 = var_36_34 + 1
											end
										end
									end
								end

								for iter_36_36, iter_36_37 in pairs(iter_36_21) do
									if var_36_0[iter_36_36] then
										var_36_0[iter_36_36] = var_36_0[iter_36_36] + iter_36_37 * var_36_34

										break
									end
								end
							elseif iter_36_21.type == 52 then
								for iter_36_38, iter_36_39 in ipairs(self._data.equips) do
									if iter_36_39.id and iter_36_39.id > 0 then
										local var_36_36 = var_0_8.find_object_by_cid(iter_36_39.id)

										for iter_36_40, iter_36_41 in pairs(iter_36_21.equipment_type) do
											if var_36_36.type == iter_36_41 then
												for iter_36_42, iter_36_43 in pairs(iter_36_21) do
													if var_36_0[iter_36_42] and var_36_36[iter_36_42] then
														var_36_0[iter_36_42] = var_36_0[iter_36_42] + var_36_36[iter_36_42] * iter_36_21[iter_36_42]
													end
												end
											end
										end
									end
								end
							elseif iter_36_21.type == 54 then
								for iter_36_44, iter_36_45 in ipairs(self._data.equips) do
									if iter_36_45.id and iter_36_45.id > 0 then
										for iter_36_46, iter_36_47 in pairs(iter_36_21.equipment_type) do
											local var_36_37 = var_0_8.find_object_by_cid(iter_36_45.id)

											if var_36_37 and var_36_37.type == iter_36_47 then
												for iter_36_48, iter_36_49 in pairs(iter_36_21) do
													if var_36_0[self._detail_attr_table[iter_36_21.attribute]] and var_36_37[self._detail_attr_table[iter_36_21.attribute]] and var_36_0[self._detail_attr_table[iter_36_21.attribute2]] then
														var_36_0[self._detail_attr_table[iter_36_21.attribute2]] = var_36_0[self._detail_attr_table[iter_36_21.attribute2]] + var_36_37[self._detail_attr_table[iter_36_21.attribute]] * iter_36_21.rate

														break
													end
												end
											end
										end
									end
								end
							elseif iter_36_21.type == 131 then
								local var_36_38

								if var_36_0[self._detail_attr_table[iter_36_21.attribute]] then
									var_36_38 = var_0_16.attr_impact_by_speed(var_36_1.speed, var_36_0[self._detail_attr_table[iter_36_21.attribute]], iter_36_21.num1, iter_36_21.num2) - var_36_0[self._detail_attr_table[iter_36_21.attribute]]
								end

								if var_36_38 then
									var_36_0[self._detail_attr_table[iter_36_21.attribute]] = var_36_0[self._detail_attr_table[iter_36_21.attribute]] + var_36_38
								end
							end
						end
					end
				end
			end
		end

		for iter_36_50, iter_36_51 in pairs(var_36_0) do
			if self._detail_attr_content[iter_36_50] then
				if iter_36_50 == "speed" then
					local var_36_40 = self._detail_attr_content[iter_36_50].attr_bg.rectTransform.sizeDelta
					local var_36_41

					self._detail_attr_content[iter_36_50].attr_num.text.text, var_36_41 = var_0_16.convert_resert_decimals(iter_36_51)
					self._detail_attr_content[iter_36_50].attr_num.text.text = self._detail_attr_content[iter_36_50].attr_num.text.text .. var_0_1:getNowLang("speedtext")
					var_36_40 = var_36_41 > 0 and var_0_14(78, var_36_40.y) or var_0_14(55, var_36_40.y)
					self._detail_attr_content[iter_36_50].attr_bg.rectTransform.sizeDelta = var_36_40
				else
					self._detail_attr_content[iter_36_50].attr_num.text.text = var_0_18(tonumber(iter_36_51))
				end

				if iter_36_50 == "range" then
					iter_36_51 = math.floor(iter_36_51) > 4 and 4 or math.floor(iter_36_51)
					self._detail_attr_content[iter_36_50].attr_num.text.text = var_0_3:get_shoot_type_name(iter_36_51)
				end
			end
		end

		self:__ship_up_or_down(var_36_0)

		if var_36_13 then
			for iter_36_52, iter_36_53 in pairs(var_36_13) do
				if var_36_0[iter_36_52] and iter_36_53 and var_36_0[iter_36_52] ~= iter_36_53 and self._detail_attr_content[iter_36_52] then
					self._detail_attr_content[iter_36_52].tip_icon:SetActive(true)
					self._detail_attr_content[iter_36_52].attr_bg:SetActive(true)

					self._detail_attr_content[iter_36_52].attr_num.text.color = Color.New(1, 1, 1)
				end
			end
		end

		local var_36_42 = self._control.right.ship_detail.detail_info.detail

		self._control.right.ship_detail.detail_info.detail.ship_star.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail.star, self._data.star))
		self._control.right.ship_equip_detail.ship_equip_detail_content.detail_2.ship_star.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail.star, self._data.star))

		if self._now_ship_data then
			var_36_42.change_icon:SetActive(self._now_ship_data.evo_class)
			self._control.right.ship_equip_detail.ship_equip_detail_content.detail_2.change_icon:SetActive(self._now_ship_data.evo_class)
		else
			var_36_42.change_icon:SetActive(false)
			self._control.right.ship_equip_detail.ship_equip_detail_content.detail_2.change_icon:SetActive(false)
		end

		self._now_character_data.hp = var_36_0.hp
	end

	function arg_1_0:__init_detail_image()
		local var_37_0 = Color.New(0.23529411764705882, 0.6196078431372549, 1)

		for iter_37_0, iter_37_1 in pairs(self._detail_attr_content) do
			iter_37_1.attr_bg:SetActive(false)
			iter_37_1.tip_icon:SetActive(false)

			iter_37_1.attr_num.text.color = var_37_0
		end
	end

	function arg_1_0:__ship_up_or_down(arg_38_1)
		local var_38_0, var_38_1 = var_0_16:get_ship_attr(self._data, (var_0_7.find_object_by_cid(self._data.cid)))

		self:__workshop_add(var_38_1)
		self:__init_detail_image()

		if var_38_1 == nil then
			return
		end

		self:__ship_detail_image_show(var_38_0, var_38_1)
	end

	function arg_1_0:__ship_detail_image_show(arg_39_1, arg_39_2)
		local var_39_0 = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_blud)
		local var_39_1 = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_red)
		local var_39_2 = self:loadSprite(var_0_3.ship_detail_equip_record.bule_up_arrows_icon)
		local var_39_3 = self:loadSprite(var_0_3.ship_detail_equip_record.red_up_arrows_icon)

		if arg_39_1.hp > arg_39_2.hp then
			self._control.right.ship_detail.detail_info.detail.attr_hp.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_hp.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_hp.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_hp.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_hp.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.hp < arg_39_2.hp then
			self._control.right.ship_detail.detail_info.detail.attr_hp.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_hp.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_hp.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_hp.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_hp.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.atk < arg_39_2.atk then
			self._control.right.ship_detail.detail_info.detail.attr_atk.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_atk.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_atk.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_atk.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_atk.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.atk > arg_39_2.atk then
			self._control.right.ship_detail.detail_info.detail.attr_atk.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_atk.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_atk.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_atk.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_atk.attr_num.text.color = Color.New(1, 1, 1)
		end

		arg_39_1.def = var_0_18(arg_39_1.def * 1000)
		arg_39_2.def = var_0_18(arg_39_2.def * 1000)

		if arg_39_1.def + 1 == arg_39_2.def then
			arg_39_1.def = arg_39_2.def
		end

		if arg_39_1.def > arg_39_2.def then
			self._control.right.ship_detail.detail_info.detail.attr_def.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_def.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_def.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_def.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_def.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.def < arg_39_2.def then
			self._control.right.ship_detail.detail_info.detail.attr_def.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_def.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_def.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_def.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_def.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.torpedo < arg_39_2.torpedo then
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_torpedo.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.torpedo > arg_39_2.torpedo then
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_torpedo.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_torpedo.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.miss > arg_39_2.miss then
			self._control.right.ship_detail.detail_info.detail.attr_miss.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_miss.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_miss.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_miss.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_miss.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.miss < arg_39_2.miss then
			self._control.right.ship_detail.detail_info.detail.attr_miss.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_miss.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_miss.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_miss.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_miss.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.air_def < arg_39_2.air_def then
			self._control.right.ship_detail.detail_info.detail.attr_airdef.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_airdef.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_airdef.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_airdef.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_airdef.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.air_def > arg_39_2.air_def then
			self._control.right.ship_detail.detail_info.detail.attr_airdef.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_airdef.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_airdef.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_airdef.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_airdef.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.capacity < arg_39_2.capacity then
			self._control.right.ship_detail.detail_info.detail.attr_capacity.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_capacity.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_capacity.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_capacity.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_capacity.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.capacity > arg_39_2.capacity then
			self._control.right.ship_detail.detail_info.detail.attr_capacity.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_capacity.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_capacity.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_capacity.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_capacity.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.antisub < arg_39_2.antisub then
			self._control.right.ship_detail.detail_info.detail.attr_antisub.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_antisub.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_antisub.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_antisub.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_antisub.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.antisub > arg_39_2.antisub then
			self._control.right.ship_detail.detail_info.detail.attr_antisub.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_antisub.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_antisub.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_antisub.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_antisub.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.speed < arg_39_2.speed then
			self._control.right.ship_detail.detail_info.detail.attr_speed.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_speed.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_speed.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_speed.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_speed.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.speed > arg_39_2.speed then
			self._control.right.ship_detail.detail_info.detail.attr_speed.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_speed.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_speed.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_speed.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_speed.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.radar < arg_39_2.radar then
			self._control.right.ship_detail.detail_info.detail.attr_radar.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_radar.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_radar.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_radar.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_radar.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.radar > arg_39_2.radar then
			self._control.right.ship_detail.detail_info.detail.attr_radar.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_radar.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_radar.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_radar.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_radar.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.luck < arg_39_2.luck then
			self._control.right.ship_detail.detail_info.detail.attr_luck.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_luck.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_luck.attr_bg.image.sprite = var_39_1
			self._control.right.ship_detail.detail_info.detail.attr_luck.tip_icon.image.sprite = var_39_3
			self._control.right.ship_detail.detail_info.detail.attr_luck.attr_num.text.color = Color.New(1, 1, 1)
		end

		if arg_39_1.luck > arg_39_2.luck then
			self._control.right.ship_detail.detail_info.detail.attr_luck.attr_bg:SetActive(true)
			self._control.right.ship_detail.detail_info.detail.attr_luck.tip_icon:SetActive(true)

			self._control.right.ship_detail.detail_info.detail.attr_luck.attr_bg.image.sprite = var_39_0
			self._control.right.ship_detail.detail_info.detail.attr_luck.tip_icon.image.sprite = var_39_2
			self._control.right.ship_detail.detail_info.detail.attr_luck.attr_num.text.color = Color.New(1, 1, 1)
		end
	end

	function arg_1_0.__calculate_attr(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
		arg_40_1 = arg_40_1 or 0
		arg_40_2 = arg_40_2 or 0
		arg_40_3 = arg_40_3 or 0
		arg_40_4 = arg_40_4 or 1

		return var_0_18(arg_40_1 + (arg_40_2 - arg_40_1) * arg_40_4 / 100)
	end

	function arg_1_0:__set_ship_detail_for_friend(arg_41_1)
		local var_41_0 = {}
		local var_41_1 = {}

		for iter_41_0, iter_41_1 in pairs(var_0_3.equip_attribute) do
			var_41_0[iter_41_1] = 0
		end

		for iter_41_2, iter_41_3 in pairs(var_0_3.equip_attribute) do
			if self._now_ship_data[iter_41_3] then
				var_41_0[iter_41_3] = var_41_0[iter_41_3] + self._now_ship_data[iter_41_3] or var_41_0[iter_41_3] + 0
			end
		end

		var_41_0.hit = self:__calculate_attr(self._now_ship_data.hit, self._now_ship_data.hit_max, self._now_ship_data.hit_max2, self._data.level)
		var_41_0.miss = self:__calculate_attr(self._now_ship_data.miss, self._now_ship_data.miss_max, self._now_ship_data.miss_max2, self._data.level)
		var_41_0.antisub = self:__calculate_attr(self._now_ship_data.antisub, self._now_ship_data.antisub_max, self._now_ship_data.antisub_max2, self._data.level)
		var_41_0.radar = self:__calculate_attr(self._now_ship_data.radar, self._now_ship_data.radar_max, self._now_ship_data.radar_max2, self._data.level)
		var_41_0.speed = self._now_ship_data.speed
		var_41_0.capacity = self._now_ship_data.capacity
		var_41_0.range = self._now_ship_data.range

		if self._data.marry then
			var_41_0.luck = var_41_0.luck + 5
		end

		local var_41_2 = var_0_7.find_object_by_cid(self._data.cid)

		if self._data.intensify then
			for iter_41_4, iter_41_5 in pairs(self._data.intensify) do
				var_41_0[iter_41_5.attr] = var_41_0[iter_41_5.attr] + iter_41_5.exp / var_41_2.strengthen_level_up_exp
			end
		end

		for iter_41_6, iter_41_7 in pairs(self._data.equips) do
			var_0_27(var_41_1, (var_0_8.find_object_by_cid(iter_41_7.id)))
		end

		local var_41_3 = not self._data.now_skill and var_0_9.find_object_by_skill_id(self._data.skill_id) or var_0_9.find_object_by_skill_type_skill_level(self._data.now_skill, self._data.skill_level)

		self:__workshop_add_friends(var_41_0)
		self:__special_equip_friends_add(var_41_0, var_41_1)

		local var_41_4
		local var_41_5

		if var_41_3 and var_41_3.effect[1] then
			for iter_41_8, iter_41_9 in pairs(var_41_3.effect) do
				if var_41_3.effect[iter_41_8].type == 1 and var_41_3.effect[iter_41_8].stage[1] == 1 then
					for iter_41_10, iter_41_11 in pairs(var_41_3.effect[iter_41_8].effect) do
						if iter_41_11.type == 3 then
							for iter_41_12, iter_41_13 in pairs(self._detail_attr_table) do
								if iter_41_11[self._detail_attr_table[iter_41_12]] then
									var_41_4 = self._detail_attr_table[iter_41_12]
									var_41_5 = iter_41_11[self._detail_attr_table[iter_41_12]]
								end
							end

							if var_41_4 and var_41_5 and var_41_0[var_41_4] and self._detail_attr_content[var_41_4] then
								var_41_5 = var_41_5 * var_0_16.get_attr_multiple_by_config(var_41_3, self._data, iter_41_8)
								var_41_0[var_41_4] = var_41_0[var_41_4] + var_41_5
							end
						elseif iter_41_11.type == 4 then
							for iter_41_14, iter_41_15 in pairs(iter_41_11) do
								if iter_41_14 ~= "type" then
									var_41_0[iter_41_14] = var_41_0[iter_41_14] or 1
									var_41_0[iter_41_14] = var_41_0[iter_41_14] + var_41_0[iter_41_14] * iter_41_15
								end
							end
						elseif iter_41_11.type == 5 then
							if var_41_0[self._detail_attr_table[iter_41_11.attribute]] and var_41_0[self._detail_attr_table[iter_41_11.attribute2]] then
								var_41_0[self._detail_attr_table[iter_41_11.attribute2]] = var_41_0[self._detail_attr_table[iter_41_11.attribute2]] + var_41_0[self._detail_attr_table[iter_41_11.attribute]] * iter_41_11.rate

								self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].tip_icon:SetActive(true)
								self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].attr_bg:SetActive(true)

								self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].attr_num.text.color = Color.New(1, 1, 1)
								self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].attr_num.text.text = var_41_0[self._detail_attr_table[iter_41_11.attribute2]]
							end
						elseif iter_41_11.type == 94 then
							if var_41_0.range >= iter_41_11.num then
								var_41_0.range = var_41_0.range or iter_41_11.num
							end
						elseif iter_41_11.type == 49 then
							for iter_41_16, iter_41_17 in ipairs(self._data.equips) do
								if iter_41_17.id and iter_41_17.id > 0 then
									local var_41_7 = var_0_8.find_object_by_cid(iter_41_17.id)

									if var_41_7 then
										for iter_41_18, iter_41_19 in pairs(var_41_7) do
											if iter_41_18 ~= "range" and iter_41_18 ~= "hp" and self._detail_attr_content[iter_41_18] and iter_41_19 ~= 0 then
												var_41_0[iter_41_18] = var_41_0[iter_41_18] + iter_41_19 * iter_41_11.rate
											end
										end
									end
								end
							end
						elseif iter_41_11.type == 50 then
							for iter_41_20, iter_41_21 in ipairs(self._data.equips) do
								if iter_41_21.id and iter_41_21.id > 0 then
									local var_41_8 = var_0_8.find_object_by_cid(iter_41_21.id)

									if var_41_8 and var_41_0[self._detail_attr_table[iter_41_11.attribute]] and var_41_8[self._detail_attr_table[iter_41_11.attribute]] and var_41_0[self._detail_attr_table[iter_41_11.attribute2]] then
										var_41_0[self._detail_attr_table[iter_41_11.attribute2]] = var_41_0[self._detail_attr_table[iter_41_11.attribute2]] + var_41_8[self._detail_attr_table[iter_41_11.attribute]] * iter_41_11.rate

										self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].tip_icon:SetActive(true)
										self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].attr_bg:SetActive(true)

										self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].attr_num.text.color = Color.New(1, 1, 1)
									end
								end
							end
						elseif iter_41_11.type == 51 then
							local var_41_9 = 0

							for iter_41_22, iter_41_23 in ipairs(self._data.equips) do
								if iter_41_23.id and iter_41_23.id > 0 then
									for iter_41_24, iter_41_25 in pairs(iter_41_11.equipment_type) do
										if var_0_8.find_object_by_cid(iter_41_23.id).type == iter_41_25 then
											var_41_9 = var_41_9 + 1
										end
									end
								end
							end

							for iter_41_26, iter_41_27 in pairs(iter_41_11) do
								if var_41_0[iter_41_26] then
									var_41_0[iter_41_26] = var_41_0[iter_41_26] + iter_41_27 * var_41_9

									break
								end
							end
						elseif iter_41_11.type == 52 then
							for iter_41_28, iter_41_29 in ipairs(self._data.equips) do
								if iter_41_29.id and iter_41_29.id > 0 then
									for iter_41_30, iter_41_31 in pairs(iter_41_11.equipment_type) do
										local var_41_10 = var_0_8.find_object_by_cid(iter_41_29.id)

										if var_41_10.type == iter_41_31 then
											for iter_41_32, iter_41_33 in pairs(iter_41_11) do
												if var_41_0[iter_41_32] and var_41_10[iter_41_32] then
													var_41_0[iter_41_32] = var_41_0[iter_41_32] + var_41_10[iter_41_32] * iter_41_11[iter_41_32]
												end
											end
										end
									end
								end
							end
						elseif iter_41_11.type == 54 then
							for iter_41_34, iter_41_35 in ipairs(self._data.equips) do
								if iter_41_35.id and iter_41_35.id > 0 then
									for iter_41_36, iter_41_37 in pairs(iter_41_11.equipment_type) do
										local var_41_11 = var_0_8.find_object_by_cid(iter_41_35.id)

										if var_41_11.type == iter_41_37 then
											for iter_41_38, iter_41_39 in pairs(iter_41_11) do
												if var_41_0[self._detail_attr_table[iter_41_11.attribute]] and var_41_11[self._detail_attr_table[iter_41_11.attribute]] and var_41_0[self._detail_attr_table[iter_41_11.attribute2]] then
													var_41_0[self._detail_attr_table[iter_41_11.attribute2]] = var_41_0[self._detail_attr_table[iter_41_11.attribute2]] + var_41_11[self._detail_attr_table[iter_41_11.attribute]] * iter_41_11.rate

													self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].tip_icon:SetActive(true)
													self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].attr_bg:SetActive(true)

													self._detail_attr_content[self._detail_attr_table[iter_41_11.attribute2]].attr_num.text.color = Color.New(1, 1, 1)

													break
												end
											end
										end
									end
								end
							end
						elseif iter_41_11.type == 131 then
							if var_41_0[self._detail_attr_table[iter_41_11.attribute]] then
								var_41_0[self._detail_attr_table[iter_41_11.attribute]] = var_0_16.attr_impact_by_speed(var_41_0.speed, var_41_0[self._detail_attr_table[iter_41_11.attribute]], iter_41_11.num1, iter_41_11.num2)
							end
						end
					end
				end
			end
		end

		local var_41_12 = var_41_0 and var_0_16.little_clone(var_41_0) or {}
		local var_41_13 = {}

		for iter_41_40, iter_41_41 in pairs(var_0_3.equip_attribute) do
			var_41_13[iter_41_41] = 0
		end

		for iter_41_42, iter_41_43 in pairs(self._data.equips) do
			if iter_41_43.id then
				local var_41_14 = var_0_8.find_object_by_cid(iter_41_43.id)

				if var_41_14 then
					for iter_41_44, iter_41_45 in pairs(var_0_3.equip_attribute) do
						if iter_41_45 == "range" then
							if var_41_14[iter_41_45] > var_41_13[iter_41_45] then
								var_41_13[iter_41_45] = var_41_14[iter_41_45] or var_41_13[iter_41_45]
							end
						else
							var_41_13[iter_41_45] = var_41_13[iter_41_45] + var_41_14[iter_41_45]
						end
					end
				end
			end
		end

		for iter_41_46, iter_41_47 in pairs(var_41_13) do
			if self._detail_attr_content[iter_41_46] then
				local var_41_15 = iter_41_47 ~= 0 and iter_41_46 ~= "range"

				self._detail_attr_content[iter_41_46].tip_icon:SetActive(iter_41_47 ~= 0 and iter_41_46 ~= "range")
				self._detail_attr_content[iter_41_46].attr_bg:SetActive(var_41_15)

				self._detail_attr_content[iter_41_46].attr_num.text.color = var_41_15 and Color.New(1, 1, 1) or Color.New(0.23529411764705882, 0.6196078431372549, 1)

				if iter_41_47 > 0 and iter_41_46 ~= "range" then
					self._detail_attr_content[iter_41_46].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_up)
					self._detail_attr_content[iter_41_46].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_blud)
				elseif iter_41_47 < 0 and iter_41_46 ~= "range" then
					self._detail_attr_content[iter_41_46].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_down)
					self._detail_attr_content[iter_41_46].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_red)
				end

				if iter_41_46 == "range" then
					if iter_41_47 <= var_41_0[iter_41_46] then
						var_41_0[iter_41_46] = var_41_0[iter_41_46] or iter_41_47
					end
				elseif var_41_0[iter_41_46] then
					var_41_0[iter_41_46] = var_41_0[iter_41_46] + iter_41_47 or iter_41_47
				end
			end
		end

		self:__add_collections(var_41_0)

		for iter_41_48, iter_41_49 in pairs(var_41_0) do
			if self._detail_attr_content[iter_41_48] then
				if iter_41_48 == "range" then
					self._detail_attr_content[iter_41_48].attr_num.text.text = var_0_3:get_shoot_type_name(iter_41_49)
				elseif iter_41_48 == "speed" then
					local var_41_18 = self._detail_attr_content[iter_41_48].attr_bg.rectTransform.sizeDelta
					local var_41_19

					self._detail_attr_content[iter_41_48].attr_num.text.text, var_41_19 = var_0_16.convert_resert_decimals(iter_41_49)
					self._detail_attr_content[iter_41_48].attr_num.text.text = self._detail_attr_content[iter_41_48].attr_num.text.text .. var_0_1:getNowLang("speedtext")
					var_41_18 = var_41_19 > 0 and var_0_14(78, var_41_18.y) or var_0_14(55, var_41_18.y)
					self._detail_attr_content[iter_41_48].attr_bg.rectTransform.sizeDelta = var_41_18
				else
					self._detail_attr_content[iter_41_48].attr_num.text.text = var_0_18(iter_41_49)
				end
			end
		end

		arg_41_1.ship_star.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail.star, self._data.star))

		arg_41_1.change_icon:SetActive(self._now_ship_data.evo_class)
		self:__init_detail_image()
		self:__ship_detail_image_show(var_41_0, var_41_12)
	end

	function arg_1_0.__init_ship_detail_content(arg_42_0, arg_42_1)
		arg_42_0._detail_attr_content = {
			hp = arg_42_1.attr_hp,
			atk = arg_42_1.attr_atk,
			def = arg_42_1.attr_def,
			torpedo = arg_42_1.attr_torpedo,
			miss = arg_42_1.attr_miss,
			air_def = arg_42_1.attr_airdef,
			capacity = arg_42_1.attr_capacity,
			antisub = arg_42_1.attr_antisub,
			speed = arg_42_1.attr_speed,
			radar = arg_42_1.attr_radar,
			range = arg_42_1.attr_range,
			luck = arg_42_1.attr_luck
		}
		arg_42_0._detail_attr_table = {
			"hp",
			"atk",
			"def",
			"torpedo",
			"miss",
			"air_def",
			"capacity",
			nil,
			"antisub",
			"speed",
			"radar",
			"range",
			"luck",
			nil,
			nil,
			"crit",
			"hit",
			nil,
			"ext"
		}
	end

	function arg_1_0:init_skin_info()
		local var_43_0

		if self._now_ship_data and self._now_ship_data.skins then
			var_43_0 = #self._now_ship_data.skins or 0

			if var_43_0 <= 0 then
				return
			end
		end

		local var_43_2 = {}

		for iter_43_0, iter_43_1 in pairs(self._now_ship_data.skins) do
			var_0_27(var_43_2, (var_0_6.find_object_by_cid(iter_43_1)))
		end

		local var_43_3

		if next(var_43_2) then
			for iter_43_2, iter_43_3 in pairs(var_43_2) do
				if iter_43_3.card_cids[1] and iter_43_3.card_cids[1] ~= self._now_ship_data.cid and iter_43_3.card_cids[1] > self._now_ship_data.cid then
					var_43_3 = iter_43_3.card_cids[1]
				end

				if self._now_ship_data.cid == 18000913 or self._now_ship_data.cid == 18011113 or self._now_ship_data.cid == 18000713 then
					var_43_3 = iter_43_3.card_cids[1]
				end
			end
		end

		if var_43_3 then
			var_43_0 = var_43_0 - 1
		end

		self._skin_num = var_43_0

		local var_43_4 = var_0_37.scrollview.content.transform:GetChild(0)

		var_43_4:Find("icon_bg"):Find("icon"):GetComponent("Image").sprite = self:loadSprite(var_0_4(var_0_3.skin_icon, self._now_ship_data.pic_id, self._now_ship_data.pic_id))

		local var_43_5 = 500 - 154 * (var_43_0 + 1)

		if 500 - 154 * (var_43_0 + 1) >= 0 then
			var_43_5 = 0
		end

		local var_43_6 = var_0_37.scrollview.content:GetComponent("RectTransform")

		var_43_6.offsetMin = var_0_14(var_43_5, var_43_6.offsetMin.y)
		var_43_6.offsetMax = var_0_14(0, var_43_6.offsetMax.y)

		for iter_43_4 = var_43_0 + 1 + 1, var_0_37.scrollview.content.transform.childCount do
			var_0_37.scrollview.content.transform:GetChild(iter_43_4 - 1).gameObject:SetActive(false)
		end

		if self._now_lable == 0 then
			for iter_43_5 = 1, var_0_37.scrollview.content.transform.childCount - 1 do
				var_0_37.scrollview.content.transform:GetChild(iter_43_5).gameObject:SetActive(false)
			end

			return
		end

		self:skin_icon_toggle_event(var_43_4)

		if var_0_37.scrollview.content.transform.childCount < var_43_0 + 1 then
			for iter_43_6 = 1, var_43_0 + 1 - var_0_37.scrollview.content.transform.childCount do
				UnityEngine.Object.Instantiate(var_43_4.gameObject, var_0_37.scrollview.content.transform, false)
			end
		end

		for iter_43_7 = 1, var_43_0 do
			local var_43_7 = var_0_37.scrollview.content.transform:GetChild(iter_43_7)

			if self._now_ship_data then
				local var_43_9 = self:__get_skin_cfg(self._now_ship_data.skins[iter_43_7]).icon
			elseif self._data.pic_id then
				-- block empty
			end

			local var_43_11
			local var_43_12 = {}

			if var_43_0 == #self._now_ship_data.skins then
				var_43_11 = self:__get_skin_cfg(self._now_ship_data.skins[iter_43_7]).icon
			else
				for iter_43_8, iter_43_9 in pairs(self._now_ship_data.skins) do
					var_0_27(var_43_12, iter_43_9)
				end

				for iter_43_10, iter_43_11 in pairs(var_43_12) do
					local var_43_13 = var_0_6.find_object_by_cid(iter_43_11)

					if #var_43_13.card_cids == 1 and var_43_13.card_cids[1] ~= self._now_ship_data.cid then
						table.remove(var_43_12, iter_43_10)
					end
				end

				if var_43_12[iter_43_7] then
					var_43_11 = self:__get_skin_cfg(var_43_12[iter_43_7]).icon
				end
			end

			if var_43_11 then
				var_43_7:Find("icon_bg"):Find("icon"):GetComponent("Image").sprite = self:loadSprite(var_0_4(var_0_3.skin_icon, var_43_11, var_43_11))

				var_43_7.gameObject:SetActive(true)

				var_43_7:GetComponent("Toggle").isOn = false

				self:skin_icon_toggle_event(var_43_7)
			else
				var_43_7.gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0.skin_icon_toggle_event(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_1:GetComponent("Toggle")

		var_44_0.onValueChanged:RemoveAllListeners()
		var_44_0.onValueChanged:AddListener(function()
			if var_44_0.isOn then
				local var_45_0 = arg_44_1:GetSiblingIndex()

				arg_44_0._now_index = var_45_0

				if arg_44_0._now_show_skin_icon ~= var_45_0 then
					arg_44_0:set_skin_info(var_45_0)
					arg_44_0:play_in_out_animation(true, function()
						if var_45_0 == 0 then
							if arg_44_0._now_ship_data then
								arg_44_0:show_ship_icon(arg_44_0._now_ship_data.pic_id)
							elseif arg_44_0._data.pic_id then
								arg_44_0:show_ship_icon(arg_44_0._data.pic_id)
							end
						elseif arg_44_0._now_ship_data then
							local var_46_0 = {}

							if arg_44_0._skin_num == #arg_44_0._now_ship_data.skins then
								arg_44_0:show_ship_icon(arg_44_0:__get_skin_cfg(arg_44_0._now_ship_data.skins[var_45_0]).icon)
							else
								for iter_46_0, iter_46_1 in pairs(arg_44_0._now_ship_data.skins) do
									var_0_27(var_46_0, iter_46_1)
								end

								for iter_46_2, iter_46_3 in pairs(var_46_0) do
									local var_46_2 = var_0_6.find_object_by_cid(iter_46_3)

									if #var_46_2.card_cids == 1 and var_46_2.card_cids[1] ~= arg_44_0._now_ship_data.cid then
										table.remove(var_46_0, iter_46_2)
									end
								end

								arg_44_0:show_ship_icon(arg_44_0:__get_skin_cfg(var_46_0[var_45_0]).icon)
							end
						elseif arg_44_0._data.pic_id then
							arg_44_0:show_ship_icon(arg_44_0._data.pic_id)
						end

						arg_44_0:play_in_out_animation(false)
					end)
				end
			end
		end)
	end

	function arg_1_0.desc_click_event(arg_47_0, arg_47_1, arg_47_2)
		local var_47_0 = arg_47_1:GetComponent("Button")

		var_47_0.onClick:RemoveAllListeners()
		var_47_0.onClick:AddListener(function()
			local var_48_0 = arg_47_1:GetSiblingIndex()

			arg_47_1:GetChild(0):Find("title"):GetComponent("Text").text = arg_47_0:__get_skin_cfg(arg_47_2).extra_desc[var_48_0 + 1].title
			arg_47_1:GetChild(0):Find("content"):GetComponent("Text").text = arg_47_0:__get_skin_cfg(arg_47_2).extra_desc[var_48_0 + 1].desc

			arg_47_1:GetChild(0).gameObject:SetActive(true)
			arg_47_0._control.tip_layer:SetActive(true)

			arg_47_0._now_click_desc_trans = arg_47_1
		end)
	end

	function arg_1_0:show_skin_extra_desc()
		local var_49_0 = 0
		local var_49_1 = var_0_37.skin_bg_1.desc_list

		if self._now_show_skin_icon == 0 and self._enter_type ~= var_0_3.enter_ship_detail_type.bootyshop_clothes and self._enter_type ~= var_0_3.enter_ship_detail_type.mall_shop then
			-- block empty
		elseif self._enter_type == var_0_3.enter_ship_detail_type.bootyshop_clothes or self._enter_type == var_0_3.enter_ship_detail_type.mall_shop then
			local var_49_2 = self._now_ship_data.skins[1]

			var_49_0 = #self:__get_skin_cfg(self._now_ship_data.skins[1]).extra_desc

			for iter_49_0 = 1, var_49_1.transform.childCount do
				var_49_1.transform:GetChild(iter_49_0 - 1).gameObject:SetActive(false)
			end

			if var_49_0 <= 0 then
				return
			end

			local var_49_3 = var_49_1.transform:GetChild(0)

			if var_49_0 > var_49_1.transform.childCount then
				for iter_49_1 = 1, var_49_0 - var_49_1.transform.childCount do
					UnityEngine.Object.Instantiate(var_49_3.gameObject, var_49_1.transform, false)
				end
			end

			for iter_49_2 = 1, var_49_0 do
				local var_49_4 = var_49_1.transform:GetChild(iter_49_2 - 1)

				var_49_4:GetComponent("Image").sprite = self:loadSprite(var_0_4(var_0_3.skin_attrib, self:__get_skin_cfg(var_49_2).extra_desc[iter_49_2].icon))

				var_49_4.gameObject:SetActive(true)
				self:desc_click_event(var_49_4, var_49_2)
			end
		else
			local var_49_5
			local var_49_7 = {}

			if self._skin_num == #self._now_ship_data.skins then
				var_49_5 = self._now_ship_data.skins[self._now_show_skin_icon]
			else
				for iter_49_3, iter_49_4 in pairs(self._now_ship_data.skins) do
					var_0_27(var_49_7, iter_49_4)
				end

				for iter_49_5, iter_49_6 in pairs(var_49_7) do
					local var_49_8 = var_0_6.find_object_by_cid(iter_49_6)

					if #var_49_8.card_cids == 1 and var_49_8.card_cids[1] ~= self._now_ship_data.cid then
						table.remove(var_49_7, iter_49_5)
					end
				end

				var_49_5 = var_49_7[self._now_show_skin_icon]
			end

			var_49_0 = #self:__get_skin_cfg(var_49_5).extra_desc

			for iter_49_7 = 1, var_49_1.transform.childCount do
				var_49_1.transform:GetChild(iter_49_7 - 1).gameObject:SetActive(false)
			end

			if var_49_0 <= 0 then
				return
			end

			local var_49_9 = var_49_1.transform:GetChild(0)

			if var_49_0 > var_49_1.transform.childCount then
				for iter_49_8 = 1, var_49_0 - var_49_1.transform.childCount do
					UnityEngine.Object.Instantiate(var_49_9.gameObject, var_49_1.transform, false)
				end
			end

			for iter_49_9 = 1, var_49_0 do
				local var_49_10 = var_49_1.transform:GetChild(iter_49_9 - 1)

				var_49_10:GetComponent("Image").sprite = self:loadSprite(var_0_4(var_0_3.skin_attrib, self:__get_skin_cfg(var_49_5).extra_desc[iter_49_9].icon))

				var_49_10.gameObject:SetActive(true)
				self:desc_click_event(var_49_10, var_49_5)
			end
		end

		for iter_49_10 = var_49_0 + 1, var_49_1.transform.childCount do
			var_49_1.transform:GetChild(iter_49_10 - 1).gameObject:SetActive(false)
		end
	end

	function arg_1_0:__init_ske(arg_50_1, arg_50_2, arg_50_3)
		local var_50_0

		if arg_50_2 then
			var_50_0 = arg_50_2.pic_id

			if arg_50_3 > 0 then
				local var_50_3 = {}

				if self._skin_num == #self._now_ship_data.skins then
					var_50_0 = self:__get_skin_cfg(arg_50_2.skins[arg_50_3]).icon
				else
					for iter_50_0, iter_50_1 in pairs(self._now_ship_data.skins) do
						var_0_27(var_50_3, iter_50_1)
					end

					for iter_50_2, iter_50_3 in pairs(var_50_3) do
						local var_50_4 = var_0_6.find_object_by_cid(iter_50_3)

						if #var_50_4.card_cids == 1 and var_50_4.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_50_3, iter_50_2)
						end
					end

					var_50_0 = self:__get_skin_cfg(var_50_3[arg_50_3]).icon
				end
			end

			if self._enter_type == var_0_3.enter_ship_detail_type.mall_shop then
				var_50_0 = self:__get_skin_cfg(arg_50_2.skins[1]).icon
			end

			arg_50_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_4(var_0_3.ship_spine, var_50_0, var_50_0))
			arg_50_1.skeletonGraphic.initialSkinName = var_0_3.Q_ship_spine_skin_name_list.normal

			local var_50_5 = UnityEngine.Shader.Find("Spine/Special/SkeletonGhost")

			arg_50_1.skeletonGraphic.material.shader = var_50_5

			arg_50_1.skeletonGraphic:Initialize(true)
			arg_50_1.skeletonGraphic.AnimationState:SetAnimation(0, var_0_3.Q_ship_spine_anim_name_list.normal, true)

			if self._enter_type == var_0_3.enter_ship_detail_type.mall_shop then
				self._control.skin_layer.skin_bg_1.skeleton.ship_girl.skeletonGraphic.material.shader = var_50_5
			end
		else
			var_50_0 = self._data.pic_id
		end

		self:_set_q_size(var_50_0)

		self._control.shine.skeletonGraphic.material.shader = UnityEngine.Shader.Find("Spine/Special/SkeletonGhost")
	end

	function arg_1_0:_set_q_size(arg_51_1)
		self._control.skin_layer.skin_bg_1.skeleton.ship_girl.transform.localScale = Vector3.New(1, 1, 1)

		if tonumber(arg_51_1) == 180 then
			self._control.skin_layer.skin_bg_1.skeleton.ship_girl.transform.localScale = Vector3.New(1.2, 1.2, 1)
		elseif tonumber(arg_51_1) == 56 then
			self._control.skin_layer.skin_bg_1.skeleton.ship_girl.transform.localScale = Vector3.New(1.2, 1.2, 1)
		elseif tonumber(arg_51_1) == 1056 then
			self._control.skin_layer.skin_bg_1.skeleton.ship_girl.transform.localScale = Vector3.New(0.9, 0.9, 1)
		elseif tostring(arg_51_1) == "29_2" or tostring(arg_51_1) == "126_1" then
			self._control.skin_layer.skin_bg_1.skeleton.ship_girl.transform.localScale = Vector3.New(0.9, 0.9, 1)
		end
	end

	function arg_1_0:_set_q_size_two(arg_52_1)
		self._control.right.ship_layer.display_bg.ship_girl.transform.localScale = Vector3.New(0.8, 0.8, 1)

		if tonumber(arg_52_1) == 10018011 then
			self._control.right.ship_layer.display_bg.ship_girl.transform.localScale = Vector3.New(1, 1, 1)
		elseif tonumber(arg_52_1) == 10009011 or tonumber(arg_52_1) == 10009111 then
			self._control.right.ship_layer.display_bg.ship_girl.transform.localScale = Vector3.New(0.7, 0.7, 1)
		elseif tonumber(arg_52_1) == 10005612 then
			self._control.right.ship_layer.display_bg.ship_girl.transform.localScale = Vector3.New(0.9, 0.9, 1)
		elseif tonumber(arg_52_1) == 10024812 then
			self._control.right.ship_layer.display_bg.ship_girl.transform.localScale = Vector3.New(0.65, 0.65, 1)
		elseif tonumber(arg_52_1) == 10012612 then
			self._control.right.ship_layer.display_bg.ship_girl.transform.localScale = Vector3.New(0.75, 0.75, 1)
		end
	end

	function arg_1_0:__ship_map_ship_girl(arg_53_1)
		if arg_53_1 then
			var_0_36.display_bg.ship_girl.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(arg_53_1.spine)

			if var_0_36.display_bg.ship_girl.skeletonGraphic.skeletonDataAsset == nil then
				log.errorlog(arg_53_1.spine, "ship_spine_url如果出现此log，表明路径资源加载有问题")

				return
			end

			var_0_36.display_bg.ship_girl.skeletonGraphic.material.shader = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
			var_0_36.display_bg.ship_girl.skeletonGraphic.initialSkinName = var_0_3.ship_spine_skin_name_list.normal

			if var_0_36.display_bg.ship_girl.skeletonGraphic.AnimationState then
				var_0_36.display_bg.ship_girl.skeletonGraphic.AnimationState:SetAnimation(0, var_0_3.ship_spine_skin_name_list.normal, true)
			end

			var_0_36.display_bg.ship_girl.skeletonGraphic:Initialize(true)
			self:_set_q_size_two(arg_53_1.cid)
		end
	end

	function arg_1_0:set_skin_info(arg_54_1)
		self._now_show_skin_icon = arg_54_1

		if self._now_lable == 0 then
			var_0_37.scrollview.content.transform:GetChild(0):GetComponent("Toggle").interactable = false
			var_0_37.scrollview.content.transform:GetChild(arg_54_1):GetComponent("Toggle").isOn = true
		else
			for iter_54_0 = 1, var_0_37.scrollview.content.transform.childCount do
				var_0_37.scrollview.content.transform:GetChild(iter_54_0 - 1):GetComponent("Toggle").interactable = true
			end

			var_0_37.scrollview.content.transform:GetChild(arg_54_1):GetComponent("Toggle").isOn = true
		end

		if arg_54_1 ~= 0 then
			var_0_37.scrollview.content.transform:GetChild(0):GetComponent("Toggle").isOn = false
		end

		local var_54_0 = ""
		local var_54_1 = ""
		local var_54_2 = true
		local var_54_3 = false
		local var_54_4 = false
		local var_54_5 = false
		local var_54_6 = false
		local var_54_7 = false
		local var_54_8 = false
		local var_54_9 = false
		local var_54_10 = 0
		local var_54_11
		local var_54_12 = self._enter_type ~= var_0_3.enter_ship_detail_type.ship_map and self._enter_type ~= var_0_3.enter_ship_detail_type.mall_shop and self._enter_type ~= var_0_3.enter_ship_detail_type.bootyshop_clothes

		if arg_54_1 == 0 then
			var_54_0 = self._now_ship_data and self._now_ship_data.title or self._data.title
			var_54_1 = ""
			var_54_2 = false
			self._marry_type = nil

			if var_54_12 then
				var_54_7 = self._data.skin ~= 0
			end
		else
			local var_54_13 = {}

			if self._skin_num == #self._now_ship_data.skins then
				var_54_11 = self:__get_skin_cfg(self._now_ship_data.skins[arg_54_1])
			else
				for iter_54_1, iter_54_2 in pairs(self._now_ship_data.skins) do
					var_0_27(var_54_13, iter_54_2)
				end

				for iter_54_3, iter_54_4 in pairs(var_54_13) do
					local var_54_15 = var_0_6.find_object_by_cid(iter_54_4)

					if #var_54_15.card_cids == 1 and var_54_15.card_cids[1] ~= self._now_ship_data.cid then
						table.remove(var_54_13, iter_54_3)
					end
				end

				var_54_11 = self:__get_skin_cfg(var_54_13[arg_54_1])
			end

			self._marry_type = var_54_11.get_type
			var_54_0 = var_54_11.title
			var_54_10 = var_54_11.is_sale and var_0_16._get_open_time(var_54_11.sale_start_time, var_54_11.sale_end_time) and var_54_11.sale_discount or var_54_11.gold

			if var_54_11.get_type == 2 then
				if self._is_marry then
					var_54_6 = true
					var_54_4 = true
				else
					local var_54_17 = {}

					if self._skin_num == #self._now_ship_data.skins then
						var_54_4 = var_0_5:skin_have_exist(self._now_ship_data.skins[arg_54_1])
					else
						for iter_54_5, iter_54_6 in pairs(self._now_ship_data.skins) do
							var_0_27(var_54_17, iter_54_6)
						end

						for iter_54_7, iter_54_8 in pairs(var_54_17) do
							local var_54_19 = var_0_6.find_object_by_cid(iter_54_8)

							if #var_54_19.card_cids == 1 and var_54_19.card_cids[1] ~= self._now_ship_data.cid then
								table.remove(var_54_17, iter_54_7)
							end
						end

						var_54_4 = var_0_5:skin_have_exist(var_54_17[arg_54_1])
					end
				end

				var_54_1 = not var_54_4 and var_54_11.desc1 or var_54_11.desc2
			elseif var_54_11.get_type == 3 then
				var_54_1 = var_54_11.desc1
				var_54_1 = var_54_11.desc2
				var_54_9 = true
			elseif var_54_11.get_type == 0 then
				var_54_5 = true

				local var_54_20 = {}

				if self._skin_num == #self._now_ship_data.skins then
					var_54_8 = var_0_5:skin_have_exist(self._now_ship_data.skins[arg_54_1])
				else
					for iter_54_9, iter_54_10 in pairs(self._now_ship_data.skins) do
						var_0_27(var_54_20, iter_54_10)
					end

					for iter_54_11, iter_54_12 in pairs(var_54_20) do
						local var_54_22 = var_0_6.find_object_by_cid(iter_54_12)

						if #var_54_22.card_cids == 1 and var_54_22.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_54_20, iter_54_11)
						end
					end

					var_54_8 = var_0_5:skin_have_exist(var_54_20[arg_54_1])
				end

				self._ship_active_skin_cid = var_54_11.cid
				var_54_1 = var_54_11.desc1
				var_54_1 = var_54_11.desc2
			elseif var_54_10 <= 0 and self._marry_type ~= 4 then
				var_54_4 = var_0_5:skin_have_exist(self._now_ship_data.skins[arg_54_1])
				var_54_1 = not var_54_4 and var_54_11.desc1 or var_54_11.desc2
			elseif self._marry_type == 4 then
				self._control.skin_layer.skin_bg_2.price_icon:SetActive(false)
				self._control.skin_layer.skin_bg_2.confirmbtn:SetActive(false)

				self._need_buy = false

				self._control.skin_layer.skin_bg_2.usebtn:SetActive(true)

				var_54_1 = var_54_11.desc2
			else
				local var_54_23 = {}

				if self._skin_num == #self._now_ship_data.skins then
					var_54_2 = not var_0_5:skin_have_exist(self._now_ship_data.skins[arg_54_1])
				else
					for iter_54_13, iter_54_14 in pairs(self._now_ship_data.skins) do
						var_0_27(var_54_23, iter_54_14)
					end

					for iter_54_15, iter_54_16 in pairs(var_54_23) do
						local var_54_25 = var_0_6.find_object_by_cid(iter_54_16)

						if #var_54_25.card_cids == 1 and var_54_25.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_54_23, iter_54_15)
						end
					end

					var_54_2 = not var_0_5:skin_have_exist(var_54_23[arg_54_1])
				end

				var_54_1 = var_54_2 and var_54_11.desc1 or var_54_11.desc2
			end

			if var_54_12 then
				local var_54_26 = {}

				if self._skin_num == #self._now_ship_data.skins then
					var_54_7 = self._data.skin ~= self._now_ship_data.skins[arg_54_1]
				else
					for iter_54_17, iter_54_18 in pairs(self._now_ship_data.skins) do
						var_0_27(var_54_26, iter_54_18)
					end

					for iter_54_19, iter_54_20 in pairs(var_54_26) do
						local var_54_28 = var_0_6.find_object_by_cid(iter_54_20)

						if #var_54_28.card_cids == 1 and var_54_28.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_54_26, iter_54_19)
						end
					end

					var_54_7 = self._data.skin ~= var_54_26[arg_54_1]
				end
			end
		end

		if self._now_lable == 0 then
			var_54_0 = self._now_ship_data.title
			var_54_2 = not var_0_5:skin_have_exist(self._now_ship_data.cid)
			var_54_1 = self._now_ship_data.desc1
			var_54_11 = self:__get_skin_cfg(self._now_ship_data.cid)
			var_54_10 = var_54_11.is_sale and var_0_16._get_open_time(var_54_11.sale_start_time, var_54_11.sale_end_time) and var_54_11.sale_discount or self._now_ship_data.gold
			var_0_37.scrollview:GetComponent("ScrollRect").horizontal = false
			var_0_35.namebg.name_txt.text.text = self._now_ship_data.ship_name
		else
			var_0_37.scrollview:GetComponent("ScrollRect").horizontal = true
			var_0_35.namebg.name_txt.text.text = var_54_0
		end

		var_0_37.skin_bg_2.slash.name_bg:GetComponent("TextHorizonScroller"):SetText(var_54_0)

		self._need_buy = var_54_2
		self._now_index_2 = arg_54_1

		self:__init_ske(var_0_37.skin_bg_1.skeleton.ship_girl, self._now_ship_data, arg_54_1)
		self:show_skin_extra_desc()

		var_0_37.skin_bg_2.scrollview.content.info_txt.text.text = var_54_1

		if var_54_3 then
			var_0_37.skin_bg_2.price_icon:SetActive(false)
			var_0_37.skin_bg_2.confirmbtn:SetActive(false)

			self._need_buy = false

			for iter_54_21, iter_54_22 in pairs(var_0_6.find_object_by_cid(self._ship_active_skin_cid).card_cids) do
				if self._now_ship_data.cid == iter_54_22 then
					var_0_37.skin_bg_2.usebtn:SetActive(var_54_4 and var_54_12 and var_54_7)

					break
				else
					var_0_37.skin_bg_2.usebtn:SetActive(false)
				end
			end
		elseif var_54_5 then
			var_0_37.skin_bg_2.price_icon:SetActive(false)
			var_0_37.skin_bg_2.confirmbtn:SetActive(false)

			self._need_buy = false

			if var_54_8 then
				for iter_54_23, iter_54_24 in pairs(var_0_6.find_object_by_cid(self._ship_active_skin_cid).card_cids) do
					if self._now_ship_data.cid == iter_54_24 then
						if var_54_7 then
							var_0_37.skin_bg_2.usebtn:SetActive(true)

							break
						else
							var_0_37.skin_bg_2.usebtn:SetActive(false)
						end
					else
						var_0_37.skin_bg_2.usebtn:SetActive(false)
					end
				end
			else
				var_0_37.skin_bg_2.usebtn:SetActive(false)
			end
		elseif var_54_6 then
			var_0_37.skin_bg_2.price_icon:SetActive(false)
			var_0_37.skin_bg_2.confirmbtn:SetActive(false)

			self._need_buy = false

			var_0_37.skin_bg_2.usebtn:SetActive(var_54_4 and var_54_12 and var_54_7)
		elseif var_54_9 then
			var_0_37.skin_bg_2.price_icon:SetActive(false)
			var_0_37.skin_bg_2.confirmbtn:SetActive(false)

			self._need_buy = false

			var_0_37.skin_bg_2.usebtn:SetActive(var_54_9 and var_54_12 and var_54_7)
		elseif not var_54_6 and self._marry_type == 2 then
			var_0_37.skin_bg_2.price_icon:SetActive(false)
			var_0_37.skin_bg_2.confirmbtn:SetActive(false)

			self._need_buy = false

			var_0_37.skin_bg_2.usebtn:SetActive(var_54_7)
		elseif self._enter_type == var_0_3.enter_ship_detail_type.bootyshop_clothes then
			var_0_37.skin_bg_2.price_icon.num.text.text = var_54_10

			var_0_37.skin_bg_2.price_icon:SetActive(false)
			var_0_37.skin_bg_2.confirmbtn:SetActive(false)

			self._need_buy = false

			var_0_37.skin_bg_2.usebtn:SetActive(not var_54_2 and var_54_12 and var_54_7)
		elseif self._marry_type == 4 then
			var_0_37.skin_bg_2.price_icon:SetActive(false)
			var_0_37.skin_bg_2.confirmbtn:SetActive(false)

			self._need_buy = false

			var_0_37.skin_bg_2.usebtn:SetActive(true)
		else
			var_0_37.skin_bg_2.price_icon.num.text.text = var_54_10

			var_0_37.skin_bg_2.price_icon:SetActive(var_54_2)
			var_0_37.skin_bg_2.confirmbtn:SetActive(var_54_2)

			self._need_buy = var_54_2

			var_0_37.skin_bg_2.usebtn:SetActive(not var_54_2 and var_54_12 and var_54_7)

			if not var_54_11 and not self._now_ship_data then
				return
			end

			var_0_37.skin_bg_2.confirmbtn.button.onClick:RemoveAllListeners()
			var_0_37.skin_bg_2.confirmbtn.button.onClick:AddListener(function()
				local var_55_0 = var_54_11 or self._now_ship_data

				self:__buy_btn_call_shop_bounced({
					type = 5,
					price = var_54_10,
					id = var_55_0.cid,
					title = var_55_0.title,
					discount = var_55_0.sale_discount,
					is_sale = var_55_0.is_sale,
					sale_start_time = var_55_0.sale_start_time,
					sale_end_time = var_55_0.sale_end_time
				})
			end)
		end

		if self._enter_type == var_0_3.enter_ship_detail_type.ship_map then
			self._control.skin_layer.skin_bg_2.usebtn:SetActive(false)
		elseif self._enter_type == var_0_3.enter_ship_detail_type.mall_shop and self._now_character_data.bought and self._now_character_data.is_have then
			self._control.skin_layer.skin_bg_2.usebtn:SetActive(true)
		end
	end

	function arg_1_0.__buy_btn_call_shop_bounced(arg_56_0, arg_56_1)
		var_0_2:createInstance("shop_bounced"):show(arg_56_1)
	end

	function arg_1_0:update_price_btn_state()
		local var_57_0 = 0
		local var_57_1 = {}

		for iter_57_0, iter_57_1 in pairs(var_0_26.special_add_skin) do
			if self._now_ship_data.skins[self._now_show_skin_icon] == iter_57_0 then
				table.insert(var_57_1, iter_57_1)

				var_57_0 = 2
			else
				var_57_0 = 0
			end
		end

		self:set_skin_info(self._now_show_skin_icon)

		if self._enter_type ~= var_0_3.enter_ship_detail_type.mall_shop and self._enter_type ~= var_0_3.enter_ship_detail_type.default then
			local var_57_2 = var_0_2:createInstance("reward_tip")

			if var_57_0 == 2 then
				local function var_57_3()
					var_57_2:show(var_57_1[1], var_0_3.enter_get_ship_type.ship_map)
					var_57_2:clear__now_skin_data(2)
				end

				local var_57_4 = {}

				if self._skin_num == #self._now_ship_data.skins then
					var_57_2:show_by_enter_type(self._now_ship_data.skins[self._now_show_skin_icon], var_0_3.enter_get_ship_type.ship_map, var_57_3)
				else
					for iter_57_2, iter_57_3 in pairs(self._now_ship_data.skins) do
						var_0_27(var_57_4, iter_57_3)
					end

					for iter_57_4, iter_57_5 in pairs(var_57_4) do
						local var_57_6 = var_0_6.find_object_by_cid(iter_57_5)

						if #var_57_6.card_cids == 1 and var_57_6.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_57_4, iter_57_4)
						end
					end

					var_57_2:show_by_enter_type(var_57_4[self._now_show_skin_icon], var_0_3.enter_get_ship_type.ship_map, var_57_3)
				end
			else
				local var_57_7 = {}

				if self._skin_num == #self._now_ship_data.skins then
					var_57_2:show(self._now_ship_data.skins[self._now_show_skin_icon], var_0_3.enter_get_ship_type.ship_map)
				else
					for iter_57_6, iter_57_7 in pairs(self._now_ship_data.skins) do
						var_0_27(var_57_7, iter_57_7)
					end

					for iter_57_8, iter_57_9 in pairs(var_57_7) do
						local var_57_9 = var_0_6.find_object_by_cid(iter_57_9)

						if #var_57_9.card_cids == 1 and var_57_9.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_57_7, iter_57_8)
						end
					end

					var_57_2:show(var_57_7[self._now_show_skin_icon], var_0_3.enter_get_ship_type.ship_map)
				end

				var_57_2:clear__now_skin_data(1, nil)
			end
		end
	end

	function arg_1_0:show_layer(arg_59_1)
		if arg_59_1 == 1 then
			self:__show_role_icon()
			self:__get_now_skin_index()
		else
			self:__get_now_skin_index()
		end

		local var_59_0 = self._is_single or self._is_team
		local var_59_1 = self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip

		self._control.left.skip_info:SetActive(arg_59_1 == 1 and not var_59_0)
		self._control.right.ship_layer:SetActive(arg_59_1 == 1 and not var_59_0)
		self._control.left.ship_love:SetActive(arg_59_1 == 1 and var_59_0)
		self._control.right.ship_detail:SetActive(arg_59_1 == 1 and var_59_0 and not var_59_1)
		self._control.left.skin_info:SetActive(arg_59_1 ~= 1)
		self._control.skin_layer:SetActive(arg_59_1 ~= 1)

		self._now_lable = arg_59_1

		self._control.left.alone_view_btn:SetActive(false)

		if self._enter_type == var_0_3.enter_ship_detail_type.ship_map then
			local var_59_2 = arg_59_1 == 1 and not var_59_0

			self._control.left.alone_view_btn:SetActive(false)
			var_0_33.view_btn:SetActive(var_59_2)
		end

		if self._enter_type == var_0_3.enter_ship_detail_type.mail_ship_award or self._enter_type == var_0_3.enter_ship_detail_type.upgradeawards or self._enter_type == var_0_3.enter_ship_detail_type.eighth_bootyshop or self._enter_type == var_0_3.enter_ship_detail_type.ninth_shop or self._enter_type == var_0_3.enter_ship_detail_type.bootyshop then
			self._control.left.alone_view_btn:SetActive(true)
		end

		if self._enter_type == var_0_3.enter_ship_detail_type.bootyshop_clothes or self._enter_type == var_0_3.enter_ship_detail_type.remake then
			self._control.left.alone_view_btn:SetActive(false)
		end

		if arg_59_1 == 2 then
			self._control.left.ship_btns.set_custom_btn:SetActive(false)
			self._control.left.ship_btns.cancel_custom_btn:SetActive(false)
		elseif arg_59_1 == 1 then
			self:set_custom_info()
		end
	end

	function arg_1_0:set_video_layer()
		local var_60_0 = var_0_5:get_cardbook_ship_list()

		for iter_60_0, iter_60_1 in ipairs(var_60_0) do
			if iter_60_1.id == self._now_ship_data.cid then
				if iter_60_1.married then
					self._control.video_btn_layer.video_btn_2:SetActive(true)
					self._control.video_btn_layer.btn_mask:SetActive(false)

					self._is_married = true

					break
				end

				self._control.video_btn_layer.video_btn_2:SetActive(false)
				self._control.video_btn_layer.btn_mask:SetActive(true)

				self._is_married = false

				if self._now_ship_data.can_evo then
					for iter_60_2, iter_60_3 in pairs(var_60_0) do
						if iter_60_3.id == ((self._now_ship_data.can_evo or nil) and self._now_ship_data.evo_to_cid) then
							if iter_60_3.married then
								self._control.video_btn_layer.video_btn_2:SetActive(true)
								self._control.video_btn_layer.btn_mask:SetActive(false)

								self._is_married = true
							else
								self._control.video_btn_layer.video_btn_2:SetActive(false)
								self._control.video_btn_layer.btn_mask:SetActive(true)

								self._is_married = false
							end
						end
					end

					break
				end

				for iter_60_4, iter_60_5 in pairs(var_60_0) do
					if iter_60_5.id == self._now_ship_data.evo_cid then
						if iter_60_5.married then
							self._control.video_btn_layer.video_btn_2:SetActive(true)
							self._control.video_btn_layer.btn_mask:SetActive(false)

							self._is_married = true
						else
							self._control.video_btn_layer.video_btn_2:SetActive(false)
							self._control.video_btn_layer.btn_mask:SetActive(true)

							self._is_married = false
						end
					end
				end

				break
			end
		end
	end

	function arg_1_0.reset_enter_type(arg_61_0)
		arg_61_0._enter_type = var_0_3.enter_ship_detail_type.default
	end

	function arg_1_0.set_enter_type(arg_62_0)
		arg_62_0._enter_type = var_0_3.enter_ship_detail_type.single_ship
	end

	function arg_1_0.__get_ship_cfg(arg_63_0, arg_63_1)
		return (var_0_7.find_object_by_cid(arg_63_1))
	end

	function arg_1_0.__get_skin_cfg(arg_64_0, arg_64_1)
		return (var_0_6.find_object_by_cid(arg_64_1))
	end

	function arg_1_0:__init_variate()
		var_0_33 = self._control.left.skin_btns
		var_0_38 = self._control.left.ship_btns
		var_0_34 = self._control.left.skip_info
		var_0_35 = self._control.left.skin_info
		var_0_39 = self._control.left.ship_love
		var_0_36 = self._control.right.ship_layer
		var_0_40 = self._control.right.ship_detail
		var_0_37 = self._control.skin_layer
		var_0_41 = self._control.right.ship_equip_detail
	end

	function arg_1_0:__init_panel()
		self._special_paint_url = nil
		self._is_mall_change_init = false

		if self._now_ship_data then
			self:show_ship_icon(self._now_ship_data.pic_id)
		elseif self._data.pic_id then
			self:show_ship_icon(self._data.pic_id)
		end

		local var_66_0 = var_0_2:getInstance("pre_formation")

		if var_66_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_66_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self:set_custom_info()
		self:__init_panel_by_type()
		self:__init_ship_pos()
		self:__init_effect()
	end

	function arg_1_0:__init_ship_pos()
		self._ship_init_pos = self._control.left.ship_role.rectTransform.anchoredPosition

		if self._enter_type == var_0_3.enter_ship_detail_type.war_concerto_play then
			self._ship_init_pos = var_0_14(640, 0)
		else
			self._control.left.ship_role.rectTransform.anchoredPosition = var_0_14(440, 50)
			self._ship_init_pos = self._control.left.ship_role.rectTransform.anchoredPosition
		end

		self._anchoredPosition = self._control.left.ship_role.rectTransform.anchoredPosition
		self._finalPos = self._control.left.ship_role.rectTransform.anchoredPosition + self._offsetVec
		self._offsetVec = Vector3(200, 0, 0)
		self._init_picture_scale = self._control.left.ship_role.transform.localScale
	end

	function arg_1_0.__init_effect(arg_68_0)
		return
	end

	function arg_1_0:__init_panel_by_type()
		local var_69_0 = self._enter_type == var_0_3.enter_ship_detail_type.ship_map
		local var_69_1 = self._enter_type == var_0_3.enter_ship_detail_type.mall_shop
		local var_69_2 = self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip
		local var_69_3 = self._enter_type == var_0_3.enter_ship_detail_type.bootyshop_clothes
		local var_69_4 = self._is_single or self._is_team

		if self:__show_big_pic() then
			return
		end

		if var_0_37 and not var_0_37:Equals(nil) then
			var_0_37:SetActive(false)
		end

		self._control.left.drag_for_switch:SetActive(self._is_team and #self._members > 1)

		if self._enter_type == var_0_3.enter_ship_detail_type.dock then
			self._control.left.drag_for_switch:SetActive(false)
		end

		self._control.skin_layer.rectTransform.anchoredPosition = var_0_14(0, 0)

		var_0_39:SetActive(var_69_4)
		var_0_38:SetActive(var_69_4)
		var_0_40:SetActive(var_69_4 and not var_69_2)
		var_0_41:SetActive(var_69_2)
		var_0_34:SetActive(not var_69_4)
		var_0_35:SetActive(not var_69_4)
		var_0_36:SetActive(not var_69_4)

		self._now_lable = var_69_1 and 0 or 1

		var_0_37.skin_bg_2.usebtn:SetActive(false)

		if var_69_0 and self._is_unlock ~= nil then
			var_0_33:SetActive(self._is_unlock)
		end

		if self._enter_type ~= var_0_3.enter_ship_detail_type.ship_map then
			var_0_33:SetActive(false)
		end

		if self._enter_type == var_0_3.enter_ship_detail_type.bootyshop_clothes then
			self._now_lable = var_69_3 and 0 or 1
		end

		self:init_skin_info()

		if self._enter_type == var_0_3.enter_ship_detail_type.ship_map or self._enter_type == var_0_3.enter_ship_detail_type.upgradeawards or self._enter_type == var_0_3.enter_ship_detail_type.mail_ship_award or self._enter_type == var_0_3.enter_ship_detail_type.bootyshop or self._enter_type == var_0_3.enter_ship_detail_type.eighth_bootyshop or self._enter_type == var_0_3.enter_ship_detail_type.ninth_shop or self._enter_type == var_0_3.enter_ship_detail_type.seven_bootyshop then
			self:init_ship_info()
			self:set_video_layer()
			self:set_skin_info(0)

			if self._enter_type == var_0_3.enter_ship_detail_type.upgradeawards or self._enter_type == var_0_3.enter_ship_detail_type.bootyshop or self._enter_type == var_0_3.enter_ship_detail_type.eighth_bootyshop or self._enter_type == var_0_3.enter_ship_detail_type.ninth_shop or self._enter_type == var_0_3.enter_ship_detail_type.seven_bootyshop then
				self:__init_slider_listenter()
				self._control.left.alone_view_btn:SetActive(true)

				self._is_up_ship = true
			elseif self._enter_type == var_0_3.enter_ship_detail_type.ship_map or self._enter_type == var_0_3.enter_ship_detail_type.mail_ship_award then
				self:__init_slider_listenter()
			end
		elseif self._enter_type == var_0_3.enter_ship_detail_type.bootyshop_clothes then
			self:set_skin_info(0)

			self._now_lable = var_69_3 and 0 or 1

			self:__init_slider_listenter()
			self:play_mall_anim(true)
		elseif self._enter_type == var_0_3.enter_ship_detail_type.mall_shop then
			self._is_mall_change_init = true

			self:set_skin_info(0)
			self:__init_slider_listenter()
		elseif self._enter_type == var_0_3.enter_ship_detail_type.new_ship then
			self:init_ship_info()
			self:set_skin_info(0)
			self:__init_slider_listenter()
		elseif self._is_single or self._is_team then
			self:update_character_data()

			local var_69_5 = 0

			if self._now_ship_data then
				local var_69_6 = {}

				if self._now_ship_data.skins and self._skin_num == #self._now_ship_data.skins then
					for iter_69_0, iter_69_1 in pairs(self._now_ship_data.skins) do
						if self._data.skin == iter_69_1 then
							var_69_5 = iter_69_0
						end
					end
				else
					for iter_69_2, iter_69_3 in pairs(self._now_ship_data.skins) do
						table.insert(var_69_6, iter_69_3)
					end

					for iter_69_4, iter_69_5 in pairs(var_69_6) do
						local var_69_8 = var_0_6.find_object_by_cid(iter_69_5)

						if #var_69_8.card_cids == 1 and var_69_8.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_69_6, iter_69_4)
						end
					end

					for iter_69_6, iter_69_7 in pairs(var_69_6) do
						if self._data.skin == iter_69_7 then
							var_69_5 = iter_69_6
						end
					end
				end
			end

			self:set_skin_info(var_69_5)

			if var_69_5 ~= 0 then
				if self._now_ship_data then
					self:show_ship_icon(self:__get_skin_cfg(self._now_ship_data.skins[var_69_5]).icon)
				elseif self._data.pic_id then
					self:show_ship_icon(self._data.pic_id)
				end
			end

			self:__init_slider_listenter()
			var_0_38.dress_toggle:SetActive(not var_69_2)
			self:__init_equip_content()
			self:__init_equips()

			if var_69_2 then
				self:__init_ship_detail_content(var_0_41.ship_equip_detail_content.detail_2)
				self:init_ship_equip_detail_info()
			else
				self:__init_ship_detail_content(var_0_40.detail_info.detail)
				self:__refresh_detail_page()
				self:init_ship_detail_info()
				self:__refresh_tactics_ui()
				var_0_40.change_name:SetActive(true)

				if self._is_my_ship and (self._special_enter_type == var_0_3.enter_ship_detail_type.robot_ship or self._special_enter_type == var_0_3.captainroom_friend_fleet) then
					var_0_40.change_name:SetActive(false)
				end

				self:word_is_conform()

				if self:__is_special_type(2) and self._is_my_ship then
					var_0_40.change_name:SetActive(false)
					var_0_38.leader_toggle:SetActive(false)
					var_0_38.secretary_btn:SetActive(false)
					var_0_38.lock_toggle:SetActive(false)
					var_0_38.achieve_btn:SetActive(false)
					var_0_38.equip_record_btn:SetActive(false)
					var_0_38.dress_toggle:SetActive(false)
					var_0_38.set_custom_btn:SetActive(false)
					var_0_38.cancel_custom_btn:SetActive(false)
				else
					var_0_38.dress_toggle.toggle.isOn = false

					self:__set_ship_btns((self._control.left.ship_btns.dress_toggle.toggle.isOn or not self._now_ship_data) and true or false)

					if not self._now_ship_data then
						var_0_38.dress_toggle:SetActive(false)
						var_0_38.view_btn:SetActive(true)
					end
				end
			end
		end

		self:show_layer(self._now_lable)

		self._now_paint_sprite = self._control.left.ship_role.image.sprite
	end

	function arg_1_0:__init_equip_content()
		local var_70_0 = self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip and var_0_41.ship_equip_detail_content or var_0_40.ship_equip

		self._equip_content = {
			var_70_0.equip_1,
			var_70_0.equip_2,
			var_70_0.equip_3,
			var_70_0.equip_4
		}
	end

	function arg_1_0:__init_languagee()
		if self._is_already_init then
			return
		end

		var_0_36.detail_item_1.type_txt.text.text = var_0_1:getNowLang("cardattribute1")
		var_0_36.detail_item_2.type_txt.text.text = var_0_1:getNowLang("cardattribute2")
		var_0_36.detail_item_3.type_txt.text.text = var_0_1:getNowLang("cardattribute3")
		var_0_36.detail_item_4.type_txt.text.text = var_0_1:getNowLang("cardattribute5")
		var_0_36.detail_item_5.type_txt.text.text = var_0_1:getNowLang("cardattribute6")
		var_0_36.detail_item_6.type_txt.text.text = var_0_3.ship_map_special_attr_str
		var_0_41.ship_equip_detail_content.ship_equip.equip_title.text.text = var_0_1:getNowLang("shipinfocurrentequips")

		gamecore.util_func.setTextHorizonInfo(var_0_36.title_mask, var_0_1:getNowLang("shipdesctitle"))

		var_0_37.skin_bg_2.confirmbtn.buy_txt.text.text = var_0_1:getNowLang("shopfunctiontitle")
		var_0_37.skin_bg_2.usebtn.title.text.text = var_0_1:getNowLang("ui_skin_use")
		var_0_40.ship_equip.shipinfocurrentequips.text.text = var_0_1:getNowLang("shipinfocurrentequips")

		self:__init_detail_attr_title(var_0_40.detail_info.detail)
		self:__init_detail_attr_title(var_0_41.ship_equip_detail_content.detail_2)

		self._is_already_init = true
	end

	function arg_1_0.__init_detail_attr_title(arg_72_0, arg_72_1)
		arg_72_1.attr_hp.hp.text.text = var_0_1:getNowLang("hp")
		arg_72_1.attr_atk.atk.text.text = var_0_1:getNowLang("atk")
		arg_72_1.attr_def.def.text.text = var_0_1:getNowLang("def")
		arg_72_1.attr_torpedo.torpedo.text.text = var_0_1:getNowLang("torpedo")
		arg_72_1.attr_miss.miss.text.text = var_0_1:getNowLang("miss")
		arg_72_1.attr_airdef.airdef.text.text = var_0_1:getNowLang("airdef")
		arg_72_1.attr_capacity.capacity.text.text = var_0_1:getNowLang("capacity")
		arg_72_1.attr_antisub.antisub.text.text = var_0_1:getNowLang("antisub")
		arg_72_1.attr_speed.speed.text.text = var_0_1:getNowLang("speed")
		arg_72_1.attr_radar.radar.text.text = var_0_1:getNowLang("radar")
		arg_72_1.attr_range.range.text.text = var_0_1:getNowLang("range")
		arg_72_1.attr_luck.luck.text.text = var_0_1:getNowLang("luck")
	end

	function arg_1_0:__init_slider_listenter()
		self._control.role_scale.slide.slider.value = 0

		self._control.role_scale.slide.slider.onValueChanged:AddListener(function(arg_74_0)
			local var_74_0 = Vector3(var_0_43 + arg_74_0 * (var_0_42 - var_0_43), var_0_43 + arg_74_0 * (var_0_42 - var_0_43), var_0_43 + arg_74_0 * (var_0_42 - var_0_43))

			if self._is_picture_hd == true then
				var_74_0 = var_74_0 / 2
			end

			self._control.left.ship_role.transform.localScale = var_74_0
		end)
		var_0_40.change_name.inputField.onEndEdit:RemoveAllListeners()
		var_0_40.change_name.inputField.onEndEdit:AddListener(function()
			self._new_name = var_0_40.change_name.inputField.text

			local var_75_0 = app:getSystem():getChannel()

			if self._new_name == " " then
				var_0_15:show((var_0_1:getNowLang("errorcode-129")))
			elseif self._new_name == "" then
				self.ship_data = nil

				if self._data.cid then
					self.ship_data = var_0_7.find_object_by_cid(self._data.cid)
				end

				self._new_name = self.ship_data.title

				var_0_5:req_ShipRename({
					id = self._data.id,
					name = self.ship_data.title
				})

				var_0_40.change_name.inputField.text = ""
			elseif (var_75_0 == var_0_3.channel.android_jp or var_75_0 == var_0_3.channel.iOS_jp) and var_0_16.calculate_utf8_char_length(self._new_name) > 40 then
				var_0_15:show(var_0_1:getNowLang("errorcode_067"))
			elseif var_75_0 ~= var_0_3.channel.android_jp and var_75_0 ~= var_0_3.channel.iOS_jp and var_0_16.calculate_utf8_char_length(self._new_name) > 16 then
				var_0_15:show(var_0_1:getNowLang("errorcode_067"))
			elseif self:__check_illegal_string(self._new_name) then
				var_0_5:req_ShipRename({
					id = self._data.id,
					name = self._new_name
				})
			end

			var_0_40.change_name.inputField.text = ""
		end)
	end

	function arg_1_0:__check_illegal_string(arg_76_1)
		local var_76_0 = true

		if arg_76_1 == var_0_7.find_object_by_cid(self._data.cid).title then
			return var_76_0
		else
			local var_76_1, var_76_2 = var_0_16.calculate_utf8_char_length(arg_76_1)

			for iter_76_0, iter_76_1 in pairs((var_0_19.get_sequence())) do
				if iter_76_1.word ~= "" and string.find(arg_76_1, iter_76_1.word, 1, true) ~= nil then
					var_76_0 = false

					local var_76_3 = var_0_5:get_account_id()

					var_0_5:req_SensitiveWordsReq({
						type = var_0_3.sensitive_words_type.ship_name,
						sensitive_words = self._new_name
					})

					break
				end
			end

			var_76_0 = var_76_0 and not var_0_16:filter_spec_chars(arg_76_1)

			if not var_76_0 then
				var_0_15:show((var_0_1:getNowLang("errorcode-129")))
			end

			return var_76_0
		end
	end

	function arg_1_0:update_name()
		var_0_40.ship_title.ship_name_move:GetComponent("TextHorizonScroller"):SetText(self._new_name)

		self._default_name = self._new_name
		var_0_40.change_name.inputField.text = ""
	end

	function arg_1_0:__set_ship_btns(arg_78_1)
		self._control.left.ship_btns.achieve_btn:SetActive(not arg_78_1)
		self._control.left.ship_btns.lock_toggle:SetActive(not arg_78_1)
		self._control.left.ship_btns.leader_toggle:SetActive(false)
		self._control.left.ship_btns.secretary_btn:SetActive(not arg_78_1)
		self._control.left.ship_btns.view_btn:SetActive(not arg_78_1)
		self._control.left.ship_btns.equip_record_btn:SetActive(not arg_78_1)
	end

	function arg_1_0:__look_over_view(arg_79_1)
		local var_79_0 = self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip

		self._control.right.ship_detail:SetActive(not arg_79_1 and not var_79_0)
		self._control.right.ship_equip_detail:SetActive(not arg_79_1 and var_79_0)
		self._control.role_scale:SetActive(arg_79_1)
		self._control.right_btn_ship:SetActive(arg_79_1)
		self._control.left.ship_btns:SetActive(not arg_79_1)
		self._control.left.return_btn:SetActive(not arg_79_1)
		self._control.left.ship_love:SetActive(not arg_79_1)

		local var_79_1 = 2240
		local var_79_2 = 1260

		if UnityEngine.Screen.width / UnityEngine.Screen.height > 1.33 and UnityEngine.Screen.width / UnityEngine.Screen.height < 1.34 then
			var_79_1 = 2240
			var_79_2 = 1680
		end

		self._control.left.ship_role.shipViewControl.onDrag:RemoveAllListeners()
		self._control.left.ship_role.shipViewControl.onDrag:AddListener(function(arg_80_0, arg_80_1)
			local var_80_0 = self._control.left.ship_role.rectTransform.anchoredPosition.x + arg_80_0
			local var_80_1 = self._control.left.ship_role.rectTransform.anchoredPosition.y + arg_80_1

			if self._control.left.ship_role.rectTransform.anchoredPosition.x + arg_80_0 <= 0 then
				var_80_0 = 0
			end

			if var_80_0 >= var_79_1 then
				var_80_0 = var_79_1
			end

			if var_80_1 <= -var_79_2 / 2 + 66.5 then
				var_80_1 = -var_79_2 / 2 + 66.5
			end

			if var_80_1 >= var_79_2 / 2 + 66.5 then
				var_80_1 = var_79_2 / 2 + 66.5
			end

			self._control.left.ship_role.rectTransform.anchoredPosition = var_0_14(var_80_0, var_80_1)
		end)
		self._control.right_btn_ship.switch_btn:SetActive(false)

		if arg_79_1 and self._data then
			local var_79_3 = false
			local var_79_4

			if self._data.skin == 0 then
				local var_79_5 = var_0_7.find_object_by_cid(self._now_ship_data.cid)

				var_79_3 = self._now_ship_data.battle_pic == 1
				var_79_4 = self._now_ship_data.pic_id
			else
				local var_79_6 = self:__get_skin_cfg(self._data.skin)

				if var_79_6 then
					var_79_3 = var_79_6.battle_pic == 1
					var_79_4 = var_79_6.icon
				end
			end

			if var_79_3 then
				local var_79_7 = var_0_3.ship_icon_type.model_l

				if self._is_picture_hd then
					var_79_7 = var_0_3.ship_icon_type.model_l_hd
				end

				self._special_paint_url = var_0_3:get_ship_icon(var_0_16:use_big_break_painting(self._now_character_data, var_79_7, self._is_open_broken, true), var_79_4)
				self._fight_specail_url = var_0_3:get_ship_icon(var_0_16:use_big_break_painting(self._now_character_data, var_79_7, false, true), var_79_4)
			end

			self._control.right_btn_ship.switch_btn:SetActive(var_79_3)
		end
	end

	function arg_1_0:__init_equips()
		local var_81_0 = self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip
		local var_81_1 = #self._equip_content

		for iter_81_0 = 1, #self._equip_content do
			self._equip_content[iter_81_0].nil_bg:SetActive(false)
			self._equip_content[iter_81_0].add_equip:SetActive(false)
			self._equip_content[iter_81_0].equipment:SetActive(false)
		end

		self._data.equipment_num = self._data.equipment_num or var_0_7.find_object_by_cid(self._data.cid).equipment_num

		for iter_81_1 = tonumber(self._data.equipment_num) + 1, var_81_1 do
			if self._equip_content[iter_81_1] then
				self._equip_content[iter_81_1].nil_bg:SetActive(true)
			end
		end

		for iter_81_2 = 1, tonumber(self._data.equipment_num) do
			local var_81_2 = self._data.equips[iter_81_2]

			if self._data.equips[iter_81_2] and type(var_81_2) ~= "number" and var_81_2.id then
				self._equip_content[iter_81_2].add_equip:SetActive(var_81_2.id == 0)
				self._equip_content[iter_81_2].equipment:SetActive(var_81_2.id ~= 0)

				if var_81_2.id ~= 0 then
					local var_81_3 = var_0_8.find_object_by_cid(var_81_2.id)

					if var_81_3 then
						self._equip_content[iter_81_2].equipment.equip_rarity.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_back.equip_back_normal, var_81_3.star))
						self._equip_content[iter_81_2].equipment.equip_icon.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_icon.large, var_81_3.pic_id))

						self._equip_content[iter_81_2].equipment.off_btn:SetActive(true)

						self._equip_content[iter_81_2].equipment.name_mask.equipname.text.text = var_81_3.title

						self._equip_content[iter_81_2].equipment.name_mask.textHorizonScroller:SetText(var_81_3.title)
					end

					if not var_0_5:get_other_info() then
						local var_81_4 = 0

						if var_81_2.carry_type == var_0_3.equip_carry_type.plane then
							var_81_4 = self._now_ship_data.capacity_slot[iter_81_2]
						elseif var_81_2.carry_type == var_0_3.equip_carry_type.missile then
							var_81_4 = self._now_ship_data.missile_slot[iter_81_2]
						end

						if var_81_4 ~= 0 and var_81_4 ~= nil then
							self._equip_content[iter_81_2].equipment.carry_num.text.text = var_81_2.num .. "/" .. var_81_4
						end

						self._equip_content[iter_81_2].equipment.carry_num:SetActive(var_81_4 ~= 0)
					else
						self._equip_content[iter_81_2].equipment.off_btn:SetActive(false)
						self._equip_content[iter_81_2].equipment.carry_num:SetActive(false)
					end

					if var_81_0 then
						local var_81_5 = var_0_5:find_equipment_by_id(var_81_2.id)

						if not var_81_5 then
							self._equip_content[iter_81_2].equipment.clock:SetActive(false)
						else
							self._equip_content[iter_81_2].equipment.clock:SetActive(var_81_5.lock)
						end

						local var_81_6 = var_0_5:get_lock_equipment_data()

						if var_81_6 then
							for iter_81_3, iter_81_4 in pairs(var_81_6) do
								if iter_81_4 == var_81_2.id then
									self._equip_content[iter_81_2].equipment.clock:SetActive(true)
								end
							end
						end

						self:__set_single_equip_attrs(self._equip_content[iter_81_2].equipment, var_81_2.id)
					end
				end
			else
				self._equip_content[iter_81_2].add_equip:SetActive(false)
				self._equip_content[iter_81_2].equipment:SetActive(true)
				self._equip_content[iter_81_2].equipment.carry_num:SetActive(false)

				if var_81_2 and var_81_2 ~= 0 then
					local var_81_7 = var_0_8.find_object_by_cid(var_81_2)

					self._equip_content[iter_81_2].equipment.name_mask.equipname.text.text = var_81_7.title

					self._equip_content[iter_81_2].equipment.name_mask.textHorizonScroller:SetText(var_81_7.title)

					self._equip_content[iter_81_2].equipment.equip_rarity.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_back.equip_back_normal, var_81_7.star))
					self._equip_content[iter_81_2].equipment.equip_icon.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_icon.large, var_81_7.pic_id))

					self._equip_content[iter_81_2].equipment.off_btn:SetActive(false)
				else
					self._equip_content[iter_81_2].add_equip:SetActive(true)
					self._equip_content[iter_81_2].equipment:SetActive(false)
				end
			end
		end
	end

	function arg_1_0.__set_single_equip_attrs(arg_82_0, arg_82_1, arg_82_2)
		local var_82_0 = {
			arg_82_1.attrib_1,
			arg_82_1.attrib_2,
			arg_82_1.attrib_3
		}
		local var_82_1 = var_0_3:get_equip_attribute(arg_82_2)

		for iter_82_0 = 1, #var_82_0 do
			if not var_82_1[iter_82_0] then
				var_82_0[iter_82_0]:SetActive(false)
			else
				if var_0_3.equip_attribute[var_82_1[iter_82_0].index] == "range" then
					var_82_0[iter_82_0].count.text.text = var_82_1[iter_82_0].count
					var_82_0[iter_82_0].add.text.text = ""
				elseif var_82_1[iter_82_0].count > 0 then
					var_82_0[iter_82_0].add.text.text = "+"
					var_82_0[iter_82_0].count.text.text = var_82_1[iter_82_0].count
				else
					var_82_0[iter_82_0].add.text.text = "-"
					var_82_0[iter_82_0].count.text.text = math.abs(var_82_1[iter_82_0].count)
				end

				var_82_0[iter_82_0].title.text.text = var_0_3:get_equip_attribute_name(var_0_3.equip_attribute[var_82_1[iter_82_0].index])

				var_82_0[iter_82_0]:SetActive(true)
			end
		end
	end

	function arg_1_0:__set_left_ship_detail()
		if self._data.marry and self._data.love then
			var_0_39.heart_icon.image.fillAmount = (self._data.love or 0) / var_0_3.ship_love.marry_love_limit
			var_0_39.love_limit.text.text = "/" .. math.floor(var_0_3.ship_love.marry_love_limit / 100)
		elseif self._data.love then
			var_0_39.heart_icon.image.fillAmount = (self._data.love or 0) / var_0_3.ship_love.love_init_limit
			var_0_39.love_limit.text.text = "/" .. math.floor(var_0_3.ship_love.love_init_limit / 100)
		else
			var_0_39.heart_icon.image.fillAmount = 1
			var_0_39.love_limit.text.text = "/0"
		end

		self._no_req = true
		var_0_39.love_num.text.text = self._data.love and math.floor(self._data.love / 100) or 0

		if self._now_ship_data then
			local var_83_3 = lx.clone_table(var_0_5:get_secretary_info().members)
			local var_83_4 = var_0_5:get_use_info_data().secretary_follow

			var_0_38.leader_toggle.toggle.isOn = false

			if var_83_3 and next(var_83_3) then
				var_0_38.secretary_btn.image.sprite = var_0_16.have_data(var_83_3, self._data.id) and self:loadSprite(var_0_3.secretary_list_img.shipDetail_btn_leader_unactive1) or self:loadSprite(var_0_3.secretary_list_img.shipDetail_btn_leader_active1)
			end

			var_0_38.lock_toggle.toggle.isOn = self._data.lock

			self:__set_ship_btns(false)

			local var_83_5 = {}

			if #self._now_ship_data.skins > 0 then
				for iter_83_0, iter_83_1 in pairs(self._now_ship_data.skins) do
					var_0_27(var_83_5, iter_83_1)
				end

				for iter_83_2, iter_83_3 in ipairs(var_83_5) do
					if not self._now_ship_data.evo_class and (iter_83_3 - 1000000000) % 10000 % 1000 / 100 < 0.9 then
						table.remove(var_83_5, iter_83_2)
					end
				end
			end

			var_0_38.dress_toggle:SetActive(#var_83_5 > 0 and self._enter_type ~= var_0_3.enter_ship_detail_type.dock_team_equip)

			self._no_req = false
			var_0_39.ship_type.text.text = var_0_1:getNowLang(var_0_3:get_ship_type_language_key(self._now_ship_data.type, 1))
			var_0_39.national_text.text.text = var_0_1:getNowLang(var_0_3:get_country_language_key(self._now_ship_data.country))
		else
			var_0_39.ship_type.text.text = var_0_1:getNowLang(var_0_3:get_ship_type_language_key(self._data.type, 1))
			var_0_39.national_text.text.text = var_0_1:getNowLang(var_0_3:get_country_language_key(self._data.country))
		end
	end

	function arg_1_0:__refresh_detail_page()
		var_0_40.detail_info.detail:SetActive(not self._is_tactics)
		var_0_40.detail_info.tactics:SetActive(self._is_tactics)

		if self._is_tactics then
			var_0_40.detail_info.page_1.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 6))
			var_0_40.detail_info.page_2.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 5))
			var_0_40.detail_info.left_arrow.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 3))
			var_0_40.detail_info.right_arrow.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 4))
		else
			var_0_40.detail_info.page_1.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 5))
			var_0_40.detail_info.page_2.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 6))
			var_0_40.detail_info.left_arrow.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 4))
			var_0_40.detail_info.right_arrow.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail_page.detail_page_by_index, 3))
		end
	end

	function arg_1_0:__get_equip_data(arg_85_1)
		if not self._data.equips[arg_85_1] then
			return nil
		end

		return (var_0_8.find_object_by_cid(type(self._data.equips[arg_85_1]) ~= "number" and self._data.equips[arg_85_1].id and self._data.equips[arg_85_1].id or self._data.equips[arg_85_1]))
	end

	function arg_1_0:__refresh_tactics_ui()
		local var_86_0 = var_0_40.detail_info.tactics

		if self._data.tactics then
			var_86_0.content.tactics_1.tactics_1_content:SetActive(self._data.tactics[1] ~= 0)
			var_86_0.content.tactics_2.tactics_2_content:SetActive(self._data.tactics[2] ~= 0)
			var_86_0.content.tactics_3.tactics_3_content:SetActive(self._data.tactics[3] ~= 0)
			var_86_0.content.tactics_1.no_open:SetActive(self._data.level < var_0_3.tactics_unlock_level.atk)
			var_86_0.content.tactics_2.no_open:SetActive(self._data.level < var_0_3.tactics_unlock_level.def)
			var_86_0.content.tactics_3.no_open:SetActive(self._data.level < var_0_3.tactics_unlock_level.special)
			var_86_0.content.tactics_1.add_btn:SetActive(self._data.tactics[1] == 0 and self._data.level >= var_0_3.tactics_unlock_level.atk)
			var_86_0.content.tactics_2.add_btn:SetActive(self._data.tactics[2] == 0 and self._data.level >= var_0_3.tactics_unlock_level.def)
			var_86_0.content.tactics_3.add_btn:SetActive(self._data.tactics[3] == 0 and self._data.level >= var_0_3.tactics_unlock_level.special)

			if self._data.level < var_0_3.tactics_unlock_level.atk then
				var_86_0.content.tactics_1.no_open.text.text = var_0_4(var_0_1:getNowLang("levelcanopentactics"), var_0_3.tactics_unlock_level.atk)
			elseif self._data.tactics[1] ~= 0 then
				self:__set_tactics_info(var_86_0.content.tactics_1.tactics_1_content, self._data.tactics[1])
			end

			if self._data.level < var_0_3.tactics_unlock_level.def then
				var_86_0.content.tactics_2.no_open.text.text = var_0_4(var_0_1:getNowLang("levelcanopentactics"), var_0_3.tactics_unlock_level.def)
			elseif self._data.tactics[2] ~= 0 then
				self:__set_tactics_info(var_86_0.content.tactics_2.tactics_2_content, self._data.tactics[2])
			end

			if self._data.level < var_0_3.tactics_unlock_level.special then
				var_86_0.content.tactics_3.no_open.text.text = var_0_4(var_0_1:getNowLang("levelcanopentactics"), var_0_3.tactics_unlock_level.special)
			elseif self._data.tactics[3] ~= 0 then
				self:__set_tactics_info(var_86_0.content.tactics_3.tactics_3_content, self._data.tactics[3])
			end
		else
			var_86_0.content.tactics_1.tactics_1_content:SetActive(false)
			var_86_0.content.tactics_2.tactics_2_content:SetActive(false)
			var_86_0.content.tactics_3.tactics_3_content:SetActive(false)
			var_86_0.content.tactics_1.no_open:SetActive(false)
			var_86_0.content.tactics_2.no_open:SetActive(false)
			var_86_0.content.tactics_3.no_open:SetActive(false)
			var_86_0.content.tactics_1.add_btn:SetActive(false)
			var_86_0.content.tactics_2.add_btn:SetActive(false)
			var_86_0.content.tactics_3.add_btn:SetActive(false)
		end
	end

	function arg_1_0:__set_tactics_info(arg_87_1, arg_87_2)
		local var_87_0 = var_0_11.find_object_by_cid(arg_87_2)

		if not self._data.all_tactics then
			return
		end

		for iter_87_0, iter_87_1 in pairs(self._data.all_tactics) do
			if iter_87_1.id == arg_87_2 then
				arg_87_1.icon.image.sprite = self:loadSprite(var_0_4(var_0_3.college_tactics, var_87_0.icon))
				arg_87_1.level.text.text = "Lv " .. var_87_0.level
				arg_87_1.exp.text.text = var_87_0.level == var_87_0.max_level and iter_87_1.exp .. "/" .. var_87_0.level_exp[var_87_0.level] or iter_87_1.exp .. "/" .. var_87_0.level_exp[var_87_0.level + 1]

				arg_87_1.bg.studying:SetActive(iter_87_1.state == var_0_3.stactic_state.study)
				arg_87_1.bg:SetActive(iter_87_1.state == var_0_3.stactic_state.study)

				if iter_87_1.state == var_0_3.stactic_state.study then
					arg_87_1.bg.studying.text.text = var_0_1:getNowLang("studying")
					arg_87_1.bg.image.sprite = self:loadSprite(var_0_4(var_0_3.tactics_bg, 2))

					arg_87_1.exp:SetActive(true)
				elseif iter_87_1.state == var_0_3.stactic_state.normal then
					arg_87_1.bg.image.sprite = self:loadSprite(var_0_4(var_0_3.tactics_bg, 3))

					arg_87_1.bg:SetActive(false)
					arg_87_1.exp:SetActive(false)
				end

				arg_87_1.tactics_name.text.text = var_87_0.title

				return
			end
		end
	end

	function arg_1_0:__show_equip_detail_equip_att(arg_88_1, arg_88_2)
		self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

		self:__show_equip_attr_panel(true)
		self._equip_attr._panel.transform:SetParent(arg_88_1.rectTransform, false)

		self._equip_attr._panel.transform.anchoredPosition = var_0_14.New(71, -99)

		self._equip_attr._panel.transform:SetParent(self._control.right.rectTransform)

		local var_88_1 = self._equip_attr._panel.transform.anchoredPosition
		local var_88_2

		if self._equip_attr._panel.transform.anchoredPosition.x < 514 then
			var_88_2 = var_88_1.x or 514

			local var_88_3

			if var_88_1.y > -253 then
				var_88_3 = var_88_1.y or -253
			end
		end

		self._equip_attr._panel.transform.anchoredPosition = var_0_14.New(var_88_2, var_88_3)

		self._equip_attr._panel.transform:SetParent(arg_88_1.rectTransform)

		local var_88_4 = self:__get_equip_data(arg_88_2)

		if var_88_4 then
			self._equip_attr:show(var_88_4)
		end
	end

	function arg_1_0:__show_equip_att(arg_89_1, arg_89_2)
		self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

		self:__show_equip_attr_panel(true)

		local var_89_1 = self:__get_equip_data(arg_89_2)

		self._equip_attr._panel.transform:SetParent(arg_89_1.rectTransform, false)

		self._equip_attr._panel.transform.anchoredPosition = var_0_14.New(-163, 49)

		if var_89_1 then
			self._equip_attr:show(var_89_1)
		end
	end

	function arg_1_0:__show_equip_attr_panel(arg_90_1)
		if not self._equip_attr then
			return
		end

		self._control.tip_layer:SetActive(arg_90_1)
		self._equip_attr:setVisible(arg_90_1)
	end

	function arg_1_0:play_mall_anim(arg_91_1)
		local var_91_0 = self:autoKillDOTween(var_0_20.Sequence())

		var_91_0:Append(self._control.left.rectTransform:DOLocalMove(var_0_14.New(-1440, 0), 0)):SetEase(DG.Tweening.Ease.Linear)
		var_91_0:Join(self._control.left.rectTransform:DOLocalMove(var_0_14.New(-590, 0), 0.3)):SetEase(DG.Tweening.Ease.Linear)
		var_91_0:Join(self._control.skin_layer.rectTransform:DOLocalMove(var_0_14.New(800, 0), 0)):SetEase(DG.Tweening.Ease.Linear)
		var_91_0:Join(self._control.skin_layer.rectTransform:DOLocalMove(var_0_14.New(0, 0), 0.3)):SetEase(DG.Tweening.Ease.Linear)

		if arg_91_1 then
			var_91_0:PlayForward()
		else
			var_91_0:PlayBackwards()
		end
	end

	function arg_1_0:_play_audio(arg_92_1)
		self:playBackgroundMusic(arg_92_1)
	end

	function arg_1_0:_play_into_se(arg_93_1)
		self:playSE(arg_93_1, false)
	end

	function arg_1_0:__judge_use_broken()
		self._is_open_broken = self._enter_type == var_0_3.enter_ship_detail_type.single_ship or self._enter_type == var_0_3.enter_ship_detail_type.dock or self._enter_type == var_0_3.enter_ship_detail_type.remake or self._enter_type == var_0_3.enter_ship_detail_type.dock_team or self._enter_type == var_0_3.enter_ship_detail_type.fight_team or self._enter_type == var_0_3.enter_ship_detail_type.pre_formation or self._enter_type == var_0_3.enter_ship_detail_type.dock_team_equip or self._enter_type == var_0_3.enter_ship_detail_type.bathroom_repair or self._enter_type == var_0_3.enter_ship_detail_type.captainroom_fleet or self._enter_type == var_0_3.enter_ship_detail_type.sixth_select or self._enter_type == var_0_3.enter_ship_detail_type.sixth_fight_prepare or self._enter_type == var_0_3.enter_ship_detail_type.strike_fight_prepare or self._enter_type == var_0_3.enter_ship_detail_type.secretary_info_ship or self._enter_type == var_0_3.enter_ship_detail_type.abyss_fight_prepare
	end

	function arg_1_0:__get_now_skin_index()
		if self._enter_type == var_0_3.enter_ship_detail_type.ship_map then
			self:set_skin_info(0)
		else
			local var_95_0 = 0

			if self._data and self._data.skin ~= 0 and self._now_ship_data ~= nil then
				local var_95_1 = {}

				if self._skin_num == #self._now_ship_data.skins then
					for iter_95_0, iter_95_1 in pairs(self._now_ship_data.skins) do
						if self._data.skin == iter_95_1 then
							var_95_0 = iter_95_0

							break
						end
					end
				else
					for iter_95_2, iter_95_3 in pairs(self._now_ship_data.skins) do
						table.insert(var_95_1, iter_95_3)
					end

					for iter_95_4, iter_95_5 in pairs(var_95_1) do
						local var_95_3 = var_0_6.find_object_by_cid(iter_95_5)

						if #var_95_3.card_cids == 1 and var_95_3.card_cids[1] ~= self._now_ship_data.cid then
							table.remove(var_95_1, iter_95_4)
						end
					end

					for iter_95_6, iter_95_7 in pairs(var_95_1) do
						if self._data.skin == iter_95_7 then
							var_95_0 = iter_95_6

							break
						end
					end
				end
			end

			self:set_skin_info(var_95_0)
		end
	end

	function arg_1_0:__show_role_icon()
		if self._enter_type == var_0_3.enter_ship_detail_type.ship_map then
			self:show_ship_icon(self._now_ship_data.pic_id)
		elseif self._data then
			if self._data.skin == 0 and self._now_ship_data ~= nil then
				self:show_ship_icon(self._now_ship_data.pic_id)
			else
				local var_96_0 = self:__get_skin_cfg(self._data.skin)

				if var_96_0 then
					self:show_ship_icon(var_96_0.icon)
				end
			end
		elseif self._now_ship_data ~= nil then
			self:show_ship_icon(self._now_ship_data.pic_id)
		end
	end

	function arg_1_0:__is_special_type(arg_97_1)
		local var_97_0 = self._special_enter_type == var_0_3.enter_ship_detail_type.captainroom_friend_fleet or self._special_enter_type == var_0_3.enter_ship_detail_type.show_room or self._special_enter_type == var_0_3.enter_ship_detail_type.captainroom_fleet

		if arg_97_1 == 1 then
			return self._special_enter_type == var_0_3.enter_ship_detail_type.captainroom_friend_fleet or self._special_enter_type == var_0_3.enter_ship_detail_type.show_room or self._special_enter_type == var_0_3.enter_ship_detail_type.robot_ship
		else
			return var_97_0
		end
	end

	function arg_1_0:__show_by_mall_shop()
		if self._enter_type == var_0_3.enter_ship_detail_type.mall_shop then
			var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, false)
			var_0_3:play_in_out_animation(self._control.skin_layer_seq.uITweenSequence, false, function()
				var_0_3:play_in_out_animation(self._control.skin_layer_seq.uITweenSequence, true)
			end)
			self._control.skin_layer.skin_bg_2.usebtn:SetActive(self._now_character_data.bought and self._now_character_data.is_have)
			self._control.left.skin_btns:SetActive(false)
			self._control.left.alone_view_btn:SetActive(false)
		end
	end

	function arg_1_0:__show_big_pic()
		if self._enter_type == var_0_3.enter_ship_detail_type.war_concerto_play then
			self._now_ship_data = self:__get_ship_cfg(self._now_ship_data.cid)

			self:show_ship_icon(self._now_ship_data.pic_id)

			self._control.left.ship_role.image.raycastTarget = true
			self._control.role_scale.slide.slider.value = 0

			self._control.role_scale.slide.slider.onValueChanged:AddListener(function(arg_101_0)
				self._control.left.ship_role.transform.localScale = var_0_43 * Vector3.one + Value * (var_0_42 - var_0_43) * Vector3.one
			end)
			self._control.left.ship_role.shipViewControl:GoToFinalPos()
			self:__look_over_view(true)
			self._control.left.drag_for_switch:SetActive(false)

			return true
		end

		return false
	end

	function arg_1_0:refresh_view_scale()
		local var_102_0 = self._control.role_scale.slide.slider.value

		if var_0_24.touchCount > 1 then
			self._control.left.ship_role.shipViewControl.enabled = false
			self.lastDistance = self.lastDistance and self.lastDistance or 0
			self.twoTouchDistance = self.twoTouchDistance and self.twoTouchDistance or 0

			if var_0_24.GetTouch(1).phase == var_0_28.Began then
				local var_102_1 = var_0_24.GetTouch(0).position
				local var_102_2 = var_0_24.GetTouch(1).position

				self.lastDistance = var_0_14.Distance(var_102_1, var_102_2)
				self.twoTouchDistance = var_0_14.Distance(var_102_1, var_102_2)
			end

			local var_102_3

			if var_0_24.GetTouch(0).phase ~= var_0_28.Moved then
				if var_0_24.GetTouch(1).phase == var_0_28.Moved then
					self.twoTouchDistance = var_0_14.Distance(var_0_24.GetTouch(0).position, var_0_24.GetTouch(1).position)
					var_102_3 = (self.twoTouchDistance - self.lastDistance) / 100
				end

				if var_102_3 and var_102_3 > 0 then
					var_102_0 = var_102_0 + var_102_3 * 0.1

					if var_102_0 >= 1 then
						return
					end

					if var_102_0 >= 0 then
						self._control.role_scale.slide.slider.value = var_102_0

						self._control.left.ship_role.shipViewControl:SetScale(var_102_0)
					end

					self._control.left.ship_role.transform.localScale = Vector3.New(self._init_scale * self._control.left.ship_role.transform.localScale.x, self._init_scale * self._control.left.ship_role.transform.localScale.y, self._init_scale * self._control.left.ship_role.transform.localScale.z)
				elseif var_102_3 and var_102_3 < 0 then
					if var_102_0 + var_102_3 * 0.1 <= 0 then
						return
					end

					self._control.role_scale.slide.slider.value = var_102_0 + var_102_3 * 0.1

					self._control.left.ship_role.shipViewControl:SetScale(var_102_0 + var_102_3 * 0.1)

					self._control.left.ship_role.transform.localScale = Vector3.New(self._init_scale * self._control.left.ship_role.transform.localScale.x, self._init_scale * self._control.left.ship_role.transform.localScale.y, self._init_scale * self._control.left.ship_role.transform.localScale.z)
				end

				if self.twoTouchDistance then
					self.lastDistance = self.twoTouchDistance
				end

				if var_0_24.GetTouch(1).phase == var_0_28.Ended then
					self.lastDistance = 0
					self.twoTouchDistance = 0
				end
			end
		else
			self._control.left.ship_role.shipViewControl.enabled = true
		end
	end

	function arg_1_0:set_custom_info()
		if self._special_enter_type and (self._special_enter_type == var_0_3.enter_ship_detail_type.captainroom_fleet or self._special_enter_type == var_0_3.enter_ship_detail_type.show_room or self._special_enter_type == var_0_3.enter_ship_detail_type.captainroom_friend_fleet or self._special_enter_type == var_0_3.enter_ship_detail_type.robot_ship) then
			self._control.left.ship_btns.set_custom_btn:SetActive(false)
			self._control.left.ship_btns.cancel_custom_btn:SetActive(false)
		else
			local var_103_1 = var_0_5:get_custom_ship_list()

			if var_103_1 and next(var_103_1) and not not var_0_16.have_data(var_103_1, self._data.id) or false then
				self._control.left.ship_btns.set_custom_btn:SetActive(false)
				self._control.left.ship_btns.cancel_custom_btn:SetActive(true)
			else
				self._control.left.ship_btns.set_custom_btn:SetActive(true)
				self._control.left.ship_btns.cancel_custom_btn:SetActive(false)
			end
		end
	end

	function arg_1_0:__onReset()
		if self._enter_type == var_0_3.enter_ship_detail_type.war_concerto_play then
			self._control.left.ship_role.rectTransform.anchoredPosition = self._ship_init_pos - var_0_14(200, 0)
			self._control.left.ship_role.rectTransform.rotation = Vector3.New(0, 0, 0)

			self._control.role_scale:SetActive(false)
			self._control.right_btn_ship:SetActive(false)
			self._control.left.return_btn:SetActive(true)
		else
			self._control.left.ship_role.rectTransform.anchoredPosition = self._ship_init_pos or var_0_14(440, 50)
		end

		self._control.left.ship_role.transform.localScale = Vector3.New(1, 1, 1)
		self._now_ship_data = nil
		self._now_skin_page = nil
		self._enter_type = nil
		self._save_data_to_marry = nil
		self._is_already_init = false
		self._now_skin_data = {}
		self._data = {}
		arg_1_0._is_tactics_panel = false
		self._control.left.ship_role.transform.localPosition = var_0_14.New(390, -60)

		var_0_3:set_is_tactics(self._is_tactics)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_105_0)
	local var_105_0 = var_0_2:class("ship_detail")

	var_105_0._is_already_init = false
	var_105_0._enter_type = nil
	var_105_0._data = {}
	var_105_0._now_ship_data = {}
	var_105_0._now_skin_data = {}
	var_105_0._now_lable = nil
	var_105_0._now_show_skin_icon = nil
	var_105_0._now_click_desc_trans = nil
	var_105_0._is_mall_change_init = false
	var_105_0._equip_content = {}
	var_105_0._detail_attr_content = {}
	var_105_0._no_req = false
	var_105_0._is_tactics = var_0_3:get_is_tactics()
	var_105_0._equip_attr = nil
	var_105_0._is_single = false
	var_105_0._is_team = false
	var_105_0._index = nil
	var_105_0._members = {}
	var_105_0._toggle_type = nil
	var_105_0._team_id = nil
	var_105_0._new_name = nil
	var_105_0._marray_into = true
	var_105_0._is_up_ship = false
	var_105_0._hood_bgm = false
	var_105_0._bsm_bgm = false
	var_105_0._formidable_bgm = false
	var_105_0._shinano_bgm = false
	var_105_0._sp_bgm = false
	var_105_0._marry_type = nil
	var_105_0._special_enter_type = nil
	var_105_0._is_marry = false
	var_105_0._show_broken = false
	var_105_0._default_name = nil
	var_105_0._is_open_broken = false
	var_105_0._now_character_data = nil
	var_105_0._now_paint_sprite = nil
	var_105_0._changed_image = false
	var_105_0._normal_paint_url = nil
	var_105_0._special_paint_url = nil
	var_105_0._now_index = nil
	var_105_0._now_skin_page = nil
	var_105_0._save_now_pic = nil
	var_105_0._ship_active_skin_cid = nil
	var_105_0._save_data_to_marry = nil
	var_105_0._ship_init_pos = nil
	var_105_0._isStart = false
	var_105_0._isReverse = false
	var_105_0._timer = 0
	var_105_0._aniTotalTime = 1
	var_105_0._finalPos = Vector3.zero
	var_105_0._anchoredPosition = Vector3.zero
	var_105_0._offsetVec = Vector3.zero
	var_105_0._init_picture_scale = 0
	var_105_0._is_picture_hd = false
	var_105_0._is_unlock = false
	var_105_0._ui_close_state = false
	var_105_0.lastDistance = 0
	var_105_0.twoTouchDistance = 0
	var_105_0._need_buy = nil
	var_105_0._now_index_2 = nil
	var_105_0._now_label = 1
	var_105_0._is_married = false
	var_105_0._is_tactics_panel = false

	gamecore.extend_obj(var_105_0)

	return var_105_0
end

return var_0_0
