local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = table.insert
local var_0_5 = gamecore.util_func
local var_0_6 = gamecore.Language
local var_0_7 = gameconfig.cinema_story_list_config
local var_0_8 = gameconfig.cinema_story_id_list_config
local var_0_9 = Vector2
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

gamecore.UILoader:define("story_btn_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
		if arg_2_1 == 1013 and arg_2_3 and next(arg_2_3) then
			local var_2_0 = 0

			for iter_2_0, iter_2_1 in pairs(arg_2_3) do
				var_2_0 = var_2_0 + 1
			end

			arg_2_2 = var_2_0
		end

		self:setVisible(true)

		local var_2_1 = var_0_2:getInstance("cinema_story_node")

		if var_2_1 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_2_1._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self:__init_panel(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)

		local var_2_2 = var_0_2:getInstance("cinema_story_node")

		var_2_2._control.cover.button.onClick:RemoveAllListeners()
		var_2_2._control.cover.button.onClick:AddListener(function()
			self:show_btn_info(false)
		end)
	end

	function arg_1_0.__onUpdate(arg_4_0)
		return
	end

	function arg_1_0:show_btn_info(arg_5_1)
		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, arg_5_1, function()
			if not arg_5_1 then
				self._control.btn_group.transform.pivot = var_0_9(0, 1)

				self._control.bg:SetActive(false)
				var_0_2:destroyInstance("story_btn_info")
				var_0_2:getInstance("cinema_story_node")._control.cover:SetActive(false)
			end
		end)
	end

	function arg_1_0:set_btn_info_data(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
		local var_7_0 = var_0_10[arg_7_1]:get_sequence()
		local var_7_1 = var_0_1:get_player_story_unlock_data()
		local var_7_2 = {}

		for iter_7_0 = 1, #var_7_1 do
			if var_7_1[iter_7_0].type == 1 then
				var_0_4(var_7_2, var_7_1[iter_7_0])
			end
		end

		local var_7_3 = {
			self._control.btn_group.story_btn_1,
			self._control.btn_group.story_btn_2,
			self._control.btn_group.story_btn_3,
			self._control.btn_group.story_btn_4
		}

		self._btn_group = var_7_3

		for iter_7_1 = 1, 4 do
			var_7_3[iter_7_1].txt_scroller.txt.text.text = ""
			var_7_3[iter_7_1].txt_scroller.txt_1.text.text = ""

			var_7_3[iter_7_1].txt_scroller.textHorizonScroller:SetText("")
		end

		local var_7_4 = {}
		local var_7_5 = {}

		for iter_7_2 = 1, arg_7_2 do
			var_7_3[iter_7_2]:SetActive(true)

			if arg_7_3 then
				local var_7_6 = var_0_8.find_object_by_id(arg_7_3[iter_7_2][3]).movie_id[1]
				local var_7_7 = var_0_8.find_object_by_id(arg_7_3[iter_7_2][3]).movie_id[2]
				local var_7_8 = var_0_10[arg_7_1].find_object_by_step(var_7_6).title
				local var_7_9 = var_0_10[arg_7_1].find_object_by_step(var_7_6).unlock

				for iter_7_3 = 1, #var_7_2 do
					var_7_3[iter_7_2].image.sprite = self:loadSprite(var_0_3.story_active_state.story_lock)
				end

				local var_7_10 = var_7_9
				local var_7_11 = Color.New(0.396078431372549, 0.396078431372549, 0.396078431372549)

				var_7_3[iter_7_2].txt_scroller.txt.text.color = var_7_11
				var_7_3[iter_7_2].txt_scroller.txt_1.text.color = var_7_11
				var_7_3[iter_7_2].txt_scroller.txt_1.text.text = var_7_10

				for iter_7_4 = 1, #var_7_2 do
					if arg_7_3[iter_7_2][3] == var_7_2[iter_7_4].id then
						var_7_10 = var_7_8

						local var_7_12 = Color.New(0.15294117647058825, 0.5686274509803921, 0.9647058823529412)

						var_7_3[iter_7_2].image.sprite = self:loadSprite(var_0_3.story_active_state.story_active)
						var_7_3[iter_7_2].txt_scroller.txt.text.text = var_7_10
						var_7_3[iter_7_2].txt_scroller.txt_1.text.text = ""
						var_7_3[iter_7_2].txt_scroller.txt.text.color = var_7_12
						var_7_3[iter_7_2].txt_scroller.txt_1.text.color = var_7_12

						var_7_3[iter_7_2].txt_scroller.textHorizonScroller:SetText(var_7_10)
						var_0_4(var_7_4, arg_7_3[iter_7_2][3])
					end
				end

				if var_7_10 == var_7_9 then
					var_7_3[iter_7_2].txt_scroller.txt_1.text.text = ""
					var_7_3[iter_7_2].txt_scroller.txt_1.text.text = var_7_10

					var_7_3[iter_7_2].txt_scroller.textHorizonScroller:SetText(var_7_10)
				end

				var_7_3[iter_7_2].button.onClick:RemoveAllListeners()
				var_7_3[iter_7_2].button.onClick:AddListener(function()
					local var_8_0

					for iter_8_0, iter_8_1 in pairs((var_0_8.get_sequence())) do
						if iter_8_1.movie_id[1] == var_7_6 then
							var_8_0 = iter_8_1.id
						end
					end

					if self:_have_data(var_7_4, var_8_0) then
						var_0_2:createInstance("cinema_dialog"):show(arg_7_1, var_7_6, var_7_7)
					else
						local var_8_3 = var_0_2:getInstance("msgbox")
						local var_8_4 = var_0_6:getNowLang("cinema_unlock")
						local var_8_5 = var_0_6:getNowLang("cinema_unlock_2")

						if var_0_1:_get_six_info().token < 100 then
							gamecore.prompt:show(var_0_6:getNowLang("token_lack"))

							return
						end

						local function var_8_6()
							var_0_1:req_TokenUnlockStoryReq(var_8_0)
						end

						if var_8_3 then
							var_8_3:show(var_8_5, var_8_6, nil, var_8_4, nil, nil, true)
						else
							var_0_2:createInstance("msgbox"):show(var_8_5, var_8_6, nil, var_8_4, nil, nil, true)
						end
					end
				end)
			end

			if arg_7_4 then
				local var_7_13 = var_0_8.find_object_by_id(arg_7_4[iter_7_2][4]).movie_id[1]
				local var_7_14 = var_0_8.find_object_by_id(arg_7_4[iter_7_2][4]).movie_id[2]
				local var_7_15 = var_0_10[arg_7_1].find_object_by_step(var_7_13)

				var_7_3[iter_7_2]:GetComponent("Button").interactable = false

				local var_7_16 = var_7_15.unlock
				local var_7_17 = Color.New(0.396078431372549, 0.396078431372549, 0.396078431372549)

				var_7_3[iter_7_2].txt_scroller.txt.text.text = var_7_15.unlock
				var_7_3[iter_7_2].txt_scroller.txt.text.color = var_7_17
				var_7_3[iter_7_2].txt_scroller.txt_1.text.color = var_7_17
				var_7_3[iter_7_2].txt_scroller.txt_1.text.text = var_7_16

				for iter_7_5 = 1, #var_7_2 do
					if arg_7_4[iter_7_2][4] == var_7_2[iter_7_5].id then
						var_7_16 = var_7_15.title

						local var_7_18 = Color.New(0.15294117647058825, 0.5686274509803921, 0.9647058823529412)

						var_7_3[iter_7_2]:GetComponent("Button").interactable = true
						var_7_3[iter_7_2].txt_scroller.txt.text.text = var_7_16
						var_7_3[iter_7_2].txt_scroller.txt_1.text.text = ""
						var_7_3[iter_7_2].txt_scroller.txt.text.color = var_7_18
						var_7_3[iter_7_2].txt_scroller.txt_1.text.color = var_7_18
					end
				end

				if var_7_16 == var_7_15.unlock then
					var_7_3[iter_7_2].txt_scroller.txt_1.text.text = var_7_16

					var_7_3[iter_7_2].txt_scroller.textHorizonScroller:SetText(var_7_16)
				end

				var_7_3[iter_7_2].button.onClick:RemoveAllListeners()
				var_7_3[iter_7_2].button.onClick:AddListener(function()
					var_0_2:createInstance("cinema_dialog"):show(arg_7_1, var_7_13, var_7_14)
				end)
			end

			if arg_7_7 then
				local var_7_19 = var_0_8.find_object_by_id(arg_7_7).movie_id[1]
				local var_7_20 = var_0_8.find_object_by_id(arg_7_7).movie_id[2]
				local var_7_21 = var_0_10[arg_7_1].find_object_by_step(var_7_19)
				local var_7_22 = var_7_21.unlock
				local var_7_23 = Color.New(0.396078431372549, 0.396078431372549, 0.396078431372549)

				var_7_3[iter_7_2].txt_scroller.txt.text.text = var_7_21.unlock
				var_7_3[iter_7_2].txt_scroller.txt.text.color = var_7_23
				var_7_3[iter_7_2].txt_scroller.txt_1.text.color = var_7_23
				var_7_3[iter_7_2].txt_scroller.txt_1.text.text = var_7_22

				for iter_7_6 = 1, #var_7_2 do
					var_7_3[iter_7_2].image.sprite = self:loadSprite(var_0_3.story_active_state.story_lock)
				end

				for iter_7_7 = 1, #var_7_2 do
					if arg_7_7 == var_7_2[iter_7_7].id then
						var_7_22 = var_7_21.title

						local var_7_24 = Color.New(0.15294117647058825, 0.5686274509803921, 0.9647058823529412)

						var_7_3[iter_7_2].txt_scroller.txt.text.text = var_7_21.title
						var_7_3[iter_7_2].txt_scroller.txt_1.text.text = ""
						var_7_3[iter_7_2].txt_scroller.txt.text.color = var_7_24
						var_7_3[iter_7_2].txt_scroller.txt_1.text.color = var_7_24

						var_0_4(var_7_5, arg_7_7)

						var_7_3[iter_7_2].image.sprite = self:loadSprite(var_0_3.story_active_state.story_active)
					end
				end

				if var_7_22 == var_7_21.unlock then
					var_7_3[iter_7_2].txt_scroller.txt_1.text.text = var_7_22

					var_7_3[iter_7_2].txt_scroller.textHorizonScroller:SetText(var_7_22)
				end

				local var_7_25 = var_0_7:get_sequence()

				self.now_branch_story_list = {}

				for iter_7_8 = 1, #var_7_25 do
					if var_7_25[iter_7_8].movie_group_id == arg_7_1 and var_7_25[iter_7_8].type == 2 then
						var_0_4(self.now_branch_story_list, var_7_25[iter_7_8])
					end
				end

				table.sort(self.now_branch_story_list, function(arg_11_0, arg_11_1)
					return arg_11_0.id < arg_11_1.id
				end)
				var_7_3[iter_7_2].button.onClick:RemoveAllListeners()
				var_7_3[iter_7_2].button.onClick:AddListener(function()
					local var_12_0

					for iter_12_0, iter_12_1 in pairs((var_0_8.get_sequence())) do
						if iter_12_1.movie_id[1] == var_7_19 then
							var_12_0 = iter_12_1.id
						end
					end

					if arg_7_7 == self.now_branch_story_list[1].movie_id and not self:_have_data(var_7_5, var_12_0) then
						local var_12_3 = var_0_2:getInstance("msgbox")
						local var_12_4 = var_0_6:getNowLang("cinema_unlock")
						local var_12_5 = var_0_6:getNowLang("cinema_unlock_2")

						if var_0_1:_get_six_info().token < 100 then
							gamecore.prompt:show(var_0_6:getNowLang("token_lack"))

							return
						end

						local function var_12_6()
							var_0_1:req_TokenUnlockStoryReq(var_12_0)

							;({}).id = arg_7_7

							local var_13_0 = var_0_2:getInstance("cinema_story_node")

							var_0_1:set_now_small_story_panel(true)
						end

						if var_12_3 then
							var_12_3:show(var_12_5, var_12_6, nil, var_12_4, nil, nil, true)
						else
							var_0_2:createInstance("msgbox"):show(var_12_5, var_12_6, nil, var_12_4, nil, nil, true)
						end
					else
						if not self:_have_data(var_7_5, var_12_0) then
							return
						end

						var_0_2:createInstance("cinema_dialog"):show(arg_7_1, var_7_19, var_7_20)
						var_0_1:req_ReadStoryReq({
							id = arg_7_7
						})
					end
				end)
			end
		end

		local var_7_26 = var_0_2:getInstance("cinema_story_node")

		if arg_7_6 == 1 then
			self._control.btn_group.transform.anchoredPosition = var_0_9(213 + (var_7_26._control.scrollview_1.viewport.content.transform.anchoredPosition.x + var_7_26._control.scrollview_2.viewport.content.transform.anchoredPosition.x) + arg_7_5 * 275, -360)
		end

		if arg_7_6 == 2 then
			self._control.btn_group.transform.anchoredPosition = var_0_9(353 + (var_7_26._control.scrollview_1.viewport.content.transform.anchoredPosition.x + var_7_26._control.scrollview_2.viewport.content.transform.anchoredPosition.x) + arg_7_5 * 275, -190)
		end

		if arg_7_6 == 3 then
			self._control.btn_group.transform.anchoredPosition = var_0_9(353 + (var_7_26._control.scrollview_1.viewport.content.transform.anchoredPosition.x + var_7_26._control.scrollview_2.viewport.content.transform.anchoredPosition.x) + arg_7_5 * 275, -526)
		end

		local var_7_27 = self._control.btn_group.rectTransform.rect.width
		local var_7_28 = self._panel:GetComponent(typeof(UnityEngine.RectTransform)).rect.width - self._control.btn_group.transform.anchoredPosition.x - self._control.btn_group.rectTransform.rect.width

		if var_7_28 < 0 then
			if var_7_27 + var_7_28 >= 0 and var_7_27 + var_7_28 > var_7_27 / 2 then
				self._control.btn_group.transform.pivot = var_0_9(0.5, 1)
			else
				if var_7_27 + var_7_28 < 0 then
					self._control.btn_group.transform.anchoredPosition = var_0_9(self._control.btn_group.transform.anchoredPosition.x + (var_7_27 + var_7_28), self._control.btn_group.transform.anchoredPosition.y)
				end

				self._control.btn_group.transform.pivot = var_0_9(1, 1)
			end
		end

		if self._control.btn_group.transform.anchoredPosition.x < 0 then
			self._control.btn_group.transform.anchoredPosition = var_0_9(self._control.btn_group.transform.anchoredPosition.x - self._control.btn_group.transform.anchoredPosition.x, self._control.btn_group.transform.anchoredPosition.y)
			self._control.btn_group.transform.pivot = var_0_9(0, 1)
		end
	end

	function arg_1_0._have_data(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = false

		if arg_14_1 and next(arg_14_1) then
			for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
				if iter_14_1 == arg_14_2 then
					var_14_0 = true

					return true
				end
			end
		end

		return var_14_0
	end

	function arg_1_0:__init_panel(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
		self:set_btn_info_data(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
		self:show_btn_info(true)

		self._uiroot_canvas_rect = var_0_5.get_ui_root_canvas_rect()
		self._ui_camera = var_0_5.get_ui_camera()
	end

	function arg_1_0:__onReset()
		self._control.btn_group.story_btn_1:SetActive(true)
		self._control.btn_group.story_btn_2:SetActive(false)
		self._control.btn_group.story_btn_3:SetActive(false)
		self._control.btn_group.story_btn_4:SetActive(false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_17_0)
	local var_17_0 = var_0_2:class("story_btn_info")

	var_17_0._is_already_init = false

	return var_17_0
end

return var_0_0
