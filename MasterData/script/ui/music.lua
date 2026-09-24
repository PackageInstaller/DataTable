local var_0_0 = {}
local var_0_1 = Vector2
local var_0_2 = gamecore.user
local var_0_3 = math.floor
local var_0_4 = gamecore.prompt
local var_0_5 = UnityEngine.Screen
local var_0_6 = gamecore.UILoader
local var_0_7 = gamecore.Language
local var_0_8 = string.format
local var_0_10 = gameenum.common_type
local var_0_11 = gamecore.AudioManager
local var_0_12 = gameconfig.music_config
local var_0_13 = {
	open_1 = "Music_box_open",
	change_music = "Music_box_change_music",
	close_3 = "Music_box_close_3",
	open_2 = "Music_box_open_2",
	close_2 = "Music_box_close_2",
	play = "Music_box_play",
	close_1 = "Music_box_close",
	stop = "Music_box_stop"
}

gamecore.UILoader:define("music", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self._enter_type = arg_2_1 or var_0_10.enter_music_type.myself

		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:play_in_out_animation(arg_3_1, arg_3_2, arg_3_3)
		arg_3_3 = arg_3_3 or self._control.bg.uITweenSequence

		if arg_3_1 then
			arg_3_3:Play(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		else
			arg_3_3:PlayReverse(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		end
	end

	function arg_1_0:play_animation(arg_6_1, arg_6_2, arg_6_3)
		self._skeleton_animation.timeScale = (arg_6_1 == var_0_13.open_1 or arg_6_1 == var_0_13.open_2) and 0.8 or 1

		if arg_6_3 then
			local var_6_0 = self._skeleton_animation.state.Complete

			local function var_6_1()
				arg_6_3()

				self._skeleton_animation.state.Complete = var_6_0
			end

			var_6_0 = self._skeleton_animation.state.Complete + var_6_1
			self._skeleton_animation.state.Complete = self._skeleton_animation.state.Complete + var_6_1
			var_6_0 = var_6_0 - var_6_1
		end

		if arg_6_1 == var_0_13.open_2 or arg_6_1 == var_0_13.stop then
			self._skeleton_animation.AnimationState:SetAnimation(0, arg_6_1, arg_6_2)
		else
			self._skeleton_animation.AnimationState:AddAnimation(0, arg_6_1, arg_6_2, 0)
		end

		self._track_entry = arg_6_1
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self._is_long_click and self._control.music_icon.activeSelf and UnityEngine.Input.GetMouseButtonUp(0) then
			local var_8_0 = false

			self._control.music_icon:SetActive(false)

			self._control.scrollview:GetComponent("ScrollRect").enabled = true
			self._control.music_icon.transform.position = UnityEngine.Vector3(1000, 1000, self._control.music_icon.transform.localPosition.z)

			local var_8_1, var_8_2 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._panel:GetComponent("RectTransform"), UnityEngine.Input.mousePosition, var_0_6:getUIRoot().parent.transform:Find("UICamera"):GetComponent("Camera"), nil)

			if var_8_2.x > -500 and var_8_2.x < -280 and var_8_2.y > -130 and var_8_2.y < 30 then
				var_0_2:req_ChangeMusicReq(self._now_reset_music_data.cid)

				var_8_0 = true
			end

			self._now_reset_music_data = {}
			self._is_long_click = false

			if self._now_music then
				if var_8_0 then
					self:play_animation(var_0_13.close_3, false, function()
						self:play_animation(var_0_13.open_1, false, function()
							self:play_animation(var_0_13.play, true, function()
								self:_reply_audio()
							end)
						end)
					end)
				else
					self:play_animation(var_0_13.close_2, false, function()
						self:play_animation(var_0_13.open_1, false, function()
							self:play_animation(var_0_13.play, true, nil)
							self:_reply_audio()
						end)
					end)
				end
			elseif var_8_0 then
				self:play_animation(var_0_13.close_3, false, function()
					self:play_animation(var_0_13.open_1, false, function()
						if self._track_entry == var_0_13.open_1 then
							self:play_animation(var_0_13.stop, false, function()
								return
							end)
						end
					end)
				end)
			else
				self:play_animation(var_0_13.close_2, false, function()
					self:play_animation(var_0_13.open_1, false, function()
						if self._track_entry == var_0_13.open_1 then
							self:play_animation(var_0_13.stop, false, nil)
						end
					end)
				end)
			end
		end

		if self._control.music_icon.activeSelf then
			local var_8_3, var_8_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._panel:GetComponent("RectTransform"), UnityEngine.Input.mousePosition, var_0_6:getUIRoot().parent.transform:Find("UICamera"):GetComponent("Camera"), nil)

			self._control.music_icon:GetComponent("RectTransform").anchoredPosition = UnityEngine.Vector3(var_8_4.x, var_8_4.y, self._control.music_icon.transform.localPosition.z)
		end

		if self._is_play_music then
			self._play_time = self._play_time + UnityEngine.Time.deltaTime

			self:_set_progress()
		end
	end

	function arg_1_0.set_listener(arg_19_0, arg_19_1)
		arg_19_0._confirm_listener = arg_19_1
	end

	function arg_1_0:reset_bgm_resp()
		if self._now_bgm_music.control then
			self._now_bgm_music.control.transform:Find("bgm_txt").gameObject:SetActive(false)

			self._now_bgm_music = {}
		end

		self:__show_reset_bgm_layer(false)
		self:_fly_txt("ui_music_reset_tip1")
	end

	function arg_1_0:__init_panel()
		self.uiMapWidth = self._control.bg.rectTransform.rect.width
		self.uiMapHeight = self._control.bg.rectTransform.rect.height

		self:__init_language()
		self:__init_rank_list()

		self._user_data = var_0_2:get_use_info_data()

		self:__update_cell()
		self:__init_animation()
		self:play_animation(var_0_13.open_1, false, function()
			self:play_animation(var_0_13.stop, false, nil)
		end)
		var_0_11:init()
	end

	function arg_1_0:__init_animation()
		self._skeleton_animation = self._control.music_box_anim:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		self._skeleton_animation:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = self._panel:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder + 1
	end

	function arg_1_0.__destroy_animation(arg_24_0)
		arg_24_0._skeleton_animation = nil
	end

	function arg_1_0:__init_language()
		if self._already_init then
			return
		end

		self._control.top.title_txt.text.text = var_0_7:getNowLang("ui_music")
		self._control.top.tip_txt.text.text = var_0_7:getNowLang("ui_music_drop_tip")
		self._control.reset_bgm_layer.tip_txt.text.text = var_0_7:getNowLang("ui_music_reset_content")
		self._control.reset_bgm_layer.bg_top.title.text.text = var_0_7:getNowLang("ui_music_reset_title")
		self._control.reset_bgm_layer.ok_btn.txt.text.text = var_0_7:getNowLang("ensure")
		self._control.reset_bgm_layer.cancel_btn.txt.text.text = var_0_7:getNowLang("cancel")
	end

	function arg_1_0:__init_rank_list()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.scrollview.viewport.content.endlessScrollView, self._control.scrollview.viewport.content, "music_node", "music")

		self._reusable_cell:init()

		self._already_init = true
	end

	function arg_1_0:__update_cell()
		local var_27_0 = var_0_2:get_cardbook_music_list()
		local var_27_1, var_27_2 = var_0_12:get_sequence()

		self._reusable_cell:set_data(var_27_1)

		function self._reusable_cell:_set_func(arg_28_1)
			local var_28_0 = var_27_1[arg_28_1 + 1]

			function self:show_btn_by_index(arg_29_1)
				local var_29_0 = {
					self.locked_btn,
					self.stop_btn,
					self.play_btn
				}

				for iter_29_0 = 1, #var_29_0 do
					var_29_0[iter_29_0]:SetActive(false)
				end

				if arg_29_1 ~= 0 then
					var_29_0[arg_29_1]:SetActive(true)
				end
			end

			if self._user_data.music == var_28_0.cid then
				self._now_bgm_music.control = self.stop_btn.transform.parent
				self._now_bgm_music.index = arg_28_1
			end

			if self._now_bgm_music then
				self.bgm_txt:SetActive(self._now_bgm_music.index == arg_28_1)
			end

			local function var_28_1(arg_30_0, arg_30_1)
				self._is_long_click = true
				self._now_long_click_music.control = arg_30_0
				self._now_long_click_music.index = arg_30_1

				if self._now_bgm_music.index then
					if self._now_bgm_music.index == arg_30_1 then
						self._control.music_icon:SetActive(false)
					else
						self:_pause_audio()
					end
				else
					self:_pause_audio()
				end
			end

			self:show_btn_by_index(0)

			self.bgm_txt.text.text = var_0_7:getNowLang("ui_main_music")
			self.music_name_txt.text.text = var_28_0.title
			self.play_btn.music_name_txt.text.text = var_28_0.title
			self.play_btn.time_txt.text.text = "00:00"
			self.sort_txt.text.text = "NO." .. arg_28_1 + 1

			local var_28_2 = true

			if var_28_0.play_type == 0 then
				var_28_2 = false
			else
				for iter_28_0, iter_28_1 in ipairs(var_27_0) do
					if iter_28_1 == var_28_0.cid then
						var_28_2 = false

						break
					end
				end
			end

			if var_28_2 then
				self.locked_btn.unget_tip_txt.text.text = var_28_0.play_desc

				self.locked_btn:SetActive(true)
			else
				self.stop_btn:SetActive(true)
			end

			if self._now_music_index and self._now_music_index == arg_28_1 then
				self:show_btn_by_index(3)
			end

			local var_28_3 = self.stop_btn:GetComponent(typeof(ClickAndLongClickEvent))

			var_28_3.onLongClick:RemoveAllListeners()
			var_28_3.onLongClick:AddListener(function()
				self._now_reset_music_data = var_28_0

				var_28_1(self.stop_btn.transform.parent, arg_28_1)
			end)

			local var_28_4 = self.play_btn:GetComponent(typeof(ClickAndLongClickEvent))

			var_28_4.onLongClick:RemoveAllListeners()
			var_28_4.onLongClick:AddListener(function()
				self._now_reset_music_data = var_28_0

				var_28_1(self.stop_btn.transform.parent, arg_28_1)
			end)
			self.locked_btn.button.onClick:RemoveAllListeners()
			self.locked_btn.button.onClick:AddListener(function()
				self:_fly_txt("medaltypeungain")
			end)
			self.stop_btn.button.onClick:RemoveAllListeners()
			self.stop_btn.button.onClick:AddListener(function()
				var_28_0.res = string.lower(var_28_0.res)

				self:_play_audio(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_28_0.res, var_28_0.res))

				local var_34_0 = self:__check_screen_scale()

				if self.last_click_music_number and var_34_0 and var_34_0 <= math.abs(var_28_0.sort - self.last_click_music_number) then
					self._now_music = nil
					self._old_music = nil
					self._now_music_index = nil
				end

				if self:__check_cell() then
					self._now_playing_object:show_btn_by_index(2)
				end

				self.last_click_music_number = var_28_0.sort
				self._old_music = self._now_music
				self._now_music = self
				self._now_music_index = arg_28_1
				self._now_music.play_btn.anim.gameObject:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).timeScale = 1

				self:show_btn_by_index(3)
				self:play_animation(var_0_13.play, true, nil)
			end)
			self.play_btn.button.onClick:RemoveAllListeners()
			self.play_btn.button.onClick:AddListener(function()
				self:_stop_audio(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_28_0.res, var_28_0.res))
				self:show_btn_by_index(2)

				self._now_music = nil
				self._old_music = nil
				self._now_music_index = nil

				self:play_animation(var_0_13.stop, false, nil)
			end)
		end
	end

	function arg_1_0:__check_cell()
		for iter_36_0, iter_36_1 in pairs(self._reusable_cell._items) do
			if iter_36_1.control.play_btn.gameObject.activeSelf == true then
				self._now_playing_object = iter_36_1.control

				return true
			end
		end

		return false
	end

	function arg_1_0.__check_screen_scale(arg_37_0)
		if var_0_5.width / var_0_5.height > 1.5 then
			return 7
		elseif var_0_5.width / var_0_5.height < 1.5 then
			return 10
		end
	end

	function arg_1_0:__show_reset_bgm_layer(arg_38_1)
		if arg_38_1 then
			self:_play_into_se(var_0_10:get_audio_url(var_0_10.common_icon.music_path, var_0_10.open))
		end

		self._control.reset_bgm_layer:SetActive(arg_38_1)
	end

	function arg_1_0._fly_txt(arg_39_0, arg_39_1)
		var_0_4:show(var_0_7:getNowLang(arg_39_1))
	end

	function arg_1_0:__show_bgm_txt()
		self:_fly_txt("ui_music_reset_tip2")

		if self._now_bgm_music and next(self._now_bgm_music) then
			self._old_bgm_music = self._now_bgm_music
			self._now_bgm_music = self._now_long_click_music

			if self._old_bgm_music.control then
				self._old_bgm_music.control.transform:Find("bgm_txt").gameObject:SetActive(false)
			end

			if self._now_bgm_music.control then
				self._now_bgm_music.control.transform:Find("bgm_txt").gameObject:SetActive(true)
			end
		else
			self._now_bgm_music = self._now_long_click_music

			self._now_bgm_music.control.transform:Find("bgm_txt").gameObject:SetActive(true)
		end

		self._now_long_click_music = {}
	end

	function arg_1_0:_play_audio(arg_41_1)
		self._is_play_music = false

		var_0_11:init()

		self._now_music_clip = self:playBackgroundMusic(arg_41_1)
		self._start_music_time = lx.ServerTime:getUtcTime()
		self._end_change_music_time = 0
		self._start_change_music_time = 0
		self._change_music_time = 0
		self._play_time = 0
		self._is_play_music = true
	end

	function arg_1_0._stop_audio(arg_42_0, arg_42_1)
		arg_42_0._is_play_music = false

		var_0_11:init()

		arg_42_0._now_music_clip = nil
		arg_42_0._start_music_time = 0
		arg_42_0._start_change_music_time = 0
		arg_42_0._play_time = 0
	end

	function arg_1_0:_pause_audio()
		if self._now_music then
			self._now_music.play_btn.anim.gameObject:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).timeScale = 0
			self._is_play_music = false

			var_0_11:pauseAll()

			self._start_change_music_time = lx.ServerTime:getUtcTime()
		end

		self._control.music_icon:SetActive(true)

		self._control.scrollview:GetComponent("ScrollRect").enabled = false

		self:play_animation(var_0_13.open_2, false, function()
			if self._track_entry == var_0_13.open_2 then
				self:play_animation(var_0_13.change_music, true, nil)
			end
		end)
	end

	function arg_1_0:_reply_audio()
		if not self._now_music then
			return
		end

		var_0_11:resumeAll()

		self._now_music.play_btn.anim.gameObject:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).timeScale = 1
		self._end_change_music_time = lx.ServerTime:getUtcTime()
		self._change_music_time = self._end_change_music_time - self._start_change_music_time
		self._start_change_music_time = 0
		self._end_change_music_time = 0
		self._is_play_music = true
	end

	function arg_1_0:_set_progress()
		local var_46_0 = var_0_3(self._now_music_clip.length - self._play_time)

		self._now_music.play_btn.progress.image.fillAmount = self._play_time / self._now_music_clip.length % 1
		self._now_music.play_btn.time_txt.text.text = var_46_0 >= 60 and var_0_8("%02d:%02d", var_46_0 / 60, var_46_0 % 60) or var_0_8("00:%02d", var_46_0)

		if var_46_0 <= 0 then
			self._start_music_time = lx.ServerTime:getUtcTime()
			self._change_music_time = 0
			self._play_time = 0
		end
	end

	function arg_1_0:_play_into_se(arg_47_1)
		self:playSE(arg_47_1, false)
	end

	function arg_1_0:__onReset()
		var_0_11:init()

		self._is_play_music = false
		self._user_data = nil
		self._now_music = nil
		self._now_music_index = nil
		self._old_music = nil
		self._now_reset_music_data = {}
		self._is_long_click = nil
		self._now_long_click_music = {}
		self._now_bgm_music = {}
		self._now_music_clip = nil
		self._old_bgm_music = {}
		self._skeleton_animation = nil
		self._track_entry = nil
		self._control.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_1(0, 0)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_49_0)
	local var_49_0 = var_0_6:class("music")

	var_49_0._already_init = false
	var_49_0._confirm_listener = nil
	var_49_0._user_data = {}
	var_49_0._reusable_cell = nil
	var_49_0._now_music = nil
	var_49_0._old_music = nil
	var_49_0._now_reset_music_data = {}
	var_49_0._is_long_click = false
	var_49_0._now_long_click_music = {}
	var_49_0._now_bgm_music = {}
	var_49_0._old_bgm_music = {}
	var_49_0._now_music_clip = nil
	var_49_0._is_play_music = false
	var_49_0._start_music_time = 0
	var_49_0._start_change_music_time = 0
	var_49_0._end_change_music_time = 0
	var_49_0._change_music_time = 0
	var_49_0._skeleton_animation = nil
	var_49_0._track_entry = nil

	return var_49_0
end

return var_0_0
