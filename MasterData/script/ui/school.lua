local var_0_0 = {}
local var_0_1 = math.abs
local var_0_2 = gamecore.user
local var_0_3 = table.insert
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_6 = string.format
local var_0_7 = UnityEngine.Vector2
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = gameenum.common_type
local var_0_10 = gameconfig.skin_config
local var_0_11 = gameconfig.ship_config
local var_0_12 = gameconfig.teacher_config

gamecore.UILoader:define("school", function(arg_1_0)
	function arg_1_0:__set_role_parent(arg_2_1, arg_2_2)
		local var_2_0
		local var_2_1 = false

		if arg_2_1 and arg_2_1 % 2 == 0 then
			var_2_0 = self._control.top_list_role.transform
			var_2_1 = false
		else
			var_2_1 = true
			var_2_0 = self._control.furniture.transform
		end

		local var_2_2 = self._role_ship_data[arg_2_2].transform

		self._role_ship_data[arg_2_2].transform.transform:SetParent(var_2_0)

		if var_2_1 then
			var_2_2:SetAsFirstSibling()
		else
			var_2_2:SetAsLastSibling()
		end
	end

	function arg_1_0:__create_new_role(arg_3_1, arg_3_2)
		local var_3_0 = self:loadUIPrefab("school_role")

		var_3_0:setVisible(true)

		local var_3_2 = var_3_0._panel.transform

		var_3_0._panel.transform:SetParent(arg_3_1 and arg_3_1 % 2 == 0 and self._control.top_list_role.transform or self._control.furniture.transform, false)

		var_3_2.localScale = var_0_7.New(1.25, 1.25)
		var_3_2.localPosition = self._pos_list[arg_3_1][1]

		var_3_2:SetAsFirstSibling()

		if not self._role_has_index_list then
			self._role_has_index_list = {}
			self._role_ske_list = {}
		end

		if arg_3_1 and arg_3_1 ~= 0 and arg_3_2 and arg_3_2 ~= 0 then
			self._role_has_index_list[arg_3_2] = arg_3_1
			self._role_ship_data[arg_3_2] = var_3_0._panel
			self._role_ske_list[arg_3_2] = var_3_0._panel.transform:GetComponent("SkeletonGraphic")
		end
	end

	function arg_1_0:show()
		var_0_2:set_to_school(true)
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0.play_skeleton_animation(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		if arg_5_4 then
			local var_5_0 = arg_5_1.state.Complete

			local function var_5_1()
				arg_5_4()

				arg_5_1.state.Complete = var_5_0
			end

			var_5_0 = arg_5_1.state.Complete + var_5_1
			arg_5_1.state.Complete = arg_5_1.state.Complete + var_5_1
			var_5_0 = var_5_0 - var_5_1
		end

		arg_5_1.startingAnimation = arg_5_2

		arg_5_1:Initialize(true)
		arg_5_1.AnimationState:ClearTracks()
		arg_5_1.AnimationState:SetAnimation(0, arg_5_2, arg_5_3)
	end

	function arg_1_0:update_data()
		self._total_class_data = var_0_2:get_class_total_info()
		self._total_teacher_data = var_0_2:get_teacher_total_info()
		self._now_class_num = #self._total_class_data
	end

	function arg_1_0:update_now_class_data(arg_8_1)
		self._on_click_num = arg_8_1
		self._teacher_cid = var_0_2:get_class_teacher_by_id(arg_8_1)
		self._now_teacher_data = var_0_12.find_object_by_cid(self._teacher_cid)

		self:__reset_talk_tween()
		self:__get_now_class_teacher_index()
		self:__update_class_btn_bg(arg_8_1)
		self:__update_btn_state(arg_8_1)
	end

	function arg_1_0.update_seat_data(arg_9_0, arg_9_1)
		arg_9_0._now_seat_index = arg_9_1
	end

	function arg_1_0.get_tactics_by_ship_id(arg_10_0, arg_10_1)
		local var_10_0 = var_0_2:find_character_by_id(arg_10_1)
		local var_10_1 = {}

		if var_10_0.all_tactics and #var_10_0.all_tactics ~= 0 then
			for iter_10_0, iter_10_1 in pairs(var_10_0.all_tactics) do
				if iter_10_1.state == var_0_9.stactic_state.study then
					arg_10_0._now_stop_study_id = arg_10_1
					arg_10_0._now_tactics_data = {
						exp = var_10_0.all_tactics[iter_10_0].exp,
						cid = var_10_0.all_tactics[iter_10_0].id,
						state = var_10_0.all_tactics[iter_10_0].state,
						sid = arg_10_1
					}
				elseif iter_10_1.state == var_0_9.stactic_state.normal then
					var_0_3(var_10_1, iter_10_1)
				end
			end
		end

		return var_10_1
	end

	function arg_1_0:set_student_name_progress(arg_11_1, arg_11_2)
		local var_11_0 = var_0_2:find_character_by_id(arg_11_2)

		self._progress_bar_list[arg_11_1].bar_bg.ship_name:GetComponent("TextHorizonScroller"):SetText(var_11_0.name)

		local var_11_1 = {}

		if var_11_0.all_tactics and #var_11_0.all_tactics ~= 0 then
			for iter_11_0, iter_11_1 in pairs(var_11_0.all_tactics) do
				if iter_11_1.state == var_0_9.stactic_state.study then
					var_11_1 = {
						exp = var_11_0.all_tactics[iter_11_0].exp,
						id = var_11_0.all_tactics[iter_11_0].id,
						state = var_11_0.all_tactics[iter_11_0].state,
						sid = arg_11_2
					}
				end
			end
		end

		if var_11_1 and next(var_11_1) then
			local var_11_2, var_11_3, var_11_4 = var_0_9:__get_tactis_config_level(var_11_1.exp, var_11_1.id)
			local var_11_5 = var_11_1.exp / var_11_3 * 100

			var_11_5 = var_11_1.exp / var_11_3 * 100 > 0 and var_11_5 < 1 and 1 or math.floor(var_11_5)
			self._progress_bar_list[arg_11_1].bar_bg.progress_num.text.text = tostring(var_11_5) .. "%"
			self._progress_bar_list[arg_11_1].bar_bg.bar.image.fillAmount = var_11_1.exp / var_11_3
		end
	end

	function arg_1_0:set_student_skeleton(arg_12_1, arg_12_2, arg_12_3)
		local var_12_0

		if arg_12_3 then
			var_12_0 = arg_12_2
			arg_12_1.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_6(var_0_9.school_teacher_anim, arg_12_2))
			arg_12_1.material = self:loadMaterial(var_0_9:get_ship_spine(var_0_9.school_teacher_mat, var_12_0))
			arg_12_1.material.shader = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
		else
			local var_12_2 = var_0_2:find_character_by_id(arg_12_2)

			var_12_0 = var_12_2.skin ~= 0 and var_0_10.find_object_by_cid(var_12_2.skin).icon or var_0_11.find_object_by_cid(var_12_2.cid).pic_id
			arg_12_1.skeletonDataAsset = self:loadSkeletonDataAsset((var_0_9:get_ship_spine(var_0_9.common_icon.common_ship_q_asset, var_12_0)))
			arg_12_1.material = self:loadMaterial(var_0_9:get_ship_spine(var_0_9.common_icon.common_ship_q_mat, var_12_0))
			arg_12_1.material.shader = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
		end

		arg_12_1.initialSkinName = self._spine_skin_name_list.normal

		arg_12_1:Initialize(true)
	end

	function arg_1_0:set_now_class_teacher()
		if var_0_2:get_class_teacher_by_id(self._now_class) ~= 0 then
			self:set_student_skeleton(self._control.role.skeletonGraphic, self._now_class_teacher_index, true)
			self._control.role.gameObject:SetActive(true)
		else
			self._control.role.gameObject:SetActive(false)
		end
	end

	function arg_1_0:update_enter_student_data()
		self:__update_study_student(true, self._now_seat_index, var_0_5:getInstance("select_tactis_view"):get_select_ship_data().id)
	end

	function arg_1_0:update_stop_student_data()
		self:__update_study_student(false, self._now_seat_index, self._now_stop_study_id)
	end

	function arg_1_0:get_curr_class()
		return self._now_class
	end

	function arg_1_0.destroy_panel(arg_17_0)
		var_0_5:destroyInstance("change_instructor_view")
		var_0_5:destroyInstance("class_info_view")
		var_0_5:destroyInstance("select_tactis_view")
		var_0_5:destroyInstance("select_member")
		var_0_5:destroyInstance("college_expand_view")
		var_0_5:destroyInstance("shop_bounced")
		var_0_5:destroyInstance("school")
		var_0_5:destroyInstance("school_open_view")
		var_0_5:destroyInstance("fight_prepare")
		var_0_5:destroyInstance("tactics_select_member")
	end

	function arg_1_0:update_class_chair_data()
		UnityEngine.UI.SpriteState.New().pressedSprite = self:loadSprite(var_0_6(var_0_9.college_class_btn_bg, 1))

		local var_18_0 = var_0_2:get_now_class_seat(self._now_class)

		for iter_18_0, iter_18_1 in pairs(self._all_table_data) do
			if iter_18_0 <= var_18_0 then
				self._total_chair_list[iter_18_0].gameObject:SetActive(true)

				self._all_table_data[iter_18_0].image.sprite = self:loadSprite((var_0_9:get_ship_icon(var_0_9.furniture_img, "907")))
			else
				self._all_table_data[iter_18_0].image.sprite = self:loadSprite((var_0_9:get_ship_icon(var_0_9.furniture_img, "907_2")))

				self._total_chair_list[iter_18_0].gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_school_default_data()
		end

		self:update_data()
		self:__init_btn_set()
		self:__init_teacher_data()

		self._role_ani_list = {}

		self:__show_talk()

		self._is_already_init = true

		self:_play_audio(var_0_9:get_audio_url(var_0_9.common_icon.music_path, "school"))
	end

	function arg_1_0:__init_language()
		self._control.change_btn.txt.text.text = var_0_4:getNowLang("changeteacher")
		self._all_table_data = {
			self._control.furniture.table_next.table_4,
			self._control.table_last.table_1,
			self._control.furniture.table_next.table_5,
			self._control.table_last.table_2,
			self._control.furniture.table_next.table_6,
			self._control.table_last.table_3
		}
		self._role_ship_data = {}
		self._light_list = {
			self._control.light.light_4,
			self._control.light.light_1,
			self._control.light.light_5,
			self._control.light.light_2,
			self._control.light.light_6,
			self._control.light.light_3
		}
		self._progress_bar_list = {
			self._control.progress_bar_set.progress_four,
			self._control.progress_bar_set.progress_one,
			self._control.progress_bar_set.progress_five,
			self._control.progress_bar_set.progress_two,
			self._control.progress_bar_set.progress_six,
			self._control.progress_bar_set.progress_three
		}
		self._total_chair_list = {
			self._control.furniture.chair_next.chair_4,
			self._control.chair_last.chair_1,
			self._control.furniture.chair_next.chair_5,
			self._control.chair_last.chair_2,
			self._control.furniture.chair_next.chair_6,
			self._control.chair_last.chair_3
		}
	end

	function arg_1_0:__init_teacher_data()
		self._teacher_cid = var_0_2:get_class_teacher_by_id(1)
		self._now_teacher_data = var_0_12.find_object_by_cid(self._teacher_cid)

		self:__get_now_class_teacher_index()

		self._now_class_num = #self._total_class_data

		self:__update_class_btn_bg(1)
		self:__update_btn_state(1)

		self._on_click_num = 1
	end

	function arg_1_0:__init_seat_student()
		self:__reset_student_position()

		local var_22_0 = {}
		local var_22_1 = var_0_2:get_now_class_seat(self._now_class)

		for iter_22_0, iter_22_1 in pairs(self._all_table_data) do
			self:__set_change_table_state(iter_22_0, false)

			if iter_22_0 <= var_22_1 then
				local var_22_2 = var_0_2:get_student_by_seat_id(self._now_class, iter_22_0)

				if var_22_2 ~= 0 then
					self:__create_new_role(iter_22_0, var_22_2)

					local var_22_3 = self._role_ship_data[var_22_2].transform:GetComponent("SkeletonGraphic")

					self:__set_role_layer_position(iter_22_0, self._role_ship_data[var_22_2].transform, false)
					self._role_ship_data[var_22_2].gameObject:SetActive(true)
					self:set_student_skeleton(var_22_3, var_22_2, false)
					self:play_skeleton_animation(var_22_3, self._role_anim_state_list.study, true, nil)
					self._light_list[iter_22_0].gameObject:SetActive(true)
					self:play_skeleton_animation(self._light_list[iter_22_0].skeletonGraphic, self._light_anim_state_list.study, true, nil)
					self:set_student_name_progress(iter_22_0, var_22_2)
					self._progress_bar_list[iter_22_0].gameObject:SetActive(true)

					self._role_ship_data[var_22_2].transform.localPosition = self._pos_list[iter_22_0][4]
					self._role_ship_data[var_22_2].transform.rotation = Vector3.New(0, 0, 0)

					self:__set_change_table_state(iter_22_0, true)
				else
					var_0_3(var_22_0, iter_22_0)
					var_0_2:set_now_statics_seat(var_22_0)

					self._is_move_list[var_22_2] = 0
				end

				self._total_chair_list[iter_22_0].gameObject:SetActive(true)
			else
				self._all_table_data[iter_22_0].image.sprite = self:loadSprite((var_0_9:get_ship_icon(var_0_9.furniture_img, "907_2")))

				self._total_chair_list[iter_22_0].gameObject:SetActive(false)
			end
		end

		self:__set_teacher_teach_state()
	end

	function arg_1_0.__set_role_layer_position(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		if arg_23_1 == var_0_9.college_const.first_pos_index or arg_23_1 == var_0_9.college_const.second_pos_index or arg_23_1 == var_0_9.college_const.third_pos_index then
			if arg_23_3 then
				arg_23_2:SetAsFirstSibling()
			else
				arg_23_2:SetAsLastSibling()
			end
		end
	end

	function arg_1_0:__reset_student_position()
		for iter_24_0, iter_24_1 in pairs(self._all_table_data) do
			if self._role_ship_data then
				for iter_24_2, iter_24_3 in pairs(self._role_ship_data) do
					self._role_ship_data[iter_24_2].gameObject:SetActive(false)

					self._role_ship_data[iter_24_2].transform.localPosition = self._pos_list[iter_24_0][1]

					self._role_ship_data[iter_24_2].transform:SetAsFirstSibling()
				end

				self._light_list[iter_24_0].gameObject:SetActive(false)
				self._progress_bar_list[iter_24_0].gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:__show_talk()
		local var_25_0 = var_0_4:getNowLang("teachersayword" .. lan_rand(1, 4))

		if var_25_0 == "" then
			return
		end

		self._control.talk.popVerticalAdaptive:SetText(var_25_0)

		self._control.talk.label_txt.text.text = ""

		self._control.talk:SetActive(true)

		self._talk_tween_seq = self:autoKillDOTween(var_0_8.Sequence())

		self._talk_tween_seq:Append(self._control.talk.canvasGroup:DOFade(1, 0.3))
		self._talk_tween_seq:Append(self._control.talk.label_txt.text:DOText(var_25_0, #var_25_0 * 0.03):SetEase(DG.Tweening.Ease.Linear))
		self._talk_tween_seq:AppendInterval(#var_25_0 * 0.03 + 0.5)
		self._talk_tween_seq:Append(self._control.talk.canvasGroup:DOFade(0, 0.5):OnComplete(function()
			return
		end))
		self._talk_tween_seq:AppendCallback(function()
			self._control.talk:SetActive(false)
		end)
		self._talk_tween_seq:Play()
	end

	function arg_1_0:__reset_talk_tween()
		if self._talk_tween_seq then
			self._talk_tween_seq:Pause()
			self._talk_tween_seq:Kill()

			self._talk_tween_seq = nil
		end

		self._control.talk.label_txt.text.text = ""
		self._control.talk.canvasGroup.alpha = 0

		self._control.talk:SetActive(false)
	end

	function arg_1_0:__update_class_btn_bg(arg_29_1)
		self._now_class = arg_29_1

		self:set_now_class_teacher()
		self:__init_seat_student()

		self._control.backboard.image.sprite = self:loadSprite(var_0_6(var_0_9.college_blackboard_bg, (self:__get_backboard_info_by_teacher_cid(self._teacher_cid))))
	end

	function arg_1_0:__init_btn_set()
		self._control.class_btn_set.class_one:SetActive(true)

		self._control.class_btn_set.class_one.Text.text.text = var_0_4:getNowLang("class_number")

		self._control.class_btn_set.class_two:SetActive(true)
		self._control.class_btn_set.class_three:SetActive(self._now_class_num >= 2)

		if self._now_class_num == 1 then
			self._control.class_btn_set.class_two.btn_expand:SetActive(true)

			self._control.class_btn_set.class_two.Text.text.text = "    " .. var_0_4:getNowLang("expantion")
			self._control.class_btn_set.class_two.Text.text.color = Color.New(0.8784313725490196, 0.8784313725490196, 0.8784313725490196)
		elseif self._now_class_num == 2 then
			self._control.class_btn_set.class_two.btn_expand:SetActive(false)

			self._control.class_btn_set.class_two.Text.text.text = var_0_4:getNowLang("class_number")

			self._control.class_btn_set.class_three.btn_expand:SetActive(true)

			self._control.class_btn_set.class_three.Text.text.text = "    " .. var_0_4:getNowLang("expantion")
			self._control.class_btn_set.class_three.Text.text.color = Color.New(0.8784313725490196, 0.8784313725490196, 0.8784313725490196)
		elseif self._now_class_num == 3 then
			self._control.class_btn_set.class_three.btn_expand:SetActive(false)

			self._control.class_btn_set.class_two.Text.text.text = var_0_4:getNowLang("class_number")
			self._control.class_btn_set.class_three.Text.text.text = var_0_4:getNowLang("class_number")
		end
	end

	function arg_1_0:__update_btn_state(arg_31_1)
		for iter_31_0, iter_31_1 in pairs(self._class_btn_set) do
			self._class_btn_set[iter_31_0].btn_selected:SetActive(arg_31_1 == iter_31_0)

			if iter_31_0 == arg_31_1 then
				iter_31_1.Text.text.color = Color.New(0.8823529411764706, 0.4392156862745098, 0.050980392156862744)
				iter_31_1.number.image.color = Color.New(0.8823529411764706, 0.4392156862745098, 0.050980392156862744)
			elseif iter_31_0 <= self._now_class_num then
				iter_31_1.Text.text.color = Color.New(0.2549019607843137, 0.5882352941176471, 0.7647058823529411)
				iter_31_1.number.image.color = Color.New(0.2549019607843137, 0.5882352941176471, 0.7647058823529411)
			end
		end
	end

	function arg_1_0:__set_change_table_state(arg_32_1, arg_32_2)
		self._all_table_data[arg_32_1].image.sprite = self:loadSprite((var_0_9:get_ship_icon(var_0_9.furniture_img, arg_32_2 and "907_1" or "907")))

		self:__set_teacher_teach_state()
	end

	function arg_1_0:__set_teacher_teach_state()
		if var_0_2:get_teacher_state_by_class(self._now_class) then
			self:play_skeleton_animation(self._control.role.skeletonGraphic, self._teacher_ani_state_list.teach, true, nil)
		else
			self:play_skeleton_animation(self._control.role.skeletonGraphic, self._teacher_ani_state_list.stand, true, nil)
		end
	end

	function arg_1_0:__get_now_class_teacher_index()
		local var_34_0, var_34_1 = var_0_12:get_sequence()

		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			if iter_34_1.cid == self._teacher_cid then
				self._now_class_teacher_index = iter_34_0

				break
			end
		end
	end

	function arg_1_0:__update_study_student(arg_35_1, arg_35_2, arg_35_3)
		local var_35_0 = tonumber(var_0_9.college_const.move_ratio)
		local var_35_1
		local var_35_2

		if self._light_list[arg_35_2].activeSelf then
			self._is_move_list[arg_35_2] = 3
		end

		if not self._role_ship_data or not self._role_ship_data[arg_35_3] then
			self:__create_new_role(arg_35_2, arg_35_3)
		end

		self:__set_ani_seq_state(self._role_ship_data[arg_35_3].transform, arg_35_2, arg_35_3, arg_35_1)

		if self._role_ani_list and self._role_ani_list[arg_35_3] then
			self._role_ani_list[arg_35_3]:Kill()
		end

		if arg_35_1 then
			if self._role_has_index_list and self._role_has_index_list[arg_35_3] then
				self._role_ship_data[arg_35_3].gameObject:SetActive(true)
				self:__set_role_parent(arg_35_2, arg_35_3)
			else
				self:__create_new_role(arg_35_2, arg_35_3)
			end

			self:set_student_skeleton(self._role_ske_list[arg_35_3], arg_35_3, false)

			var_35_1 = self._role_ship_data[arg_35_3].transform
			var_35_2 = self._role_ske_list[arg_35_3]

			self:play_skeleton_animation(self._role_ske_list[arg_35_3], self._role_anim_state_list.walk, true, nil)

			local var_35_4 = self:autoKillDOTween(var_0_8.Sequence())

			self._role_ani_list[arg_35_3] = var_35_4

			if not self._first_complete then
				local var_35_5 = self._pos_list[arg_35_2][2].x - var_35_1.localPosition.x

				var_35_1.rotation = self._pos_list[arg_35_2][2].x - var_35_1.localPosition.x < 0 and var_0_7.New(0, 0, 0) or var_0_7.New(0, 180, 0)

				var_35_4:Append(var_35_1:DOLocalMoveX(self._pos_list[arg_35_2][2].x, var_0_1(var_35_5) / var_35_0):SetEase(DG.Tweening.Ease.Linear))
				var_35_4:AppendCallback(function()
					self._is_move_list[arg_35_3] = 1
				end)
			end

			if not self._second_complete then
				var_35_4:Append(var_35_1:DOLocalMoveY(self._pos_list[arg_35_2][3].y, var_0_1(self._pos_list[arg_35_2][3].y - var_35_1.localPosition.y) / var_35_0):SetEase(DG.Tweening.Ease.Linear))
				var_35_4:AppendCallback(function()
					self:__set_role_layer_position(arg_35_2, var_35_1, false)

					var_35_1.rotation = Vector3.New(0, 180, 0)
					self._is_move_list[arg_35_3] = 2
				end)
			end

			if not self._third_complete then
				var_35_4:Append(var_35_1:DOLocalMoveX(self._pos_list[arg_35_2][4].x, 50 / var_35_0):SetEase(DG.Tweening.Ease.Linear))
				var_35_4:AppendCallback(function()
					self:play_skeleton_animation(var_35_2, self._role_anim_state_list.study, true, nil)
					self:__set_change_table_state(arg_35_2, true)

					var_35_1.rotation = Vector3.New(0, 0, 0)

					self._light_list[arg_35_2].gameObject:SetActive(true)

					self._is_move_list[arg_35_3] = 3

					self:play_skeleton_animation(self._light_list[arg_35_2].skeletonGraphic, self._light_anim_state_list.study, true, nil)
					self:set_student_name_progress(arg_35_2, arg_35_3)
					self._progress_bar_list[arg_35_2].gameObject:SetActive(true)
				end)
				var_35_4:Play()
			end
		else
			if self._light_list[arg_35_2].activeSelf then
				self:play_skeleton_animation(self._light_list[arg_35_2].skeletonGraphic, self._light_anim_state_list.study_end, false, nil)
			end

			self:__set_change_table_state(arg_35_2, false)

			var_35_1 = self._role_ship_data[arg_35_3].transform
			var_35_2 = self._role_ske_list[arg_35_3]

			local var_35_6 = self:autoKillDOTween(var_0_8.Sequence())

			self._role_ani_list[arg_35_3] = var_35_6

			var_35_6:AppendInterval(0.367)
			var_35_6:AppendCallback(function()
				self._light_list[arg_35_2].gameObject:SetActive(false)
				self._progress_bar_list[arg_35_2].gameObject:SetActive(false)
			end)
			self:play_skeleton_animation(var_35_2, self._role_anim_state_list.walk, true, nil)

			if not self._first_complete then
				var_35_1.rotation = Vector3.New(0, 0, 0)

				var_35_6:Append(var_35_1:DOLocalMoveX(self._pos_list[arg_35_2][3].x, var_0_1((var_35_1.transform.localPosition.x - self._pos_list[arg_35_2][3].x) / var_35_0)):SetEase(DG.Tweening.Ease.Linear))
				var_35_6:AppendCallback(function()
					self._is_move_list[arg_35_3] = 1
				end)
			end

			if not self._second_complete then
				local var_35_7 = self._pos_list[arg_35_2][1].x - var_35_1.localPosition.x

				var_35_6:Append(var_35_1:DOLocalMoveY(self._pos_list[arg_35_2][2].y, var_0_1(var_35_1.transform.localPosition.y - self._pos_list[arg_35_2][2].y) / var_35_0):SetEase(DG.Tweening.Ease.Linear))
				var_35_6:AppendCallback(function()
					var_35_1.rotation = var_0_7.New(0, 180, 0)
					var_35_1.rotation = var_35_7 < 0 and var_0_7.New(0, 0, 0) or var_0_7.New(0, 180, 0)

					self:__set_role_layer_position(arg_35_2, var_35_1, true)

					self._is_move_list[arg_35_3] = 2
				end)
			end

			if not self._third_complete then
				if self._second_complete then
					var_35_1.rotation = var_0_7.New(0, 180, 0)
				end

				var_35_6:Append(var_35_1:DOLocalMoveX(self._pos_list[arg_35_2][1].x, var_0_1(self._pos_list[arg_35_2][1].x - var_35_1.localPosition.x) / var_35_0):SetEase(DG.Tweening.Ease.Linear))
				var_35_6:AppendCallback(function()
					self:play_skeleton_animation(var_35_2, self._role_anim_state_list.stand, true, nil)
					self._role_ship_data[arg_35_3].gameObject:SetActive(false)

					var_35_1.localPosition = self._pos_list[arg_35_2][1]
					self._is_move_list[arg_35_3] = 0
				end)
				var_35_6:Play()
			end
		end
	end

	function arg_1_0:__get_now_move_position(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
		if arg_43_4 then
			if arg_43_1.localPosition.x - self._pos_list[arg_43_2][4].x == 0 and arg_43_1.localPosition.y - self._pos_list[arg_43_2][4].y == 0 then
				self._first_complete = true
				self._second_complete = true
				self._third_complete = true
			else
				self._third_complete = false

				if arg_43_1.localPosition.y - self._pos_list[arg_43_2][4].y == 0 then
					self._second_complete = true
				else
					self._second_complete = false
					self._first_complete = arg_43_1.localPosition.x == self._pos_list[arg_43_2][2].x
				end
			end
		elseif not arg_43_4 then
			if arg_43_1.localPosition.y <= 80 and arg_43_1.localPosition.y >= 65 then
				self._first_complete = true
				self._second_complete = true

				if arg_43_1.localPosition.x == self._pos_list[1][1].x then
					self._third_complete = true
				end
			else
				self._first_complete = false
				self._second_complete = false
				self._third_complete = false
			end
		end
	end

	function arg_1_0:__set_ani_seq_state(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
		if (arg_44_4 and var_0_7(arg_44_1.localPosition.x, arg_44_1.localPosition.y) - self._pos_list[arg_44_2][1] or var_0_7(arg_44_1.localPosition.x, arg_44_1.localPosition.y) - self._pos_list[arg_44_2][4]).x == 0 then
			self._first_complete = false
			self._second_complete = false
			self._third_complete = false

			self:__get_now_move_position(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
		else
			self:__get_now_move_position(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
		end
	end

	function arg_1_0.__get_backboard_info_by_teacher_cid(arg_45_0, arg_45_1)
		local var_45_0 = 0

		if arg_45_1 == var_0_9.college_const.ella_cid then
			var_45_0 = var_0_9.college_const.chair_data.first_group
		elseif arg_45_1 == var_0_9.college_const.victory_cid then
			var_45_0 = var_0_9.college_const.chair_data.second_group
		elseif arg_45_1 == var_0_9.college_const.fuleer_cid then
			var_45_0 = var_0_9.college_const.chair_data.third_group
		end

		return var_45_0
	end

	function arg_1_0:_play_audio(arg_46_1)
		self:playBackgroundMusic(arg_46_1)
	end

	function arg_1_0:__init_school_default_data()
		self._spine_skin_name_list = {
			normal = "normal"
		}
		self._role_anim_state_list = {
			study = "SP2_book",
			stand = "stand1",
			walk = "walk_slow"
		}
		self._light_anim_state_list = {
			study = "study",
			study_end = "end"
		}
		self._teacher_ani_state_list = {
			teach = "teach",
			stand = "stand1"
		}
		self._pos_list = {
			{
				var_0_7.New(1295, 65),
				var_0_7.New(460, 65),
				var_0_7.New(460, -15),
				var_0_7.New(500, -15)
			},
			{
				var_0_7.New(1295, 80),
				var_0_7.New(460, 80),
				var_0_7.New(460, 140),
				var_0_7.New(500, 140)
			},
			{
				var_0_7.New(1295, 65),
				var_0_7.New(750, 65),
				var_0_7.New(750, -15),
				var_0_7.New(790, -15)
			},
			{
				var_0_7.New(1295, 80),
				var_0_7.New(750, 80),
				var_0_7.New(750, 140),
				var_0_7.New(790, 140)
			},
			{
				var_0_7.New(1295, 65),
				var_0_7.New(1035, 65),
				var_0_7.New(1035, -15),
				var_0_7.New(1075, -15)
			},
			{
				var_0_7.New(1295, 80),
				var_0_7.New(1035, 80),
				var_0_7.New(1035, 140),
				var_0_7.New(1075, 140)
			}
		}

		if self._is_move_list then
			for iter_47_0, iter_47_1 in pairs(self._is_move_list) do
				self._is_move_list[iter_47_0] = 3
			end
		end

		self._class_btn_set = {
			self._control.class_btn_set.class_one,
			self._control.class_btn_set.class_two,
			self._control.class_btn_set.class_three
		}
	end

	function arg_1_0:__onReset()
		self:__reset_talk_tween()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_49_0)
	local var_49_0 = var_0_5:class("school")

	var_49_0._is_already_init = false
	var_49_0._now_teacher_data = {}
	var_49_0._total_class_data = {}
	var_49_0._total_teacher_data = {}
	var_49_0._now_class_num = 1
	var_49_0._on_click_num = 1
	var_49_0._now_class = nil
	var_49_0._now_seat_index = nil
	var_49_0._now_stop_study_id = nil
	var_49_0._now_tactics_data = {}
	var_49_0._all_table_data = {}
	var_49_0._role_list = {}
	var_49_0._teacher_cid = nil
	var_49_0._now_class_teacher_index = nil
	var_49_0._role_ani_list = {}
	var_49_0._first_position = {
		x = 0,
		y = 0
	}
	var_49_0._second_position = {
		x = 0,
		y = 0
	}
	var_49_0._role_ship_data = {}
	var_49_0._total_chair_list = {}
	var_49_0._light_list = {}
	var_49_0._progress_bar_list = {}
	var_49_0._spine_skin_name_list = {}
	var_49_0._role_anim_state_list = {}
	var_49_0._light_anim_state_list = {}
	var_49_0._teacher_ani_state_list = {}
	var_49_0._pos_list = {}
	var_49_0._first_complete = false
	var_49_0._second_complete = false
	var_49_0._third_complete = false
	var_49_0._is_move_list = {}
	var_49_0._talk_tween_seq = nil
	var_49_0._class_btn_set = {}

	return var_49_0
end

return var_0_0
