local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = DG.Tweening.DOTween
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.prompt
local var_0_6 = gameconfig.chat_head_config
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.skin_config
local var_0_9 = string.format
local var_0_10 = gamecore.Language
local var_0_11 = gameconfig.sensitive_words_config
local var_0_12 = UnityEngine.Vector2
local var_0_13 = gamecore.util_func
local var_0_14
local var_0_15
local var_0_16
local var_0_17
local var_0_18
local var_0_19
local var_0_20
local var_0_21
local var_0_22

gamecore.UILoader:define("captainroom", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)
		var_0_3:set_to_cap(true)

		if not arg_2_1 then
			arg_2_1 = var_0_4.enter_captainroom_type.myself
		else
			self._friend_data = arg_2_2 and var_0_13.little_clone(arg_2_2) or {}
		end

		self._enter_type = arg_2_1

		self:__init_panel()
	end

	function arg_1_0:__onUpdate(arg_3_1)
		if self._start_update then
			self:__update_btn_bg(arg_3_1)
		end

		if self._can_close_btns == true and UnityEngine.Input.GetMouseButtonUp(0) then
			self:show_btn_list_layer(false)
		end
	end

	function arg_1_0.play_ske_anim(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_4_1.skeletonGraphic.AnimationState then
			arg_4_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_4_2, arg_4_3)
		end
	end

	function arg_1_0.get_ship_voice_path(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0

		if arg_5_3 then
			return ""
		else
			var_5_0 = "%s/%s_my_room.mp3"
		end

		if arg_5_2 and arg_5_2 ~= 0 then
			local var_5_1 = var_0_8.find_object_by_cid(arg_5_2).cv_id

			if var_5_1 and var_5_1 ~= 0 and var_5_1 ~= "0" then
				return var_0_9(var_5_0, var_5_1, var_5_1)
			end
		end

		local var_5_2 = var_0_7.find_object_by_cid(arg_5_1).pic_id

		return var_0_9(var_5_0, var_5_2, var_5_2)
	end

	function arg_1_0:set_captainroom_style()
		local var_6_0 = 0
		local var_6_1

		if self._enter_type == var_0_4.enter_captainroom_type.friend or self._enter_type == var_0_4.enter_captainroom_type.tower and self._friend_data._is_friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook and self._friend_data._is_friend then
			var_6_0 = self._friend_data.mansion.style
			var_6_1 = self:get_ship_voice_path(self._friend_data.secretary, self._friend_data.skin, true)
		elseif self._enter_type == var_0_4.enter_captainroom_type.cardbook or self._enter_type == var_0_4.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_4.enter_captainroom_type.tower and not self._friend_data._is_friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook and not self._friend_data._is_friend then
			var_6_0 = self._friend_data.mansion_style
			var_6_1 = self:get_ship_voice_path(self._friend_data.secretary, self._friend_data.skin, true)
		else
			var_6_0 = self._user_data.mansion_style

			local var_6_2 = var_0_3:find_character_by_id(self._user_data.secretary)

			var_6_1 = self:get_ship_voice_path(var_6_2.cid, var_6_2.skin)
		end

		if var_6_1 and var_6_1 ~= "" then
			self:playCV(var_6_1, false, "cv")
		end

		if var_6_0 == 10145 then
			self._control.bg.image.sprite = self:loadSprite(var_0_4.captainroom_style.room1)

			self._control.role_1:SetActive(true)
			self._control.role_2:SetActive(false)
			self._control.type1:SetActive(true)
			self._control.type2:SetActive(false)

			self._now_style_index = 1
			self._control.btn_list_layer.bg.rectTransform.anchoredPosition = var_0_12(426, 374)
			self._control.btn_list_layer2.bg.rectTransform.anchoredPosition = var_0_12(650, 320)
		else
			self._control.btn_list_layer2.bg.rectTransform.anchoredPosition = var_0_12(490, 290)
			self._control.bg.image.sprite = self:loadSprite(var_0_4.captainroom_style.room2)

			self._control.role_1:SetActive(false)
			self._control.role_2:SetActive(true)
			self._control.type1:SetActive(false)
			self._control.type2:SetActive(true)

			self._now_style_index = 2
		end
	end

	function arg_1_0:init_ske(arg_7_1, arg_7_2, arg_7_3)
		arg_7_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_4:get_ship_spine(var_0_4.common_icon.common_ship_q_asset, arg_7_2))
		arg_7_1.skeletonGraphic.material = self:loadMaterial(var_0_4:get_ship_spine(var_0_4.common_icon.common_ship_q_mat, arg_7_2))
		arg_7_1.skeletonGraphic.initialSkinName = arg_7_3

		arg_7_1.skeletonGraphic:Initialize(true)
	end

	function arg_1_0:init_ske2(arg_8_1, arg_8_2, arg_8_3)
		arg_8_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_9(var_0_4.captainroom_style.captain_asset_url, arg_8_2))
		arg_8_1.skeletonGraphic.material = self:loadMaterial(var_0_9(var_0_4.captainroom_style.captain_material_url, arg_8_2))
		arg_8_1.skeletonGraphic.initialSkinName = arg_8_3

		arg_8_1.skeletonGraphic:Initialize(true)
	end

	function arg_1_0:set_ship_girl()
		local var_9_0
		local var_9_1

		if self._enter_type == var_0_4.enter_captainroom_type.friend then
			var_9_0 = var_0_7.find_object_by_cid(self._friend_data.secretary).pic_id
			var_9_1 = self._friend_data.skin
		elseif self._enter_type == var_0_4.enter_captainroom_type.cardbook or self._enter_type == var_0_4.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_4.enter_captainroom_type.tower then
			var_9_0 = var_0_7.find_object_by_cid(self._friend_data.secretary).pic_id
			var_9_1 = self._friend_data.skin
		else
			local var_9_2 = var_0_3:find_character_by_id(self._user_data.secretary)

			var_9_0 = var_0_7.find_object_by_cid(var_9_2.cid).pic_id
			var_9_1 = var_9_2.skin
		end

		self:init_ske(var_0_20[self._now_style_index], (var_9_1 ~= 0 or nil) and var_0_8.find_object_by_cid(var_9_1).icon, var_0_21.normal)
		self:play_ske_anim(var_0_20[self._now_style_index], var_0_18.stand, true)
	end

	function arg_1_0:role_talk(arg_10_1, arg_10_2)
		local var_10_0 = 0

		var_10_0 = (self._enter_type == var_0_4.enter_captainroom_type.friend or self._enter_type == var_0_4.enter_captainroom_type.tower and self._friend_data._is_friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook and self._friend_data._is_friend) and self._friend_data.head or (self._enter_type == var_0_4.enter_captainroom_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook_and_no_friend) and self._friend_data.chat_head or self._user_data.chat_head

		if not var_10_0 or var_10_0 == 0 then
			return
		end

		if arg_10_1.talk.canvasGroup.alpha == 0 then
			self._talk_seq_list = self._talk_seq_list or {}

			local var_10_1 = var_0_13.role_talk(arg_10_1.talk, arg_10_2, 640, nil, true)

			self:autoKillDOTween(var_10_1)

			local var_10_2 = self:autoKillDOTween(var_0_2.Sequence())

			var_10_2:AppendInterval(20 + #arg_10_2 * 3)
			var_10_2:AppendCallback(function()
				if not self._control.model_layer.talk:Equals(nil) then
					self._control.model_layer.talk:SetActive(false)
					self._control.model_layer2.talk:SetActive(false)
					self._control.model_layer:SetActive(false)
				end
			end)
			table.insert(self._talk_seq_list, var_10_1)
		end
	end

	function arg_1_0:__clear_talk_seq()
		if self._talk_seq_list then
			for iter_12_0, iter_12_1 in pairs(self._talk_seq_list) do
				iter_12_1:Kill()
			end
		end

		self._talk_seq_list = {}
	end

	function arg_1_0:show_btn_list_layer(arg_13_1)
		local var_13_0
		local var_13_1

		self._can_close_btns = false

		if self._enter_type == var_0_4.enter_captainroom_type.myself then
			var_13_0 = self._control.btn_list_layer
			var_13_1 = var_0_14
		elseif self._enter_type == var_0_4.enter_captainroom_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_4.enter_captainroom_type.tower and not self._friend_data._is_friend then
			return
		else
			var_13_0 = self._control.btn_list_layer2
			var_13_1 = var_0_15
		end

		self:reset_btn(var_13_1)
		var_13_0:SetActive(arg_13_1)

		if arg_13_1 then
			self:btn_anim(var_13_1)
		end
	end

	function arg_1_0.reset_btn(arg_14_0, arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			iter_14_1.transform:GetComponent("CanvasGroup").alpha = 0
		end

		for iter_14_2, iter_14_3 in ipairs(arg_14_1) do
			if var_0_16[iter_14_2] then
				var_0_16[iter_14_2]:Kill()

				var_0_16[iter_14_2] = nil
			end
		end

		arg_14_0._start_update = false
		arg_14_0._start_time = nil
	end

	function arg_1_0:btn_anim(arg_15_1)
		for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
			local var_15_0 = iter_15_1.transform:GetComponent("CanvasGroup")
			local var_15_1 = self:autoKillDOTween(var_0_2.Sequence())

			var_15_1:Append(var_15_0:DOFade(1, 0))
			var_15_1:Append(iter_15_1.transform:DOAnchorPosY(110, 0.1))
			var_15_1:Append(iter_15_1.transform:DOAnchorPosY(90, 0.1))
			var_15_1:Pause()

			var_0_16[iter_15_0] = var_15_1
		end

		local var_15_2 = self:autoKillDOTween(var_0_2.Sequence())

		for iter_15_2, iter_15_3 in ipairs(var_0_16) do
			var_15_2:AppendCallback(function()
				iter_15_3:Play()
			end)
			var_15_2:AppendInterval(0.07)
		end

		var_15_2:AppendCallback(function()
			self._can_close_btns = true
		end)
		var_15_2:Play()

		if self._enter_type == var_0_4.enter_captainroom_type.myself then
			self._start_update = true
		end
	end

	function arg_1_0:__update_btn_bg(arg_18_1)
		self._start_time = self._start_time or 0
		self._start_time = self._start_time + 30
		self._control.btn_list_layer.bg.rectTransform.sizeDelta = var_0_12(150 + self._start_time, self._control.btn_list_layer.bg.rectTransform.sizeDelta.y)

		if 150 + self._start_time >= 848 then
			self._control.btn_list_layer.bg.rectTransform.sizeDelta = var_0_12(848, self._control.btn_list_layer.bg.rectTransform.sizeDelta.y)
			self._start_update = false
			self._start_time = nil
		end
	end

	function arg_1_0.__check_illegal_string(arg_19_0, arg_19_1)
		local var_19_0 = true

		for iter_19_0, iter_19_1 in pairs((var_0_11.get_sequence())) do
			if iter_19_1.word ~= "" and string.find(arg_19_1, iter_19_1.word, 1, true) ~= nil then
				var_19_0 = false

				local var_19_1 = var_0_3:get_account_id()

				var_0_3:req_SensitiveWordsReq({
					type = var_0_4.sensitive_words_type.user_sign,
					sensitive_words = arg_19_1
				})

				break
			end
		end

		return var_19_0
	end

	function arg_1_0.__filter_spec_chars(arg_20_0, arg_20_1)
		local var_20_0 = false
		local var_20_1 = 1

		while true do
			if var_20_1 > #arg_20_1 then
				break
			end

			local var_20_2 = string.byte(arg_20_1, var_20_1)

			if not var_20_2 then
				break
			end

			if var_20_2 < 192 then
				if var_20_2 >= 48 and var_20_2 <= 57 or var_20_2 >= 65 and var_20_2 <= 90 or var_20_2 >= 97 and var_20_2 <= 122 then
					-- block empty
				else
					var_20_0 = true

					local var_20_3 = false
				end

				var_20_1 = var_20_1 + 1
			elseif var_20_2 < 224 then
				var_20_0 = true
				var_20_3 = false
				var_20_1 = var_20_1 + 2
			elseif var_20_2 < 240 then
				if var_20_2 >= 228 and var_20_2 <= 233 then
					local var_20_4 = string.byte(arg_20_1, var_20_1 + 1)
					local var_20_5 = string.byte(arg_20_1, var_20_1 + 2)

					if var_20_4 and var_20_5 then
						local var_20_6 = 128
						local var_20_7 = 191
						local var_20_8 = 191

						if var_20_2 == 228 then
							var_20_6 = 184
						elseif var_20_2 == 233 then
							var_20_7, var_20_8 = 190, var_20_4 ~= 190 and 191 or 165
						end

						if var_20_6 <= var_20_4 and var_20_4 <= var_20_7 and 128 <= var_20_5 and var_20_5 <= var_20_8 then
							-- block empty
						else
							var_20_0 = true
							var_20_3 = false
						end
					end
				end

				var_20_1 = var_20_1 + 3
			elseif var_20_2 < 248 then
				var_20_0 = true
				var_20_3 = false
				var_20_1 = var_20_1 + 4
			elseif var_20_2 < 252 then
				var_20_0 = true
				var_20_3 = false
				var_20_1 = var_20_1 + 5
			elseif var_20_2 < 254 then
				var_20_0 = true
				var_20_3 = false
				var_20_1 = var_20_1 + 6
			end
		end

		return var_20_0
	end

	function arg_1_0:word_is_conform(arg_21_1)
		if not self:__filter_spec_chars(arg_21_1) then
			return true
		else
			return false
		end
	end

	function arg_1_0:editor_end_event()
		local var_22_0 = self._control.editor_layer.input.inputField

		self._user_data = var_0_3:get_use_info_data()
		self._control.editor_layer.input.inputField.text = self._user_data.signature

		local var_22_1 = self._control.editor_layer.input.inputField.text

		if not self:__check_illegal_string(self._control.editor_layer.input.inputField.text) then
			var_22_1 = ""

			var_0_3:req_ChangeSignatureReq("")
			self._control.editor_layer:SetActive(true)

			return
		end

		self._control.editor_layer.input.inputField.onEndEdit:RemoveAllListeners()
		self._control.editor_layer.input.inputField.onEndEdit:AddListener(function()
			local var_23_0, var_23_1 = var_0_13.calculate_utf8_char_length(var_22_0.text)

			if var_23_0 > 30 then
				var_22_0.text = var_22_1

				var_0_5:show(var_0_10:getNowLang("signatures_must_not_exceed_30_bytes"))
			else
				if var_22_1 == var_22_0.text then
					return
				end

				if not self:__filter_spec_chars(var_22_0.text) and self:__check_illegal_string(var_22_0.text) then
					var_0_3:req_ChangeSignatureReq(var_22_0.text)
				else
					var_0_5:show((var_0_10:getNowLang("errorcode-129")))
				end
			end
		end)
		self._control.editor_layer:SetActive(true)
	end

	function arg_1_0:set_head_by_icon(arg_24_1, arg_24_2)
		self._control.type1.head:SetActive(arg_24_1)
		self._control.type2.head:SetActive(arg_24_1)

		if not arg_24_1 then
			return
		end

		var_0_19[self._now_style_index].head.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.captainroom_icon, arg_24_2))

		var_0_19[self._now_style_index].head.image:SetNativeSize()
	end

	function arg_1_0:set_captain_spine(arg_25_1, arg_25_2)
		self._control.type1.captain:SetActive(arg_25_1)
		self._control.type2.captain:SetActive(arg_25_1)

		if not arg_25_1 then
			return
		end

		for iter_25_0, iter_25_1 in ipairs(var_0_17) do
			if iter_25_1 == arg_25_2 and iter_25_1 ~= 36 then
				self:init_ske2(var_0_19[self._now_style_index].captain, var_0_4.captainroom_style.captain_spine_list[iter_25_0], var_0_21.normal)
			elseif iter_25_1 == arg_25_2 and iter_25_1 == 36 then
				self:init_ske2(var_0_19[self._now_style_index].captain, var_0_4.captainroom_style.captain_spine_list[iter_25_0], var_0_21.default)
			end
		end

		if arg_25_2 == 36 then
			self:play_ske_anim(var_0_19[self._now_style_index].captain, var_0_18.normal, true)
		else
			self:play_ske_anim(var_0_19[self._now_style_index].captain, var_0_18.stand, true)
		end
	end

	function arg_1_0:set_chat_head()
		self._user_data = var_0_3:get_use_info_data()

		local var_26_1 = var_0_6.find_object_by_cid((self._enter_type == var_0_4.enter_captainroom_type.friend or self._enter_type == var_0_4.enter_captainroom_type.tower and self._friend_data._is_friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook and self._friend_data._is_friend) and self._friend_data.head or (self._enter_type == var_0_4.enter_captainroom_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_4.enter_captainroom_type.tower and not self._friend_data._is_friend) and self._friend_data.chat_head or self._user_data.chat_head)

		if var_26_1.is_animation == 0 then
			self:set_head_by_icon(true, var_26_1.icon)
			self:set_captain_spine(false, nil)
		elseif var_26_1.is_animation == 1 then
			self:set_head_by_icon(false, nil)
			self:set_captain_spine(true, var_26_1.icon)
		else
			self:set_head_by_icon(true, var_26_1.icon)
			self:set_captain_spine(true, var_26_1.icon)
		end
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
		end

		self._user_data = var_0_3:get_use_info_data()

		self:show_btn_list_layer(false)
		self:set_captainroom_style()
		self:set_ship_girl()
		self:set_chat_head()
		self._control.model_layer:SetActive(true)
		self._control.model_layer.talk:SetActive(true)
		self._control.model_layer2.talk:SetActive(true)

		if not self._is_already_init and self._enter_type == var_0_4.enter_captainroom_type.myself then
			local var_27_0 = var_0_3:find_character_by_id(self._user_data.secretary)
			local var_27_1 = var_0_7.find_object_by_cid(var_27_0.cid).my_room_dialogue

			if var_27_0.skin ~= 0 then
				var_27_1 = var_0_8.find_object_by_cid(var_27_0.skin).my_room_dialogue

				if var_27_1 == "0" or var_27_1 == "" then
					var_27_1 = var_27_1
				end
			end

			if var_27_1 == "0" or var_27_1 == "" then
				return
			end

			self:role_talk(var_0_22[self._now_style_index], var_27_1)
		end

		if self._enter_type == var_0_4.enter_captainroom_type.friend then
			self._control.model_layer.talk:SetActive(false)
			self._control.model_layer2.talk:SetActive(false)
		else
			self._control.model_layer.talk:SetActive(true)
			self._control.model_layer2.talk:SetActive(true)
		end

		if self._enter_type == var_0_4.enter_captainroom_type.friend or self._enter_type == var_0_4.enter_captainroom_type.cardbook or self._enter_type == var_0_4.enter_captainroom_type.cardbook_and_no_friend or self._enter_type == var_0_4.enter_captainroom_type.tower then
			self._control.collect_btn:SetActive(true)
			self._control.home_btn:SetActive(false)
		end

		self._is_already_init = true
	end

	function arg_1_0:__init_panel_order()
		self._panel.transform:GetComponent("Canvas").sortingOrder = 500
	end

	function arg_1_0:__init_language()
		self._control.editor_layer.bg_top.node.title.text.text = var_0_10:getNowLang("editprofile")
		self._control.editor_layer.bg_content.tip_txt.text.text = var_0_10:getNowLang("nomorethan")
	end

	function arg_1_0:__init_constant()
		var_0_14 = {
			self._control.btn_list_layer.bg.supply_btn,
			self._control.btn_list_layer.bg.editor_btn,
			self._control.btn_list_layer.bg.head_btn,
			self._control.btn_list_layer.bg.garrison_btn,
			self._control.btn_list_layer.bg.style_btn,
			self._control.btn_list_layer.bg.music_btn
		}
		var_0_15 = {
			self._control.btn_list_layer2.bg.odds_btn
		}
		var_0_16 = {}
		var_0_17 = {
			7,
			18,
			30,
			31,
			36,
			38
		}
		var_0_18 = {
			normal = "normal",
			stand = "stand1"
		}
		var_0_19 = {
			self._control.type1,
			self._control.type2
		}
		var_0_21 = {
			default = "default",
			bathroom = "bathroom",
			normal = "normal"
		}
		var_0_20 = {
			self._control.role_1,
			self._control.role_2
		}
		var_0_22 = {
			self._control.model_layer,
			self._control.model_layer2
		}
	end

	function arg_1_0:_play_into_se(arg_31_1)
		self:playSE(arg_31_1, false)
	end

	function arg_1_0:__onReset()
		self._is_already_init = false
		self._now_style_index = 0
		self._user_data = {}
		self._start_update = false

		self._control.collect_btn:SetActive(false)
		self._control.home_btn:SetActive(true)
		self:__clear_talk_seq()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_33_0)
	local var_33_0 = var_0_1:class("captainroom")

	var_33_0._is_already_init = false
	var_33_0._enter_type = nil
	var_33_0._friend_data = nil
	var_33_0._now_style_index = 0
	var_33_0._user_data = {}
	var_33_0._start_update = false

	return var_33_0
end

return var_0_0
