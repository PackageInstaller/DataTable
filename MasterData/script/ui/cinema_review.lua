local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameconfig.story_list_config
local var_0_5 = gameconfig.cinema_story_id_list_config
local var_0_6 = gameenum.common_type
local var_0_7 = table.insert
local var_0_8 = gamecore.prompt
local var_0_10 = {
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

gamecore.UILoader:define("cinema_review", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell_1 then
			self._reusable_cell_1:update()
		end

		if self._reusable_cell_2 then
			self._reusable_cell_2:update()
		end
	end

	function arg_1_0.contrast_tab(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			local var_4_1 = false

			for iter_4_2, iter_4_3 in pairs(arg_4_2) do
				if iter_4_1.cid == iter_4_3.cid then
					var_4_1 = true
				end
			end

			if not var_4_1 then
				var_0_7(var_4_0, iter_4_1)
			end
		end

		return var_4_0
	end

	function arg_1_0:get_cell_by_now_lable()
		return (self._now_label == 2 or nil) and self._reusable_cell_2
	end

	function arg_1_0:show_scroll_by_index(arg_6_1)
		if arg_6_1 == 1 then
			self._control.scrollview_1:SetActive(true)
			self._control.scrollview_2:SetActive(false)

			self._now_label = 1

			self:__update_edge_mask_1()
		else
			self._control.scrollview_1:SetActive(false)
			self._control.scrollview_2:SetActive(true)

			self._now_label = 2

			self:__update_edge_mask_2()
		end
	end

	function arg_1_0:init_cell()
		if self._is_already_init then
			return
		end

		self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.scrollview_1.viewport.content.endlessScrollView, self._control.scrollview_1.viewport.content, "story_cell", "cinema_review")

		self._reusable_cell_1:init()

		self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.scrollview_2.viewport.content.endlessScrollView, self._control.scrollview_2.viewport.content, "story_cell", "cinema_review")

		self._reusable_cell_2:init()

		self._is_already_init = true
	end

	function arg_1_0:init_story_cell_list()
		local var_8_0, var_8_1 = var_0_4:get_sequence()
		local var_8_2 = var_0_1:get_player_story_unlock_data()
		local var_8_3 = {}
		local var_8_4 = {}

		for iter_8_0 = 1, #var_8_2 do
			if var_8_2[iter_8_0].type == 1 then
				var_0_7(var_8_3, var_8_2[iter_8_0].id)
			end
		end

		for iter_8_1 = 1, #var_8_3 do
			local var_8_6 = var_0_5.find_object_by_id(var_8_3[iter_8_1])

			if var_8_6 then
				var_0_7(var_8_4, var_8_6.movie_group_id)
			else
				log.print_r(var_8_3[iter_8_1], "story config not found")
			end
		end

		local var_8_7 = {}
		local var_8_8 = {}

		for iter_8_2 = 1, #var_8_0 do
			if var_8_0[iter_8_2].type == 1 then
				var_0_7(var_8_7, var_8_0[iter_8_2])
			else
				var_0_7(var_8_8, var_8_0[iter_8_2])
			end
		end

		local var_8_9 = self:get_cell_by_now_lable()
		local var_8_10 = self._now_label == 1 and var_8_7 or var_8_8

		var_8_9:set_data(self._now_label == 1 and var_8_7 or var_8_8)

		function var_8_9:_set_func(arg_9_1)
			self.mask.lock:SetActive(true)
			self.info_btn:SetActive(false)

			local var_9_0 = var_8_10[arg_9_1 + 1]

			if self._now_label == 1 then
				if (var_8_7 or var_8_8)[1].title ~= var_8_10[1].title then
					return
				end
			end

			for iter_9_0 = 1, #var_8_4 do
				if var_8_4[iter_9_0] == var_9_0.movie_group_id then
					self.mask.lock:SetActive(false)
					self.info_btn:SetActive(true)
				end
			end

			if self._now_label == 1 then
				self.mask.chara_image:SetActive(false)
				self.mask.story_image:SetActive(true)

				self.mask.story_image.image.sprite = self:loadSprite(var_0_6:get_ship_icon(var_0_6.story_icon[1], var_9_0.pic))

				self.info_btn.button.onClick:RemoveAllListeners()
				self.info_btn.button.onClick:AddListener(function()
					self:setVisible(false)
					var_0_3:createInstance("cinema_story_node"):show(var_9_0.movie_group_id)
				end)
				self.mask.lock.button.onClick:RemoveAllListeners()
				self.mask.lock.button.onClick:AddListener(function()
					local var_11_0 = var_0_2:getNowLang("cinema_unlock")
					local var_11_1 = var_0_2:getNowLang("cinema_unlock_1")
					local var_11_2 = var_0_3:getInstance("msgbox")

					var_0_1:set_now_story_info(var_9_0)

					local function var_11_3()
						if var_0_1:_get_six_info().token >= 100 then
							local var_12_0 = {}
							local var_12_1, var_12_2 = var_0_5:get_sequence()

							for iter_12_0, iter_12_1 in ipairs(var_12_1) do
								if iter_12_1.movie_group_id == var_9_0.id then
									var_0_7(var_12_0, iter_12_1)
								end
							end

							table.sort(var_12_0, function(arg_13_0, arg_13_1)
								return arg_13_0.id < arg_13_1.id
							end)
							var_0_1:set_init_story_id(var_12_0[1].id)
							var_0_1:req_TokenUnlockStoryReq(var_12_0[1].id)
						else
							var_0_8:show(var_0_2:getNowLang("token_lack"))
						end
					end

					if var_11_2 then
						var_11_2:show(var_11_1, var_11_3, nil, var_11_0, nil, nil, true)
					else
						var_0_3:createInstance("msgbox"):show(var_11_1, var_11_3, nil, var_11_0, nil, nil, true)
					end
				end)
			else
				local var_9_2 = {}

				self.mask.story_image:SetActive(false)
				self.mask.chara_image:SetActive(true)

				self.mask.chara_image.image.sprite = self:loadSprite(var_0_6:get_ship_icon(var_0_6.story_icon[2], var_9_0.pic))

				local var_9_3, var_9_4 = var_0_10[var_9_0.movie_group_id]:get_sequence()

				self.info_btn.button.onClick:RemoveAllListeners()
				self.info_btn.button.onClick:AddListener(function()
					var_0_3:createInstance("cinema_dialog"):show(var_9_0.movie_group_id, var_9_3[1].step, var_9_3[#var_9_3].step)
				end)
				self.mask.lock.button.onClick:RemoveAllListeners()
				self.mask.lock.button.onClick:AddListener(function()
					var_0_8:show(var_0_2:getNowLang("ui_4th_shop_sort_lock"))
				end)

				for iter_9_1 = 1, #var_8_2 do
					if var_8_2[iter_9_1].type == 2 then
						var_0_7(var_9_2, var_8_2[iter_9_1].id)
					end
				end

				if var_9_2[1] then
					for iter_9_2 = 1, #var_9_2 do
						if var_9_0.movie_group_id == var_9_2[iter_9_2] then
							self.mask.lock:SetActive(false)
							self.info_btn:SetActive(true)
						end
					end
				end
			end
		end
	end

	function arg_1_0:__init_panel(arg_16_1)
		self:show_scroll_by_index(arg_16_1)
		self:init_cell()
		self:init_story_cell_list()

		self._control.btn_group.main_story_btn.txt.text.text = var_0_2:getNowLang("cinemaplayer1")
		self._control.btn_group.chara_story_btn.txt.text.text = var_0_2:getNowLang("cinemaplayer2")
	end

	function arg_1_0:__update_edge_mask_1()
		self._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
	end

	function arg_1_0:__update_edge_mask_2()
		self._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)
	end

	function arg_1_0:__reset_toggle()
		self._control.btn_group.main_story_btn.toggle.isOn = true
		self._control.btn_group.chara_story_btn.toggle.isOn = false
	end

	function arg_1_0:__onReset()
		self._is_already_init = false
		self._now_label = 1

		self:__reset_toggle()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_21_0)
	local var_21_0 = var_0_3:class("cinema_review")

	var_21_0._is_already_init = false
	var_21_0._reusable_cell_1 = nil
	var_21_0._reusable_cell_2 = nil
	var_21_0._now_label = 1

	return var_21_0
end

return var_0_0
