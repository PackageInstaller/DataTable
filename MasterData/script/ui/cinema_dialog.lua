local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = UnityEngine.Time
local var_0_7 = UnityEngine.Vector3
local var_0_8 = gameconfig.ship_config
local var_0_9 = gameconfig.monster_config
local var_0_10 = Spine.Unity.SkeletonGraphic
local var_0_11 = gamecore.BattleManager
local var_0_12 = gameconfig.pve_active_map_config
local var_0_13 = gameconfig.cinema_story_id_list_config
local var_0_14 = {
	[1001] = gameconfig.main_story_1_config,
	[1002] = gameconfig.main_story_2_config,
	[1003] = gameconfig.main_story_3_config,
	[1004] = gameconfig.main_story_4_config,
	[1005] = gameconfig.main_story_5_config,
	[1006] = gameconfig.main_story_6_config,
	[1007] = gameconfig.main_story_7_config,
	[1008] = gameconfig.main_story_8_config,
	[1009] = gameconfig.main_story_9_config,
	[1010] = gameconfig.main_story_10_config,
	[1011] = gameconfig.main_story_11_config,
	[1012] = gameconfig.main_story_12_config,
	[1013] = gameconfig.main_story_13_config,
	[1014] = gameconfig.main_story_14_config,
	[1015] = gameconfig.main_story_15_config,
	[1016] = gameconfig.main_story_16_config,
	[1017] = gameconfig.main_story_17_config,
	[1018] = gameconfig.main_story_18_config,
	[1019] = gameconfig.main_story_19_config,
	[1020] = gameconfig.main_story_20_config,
	[1021] = gameconfig.main_story_21_config,
	[1022] = gameconfig.main_story_22_config,
	[1023] = gameconfig.main_story_23_config,
	[1024] = gameconfig.main_story_24_config,
	[1025] = gameconfig.main_story_25_config,
	[2001] = gameconfig.character_story_1_config,
	[2002] = gameconfig.character_story_2_config,
	[2003] = gameconfig.character_story_3_config,
	[2004] = gameconfig.character_story_4_config,
	[2005] = gameconfig.character_story_5_config,
	[2006] = gameconfig.character_story_6_config,
	[2007] = gameconfig.character_story_7_config,
	[2008] = gameconfig.character_story_8_config,
	[2009] = gameconfig.character_story_9_config,
	[2010] = gameconfig.character_story_10_config
}
local var_0_16 = 0
local var_0_17 = 0

