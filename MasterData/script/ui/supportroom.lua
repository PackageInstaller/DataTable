local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = string.format
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.skin_config
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12

gamecore.UILoader:define("supportroom", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
	end

	function arg_1_0:__onVisible(arg_3_1)
		if not arg_3_1 then
			return
		end

		self:__init_panel()

		self._already_init = true
	end

	function arg_1_0:init_ske(arg_4_1, arg_4_2, arg_4_3)
		arg_4_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(arg_4_2)
		arg_4_1.skeletonGraphic.initialSkinName = arg_4_3

		arg_4_1.skeletonGraphic:Initialize(true)
	end

	function arg_1_0:init_mat(arg_5_1, arg_5_2)
		arg_5_1.skeletonGraphic.material = self:loadMaterial(arg_5_2)
		arg_5_1.skeletonGraphic.material.shader = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
	end

	function arg_1_0:show_btn_list_layer(arg_6_1)
		self:reset_btn()
		self._control.menu:SetActive(arg_6_1)

		if arg_6_1 then
			self:btn_anim()
		end
	end

	function arg_1_0.reset_btn(arg_7_0)
		for iter_7_0, iter_7_1 in ipairs(var_0_11) do
			iter_7_1.transform:GetComponent("CanvasGroup").alpha = 0
		end

		for iter_7_2, iter_7_3 in ipairs(var_0_11) do
			if var_0_12[iter_7_2] then
				var_0_12[iter_7_2]:Kill()

				var_0_12[iter_7_2] = nil
			end
		end
	end

	function arg_1_0:btn_anim()
		for iter_8_0, iter_8_1 in ipairs(var_0_11) do
			local var_8_0 = iter_8_1.transform:GetComponent("CanvasGroup")
			local var_8_1 = self:autoKillDOTween(var_0_5.Sequence())

			var_8_1:Append(var_8_0:DOFade(1, 0))
			var_8_1:Append(iter_8_1.transform:DOLocalMoveY(60, 0.1))
			var_8_1:Append(iter_8_1.transform:DOLocalMoveY(30.5, 0.1))
			var_8_1:Pause()

			var_0_12[iter_8_0] = var_8_1
		end

		local var_8_2 = self:autoKillDOTween(var_0_5.Sequence())

		for iter_8_2, iter_8_3 in ipairs(var_0_12) do
			var_8_2:AppendCallback(function()
				iter_8_3:Play()
			end)
			var_8_2:AppendInterval(0.07)
		end

		var_8_2:Play()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_constant()
		end

		self:set_ship_girl()
		self:role_talk()
		self:show_btn_list_layer(false)
		self:change_table_style()
	end

	function arg_1_0:__is_already_init()
		return self._already_init
	end

	function arg_1_0:set_ship_girl()
		self._user_data = var_0_2:get_use_info_data()
		self._character_data = var_0_2:find_character_by_id(self._user_data.secretary)
		self._ship_data = var_0_6.find_object_by_cid(self._character_data.cid)

		if self._character_data.skin ~= 0 then
			local var_12_0 = var_0_7.find_object_by_cid(self._character_data.skin)

			self:init_ske(var_0_9, var_0_4:get_ship_spine(var_0_4.common_icon.common_ship_q_asset, var_12_0.skin_id), var_0_10.normal)
			self:init_mat(var_0_9, var_0_4:get_ship_spine(var_0_4.common_icon.common_ship_q_mat, var_12_0.skin_id))
		else
			self:init_ske(var_0_9, var_0_4:get_ship_spine(var_0_4.common_icon.common_ship_q_asset, self._ship_data.pic_id), var_0_10.normal)
			self:init_mat(var_0_9, var_0_4:get_ship_spine(var_0_4.common_icon.common_ship_q_mat, self._ship_data.pic_id))
		end

		self:__ship_gir_cv()
	end

	function arg_1_0:__ship_gir_cv()
		self._character_data = var_0_2:find_character_by_id(self._user_data.secretary)
		self._ship_data = var_0_6.find_object_by_cid(self._character_data.cid)

		local var_13_1 = ""

		if self._character_data.skin == 0 then
			var_13_1 = var_0_3("%s/%s_my_room.mp3", self._ship_data.pic_id, self._ship_data.pic_id)
		else
			local var_13_3 = var_0_7.find_object_by_cid(self._character_data.skin)

			var_13_1 = var_13_3.cv_id ~= "0" and var_13_3.my_room_dialogue ~= "0" and var_0_3("%s/%s_my_room.mp3", var_13_3.cv_id, var_13_3.cv_id) or var_13_3.cv_id ~= "0" and var_13_3.my_room_dialogue == "0" and var_0_3("%s/%s_my_room.mp3", self._ship_data.pic_id, self._ship_data.pic_id) or var_13_3.cv_id == "0" and var_13_3.my_room_dialogue == "0" and var_0_3("%s/%s_my_room.mp3", self._ship_data.pic_id, self._ship_data.pic_id) or nil
		end

		self:playCV(var_13_1, false, "cv")
	end

	function arg_1_0:role_talk()
		self._character_data = var_0_2:find_character_by_id(self._user_data.secretary)
		self._ship_data = var_0_6.find_object_by_cid(self._character_data.cid)

		local var_14_0 = "" or nil

		if self._character_data.skin == 0 then
			var_14_0 = self._ship_data.my_room_dialogue
		else
			local var_14_1 = var_0_7.find_object_by_cid(self._character_data.skin)

			var_14_0 = var_14_1.cv_id ~= "0" and var_14_1.my_room_dialogue ~= "0" and var_14_1.my_room_dialogue or var_14_1.cv_id ~= "0" and var_14_1.my_room_dialogue == "0" and self._ship_data.my_room_dialogue or var_14_1.cv_id == "0" and var_14_1.my_room_dialogue == "0" and self._ship_data.my_room_dialogue or var_14_1.my_room_dialogue
		end

		if #var_14_0 > 1 then
			self._control.model_layer.talk.gameObject:SetActive(true)

			self._control.model_layer.talk.canvasGroup.alpha = 1
		else
			return
		end

		local var_14_2 = self._control.model_layer
		local var_14_3 = self._control.model_layer.talk.label_txt.rectTransform.sizeDelta

		self._control.model_layer.talk.popVerticalAdaptive:SetText(var_14_0)

		var_14_2.talk.label_txt.text.text = ""

		if var_14_2.talk.label_txt.text.preferredHeight < var_14_2.talk.popVerticalAdaptive.offset.y * 2 + var_14_2.talk.label_txt.text.fontSize then
			var_14_2.talk.popVerticalAdaptive.textMaxWidth = self._control.model_layer.talk.label_txt.rectTransform.sizeDelta.x

			var_14_2.talk.popVerticalAdaptive:SetText(var_14_0)

			var_14_2.talk.label_txt.text.text = ""
			var_14_2.talk.popVerticalAdaptive.textMaxWidth = 0
		end

		local var_14_4 = 1

		if var_14_0 then
			var_14_4 = #var_14_0 * 0.03
		end

		self._talk_dialog_box_seq = self:autoKillDOTween(var_0_5.Sequence())

		self._talk_dialog_box_seq:Append(var_14_2.talk.label_txt.text:DOText(var_14_0, var_14_4))
		self._talk_dialog_box_seq:AppendInterval(var_14_4 + 0.5)
		self._talk_dialog_box_seq:Append(var_14_2.talk.canvasGroup:DOFade(0, 2):OnComplete(function()
			if self._talk_dialog_box_seq then
				self._talk_dialog_box_seq:Kill()

				self._talk_dialog_box_seq = nil
			end
		end))
		self._talk_dialog_box_seq:OnKill(function()
			var_14_2.talk.label_txt.rectTransform.sizeDelta = var_14_3
		end)
	end

	function arg_1_0:change_table_style()
		function arg_1_0:table_style(arg_18_1)
			local var_18_0 = UnityEngine.UI.SpriteState.New()

			self._control.main.table.image.sprite = self:loadSprite(var_0_3(var_0_4.support_room_card_desk, tostring(arg_18_1)))
			self._control.main.supportmap.image.sprite = self:loadSprite(var_0_3(var_0_4.support_room_card_support, tostring(arg_18_1)))
			var_18_0.pressedSprite = self:loadSprite(var_0_3(var_0_4.support_room_card_support_d, tostring(arg_18_1)))
			self._control.main.supportmap.button.spriteState = var_18_0
			self._control.main.grademap.image.sprite = self:loadSprite(var_0_3(var_0_4.support_room_card_rank, tostring(arg_18_1)))
			var_18_0.pressedSprite = self:loadSprite(var_0_3(var_0_4.support_room_card_rank_d, tostring(arg_18_1)))
			self._control.main.grademap.button.spriteState = var_18_0
		end

		local var_17_0 = var_0_2:get_now_rank_point().rank_point

		if var_17_0 < var_0_4.gradeprogressnum.rank_1 then
			self:table_style(1)
		elseif var_17_0 < var_0_4.gradeprogressnum.rank_2 and var_17_0 >= var_0_4.gradeprogressnum.rank_1 then
			self:table_style(2)
		elseif var_17_0 < var_0_4.gradeprogressnum.rank_3 and var_17_0 >= var_0_4.gradeprogressnum.rank_2 then
			self:table_style(3)
		elseif var_17_0 < var_0_4.gradeprogressnum.rank_4 and var_17_0 >= var_0_4.gradeprogressnum.rank_3 then
			self:table_style(4)
		elseif var_17_0 >= var_0_4.gradeprogressnum.rank_4 then
			self:table_style(5)
		end
	end

	function arg_1_0:__init_constant()
		var_0_9 = self._control.character
		var_0_12 = {}
		var_0_10 = {
			normal = "normal",
			bathroom = "bathroom"
		}
		var_0_8 = {
			normal = "normal",
			stand = "stand1"
		}
		var_0_11 = {
			self._control.menu.main.bubblezu.support,
			self._control.menu.main.bubblezu.grade
		}
	end

	function arg_1_0:_play_into_se(arg_20_1)
		self:playSE(arg_20_1, false)
	end

	function arg_1_0:reset_talk_dialog_box()
		if self._talk_dialog_box_seq then
			self._talk_dialog_box_seq:Kill()

			self._talk_dialog_box_seq = nil
		end

		self._control.model_layer.talk.canvasGroup.alpha = 0
	end

	function arg_1_0:__onReset()
		self:reset_talk_dialog_box()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_23_0)
	local var_23_0 = var_0_1:class("supportroom")

	var_23_0._already_init = false
	var_23_0._btn_anim_seq_list = {}
	var_23_0._user_data = nil
	var_23_0._character_data = nil
	var_23_0._ship_data = nil

	return var_23_0
end

return var_0_0
