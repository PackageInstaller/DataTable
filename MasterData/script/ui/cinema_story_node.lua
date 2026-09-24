local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = table.insert
local var_0_6 = gameconfig.cinema_story_list_config
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = gamecore.util_func
local var_0_10 = {
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
	[1025] = gameconfig.main_story_25_config
}

gamecore.UILoader:define("cinema_story_node", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)
		self:__init_panel(arg_2_1)

		self.from_event = arg_2_2
	end

	function arg_1_0:__onUpdate()
		local var_3_0

		if self._control.scrollview_1.viewport.content.transform.rect.width > 1325 then
			var_3_0 = self._control.scrollview_1.viewport.content.transform.anchoredPosition.x / (self._control.scrollview_1.viewport.content.transform.rect.width - 1325) or 0

			local var_3_1

			if self._control.scrollview_2.viewport.content.transform.rect.width > 1325 then
				var_3_1 = self._control.scrollview_2.viewport.content.transform.anchoredPosition.x / (self._control.scrollview_2.viewport.content.transform.rect.width - 1325) or 0
			end
		end

		self._control.bg.transform.anchoredPosition = Vector2(90 * (var_3_0 + var_3_1), 0)
	end

	function arg_1_0:show_now_scrollview(arg_4_1)
		var_0_4:play_in_out_animation(self._control.bg.uITweenSequence, arg_4_1, function()
			if arg_4_1 then
				self._control.scrollview_1:SetActive(false)
				self._control.cover_2:SetActive(false)

				self._control.scrollview_2.canvasGroup.alpha = 1
			end

			if not arg_4_1 then
				self._control.scrollview_2.canvasGroup.alpha = 0

				self._control.scrollview_2:SetActive(false)
				self._control.cover_2:SetActive(false)
			end
		end)
	end

	function arg_1_0:play_in_handover_animation_1(arg_6_1)
		self._control.handover_tweem.uITweenSequence:Play(function()
			if arg_6_1 then
				arg_6_1()
			end
		end)
	end

	function arg_1_0:play_out_handover_animation_1(arg_8_1)
		self._control.handover_tweem.uITweenSequence:PlayReverse(function()
			if arg_8_1 then
				arg_8_1()
			end
		end)
	end

	function arg_1_0:show_now_handover_1(arg_10_1)
		var_0_4:play_in_out_animation(self._control.handover_tweem.uITweenSequence, arg_10_1, function()
			if arg_10_1 then
				self:play_out_handover_animation_1()

				self._control.handover_btn.image.sprite = self:loadSprite(var_0_4.story_handover[1])
			end
		end)
	end

	function arg_1_0:show_now_handover_2(arg_12_1)
		var_0_4:play_in_out_animation(self._control.handover_tweem.uITweenSequence, arg_12_1, function()
			if arg_12_1 then
				self:play_out_handover_animation_1()

				self._control.handover_btn.image.sprite = self:loadSprite(var_0_4.story_handover[2])
			end
		end)
	end

	function arg_1_0:play_in_animation_1(arg_14_1)
		local var_14_0 = self._control.scrollview_1.transform:GetComponent("CanvasGroup")
		local var_14_1 = self:autoKillDOTween(var_0_8.Sequence())

		if arg_14_1 then
			var_14_1:Append(var_14_0:DOFade(1, 1))
		else
			var_14_1:Append(var_14_0:DOFade(0, 1))
		end
	end

	function arg_1_0:play_in_animation_2(arg_15_1)
		local var_15_0 = self._control.scrollview_2.transform:GetComponent("CanvasGroup")
		local var_15_1 = self:autoKillDOTween(var_0_8.Sequence())

		if arg_15_1 then
			var_15_1:Append(var_15_0:DOFade(1, 1))
		else
			var_15_1:Append(var_15_0:DOFade(0, 1))
		end
	end

	function arg_1_0:set_story_node(arg_16_1)
		local var_16_0 = var_0_6:get_sequence()
		local var_16_1 = var_0_10[arg_16_1]:get_sequence()
		local var_16_2 = var_0_1:get_player_story_unlock_data()
		local var_16_3 = {}

		for iter_16_0 = 1, #var_16_2 do
			if var_16_2[iter_16_0].type == 1 then
				var_0_5(var_16_3, var_16_2[iter_16_0].id)
			end
		end

		for iter_16_1 = 1, #var_16_0 do
			if var_16_0[iter_16_1].movie_group_id == arg_16_1 and var_16_0[iter_16_1].type == 1 then
				var_0_5(self.now_story_list, var_16_0[iter_16_1])
			end
		end

		for iter_16_2 = 1, #var_16_0 do
			if var_16_0[iter_16_2].movie_group_id == arg_16_1 and var_16_0[iter_16_2].type == 2 then
				var_0_5(self.now_branch_story_list, var_16_0[iter_16_2])
			end
		end

		if self.now_branch_story_list[1] then
			self._control.handover_btn:SetActive(true)

			self._control.handover_btn.image.sprite = self:loadSprite(var_0_4.story_handover[2])
		end

		for iter_16_3 = 1, #self.now_story_list do
			if self.now_story_list[iter_16_3].pos == 1 then
				self.node_count_1 = self.node_count_1 + 1

				local var_16_4 = self:loadUI("single_story_node")

				var_16_4:show()

				local var_16_5 = {
					var_16_4._control.sign_group.sign_1,
					var_16_4._control.sign_group.sign_2,
					var_16_4._control.sign_group.sign_3,
					var_16_4._control.sign_group.sign_4,
					var_16_4._control.main_btn,
					var_16_4._control.line_main
				}
				local var_16_6 = {
					var_16_4._control.branch_up.node_up.sign_group.sign_1,
					var_16_4._control.branch_up.node_up.sign_group.sign_2,
					var_16_4._control.branch_up.node_up.sign_group.sign_3,
					var_16_4._control.branch_up.node_up.sign_group.sign_4,
					var_16_4._control.branch_up.node_up,
					var_16_4._control.branch_up
				}
				local var_16_7 = {
					var_16_4._control.branch_down.node_down.sign_group.sign_1,
					var_16_4._control.branch_down.node_down.sign_group.sign_2,
					var_16_4._control.branch_down.node_down.sign_group.sign_3,
					var_16_4._control.branch_down.node_down.sign_group.sign_4,
					var_16_4._control.branch_down.node_down,
					var_16_4._control.branch_down
				}
				local var_16_8 = {
					var_16_4._control.branch_up_1.node_up.sign_group.sign_1,
					var_16_4._control.branch_up_1.node_up.sign_group.sign_2,
					var_16_4._control.branch_up_1.node_up.sign_group.sign_3,
					var_16_4._control.branch_up_1.node_up.sign_group.sign_4,
					var_16_4._control.branch_up_1.node_up,
					var_16_4._control.branch_up_1
				}
				local var_16_9 = {
					var_16_4._control.branch_down_1.node_down.sign_group.sign_1,
					var_16_4._control.branch_down_1.node_down.sign_group.sign_2,
					var_16_4._control.branch_down_1.node_down.sign_group.sign_3,
					var_16_4._control.branch_down_1.node_down.sign_group.sign_4,
					var_16_4._control.branch_down_1.node_down,
					var_16_4._control.branch_down_1
				}

				var_16_4._panel.transform:SetParent(self._control.scrollview_1.viewport.content.transform, false)
				self:set_node_data(arg_16_1, self.now_story_list[iter_16_3], var_16_5, self.node_count_1, 1, var_16_3, 1)

				var_16_4._control.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_story_list[iter_16_3].flag))

				if 0 == 0 then
					var_16_4._control.line_main:SetActive(false)
				end

				if self.now_story_list[iter_16_3 + 1] and self.now_story_list[iter_16_3 + 1].pos == 2 then
					var_16_4._control.branch_up:SetActive(true)

					var_16_4._control.branch_up.node_up.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_story_list[iter_16_3 + 1].flag))

					self:set_node_data(arg_16_1, self.now_story_list[iter_16_3 + 1], var_16_6, self.node_count_1, 2, var_16_3, 2)

					if self.now_story_list[iter_16_3 + 2] and self.now_story_list[iter_16_3 + 2].pos == 3 then
						var_16_4._control.branch_down:SetActive(true)

						var_16_4._control.branch_down.node_down.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_story_list[iter_16_3 + 2].flag))

						self:set_node_data(arg_16_1, self.now_story_list[iter_16_3 + 2], var_16_7, self.node_count_1, 3, var_16_3, 2)
					end

					if self.now_story_list[iter_16_3 + 2] and self.now_story_list[iter_16_3 + 2].pos == 2 then
						var_16_4._control.branch_up_1:SetActive(true)

						var_16_4._control.branch_up_1.node_up.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_story_list[iter_16_3 + 2].flag))

						self:set_node_data(arg_16_1, self.now_story_list[iter_16_3 + 2], var_16_8, self.node_count_1 + 1, 2, var_16_3, 2)
					end
				end

				if self.now_story_list[iter_16_3 + 1] and self.now_story_list[iter_16_3 + 1].pos == 3 then
					var_16_4._control.branch_down:SetActive(true)

					var_16_4._control.branch_down.node_down.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_story_list[iter_16_3 + 1].flag))

					self:set_node_data(arg_16_1, self.now_story_list[iter_16_3 + 1], var_16_7, self.node_count_1, 3, var_16_3, 2)

					if self.now_story_list[iter_16_3 + 2] and self.now_story_list[iter_16_3 + 2].pos == 2 then
						var_16_4._control.branch_up:SetActive(true)

						var_16_4._control.branch_up.node_up.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_story_list[iter_16_3 + 2].flag))

						self:set_node_data(arg_16_1, self.now_story_list[iter_16_3 + 2], var_16_6, self.node_count_1, 2, var_16_3, 2)
					end

					if self.now_story_list[iter_16_3 + 2] and self.now_story_list[iter_16_3 + 2].pos == 3 then
						var_16_4._control.branch_down_1:SetActive(true)

						var_16_4._control.branch_down_1.node_down.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_story_list[iter_16_3 + 2].flag))

						self:set_node_data(arg_16_1, self.now_story_list[iter_16_3 + 2], var_16_9, self.node_count_1 + 1, 3, var_16_3, 2)
					end
				end

				self._control.scrollview_1.viewport.content:GetComponent("GridLayoutGroup").constraintCount = self._control.scrollview_1.viewport.content:GetComponent("GridLayoutGroup").constraintCount + 1
			end
		end

		for iter_16_4 = 1, #self.now_branch_story_list do
			if self.now_branch_story_list[iter_16_4].pos == 1 then
				self.node_count_2 = self.node_count_2 + 1

				local var_16_11 = self:loadUI("single_story_node")

				var_16_11:show()

				if 0 == 0 then
					var_16_11._control.line_main:SetActive(false)
				end

				var_16_11._panel.transform:SetParent(self._control.scrollview_2.viewport.content.transform, false)

				var_16_11._control.number.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_nobe_number[1], self.now_branch_story_list[iter_16_4].flag))

				self:set_branch_node_data(arg_16_1, var_16_11, self.node_count_2, 1, self.now_branch_story_list[iter_16_4].movie_id, var_16_3)

				self._control.scrollview_2.viewport.content:GetComponent("GridLayoutGroup").constraintCount = self._control.scrollview_2.viewport.content:GetComponent("GridLayoutGroup").constraintCount + 1
			end
		end
	end

	function arg_1_0.__have_data(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_1 and next(arg_17_1) then
			for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
				if iter_17_1[3] == arg_17_2 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:set_node_data(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
		if arg_18_2.condition then
			local var_18_0 = {}

			for iter_18_0, iter_18_1 in ipairs(arg_18_2.condition) do
				if var_18_0 and next(var_18_0) then
					if not self:__have_data(var_18_0, iter_18_1[3]) then
						var_0_5(var_18_0, iter_18_1)
					end
				else
					var_0_5(var_18_0, iter_18_1)
				end
			end

			if arg_18_1 == 1013 then
				var_18_0 = arg_18_2.condition
			end

			for iter_18_2 = 1, #var_18_0 do
				for iter_18_3 = 1, #arg_18_6 do
					if var_18_0[iter_18_2][3] == arg_18_6[iter_18_3] then
						arg_18_3[iter_18_2].image.sprite = self:loadSprite(var_0_4.story_sign[2])
						arg_18_3[5].image.sprite = self:loadSprite(var_0_4.story_nobe[arg_18_7])
						arg_18_3[5]:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.SpriteSwap
						arg_18_3[6].image.sprite = self:loadSprite(var_0_4.story_nobe_line[2])
					end
				end

				arg_18_3[iter_18_2]:SetActive(true)
				arg_18_3[5].button.onClick:RemoveAllListeners()
				arg_18_3[5].button.onClick:AddListener(function()
					self._control.cover:SetActive(true)
					var_0_3:createInstance("story_btn_info"):show(arg_18_1, #var_18_0, arg_18_2.condition, nil, arg_18_4, arg_18_5)
				end)
			end
		end

		if arg_18_2.condition2 then
			for iter_18_4 = 1, #arg_18_2.condition2 do
				for iter_18_5 = 1, #arg_18_6 do
					if arg_18_2.condition2[iter_18_4][4] == arg_18_6[iter_18_5] then
						arg_18_3[iter_18_4].image.sprite = self:loadSprite(var_0_4.story_sign[2])
						arg_18_3[5].image.sprite = self:loadSprite(var_0_4.story_nobe[arg_18_7])
						arg_18_3[5]:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.SpriteSwap
						arg_18_3[6].image.sprite = self:loadSprite(var_0_4.story_nobe_line[2])
					end
				end

				arg_18_3[iter_18_4]:SetActive(true)
				arg_18_3[5].button.onClick:RemoveAllListeners()
				arg_18_3[5].button.onClick:AddListener(function()
					self._control.cover:SetActive(true)
					var_0_3:createInstance("story_btn_info"):show(arg_18_1, #arg_18_2.condition2, nil, arg_18_2.condition2, arg_18_4, arg_18_5)
				end)
			end
		end
	end

	function arg_1_0:set_branch_node_data(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
		for iter_21_0 = 1, #arg_21_6 do
			if arg_21_5 == arg_21_6[iter_21_0] then
				arg_21_2._control.sign_group.sign_1.image.sprite = self:loadSprite(var_0_4.story_sign[2])
				arg_21_2._control.main_btn.image.sprite = self:loadSprite(var_0_4.story_nobe[1])
				arg_21_2._control.main_btn:GetComponent("Button").transition = UnityEngine.UI.Selectable.Transition.SpriteSwap
				arg_21_2._control.line_main.image.sprite = self:loadSprite(var_0_4.story_nobe_line[2])
			end
		end

		arg_21_2._control.main_btn.button.onClick:RemoveAllListeners()
		arg_21_2._control.main_btn.button.onClick:AddListener(function()
			self._control.cover:SetActive(true)
			var_0_3:createInstance("story_btn_info"):show(arg_21_1, 1, nil, nil, arg_21_3, arg_21_4, arg_21_5)
		end)
	end

	function arg_1_0:reset_story_node()
		self.now_story_list = {}
		self.now_branch_story_list = {}

		for iter_23_0 = 0, self._control.scrollview_1.viewport.content.rectTransform.childCount - 1 do
			self:destroyGameObject(self._control.scrollview_1.viewport.content.rectTransform:GetChild(iter_23_0).gameObject)
		end

		for iter_23_1 = 0, self._control.scrollview_2.viewport.content.rectTransform.childCount - 1 do
			self:destroyGameObject(self._control.scrollview_2.viewport.content.rectTransform:GetChild(iter_23_1).gameObject)
		end

		self._control.scrollview_1.viewport.content:GetComponent("GridLayoutGroup").constraintCount = 1
		self._control.scrollview_2.viewport.content:GetComponent("GridLayoutGroup").constraintCount = 1
		start_point_1 = 0
		start_point_2 = 0
		self.node_count_1 = -1
		self.node_count_2 = -1
		self._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)

		self._control.scrollview_1:SetActive(true)
		self._control.scrollview_2:SetActive(false)
		self:play_in_animation_1(false)

		self._control.handover_btn.image.sprite = self:loadSprite(var_0_4.story_handover[2])

		self._control.handover_btn:SetActive(false)
	end

	function arg_1_0:__init_panel(arg_24_1)
		self.index = arg_24_1

		var_0_1:set_now_story(self.index)
		self:set_story_node(arg_24_1)

		self._uiroot_canvas_rect = var_0_9.get_ui_root_canvas_rect()
		self._ui_camera = var_0_9.get_ui_camera()

		self:play_in_animation_1(true)

		self._control.title.txt.text.text = var_0_2:getNowLang("ui_4th_enter_dialog_review")

		local var_24_0 = var_0_3:getInstance("ninth_main_map")

		if var_24_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_24_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_25_0)
	local var_25_0 = var_0_3:class("cinema_story_node")

	var_25_0.index = nil
	var_25_0._is_already_init = false
	var_25_0.node_count_1 = -1
	var_25_0.node_count_2 = -1
	var_25_0.now_story_list = {}
	var_25_0.now_branch_story_list = {}

	return var_25_0
end

return var_0_0