gamecore.UILoader:define("cinema_dialog", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self:setVisible(true)
		self:__init_panel(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)

		if arg_2_2 then
			local var_2_0

			for iter_2_0, iter_2_1 in pairs((var_0_13.get_sequence())) do
				if iter_2_1.movie_id[1] == arg_2_2 then
					var_2_0 = iter_2_1.id
				end
			end

			if var_2_0 then
				var_0_1:req_UnlockStoryReq(var_2_0)
			end
		end
	end

	function arg_1_0:__onUpdate()
		if self._is_already_init then
			if self.is_now_playback then
				return
			end

			var_0_16 = var_0_6.deltaTime + var_0_16

			if var_0_16 > var_0_17 and self._is_beacon_show == false and self.is_auto == false then
				self:play_beacon_animation(true)
			end

			if var_0_16 > var_0_17 + 0.5 and self.is_auto == true then
				self:set_onclick_event()
			end
		end
	end

	function arg_1_0:set_expression_animation(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
		self._expression_skeleton_graphic.AnimationState:ClearTracks()

		self._expression_skeleton_graphic.startingAnimation = arg_4_3

		self._expression_skeleton_graphic:Initialize(true)

		arg_4_1.canvasGroup.alpha = 1

		self._expression_skeleton_graphic.AnimationState:SetAnimation(arg_4_2, arg_4_3, arg_4_4)

		local var_4_0 = {}

		var_4_0[#var_4_0 + 1] = {
			execute_time = arg_4_5,
			execute_func = function()
				self._expression_skeleton_graphic.AnimationState:ClearTracks()
			end
		}
		var_4_0[#var_4_0 + 1] = {
			execute_time = arg_4_5 + 0.4,
			execute_func = function()
				arg_4_1.canvasGroup.alpha = 0
			end
		}
	end

	function arg_1_0:play_text_animation(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8, arg_7_9)
		arg_7_2 = string.gsub(arg_7_2, "#username#", var_0_1:get_name())
		var_0_17 = #arg_7_2 * 0.03
		self.now_word = arg_7_2

		if arg_7_3 ~= "4" then
			self:play_font_type(arg_7_2, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8, arg_7_9)
		else
			self._control.background:SetActive(true)

			self._control.background.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_dialog_background[1], arg_7_7))
		end

		self._control.dialog_box.txt_n.text.text = ""
		self._control.dialog_box.txt_side.text.text = ""

		local var_7_0 = self._control.dialog_box.txt_n:GetComponent("Text")
		local var_7_1 = self:autoKillDOTween(var_0_5.Sequence())

		if arg_7_1 then
			self._control.cilck_btn:GetComponent("Button").interactable = true

			self._control.dialog_box:SetActive(true)

			if self.now_dialog_data.chara1No ~= "0" then
				self._control.chara_1:SetActive(true)
			end

			self._control.monologue_txt:SetActive(false)

			if arg_7_3 == "1" then
				self._control.dialog_box.image.sprite = self:loadSprite(var_0_4.story_dialog_box[1])
				self._control.dialog_box.transform.anchoredPosition = Vector2(105, 0)

				self._control.dialog_box:GetComponent("Image"):SetNativeSize()
				self._control.dialog_box.chara_name:SetActive(false)
				self._control.dialog_box.txt_n:SetActive(false)
				self._control.dialog_box.txt_side:SetActive(true)

				self.now_dotext = var_7_1:Append(self._control.dialog_box.txt_side:GetComponent("Text"):DOText(self.now_word, var_0_17):SetEase(DG.Tweening.Ease.Linear):SetDelay(self.delay_time))
				self.now_beacon_pos = Vector2(497, -60)
				self._control.dialog_box.beacon.rectTransform.anchoredPosition = self.now_beacon_pos
			end

			if arg_7_3 == "2" then
				self._control.dialog_box.image.sprite = self:loadSprite(var_0_4.story_dialog_box[2])
				self._control.dialog_box.transform.anchoredPosition = Vector2(105, 26)

				self._control.dialog_box:GetComponent("Image"):SetNativeSize()

				self._control.dialog_box.chara_name.image.sprite = self:loadSprite(var_0_4.story_dialog_name_box[1])

				self._control.dialog_box.chara_name:GetComponent("Image"):SetNativeSize()
				self._control.dialog_box.chara_name:SetActive(true)
				self._control.dialog_box.txt_n:SetActive(true)
				self._control.dialog_box.txt_side:SetActive(false)

				self.now_dotext = var_7_1:Append(var_7_0:DOText(self.now_word, var_0_17):SetEase(DG.Tweening.Ease.Linear):SetDelay(self.delay_time))
				self.now_beacon_pos = Vector2(508, -65)
				self._control.dialog_box.beacon.rectTransform.anchoredPosition = self.now_beacon_pos
			end

			if arg_7_3 == "3" then
				self._control.dialog_box.image.sprite = self:loadSprite(var_0_4.story_dialog_box[3])
				self._control.dialog_box.transform.anchoredPosition = Vector2(65, 0)

				self._control.dialog_box:GetComponent("Image"):SetNativeSize()

				self._control.dialog_box.chara_name.image.sprite = self:loadSprite(var_0_4.story_dialog_name_box[2])

				self._control.dialog_box.chara_name:GetComponent("Image"):SetNativeSize()
				self._control.dialog_box.chara_name:SetActive(true)
				self._control.dialog_box.txt_n:SetActive(true)
				self._control.dialog_box.txt_side:SetActive(false)

				self.now_dotext = var_7_1:Append(var_7_0:DOText(self.now_word, var_0_17):SetEase(DG.Tweening.Ease.Linear):SetDelay(self.delay_time))
				self.now_beacon_pos = Vector2(466, -54)
				self._control.dialog_box.beacon.rectTransform.anchoredPosition = self.now_beacon_pos
			end

			if arg_7_3 == "4" then
				var_0_17 = #arg_7_2 * 0.02
				self._control.cilck_btn:GetComponent("Button").interactable = false

				self._control.dialog_box:SetActive(false)
				self._control.chara_1:SetActive(false)

				self._control.monologue_txt.text.text = ""

				local var_7_2 = self._control.monologue_txt:GetComponent("Text")
				local var_7_3 = self:autoKillDOTween(var_0_5.Sequence())

				self._control.monologue_txt:SetActive(arg_7_1)

				self.now_dotext = var_7_3:Append(var_7_2:DOText(self.now_word, var_0_17):SetEase(DG.Tweening.Ease.Linear))

				var_7_2:DOFade(1, 5)
				var_7_3:AppendInterval(self.now_dialog_data.displaytime - var_0_17)
				var_7_3:AppendCallback(function()
					var_7_2:DOFade(0, 5):OnComplete(function()
						self._control.monologue_txt:SetActive(not arg_7_1)
						var_7_3:Kill()

						var_7_3 = nil

						self:set_dialog_data(self.now_index, self.now_id + 1, self.now_end_id)
					end)
				end)
			end
		else
			self.now_dotext:Kill()

			self._control.dialog_box.txt_n.text.text = arg_7_2
			self._control.dialog_box.txt_side.text.text = arg_7_2
		end
	end

	function arg_1_0:play_font_type(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
		if arg_10_2 == 1 and arg_10_3 ~= 1 then
			arg_10_1 = "<i>" .. arg_10_1 .. "</i>"
			self.now_word = arg_10_1
		end

		if arg_10_2 ~= 1 and arg_10_3 == 1 then
			arg_10_1 = "<b>" .. arg_10_1 .. "</b>"
			self.now_word = arg_10_1
		end

		if arg_10_2 == 1 and arg_10_3 == 1 then
			arg_10_1 = "<b>" .. "<i>" .. arg_10_1 .. "</b>" .. "</i>"
			self.now_word = arg_10_1
		end

		if arg_10_4 == 1 then
			self._control.yellow:SetActive(true)
		end

		if arg_10_4 == 0 then
			self._control.yellow:SetActive(false)
		end

		if arg_10_5 and arg_10_5 ~= "0" then
			self._control.background:SetActive(true)

			self._control.background.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_dialog_background[1], arg_10_5))
		end

		if arg_10_5 == "0" then
			self._control.background:SetActive(false)
		end

		if arg_10_6 then
			self.now_word = string.format("<color=#%s>%s</color>", arg_10_6, self.now_word)
		end

		if arg_10_7 then
			self.now_word = string.format("<size=%s>%s</size>", arg_10_7, self.now_word)
		end
	end

	function arg_1_0:play_beacon_animation(arg_11_1, arg_11_2)
		if arg_11_1 then
			self.now_beacon_domove = self:autoKillDOTween(var_0_5.Sequence()):Append(self._control.dialog_box.beacon.transform:DOLocalMoveY(10, 0.3):SetRelative(true))

			self.now_beacon_domove:SetLoops(-1, DG.Tweening.LoopType.Yoyo)

			self._is_beacon_show = true
		elseif self.now_beacon_domove then
			self.now_beacon_domove:Kill()

			if self.now_beacon_pos then
				self._control.dialog_box.beacon.rectTransform.anchoredPosition = self.now_beacon_pos
			end

			self._is_beacon_show = false
		end
	end

	function arg_1_0:set_chara_animation(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8, arg_12_9, arg_12_10, arg_12_11, arg_12_12, arg_12_13)
		if arg_12_13 ~= nil and arg_12_13 == self._bg_bgm then
			-- block empty
		elseif arg_12_13 ~= nil and arg_12_13 ~= self._bg_bgm then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, arg_12_13))

			self._bg_bgm = arg_12_13
		end

		local var_12_0 = arg_12_1.rectTransform
		local var_12_1 = arg_12_1.rectTransform:GetComponent("CanvasGroup")
		local var_12_2 = self:autoKillDOTween(var_0_5.Sequence())

		if arg_12_2 == 1 then
			self._control.cover:SetActive(true)

			self.now_chara_animation = var_12_2:Append(var_12_0:DOShakePosition(1, 8, 7, 0.3, true):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true))

			self.now_chara_animation:OnKill(function()
				self._control.cover:SetActive(false)

				var_0_16 = 0
			end)

			self.delay_time = 1
		end

		if arg_12_3 == 1 then
			self._control.cover:SetActive(true)

			var_12_1.alpha = 0
			self.now_chara_animation = var_12_2:Append(var_12_1:DOFade(1, 2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true))

			self.now_chara_animation:OnKill(function()
				self._control.cover:SetActive(false)

				var_0_16 = 0
			end)

			self.delay_time = 2
		end

		if arg_12_4 == 1 then
			self._control.cover:SetActive(true)

			var_12_1.alpha = 1
			self.now_chara_animation = var_12_2:Append(var_12_1:DOFade(0, 2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true))

			self.now_chara_animation:OnKill(function()
				self._control.cover:SetActive(false)

				var_0_16 = 0

				arg_12_1:SetActive(false)

				var_12_1.alpha = 1
			end)

			self.delay_time = 0
		end

		if arg_12_5 == 1 then
			self._control.cover:SetActive(true)

			self.now_chara_animation = var_12_2:Append(var_12_0:DOShakePosition(1, 0, 0, 0, true):SetAutoKill(true))

			self.now_chara_animation:OnKill(function()
				self._control.cover:SetActive(false)

				var_0_16 = 0

				self._control.cover:SetActive(false)
			end)

			self.delay_time = 1
		end

		if arg_12_6 == 1 then
			self._control.cover:SetActive(true)

			local var_12_3 = self._control.black.transform:GetComponent("CanvasGroup")

			self._control.dialog_box:SetActive(false)

			self.now_chara_animation = var_12_2:Append(var_12_3:DOFade(1, 1):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true))

			self.now_chara_animation:OnKill(function()
				var_0_16 = 0
				self.now_chara_animation_2 = var_12_2:Append(var_12_3:DOFade(0, 1):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true))

				if self then
					self._control.dialog_box:SetActive(true)
					self._control.cover:SetActive(false)
				end
			end)

			self.delay_time = 2
		end

		if arg_12_9 and arg_12_9 ~= 0 then
			self._control.cover:SetActive(true)

			local var_12_4 = arg_12_1.rectTransform.localPosition.x

			self.now_chara_animation = var_12_2:Append(var_12_0:DOLocalMoveX(arg_12_9, 0.5):SetAutoKill(true))

			self.now_chara_animation:OnKill(function()
				self:charaCrashX_animation_2(arg_12_1, var_12_4)
			end)

			self.delay_time = 2
		end

		if arg_12_10 and arg_12_10 ~= 0 then
			self._control.storyicon:SetActive(true)

			self._control.storyicon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_dialog_storyicon[1], arg_12_10))
			self._control.storyicon.rectTransform.anchoredPosition = Vector2(arg_12_11, arg_12_12)
		else
			self._control.storyicon:SetActive(false)
		end
	end

	function arg_1_0:charaCrashX_animation_2(arg_19_1, arg_19_2)
		local var_19_0 = arg_19_1.rectTransform:GetComponent("CanvasGroup")

		self.now_chara_animation_2 = self:autoKillDOTween(var_0_5.Sequence()):Append(arg_19_1.rectTransform:DOShakePosition(1, 8, 7, 0.3, true):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true))

		self.now_chara_animation_2:OnKill(function()
			self:charaCrashX_animation_3(arg_19_1, arg_19_2)
		end)
	end

	function arg_1_0:charaCrashX_animation_3(arg_21_1, arg_21_2)
		local var_21_0 = arg_21_1.rectTransform:GetComponent("CanvasGroup")

		self.now_chara_animation_3 = self:autoKillDOTween(var_0_5.Sequence()):Append(arg_21_1.rectTransform:DOLocalMoveX(arg_21_2, 0.5):SetAutoKill(true))

		self.now_chara_animation_3:OnKill(function()
			var_0_16 = 0

			self._control.cover:SetActive(false)
		end)
	end

	function arg_1_0:set_chara_data(arg_23_1)
		self._control.chara_1:SetActive(false)
		self._control.chara_2:SetActive(false)
		self._control.chara_3:SetActive(false)
		self:set_chara_num_data(self._control.chara_1, arg_23_1.chara1No, arg_23_1.chara1Broken, arg_23_1.chara1PosX, arg_23_1.chara1PosY, arg_23_1.highlight1)
		self:set_chara_num_data(self._control.chara_2, arg_23_1.chara2No, arg_23_1.chara2Broken, arg_23_1.chara2PosX, arg_23_1.chara2PosY, arg_23_1.highlight2)
		self:set_chara_num_data(self._control.chara_3, arg_23_1.chara3No, arg_23_1.chara3Broken, arg_23_1.chara3PosX, arg_23_1.chara3PosY, arg_23_1.highlight3)
		self:set_expression_num_data(self._control.expression_1, arg_23_1.chara1faceNo, arg_23_1.chara1facePosX, arg_23_1.chara1facePosY)
		self:set_expression_num_data(self._control.expression_2, arg_23_1.chara2faceNo, arg_23_1.chara2facePosX, arg_23_1.chara2facePosY)
		self:set_expression_num_data(self._control.expression_3, arg_23_1.chara3faceNo, arg_23_1.chara3facePosX, arg_23_1.chara3facePosY)
	end

	function arg_1_0:set_chara_num_data(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6)
		if arg_24_2 ~= nil and arg_24_2 ~= "0" then
			arg_24_1:SetActive(true)
			self:find_ship_id(arg_24_2)

			local var_24_1 = self:autoKillDOTween(var_0_5.Sequence())
			local var_24_3, var_24_4 = self:loadSprite(arg_24_3 == 0 and var_0_4:get_audio_url(var_0_4.ship_icon.model_normal_l, self.now_dialog_pic_id, self.now_dialog_pic_id) or var_0_4:get_audio_url(var_0_4.ship_icon.model_broken_l, self.now_dialog_pic_id, self.now_dialog_pic_id))

			arg_24_1.image.sprite = var_24_3
			arg_24_1.image.transform.localScale = var_0_7(1, 1, 1)

			if var_24_4 then
				var_0_4:hd_sprite_half_scale(arg_24_1.image.transform)
			end

			arg_24_1:GetComponent("Image"):SetNativeSize()

			arg_24_1.rectTransform.anchoredPosition = Vector2(arg_24_4, arg_24_5)
			arg_24_1:GetComponent("Image").color = arg_24_6 == 1 and Color(1, 1, 1, 1) or Color(0.5, 0.5, 0.5, 1)
		end
	end

	function arg_1_0:set_expression_num_data(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
		local var_25_0 = {
			"story_emoticon_angry",
			"story_emoticon_awkward",
			"story_emoticon_helpless",
			"story_emoticon_sadness",
			"story_emoticon_happy"
		}

		if arg_25_2 ~= 0 then
			if not arg_25_1:GetComponent("SkeletonGraphic") then
				self._expression_skeleton_graphic = var_0_10.AddSkeletonGraphicComponent(arg_25_1.gameObject, (self:loadSkeletonDataAsset(var_0_4.story_dialog_emoticon[1])))
				self._expression_skeleton_graphic.material = self:loadMaterial(var_0_4.dormitory_const.ship_expression_spine_mat_path)
				self._expression_skeleton_graphic.startingAnimation = var_25_0[arg_25_2]
				self._expression_skeleton_graphic.raycastTarget = false

				self._expression_skeleton_graphic:Initialize(true)
			end

			arg_25_1.canvasGroup.alpha = 1
			arg_25_1.rectTransform.anchoredPosition = Vector2(arg_25_3, arg_25_4)

			self:set_expression_animation(arg_25_1, 0, var_25_0[arg_25_2], false, 0.7)
		else
			arg_25_1.canvasGroup.alpha = 0
		end
	end

	function arg_1_0:set_dialog_data(arg_26_1, arg_26_2, arg_26_3)
		self._is_already_init = true

		if arg_26_3 < arg_26_2 or arg_26_2 == 0 or self.now_dialog_data.nextStep == -1 then
			self:reset_dialog_data()
			var_0_3:destroyInstance("cinema_dialog")

			self.num = 1

			self:set_exit_bgm()

			return
		end

		self.now_index = arg_26_1
		self.now_id = arg_26_2
		self.now_end_id = arg_26_3
		self.now_dialog_data = var_0_14[arg_26_1].find_object_by_step(arg_26_2)

		if self.now_dialog_data.branch1 and self.now_dialog_data.branch1 ~= 0 then
			self:reset_dialog_data(true)
			self:set_option_data(self.now_dialog_data)

			return
		end

		self._control.dialog_box.chara_name.txt.text.text = self.now_dialog_data.shipname

		if self.now_dialog_data.shipname == "userid" then
			self._control.dialog_box.chara_name.txt.text.text = var_0_1:get_name()
			self.now_dialog_data.shipname = var_0_1:get_name()
		elseif string.find(self.now_dialog_data.shipname, "userid") ~= nil then
			local var_26_0, var_26_1 = string.find(self.now_dialog_data.shipname, "userid")

			self._control.dialog_box.chara_name.txt.text.text = var_0_1:get_name() .. string.sub(self.now_dialog_data.shipname, var_26_1 + 1)
			self.now_dialog_data.shipname = var_0_1:get_name()
		end

		self.now_dialog_data.word = string.gsub(self.now_dialog_data.word, "#username#", var_0_1:get_name())

		self:set_chara_data(self.now_dialog_data)
		self:set_chara_animation(self._control.chara_1, self.now_dialog_data.chara1Shock, self.now_dialog_data.chara1FadeIn, self.now_dialog_data.chara1FadeOut, nil, nil, self.now_dialog_data.chara1ExitRight, self.now_dialog_data.chara1ExitLeft, self.now_dialog_data.chara1CrashX)
		self:set_chara_animation(self._control.chara_2, self.now_dialog_data.chara2Shock, self.now_dialog_data.chara2FadeIn, self.now_dialog_data.chara2FadeOut, nil, nil, self.now_dialog_data.chara2ExitRight, self.now_dialog_data.chara2ExitLeft, self.now_dialog_data.chara2CrashX)
		self:set_chara_animation(self._control.chara_3, self.now_dialog_data.chara3Shock, self.now_dialog_data.chara3FadeIn, self.now_dialog_data.chara3FadeOut, nil, nil, self.now_dialog_data.chara3ExitRight, self.now_dialog_data.chara3ExitLeft, self.now_dialog_data.chara3CrashX)
		self:set_chara_animation(self._control.dialog_box, self.now_dialog_data.shock, nil, nil, self.now_dialog_data.wait, self.now_dialog_data.black, nil, nil, nil, self.now_dialog_data.storyicon, self.now_dialog_data.storyiconX, self.now_dialog_data.storyiconY, self.now_dialog_data.bgm)
		self:play_text_animation(true, self.now_dialog_data.word, self.now_dialog_data.dialogbox, self.now_dialog_data.incline, self.now_dialog_data.bold, self.now_dialog_data.yellow, self.now_dialog_data.background, self.now_dialog_data.fontcolor, self.now_dialog_data.wordsize)

		self.delay_time = 0

		local var_26_2 = self:loadUI("single_back_dialog")

		var_26_2:show(self.now_dialog_data.dialogbox, self.now_dialog_data.shipname, self.now_dialog_data.word)
		var_26_2._panel.transform:SetParent(self._control.back_play.scrollview.viewport.content.transform, false)
	end

	function arg_1_0:set_option_data(arg_27_1)
		self._control.chara_1:SetActive(false)
		self._control.chara_2:SetActive(false)
		self._control.chara_3:SetActive(false)
		self._control.dialog_box:SetActive(false)
		self._control.cilck_btn:SetActive(false)
		self._control.playback_btn:SetActive(false)
		self._control.auto_btn:SetActive(false)
		self._control.skip_btn:SetActive(false)
		self._control.storyicon:SetActive(false)
		self._control.chose_option:SetActive(true)

		self._control.chose_option.option_1.txt_1.text.text = arg_27_1.upDesc1
		self._control.chose_option.option_1.txt_2.text.text = arg_27_1.downDesc1
		self._control.chose_option.option_2.txt_1.text.text = arg_27_1.upDesc2
		self._control.chose_option.option_2.txt_2.text.text = arg_27_1.downDesc2

		self._control.chose_option.option_1.button.onClick:RemoveAllListeners()
		self._control.chose_option.option_1.button.onClick:AddListener(function()
			self:set_dialog_data(self.now_index, arg_27_1.branch1, self.now_end_id)
			self._control.playback_btn:SetActive(true)
			self._control.auto_btn:SetActive(true)
			self._control.skip_btn:SetActive(true)
			self._control.chose_option:SetActive(false)
			self._control.dialog_box:SetActive(true)
			self._control.cilck_btn:SetActive(true)
		end)
		self._control.chose_option.option_2.button.onClick:RemoveAllListeners()
		self._control.chose_option.option_2.button.onClick:AddListener(function()
			self:set_dialog_data(self.now_index, arg_27_1.branch2, self.now_end_id)
			self._control.playback_btn:SetActive(true)
			self._control.auto_btn:SetActive(true)
			self._control.skip_btn:SetActive(true)
			self._control.chose_option:SetActive(false)
			self._control.dialog_box:SetActive(true)
			self._control.cilck_btn:SetActive(true)
		end)
	end

	function arg_1_0:set_onclick_event()
		if var_0_16 < var_0_17 then
			self:play_text_animation(false, self.now_word)

			var_0_16 = var_0_17

			return
		end

		if var_0_16 > var_0_17 then
			self:play_beacon_animation(false)

			if self.now_dialog_data.nextStep and self.now_dialog_data.nextStep ~= 0 then
				self:set_dialog_data(self.now_index, self.now_dialog_data.nextStep, self.now_end_id)
			else
				self:set_dialog_data(self.now_index, self.now_id + 1, self.now_end_id)
			end

			var_0_16 = 0

			return
		end
	end

	function arg_1_0:set_auto_event()
		if self.is_auto == false then
			self.is_auto = true
			self.now_auto_dorotate = self:autoKillDOTween(var_0_5.Sequence()):Append(self._control.auto_btn.icon.transform:DORotate(var_0_7(0, 0, -360), 3):SetEase(DG.Tweening.Ease.Linear):SetRelative(true))

			self.now_auto_dorotate:SetLoops(-1, DG.Tweening.LoopType.Incremental)

			return
		end

		if self.is_auto == true then
			self.is_auto = false

			self.now_auto_dorotate:Kill()

			self._control.auto_btn.icon.transform.rotation = var_0_7(0, 0, 0)

			return
		end
	end

	function arg_1_0:set_exit_bgm()
		self._control.monologue_txt:SetActive(false)

		if var_0_1:get_into_cinema() then
			if self._now_index == var_0_4.activity_into_cinema.abyss then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.abyss_activity_bgm))
			end
		elseif var_0_1:get_goto_abyss() then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.abyss_activity_bgm))
		elseif var_0_1:get_goto_fear_sea() then
			local var_32_0 = var_0_3:getInstance("fight_info")
			local var_32_1 = var_0_3:getInstance("fearlessness_sea")

			if var_32_0 and var_32_0 then
				if var_32_0._map_id then
					self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_12.find_object_by_id(var_32_0._map_id).music))
				end
			end

			if var_32_1 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_1._active_config.bgm))
			end
		elseif var_0_1:get_to_six_year() then
			if var_0_1:get_now_six_bgm() then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_1:get_now_six_bgm()))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.sixth_activity_bgm))
			end
		elseif var_0_1:get_to_mix() then
			local var_32_2 = var_0_3:getInstance("mix_main_map")
			local var_32_3 = var_0_3:getInstance("fight_info")

			if var_32_2 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_2._pve_active_cfg.bgm))

				if var_32_3 then
					self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_3._seven_bgm))
				end
			elseif not var_32_2 and var_32_3 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_3._seven_bgm))
			end
		elseif var_0_1:get_to_eighth() then
			local var_32_4 = var_0_3:getInstance("eighth_main_map")
			local var_32_5 = var_0_3:getInstance("fight_info")

			if var_32_4 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_4._pve_active_cfg.bgm))

				if var_32_5 then
					self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_5._eighth_bgm))
				end
			elseif not var_32_4 and var_32_5 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_5._eighth_bgm))
			end
		elseif var_0_1:get_to_ninth() then
			local var_32_6 = var_0_3:getInstance("ninth_main_map")
			local var_32_7 = var_0_3:getInstance("fight_info")

			if var_32_6 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_6._active_config.bgm))

				if var_32_7 then
					self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_7._ninth_bgm))
				end
			elseif not var_32_6 and var_32_7 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_32_7._ninth_bgm))
			end
		else
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.living_bgm))
		end
	end

	function arg_1_0:set_skip_event()
		if self.now_dotext then
			self.now_dotext:Kill()
		end

		if self.is_auto == true then
			self.is_auto = false

			self.now_auto_dorotate:Kill()

			self._control.auto_btn.icon.transform.rotation = var_0_7(0, 0, 0)
		end

		self:set_dialog_data(self.now_index, self.now_dialog_data.skipstep, self.now_end_id)
	end

	function arg_1_0:find_ship_id(arg_34_1)
		arg_34_1 = tonumber(arg_34_1)
		self.now_chara_data = var_0_8.find_object_by_cid(arg_34_1)

		if var_0_8.find_object_by_cid(arg_34_1) == nil then
			self.now_chara_data = var_0_9.find_object_by_id(arg_34_1)
		end

		if self.now_chara_data ~= nil then
			self.now_dialog_pic_id = self.now_chara_data.pic_id
		end
	end

	function arg_1_0:reset_dialog_data(arg_35_1)
		if self.now_dotext then
			self.now_dotext:Kill()
		end

		self.delay_time = 0
		self._control.dialog_box.txt_n.text.text = ""
		self._control.dialog_box.txt_side.text.text = ""
		self.is_auto = false
		var_0_16 = 0

		self:play_beacon_animation(false)

		self._is_already_init = false

		if not arg_35_1 then
			for iter_35_0 = 0, self._control.back_play.scrollview.viewport.content.rectTransform.childCount - 1 do
				self:destroyGameObject(self._control.back_play.scrollview.viewport.content.rectTransform:GetChild(iter_35_0).gameObject)
			end
		end

		if self.back_type == 1 then
			var_0_3:getInstance("fight_info"):__play_ship_move(self.data.start_node, self.data.next_node, true, self.data.is_chose)
		elseif self.back_type == 2 then
			var_0_3:getInstance("fight_info"):__map_move_response(self.data)
		elseif self.back_type == 3 then
			var_0_11:handleBattleScene("story_end", true)
		elseif self.back_type == 4 then
			var_0_3:getInstance("strike_map"):__play_ship_move(self.data.start_node, self.data.next_node, true)
		elseif self.back_type == 5 and self.func then
			self.func()
		end
	end

	function arg_1_0:__init_panel(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6)
		local var_36_0 = var_0_14[arg_36_1].find_object_by_step(arg_36_2).bgm

		self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_36_0))

		self._bg_bgm = var_36_0

		self:set_dialog_data(arg_36_1, arg_36_2, arg_36_3)

		self._is_already_init = true
		self.back_type = arg_36_4
		self.data = arg_36_5
		self.func = arg_36_6
		self._control.playback_btn.txt.text.text = var_0_2:getNowLang("ui_4th_dialog_log")
		self._control.auto_btn.txt.text.text = var_0_2:getNowLang("ui_4th_dialog_auto")
		self._control.skip_btn.txt.text.text = var_0_2:getNowLang("ui_4th_dialog_skip")
		self._now_index = arg_36_1
	end

	function arg_1_0:_play_audio(arg_37_1)
		self:playBackgroundMusic(arg_37_1)
	end

	function arg_1_0:_play_into_se(arg_38_1)
		self:playSE(arg_38_1, false)
	end

	function arg_1_0:__onReset()
		self.is_auto = false

		if self.now_auto_dorotate then
			self.now_auto_dorotate:Kill()
		end

		self._is_already_init = false
		self._is_beacon_show = false
		self.now_word = nil
		self.now_dotext = nil
		self.now_beacon_domove = nil
		self.now_beacon_pos = nil
		self.now_chara_data = {}
		self.now_dialog_data = {}
		self.now_dialog_pic_id = nil
		self.delay_time = 0
		self._bg_bgm = nil
		self.back_type = nil
		self.data = nil
		self.monologue_txt_length = 0
		self.func = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_40_0)
	local var_40_0 = var_0_3:class("cinema_dialog")

	var_40_0._is_already_init = false
	var_40_0._is_beacon_show = false
	var_40_0.now_word = nil
	var_40_0.now_dotext = nil
	var_40_0.now_beacon_domove = nil
	var_40_0.now_beacon_pos = nil
	var_40_0.now_chara_data = {}
	var_40_0.now_dialog_data = {}
	var_40_0.now_dialog_pic_id = nil
	var_40_0._expression_skeleton_graphic = nil
	var_40_0.delay_time = 0
	var_40_0.is_auto = false
	var_40_0._bg_bgm = nil
	var_40_0.back_type = nil
	var_40_0.data = nil
	var_40_0.monologue_txt_length = 0
	var_40_0.func = nil

	return var_40_0
end

return var_0_0
