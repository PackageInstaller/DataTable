local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameconfig.skin_config
local var_0_4 = gameconfig.medal_config
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.music_config
local var_0_7 = string.format
local var_0_8 = gameconfig.ship_cg_config
local var_0_9 = Vector2
local var_0_10 = DG.Tweening.DOTween

gamecore.UILoader:define("reward_tip", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if self._now_skin_data_2 == 2 then
			self._now_skin_data_2 = 1

			return
		end

		self._picture_id = nil

		self:setVisible(true)

		self._now_medal_lv = arg_2_4
		self._now_medal_id = arg_2_3
		self._now_show_skin_id = arg_2_1
		self._enter_type = arg_2_2

		self:__init_panel()
	end

	function arg_1_0:show_by_enter_type(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		self:setVisible(true)

		self._now_show_skin_id = arg_3_1
		self._enter_type = arg_3_2
		self._call_back_func = nil

		if arg_3_3 then
			self._call_back_func = arg_3_3
		end

		self._picture_id = nil

		if arg_3_4 then
			self._picture_id = arg_3_4
		end

		self:__init_panel()
	end

	function arg_1_0:show_get_music(arg_4_1)
		self:setVisible(true)

		self._control.name_point.skin_des.text.text = var_0_1:getNowLang("unlockmusic")
		self._control.name_point.skin_name.text.text = var_0_6.find_object_by_cid(arg_4_1).title

		self._control.name_point.gameObject:SetActive(true)
		self:play_bg_in_animation(self._control.bg_content, true, function()
			self:play_bg_in_animation(self._control.text_content, true, function()
				self:play_bg_in_animation(self._control.text_content, false, function()
					self:play_bg_in_animation(self._control.bg_content, false, function()
						self:setVisible(false)
						self:__show_call_back()

						self._control.name_point.skin_des.text.text = var_0_1:getNowLang("gainskin")
					end)
				end)
			end)
		end)
	end

	function arg_1_0:show_map_pass(arg_9_1, arg_9_2)
		self:setVisible(true)

		self._control.name_point.skin_des.text.text = arg_9_1
		self._control.name_point.skin_name.text.text = arg_9_2

		self._control.name_point.gameObject:SetActive(true)
		self:play_bg_in_animation(self._control.bg_content, true, function()
			self:play_bg_in_animation(self._control.text_content, true, function()
				self:play_bg_in_animation(self._control.text_content, false, function()
					self:play_bg_in_animation(self._control.bg_content, false, function()
						self:setVisible(false)
					end)
				end)
			end)
		end)
	end

	function arg_1_0:show_map_pass_award(arg_14_1, arg_14_2, arg_14_3)
		self:setVisible(true)

		self._control.name_point.skin_des.text.text = arg_14_1
		self._control.name_point.skin_name.text.text = arg_14_2

		self._control.name_point.gameObject:SetActive(true)
		self:play_bg_in_animation(self._control.bg_content, true, function()
			self:play_bg_in_animation(self._control.text_content, true, function()
				self:play_bg_in_animation(self._control.text_content, false, function()
					self:play_bg_in_animation(self._control.bg_content, false, function()
						self:setVisible(false)

						if arg_14_3 then
							local var_18_0 = var_0_2:getInstance("mix_main_map")

							if var_18_0 then
								var_18_0:check_if_first_pass_and_switch()
							end
						end
					end)
				end)
			end)
		end)
	end

	function arg_1_0.play_bg_in_animation(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		if not arg_19_1 then
			return
		end

		local var_19_0 = arg_19_1

		if arg_19_2 then
			var_19_0.uITweenSequence:Play(function()
				if arg_19_3 then
					arg_19_3()
				end
			end)
		else
			var_19_0.uITweenSequence:PlayReverse(function()
				if arg_19_3 then
					arg_19_3()
				end
			end)
		end
	end

	function arg_1_0:__init_panel()
		self:__init_language()
		self:__show_school_prompt_info()

		self._is_already_init = true
	end

	function arg_1_0:__set_normal_content_ani(arg_23_1)
		self:play_bg_in_animation(self._control.bg_content, true, function()
			self:play_bg_in_animation(arg_23_1, true, function()
				self:__set_content_animation_state(arg_23_1)
			end)
		end)
	end

	function arg_1_0:__set_content_animation_state(arg_26_1)
		self:play_bg_in_animation(arg_26_1, false, function()
			self:play_bg_in_animation(self._control.bg_content, false, function()
				self:__show_ship_detail_panel()
				self:__show_picture_panel()
				self:setVisible(false)
				self:__show_call_back()
			end)
		end)
	end

	function arg_1_0:__init_language()
		self._control.name_point.skin_des.text.text = var_0_1:getNowLang("gainskin")
		self._control.new_head.get_des.text.text = var_0_1:getNowLang("ui_rewardtitle")
		self._control.new_head.head_name.text.text = var_0_1:getNowLang("head_icon")

		if self._enter_type == var_0_5.enter_get_ship_type.mall_shop or var_0_5.enter_get_ship_type.combats_shop then
			self._control.name_point.skin_des.text.text = var_0_1:getNowLang("get_change")
		end
	end

	function arg_1_0:__init_skin_data()
		self._now_skin_data = var_0_3.find_object_by_cid(self._now_show_skin_id)

		if self._now_skin_data then
			self._control.name_point.skin_name.text.text = self._now_skin_data.title
		end
	end

	function arg_1_0:__show_ship_detail_panel()
		if not self._now_skin_data then
			return
		end

		if self._enter_type ~= var_0_5.enter_get_ship_type.school_panel and self._enter_type ~= var_0_5.enter_get_ship_type.medal and self._enter_type ~= var_0_5.enter_get_ship_type.mail_new_head_award and self._enter_type ~= var_0_5.enter_icon_detail_type.picture_panel and self._enter_type ~= var_0_5.enter_get_ship_type.task_award then
			local var_31_0 = var_0_2:getInstance("mall_shop")

			if var_31_0 then
				var_31_0:setVisible(false)
			end

			var_0_2:createInstance("new_ship_or_equip"):show(true, {
				star = 6,
				pic_id = self._now_skin_data.icon,
				title = self._now_skin_data.title
			}, self._enter_type, function()
				if self._call_back_func then
					self._call_back_func()
				end

				if var_31_0 then
					var_31_0:setVisible(true)
				end
			end, self._now_skin_data)
		end
	end

	function arg_1_0:__show_picture_panel()
		if not self._picture_id then
			return
		end

		if self._enter_type ~= var_0_5.enter_get_ship_type.school_panel and self._enter_type ~= var_0_5.enter_get_ship_type.medal and self._enter_type ~= var_0_5.enter_get_ship_type.mail_new_head_award and self._enter_type ~= var_0_5.enter_get_ship_type.task_award then
			var_0_2:createInstance("cinema_cg_info"):show(self._picture_id, nil, var_0_5.enter_icon_detail_type.picture_panel, self._call_back_func)
		end
	end

	function arg_1_0:__show_school_prompt_info()
		self._control.bg_content.gameObject:SetActive(true)
		self._control.bg_content_back_ground.gameObject:SetActive(false)

		if self._enter_type == var_0_5.enter_get_ship_type.school_panel then
			self._control.school_info.gameObject:SetActive(true)

			self._control.school_info.text_des.text.text = self._now_show_skin_id == 1 and var_0_1:getNowLang("newclassopen") or var_0_1:getNowLang("classthreeopen")

			self:__set_normal_content_ani(self._control.school_content)
		elseif self._enter_type == var_0_5.enter_get_ship_type.medal then
			self._now_medal_data = var_0_4.find_object_by_id(self._now_medal_id)
			self._control.medal_point.medal_des.text.text = var_0_1:getNowLang("logget")
			self._control.medal_point.medal_name.text.text = self._now_medal_data.sub_title[self._now_medal_lv + 1].value .. self._now_medal_data.title

			self:__set_normal_content_ani(self._control.medal_content)
		elseif self._enter_type == var_0_5.enter_get_ship_type.mail_new_head_award or self._enter_type == var_0_5.enter_get_ship_type.task_award then
			local var_34_0 = var_0_7(var_0_5.captainroom_head, self._now_show_skin_id)
			local var_34_1 = self:loadSprite(var_0_7(var_0_5.captainroom_head, self._now_show_skin_id))

			if var_34_1 then
				self._control.new_head.head_image.image.sprite = var_34_1
			end

			self:__set_normal_content_ani(self._control.new_head_content)
		elseif self._enter_type == var_0_5.enter_icon_detail_type.picture_panel then
			self._control.picture_point.gameObject:SetActive(true)

			self._control.picture_point.skin_des.text.text = var_0_1:getNowLang("ui_cg_get_tip")
			self._control.picture_point.skin_name.text.text = var_0_8.find_object_by_cid(self._picture_id).title

			self._control.bg.gameObject:SetActive(true)

			self._control.bg.gameObject.canvasGroup.alpha = 1
			self._control.picture_point.rectTransform.anchoredPosition = var_0_9(900, 0)
			self._control.picture_point.transform:DOLocalMoveX(-850, 0.8):SetEase(DG.Tweening.Ease.Linear):SetRelative(true):SetAutoKill(true).onComplete = function()
				local var_35_0 = self:autoKillDOTween(var_0_10.Sequence())

				var_35_0:AppendInterval(2.5)
				var_35_0:AppendCallback(function()
					self._control.picture_point.gameObject:SetActive(false)
					self._control.bg.gameObject:SetActive(false)
					self:play_bg_in_animation(self._control.picture_content, false, function()
						return
					end)
					self:setVisible(false)
					self:__show_picture_panel()
				end)
			end
		else
			self._control.name_point.gameObject:SetActive(true)
			self:__init_skin_data()
			self:__set_normal_content_ani(self._control.text_content)
		end
	end

	function arg_1_0:__show_call_back()
		if (self._enter_type == var_0_5.enter_get_ship_type.mail_new_head_award or self._enter_type == var_0_5.enter_get_ship_type.mail_skin_award) and self._call_back_func then
			self._call_back_func()
		end
	end

	function arg_1_0.clear__now_skin_data(arg_39_0, arg_39_1, arg_39_2)
		arg_39_0._call_back_func = arg_39_2
		arg_39_0._now_skin_data_2 = arg_39_1
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_40_0)
	local var_40_0 = var_0_2:class("reward_tip")

	var_40_0._is_already_init = false
	var_40_0._now_show_skin_id = nil
	var_40_0._now_skin_data = nil
	var_40_0._now_medal_id = nil
	var_40_0._now_medal_lv = nil
	var_40_0._now_medal_data = nil
	var_40_0._enter_type = nil
	var_40_0._call_back_func = nil
	var_40_0._now_skin_data_2 = 1

	return var_40_0
end

return var_0_0
