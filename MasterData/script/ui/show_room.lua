local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = DG.Tweening.DOTween
local var_0_4 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_7 = gameconfig.medal_config
local var_0_8 = gameconfig.skin_config
local var_0_9 = gameconfig.chat_head_config
local var_0_10 = gameconfig.ship_config
local var_0_11 = string.format
local var_0_12 = table.insert
local var_0_13 = table.sort
local var_0_15 = gamecore.util_func
local var_0_16 = UnityEngine.Vector2

gamecore.UILoader:define("show_room", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:setVisible(true)

		self._enter_type = arg_2_2

		self:__init_panel(arg_2_1)

		if arg_2_3 then
			self:role_talk()
		end
	end

	function arg_1_0.sort_rule(arg_3_0, arg_3_1)
		var_0_13(arg_3_1, function(arg_4_0, arg_4_1)
			return arg_4_0.id < arg_4_1.id
		end)

		return arg_3_1
	end

	function arg_1_0.__onUpdate(arg_5_0)
		return
	end

	function arg_1_0:role_talk(arg_6_1)
		if not arg_6_1 then
			if self.from_friend == true then
				self:playCV(self:get_ship_voice_path(self._friend_data.secretary, self._friend_data.skin, true), false, "cv")
			else
				local var_6_0 = var_0_4:find_character_by_id(self._user_data.secretary)

				self:playCV(self:get_ship_voice_path(var_6_0.cid, var_6_0.skin), false, "cv")
			end
		end

		if self._control.collect.model_layer.talk.canvasGroup.alpha == 0 then
			if self._control.collect.model_layer.talk.label_txt.text.text ~= "" then
				self._control.collect.model_layer.talk.label_txt.text.text = ""
			end

			self._control.collect.model_layer.talk:SetActive(true)

			local var_6_1 = var_0_4:find_character_by_id(self._user_data.secretary)
			local var_6_2 = var_0_10.find_object_by_cid(var_6_1.cid)
			local var_6_3 = ""

			if self.from_friend == true then
				var_6_1 = self._friend_data
				var_6_2 = var_0_10.find_object_by_cid(self._friend_data.secretary)

				if self._friend_data.skin ~= 0 then
					var_6_3 = var_0_8.find_object_by_cid(var_6_1.skin).friend_room_dialogue

					if var_6_3 == "0" then
						var_6_3 = var_6_2.friend_room_dialogue
					end
				else
					var_6_3 = var_6_2.friend_room_dialogue
				end
			elseif var_6_1.skin ~= 0 then
				var_6_3 = var_0_8.find_object_by_cid(var_6_1.skin).my_room_dialogue

				if var_6_3 == "0" then
					var_6_3 = var_6_2.my_room_dialogue
				end
			else
				var_6_3 = var_6_2.my_room_dialogue
			end

			if var_6_3 == "" or var_6_3 == "0" then
				self._control.collect.model_layer.talk:SetActive(false)

				return
			end

			self._talk_dialog_box_seq = var_0_15.role_talk(self._control.collect.model_layer.talk, var_6_3, 700, nil, true)

			self:autoKillDOTween(self._talk_dialog_box_seq)
		end
	end

	function arg_1_0.play_ske_anim(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		arg_7_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_7_2, arg_7_3)
	end

	function arg_1_0:init_ske(arg_8_1, arg_8_2, arg_8_3)
		arg_8_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_5:get_ship_spine(var_0_5.common_icon.common_ship_q_asset, arg_8_2))
		arg_8_1.skeletonGraphic.material = self:loadMaterial(var_0_5:get_ship_spine(var_0_5.common_icon.common_ship_q_mat, arg_8_2))
		arg_8_1.skeletonGraphic.initialSkinName = arg_8_3

		arg_8_1.skeletonGraphic:Initialize(true)
	end

	function arg_1_0.get_ship_voice_path(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		if arg_9_2 and arg_9_2 ~= 0 then
			local var_9_2 = var_0_8.find_object_by_cid(arg_9_2).cv_id

			if var_9_2 and var_9_2 ~= 0 and var_9_2 ~= "0" then
				return var_0_11(var_9_0, var_9_2, var_9_2)
			end
		end

		local var_9_3 = var_0_10.find_object_by_cid(arg_9_1).pic_id

		return var_0_11(var_9_0, var_9_3, var_9_3)
	end

	function arg_1_0:set_ship_girl()
		local var_10_0
		local var_10_1

		if self.from_friend == true then
			var_10_0 = var_0_10.find_object_by_cid(self._friend_data.secretary).pic_id
			var_10_1 = self._friend_data.skin
		else
			local var_10_2 = var_0_4:find_character_by_id(self._user_data.secretary)

			var_10_0 = var_0_10.find_object_by_cid(var_10_2.cid).pic_id
			var_10_1 = var_10_2.skin
		end

		self:init_ske(self._control.collect.role_1, (var_10_1 ~= 0 or nil) and var_0_8.find_object_by_cid(var_10_1).icon, "normal")
		self:play_ske_anim(self._control.collect.role_1, "stand1", true)
	end

	function arg_1_0:show_btn_list_layer(arg_11_1)
		self:reset_btn()

		self._can_close_btns = false

		self._control.collect.freind_btn_list_layer:SetActive(false)
		self._control.collect.btn_list_layer:SetActive(false)

		self._control.collect.role_btn.button.interactable = not arg_11_1

		if self.from_friend == true then
			self._control.collect.freind_btn_list_layer:SetActive(arg_11_1)
		else
			self._control.collect.btn_list_layer:SetActive(arg_11_1)
		end

		if arg_11_1 then
			self:btn_anim()
		end
	end

	function arg_1_0:reset_btn()
		for iter_12_0, iter_12_1 in ipairs(self.btn_list) do
			iter_12_1.transform:GetComponent("CanvasGroup").alpha = 0
		end

		for iter_12_2, iter_12_3 in ipairs(self.btn_list) do
			if btn_anim_seq_list[iter_12_2] then
				btn_anim_seq_list[iter_12_2]:Kill()

				btn_anim_seq_list[iter_12_2] = nil
			end
		end
	end

	function arg_1_0:friend_medal_anim()
		local var_13_0 = self:autoKillDOTween(var_0_2.Sequence())

		if self.big_medal == false then
			self._control.collect.medal.transform:SetSiblingIndex(self._control.collect.transform.childCount - 1)

			for iter_13_0 = 1, #self.show_medal_list do
				self.show_medal_list[iter_13_0]:GetComponent("Image").raycastTarget = true

				self.show_medal_list[iter_13_0].button.onClick:RemoveAllListeners()
				self.show_medal_list[iter_13_0].button.onClick:AddListener(function()
					local var_14_0 = var_0_1:createInstance("medal_info")

					var_14_0:show(self.now_show_medal_list[iter_13_0].id, self.now_show_medal_list[iter_13_0].level, 0, true)
					var_14_0._control.bg_container.progress:SetActive(false)
					var_14_0._control.cover:SetActive(true)
				end)
			end

			var_13_0:Append(self._control.collect.medal.transform:DOScale(2, 0.8):SetEase(DG.Tweening.Ease.Linear))
			self._control.collect.cover:SetActive(true)

			self.big_medal = true

			return
		else
			self._control.collect.medal.transform:SetSiblingIndex(3)

			for iter_13_1 = 1, #self.show_medal_list do
				self.show_medal_list[iter_13_1]:GetComponent("Image").raycastTarget = false

				self.show_medal_list[iter_13_1].button.onClick:RemoveAllListeners()
			end

			var_13_0:Append(self._control.collect.medal.transform:DOScale(1, 0.8):SetEase(DG.Tweening.Ease.Linear))
			self._control.collect.cover:SetActive(false)

			self.big_medal = false

			return
		end
	end

	function arg_1_0:btn_anim()
		for iter_15_0, iter_15_1 in ipairs(self.btn_list) do
			local var_15_0 = iter_15_1.transform:GetComponent("CanvasGroup")
			local var_15_1 = self:autoKillDOTween(var_0_2.Sequence())

			var_15_1:Append(var_15_0:DOFade(1, 0))
			var_15_1:Append(iter_15_1.transform:DOLocalMoveY(0, 0.1))
			var_15_1:Append(iter_15_1.transform:DOLocalMoveY(-30, 0.1))
			var_15_1:Pause()

			btn_anim_seq_list[iter_15_0] = var_15_1
		end

		local var_15_2 = self:autoKillDOTween(var_0_2.Sequence())

		for iter_15_2, iter_15_3 in ipairs(btn_anim_seq_list) do
			var_15_2:AppendCallback(function()
				iter_15_3:Play()
			end)
			var_15_2:AppendInterval(0.07)
		end

		var_15_2:AppendCallback(function()
			self._can_close_btns = true
		end)
		var_15_2:Play()
	end

	function arg_1_0:__init_constant()
		self.btn_list = {
			self._control.collect.btn_list_layer.medal_btn,
			self._control.collect.btn_list_layer.collection_btn,
			self._control.collect.btn_list_layer.changestyle_btn
		}

		if self.from_friend == true then
			self.btn_list = {
				self._control.collect.freind_btn_list_layer.friend_drill_btn
			}
		end

		btn_anim_seq_list = {}
		self.show_room_collection_list = {
			self._control.collect.desktop_l.collect_wall_icon_1,
			self._control.collect.desktop.collect_wall_icon_2,
			self._control.collect.desktop_r.collect_wall_icon_3,
			self._control.collect.showcase_l.collect_wall_icon_1,
			self._control.collect.showcase_l.collect_wall_icon_2,
			self._control.collect.showcase_l.collect_wall_icon_3,
			self._control.collect.showcase_l.collect_wall_icon_4,
			self._control.collect.showcase_l.collect_wall_icon_5,
			self._control.collect.showcase_l.collect_wall_icon_6,
			self._control.collect.showcase_r.collect_wall_icon_1,
			self._control.collect.showcase_r.collect_wall_icon_2,
			self._control.collect.showcase_r.collect_wall_icon_3,
			self._control.collect.showcase_r.collect_wall_icon_4,
			self._control.collect.showcase_r.collect_wall_icon_5,
			self._control.collect.showcase_r.collect_wall_icon_6
		}
		self.show_medal_list = {
			self._control.collect.medal.medal_icon_1,
			self._control.collect.medal.medal_icon_2,
			self._control.collect.medal.medal_icon_3,
			self._control.collect.medal.medal_icon_4,
			self._control.collect.medal.medal_icon_5
		}
		self.show_room_style_url = {
			self._control.bg,
			self._control.photoframe,
			self._control.collect.desktop,
			self._control.collect.desktop_l,
			self._control.collect.desktop_r,
			self._control.collect.medal,
			self._control.collect.showcase_l,
			self._control.collect.showcase_r
		}
	end

	function arg_1_0:get_user_use_collection_data()
		self.user_use_desk_collection_list = {}
		self.user_use_wall_collection_list = {}
		self.now_show_medal_list = {}
		self.now_use_medal_list = {}
		self.is_have_medal_list = {}
		self.medal_config_list, medal_num = var_0_7:get_sequence()
		self.user_use_desk_collection_list = var_0_4:get_player_desk_collection_data()
		self.user_use_wall_collection_list = var_0_4:get_player_wall_collection_data()
		self.now_use_medal_list = var_0_4:get_player_show_medal_data()
		self.user_medal_list = var_0_4:get_player_medal_data()

		if self.from_friend == true then
			self.user_use_desk_collection_list = self._friend_data.boxroom.desk
			self.user_use_wall_collection_list = self._friend_data.boxroom.wall
			self.now_show_medal_list = self._friend_data.boxroom.medal
		end

		for iter_19_0 = 1, #self.medal_config_list + 10 do
			local var_19_0 = var_0_4:get_all_medal_by_id(iter_19_0)

			if var_19_0[1] then
				var_0_12(self.is_have_medal_list, var_19_0[#var_19_0])
			end
		end

		self:sort_rule(self.is_have_medal_list)

		for iter_19_1 = 1, #self.show_room_collection_list do
			self.show_room_collection_list[iter_19_1]:SetActive(false)
		end

		for iter_19_2 = 1, #self.user_use_desk_collection_list do
			if self.user_use_desk_collection_list[iter_19_2].id ~= 0 and self.user_use_desk_collection_list[iter_19_2].index ~= 0 then
				self.show_room_collection_list[self.user_use_desk_collection_list[iter_19_2].index].image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.collection_use_icon[1], self.user_use_desk_collection_list[iter_19_2].id))

				self.show_room_collection_list[self.user_use_desk_collection_list[iter_19_2].index]:GetComponent("Image"):SetNativeSize()
				self.show_room_collection_list[self.user_use_desk_collection_list[iter_19_2].index]:SetActive(true)
			end
		end

		for iter_19_3 = 1, #self.user_use_wall_collection_list do
			if self.user_use_wall_collection_list[iter_19_3].id ~= 0 and self.user_use_wall_collection_list[iter_19_3].index + 3 ~= 0 then
				self.show_room_collection_list[self.user_use_wall_collection_list[iter_19_3].index + 3].image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.collection_use_icon[1], self.user_use_wall_collection_list[iter_19_3].id))
				self.show_room_collection_list[self.user_use_wall_collection_list[iter_19_3].index + 3].rectTransform.sizeDelta = var_0_16(89.31, 89.31)

				self.show_room_collection_list[self.user_use_wall_collection_list[iter_19_3].index + 3]:SetActive(true)
			end
		end

		if self.from_friend == false then
			self.now_show_medal_list = {}

			local var_19_1 = var_0_4:get_player_show_medal_data()

			if next(var_19_1) then
				for iter_19_4 = 1, #var_19_1 do
					for iter_19_5 = 1, #self.is_have_medal_list do
						if var_19_1[iter_19_4] == self.is_have_medal_list[iter_19_5].id then
							var_0_12(self.now_show_medal_list, self.is_have_medal_list[iter_19_5])
						end
					end
				end
			end
		end

		for iter_19_6 = 1, #self.show_medal_list do
			if self.now_show_medal_list[iter_19_6] then
				self.show_medal_list[iter_19_6]:SetActive(true)

				if self.now_show_medal_list[iter_19_6].id ~= 0 and self.now_show_medal_list[iter_19_6].level ~= 0 then
					self.show_medal_list[iter_19_6].image.sprite = self:loadSprite(var_0_11(var_0_5.medal_icon[1], self.now_show_medal_list[iter_19_6].id, self.now_show_medal_list[iter_19_6].level))
				end

				if self.now_show_medal_list[iter_19_6].id == 0 then
					self.show_medal_list[iter_19_6]:SetActive(false)
				end
			else
				self.show_medal_list[iter_19_6]:SetActive(false)
			end
		end
	end

	function arg_1_0:set_user_style_data(arg_20_1)
		self.show_room_style = arg_20_1

		for iter_20_0 = 1, #self.show_room_style_url do
			self.show_room_style_url[iter_20_0].image.sprite = self:loadSprite(var_0_5.show_room_style[arg_20_1][iter_20_0])
		end

		if self.from_friend == true then
			for iter_20_1 = 1, #self.show_room_style_url do
				self.show_room_style_url[iter_20_1].image.sprite = self:loadSprite(var_0_5.show_room_style[self._friend_data.boxroom.style][iter_20_1])
			end
		end
	end

	function arg_1_0:set_friend_modo_show_room()
		self._control.collect.home_btn:SetActive(false)
		self._control.to_captain_btn:SetActive(true)
		self._control.to_restaurant_btn:SetActive(true)
		self:play_bgm()
	end

	function arg_1_0:play_bgm()
		self:playBackgroundMusic((var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.living_bgm)))
	end

	function arg_1_0:__init_panel(arg_23_1)
		if type(arg_23_1) == "table" then
			for iter_23_0, iter_23_1 in pairs((var_0_4:get_friend_list())) do
				if arg_23_1.account_id == iter_23_0 then
					self._myFriend_data = arg_23_1
					self._is_friend = true

					break
				end
			end
		end

		self.from_friend_id = arg_23_1
		self.from_friend = false

		self._control.collect.home_btn:SetActive(true)
		self._control.to_captain_btn:SetActive(false)
		self._control.to_restaurant_btn:SetActive(false)

		if arg_23_1 then
			self.from_friend = true

			if self._enter_type == var_0_5.show_room_enter_type.cardbook and not arg_23_1._is_friend or self._enter_type == var_0_5.show_room_enter_type.cardbook_and_no_friend or self._enter_type == var_0_5.show_room_enter_type.tower and not arg_23_1._is_friend then
				self._friend_data = arg_23_1
			elseif self._enter_type == var_0_5.show_room_enter_type.tower and arg_23_1._is_friend or self._enter_type == var_0_5.show_room_enter_type.cardbook and arg_23_1._is_friend then
				self._friend_data = var_0_4:get_friend_info(arg_23_1.account_id)

				var_0_4:set_friend_id(arg_23_1.account_id)

				self._friend_data._is_friend = true
			else
				self._friend_data = var_0_4:get_friend_info(arg_23_1)

				var_0_4:set_friend_id(arg_23_1)
			end

			self:set_friend_modo_show_room()
		end

		self._user_data = var_0_4:get_use_info_data()

		local var_23_1 = self._user_data.boxroom_style

		self._control.photoframe.user_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.captainroom_head, var_0_9.find_object_by_cid(arg_23_1 and (self._friend_data.head or self._friend_data.chat_head) or self._user_data.chat_head).icon))

		self:__init_constant()
		self:__init_buttons_events()
		self:show_btn_list_layer(false)
		self:set_ship_girl()
		self:set_user_style_data(var_23_1)
		self:get_user_use_collection_data()
	end

	function arg_1_0:__init_buttons_events()
		local var_24_0 = self._control.collect.btn_list_layer

		self._control.collect.btn_list_layer.maskButton.onPointerUp:RemoveAllListeners()
		self._control.collect.btn_list_layer.maskButton.onPointerUp:AddListener(function()
			self:show_btn_list_layer(false)
		end)
		self._control.collect.btn_list_layer.changestyle_btn.maskButton.onPointerUp:RemoveAllListeners()
		self._control.collect.btn_list_layer.changestyle_btn.maskButton.onPointerUp:AddListener(function()
			if var_24_0.changestyle_btn.maskButton.is_exit then
				self:show_btn_list_layer(false)

				return
			end

			if self.from_friend == true then
				return
			end

			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
			self:show_btn_list_layer(false)
			var_0_1:createInstance("show_room_change_style"):show(self.show_room_style)
		end)
		self._control.collect.btn_list_layer.collection_btn.maskButton.onPointerUp:RemoveAllListeners()
		self._control.collect.btn_list_layer.collection_btn.maskButton.onPointerUp:AddListener(function()
			if var_24_0.collection_btn.maskButton.is_exit then
				self:show_btn_list_layer(false)

				return
			end

			self:instance_layer("show_room_collection", false, 2)
		end)
		self._control.collect.btn_list_layer.medal_btn.maskButton.onPointerUp:RemoveAllListeners()
		self._control.collect.btn_list_layer.medal_btn.maskButton.onPointerUp:AddListener(function()
			if var_24_0.medal_btn.maskButton.is_exit then
				self:show_btn_list_layer(false)

				return
			end

			self:instance_layer("show_room_medal", false)
		end)

		local var_24_1 = self._control.collect.freind_btn_list_layer

		self._control.collect.freind_btn_list_layer.maskButton.onPointerUp:RemoveAllListeners()
		self._control.collect.freind_btn_list_layer.maskButton.onPointerUp:AddListener(function()
			self:show_btn_list_layer(false)
		end)
		self._control.collect.freind_btn_list_layer.friend_drill_btn.maskButton.onPointerUp:RemoveAllListeners()
		self._control.collect.freind_btn_list_layer.friend_drill_btn.maskButton.onPointerUp:AddListener(function()
			if var_24_1.friend_drill_btn.maskButton.is_exit then
				self:show_btn_list_layer(false)

				return
			end

			local var_30_0

			if self._enter_type == var_0_5.show_room_enter_type.tower then
				var_30_0 = var_0_5.fight_type.tower_rank_list
			end

			var_30_0 = var_30_0 or var_0_5.fight_type.show_room_friend

			var_0_1:createInstance("captainroom_friend_fleet"):show(self._friend_data, var_30_0)
		end)
	end

	function arg_1_0:reset_talk_dialog_box()
		if self._talk_dialog_box_seq then
			self._talk_dialog_box_seq:Kill()

			self._talk_dialog_box_seq = nil
			self._control.collect.model_layer.talk.canvasGroup.alpha = 0
		end
	end

	function arg_1_0:_play_into_se(arg_32_1)
		self:playSE(arg_32_1, false)
	end

	function arg_1_0:__onReset()
		self._is_already_init = false
		self._is_friend = nil
		self.big_medal = nil
		self.show_room_style = nil
		self._can_close_btns = false
		self.now_show_medal_list = nil

		self:reset_btn()
		self:reset_talk_dialog_box()
	end

	function arg_1_0.__onDestroy(arg_34_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_35_0)
	local var_35_0 = var_0_1:class("show_room")

	var_35_0._is_already_init = false
	var_35_0.btn_list = {}
	var_35_0.btn_anim_seq_list = {}
	var_35_0.show_room_collection_list = {}
	var_35_0.user_use_desk_collection_list = {}
	var_35_0.user_use_wall_collection_list = {}
	var_35_0.user_medal_list = {}
	var_35_0.now_use_medal_list = {}
	var_35_0.now_show_medal_list = {}
	var_35_0.from_friend = false
	var_35_0.big_medal = false
	var_35_0.from_friend = false
	var_35_0.from_friend_id = nil
	var_35_0.show_room_style = nil
	var_35_0._enter_type = nil
	var_35_0._can_close_btns = false
	var_35_0._is_friend = false
	var_35_0._myFriend_data = nil

	return var_35_0
end

return var_0_0
