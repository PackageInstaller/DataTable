local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = string.format
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = UnityEngine.Vector2
local var_0_7 = gamecore.util_func
local var_0_8 = gameenum.common_type
local var_0_9 = gameconfig.ship_config
local var_0_10 = gameconfig.equip_config

gamecore.UILoader:define("ship_available", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1, arg_3_2)
		if arg_3_1 == var_0_8.go_to_ship_available.build_go or self._now_type == var_0_8.go_to_ship_available.equip_go then
			self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.open))
		end

		self:setVisible(true)

		self._now_data = arg_3_2
		self._now_type = arg_3_1

		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		var_0_8:play_in_out_animation(self._control.bg.uITweenSequence, true, function()
			self:__init_mask_move()
		end)

		if arg_4_1 == var_0_8.go_to_ship_available.build_go then
			self._control.content.bg_layer.title_bg.title.text.text = var_0_3:getNowLang("build_access_desc")
		elseif arg_4_1 == var_0_8.go_to_ship_available.main_go then
			self._control.content.bg_layer.title_bg.title.text.text = var_0_3:getNowLang("map_access_desc")
		elseif arg_4_1 == var_0_8.go_to_ship_available.sixth_go then
			self._control.content.bg_layer.title_bg.title.text.text = var_0_3:getNowLang("combat_access_desc")
		elseif self._now_type == var_0_8.go_to_ship_available.equip_go then
			self._control.content.bg_layer.title_bg.title.text.text = var_0_3:getNowLang("develop_access_desc")
		end

		if arg_4_1 == var_0_8.go_to_ship_available.main_go and (not self._now_data.drop_id or not next(self._now_data.drop_id)) then
			self._control.content.scroll:SetActive(false)

			return
		end

		self._control.content.scroll:SetActive(true)

		self._control.content.scroll.Viewport.Content.transform.anchoredPosition = var_0_6(0, 0)
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.content.scroll.Viewport.Content.endlessScrollView, self._control.content.scroll.Viewport.Content, "single_ship_available", "ship_available")

		self._reusable_cell:init()
		self:__update_cell()
	end

	function arg_1_0:__update_cell()
		local var_6_0 = {}

		if self._now_type == var_0_8.go_to_ship_available.main_go then
			var_6_0 = self._now_data.drop_id
		elseif self._now_type == var_0_8.go_to_ship_available.sixth_go then
			var_6_0 = self._now_data
		elseif self._now_type == var_0_8.go_to_ship_available.build_go or self._now_type == var_0_8.go_to_ship_available.equip_go then
			var_6_0 = self._now_data
		end

		if not var_6_0 or not next(var_6_0) then
			return
		end

		self._already_list = {}

		if self._now_type == var_0_8.go_to_ship_available.build_go or self._now_type == var_0_8.go_to_ship_available.sixth_go or self._now_type == var_0_8.go_to_ship_available.main_go then
			local var_6_1 = var_0_1:get_cardbook_ship_list()

			for iter_6_0, iter_6_1 in pairs(var_6_0) do
				self._already_list[iter_6_1] = 0

				for iter_6_2, iter_6_3 in pairs(var_6_1) do
					if iter_6_3.id == iter_6_1 then
						self._already_list[iter_6_1] = 1

						break
					end
				end
			end

			table.sort(var_6_0, function(arg_7_0, arg_7_1)
				if self._already_list[arg_7_0] ~= self._already_list[arg_7_1] then
					return self._already_list[arg_7_0] < self._already_list[arg_7_1]
				else
					local var_7_0 = var_0_9.find_object_by_cid(arg_7_0)
					local var_7_1 = var_0_9.find_object_by_cid(arg_7_1)

					if var_7_0.star ~= var_7_1.star then
						return var_7_0.star > var_7_1.star
					else
						return var_7_0.cid > var_7_1.cid
					end
				end
			end)
		elseif self._now_type == var_0_8.go_to_ship_available.equip_go then
			local var_6_2 = var_0_1:get_cardbook_equip_list()

			for iter_6_4, iter_6_5 in pairs(var_6_0) do
				self._already_list[iter_6_5] = 0

				for iter_6_6, iter_6_7 in pairs(var_6_2) do
					if var_0_7.have_data(var_6_2, iter_6_5) then
						self._already_list[iter_6_5] = 1

						break
					end
				end
			end

			table.sort(var_6_0, function(arg_8_0, arg_8_1)
				if self._already_list[arg_8_0] ~= self._already_list[arg_8_1] then
					return self._already_list[arg_8_0] < self._already_list[arg_8_1]
				else
					local var_8_0 = var_0_10.find_object_by_cid(arg_8_0)
					local var_8_1 = var_0_10.find_object_by_cid(arg_8_1)

					if var_8_0.star ~= var_8_1.star then
						return var_8_0.star > var_8_1.star
					else
						return var_8_0.cid > var_8_1.cid
					end
				end
			end)
		end

		self._reusable_cell:set_data(var_6_0)

		function self._reusable_cell:_set_func(arg_9_1)
			if self._now_type == var_0_8.go_to_ship_available.build_go or self._now_type == var_0_8.go_to_ship_available.sixth_go or self._now_type == var_0_8.go_to_ship_available.main_go then
				local var_9_0 = var_0_9.find_object_by_cid(var_6_0[arg_9_1 + 1])

				self.model.mask.icon:SetActive(true)
				self.model.mask.not_get_btn:SetActive(self._already_list[var_6_0[arg_9_1 + 1]] == 0)

				self.model.mask.not_get_btn.Text.text.text = var_0_3:getNowLang("medaltypeungain")

				self.model.mask.already_get_btn:SetActive(self._already_list[var_6_0[arg_9_1 + 1]] ~= 0)

				self.model.mask.icon.image.sprite = self:loadSprite(var_0_4(var_0_8.normal_str, var_6_0[arg_9_1 + 1]))
				self.model.bg.image.sprite = self:loadSprite(var_0_4(var_0_8.equip_back.equip_back_normal, var_9_0.star))

				self.model.mask.not_get_btn.button.onClick:RemoveAllListeners()
				self.model.mask.not_get_btn.button.onClick:AddListener(function()
					self:setVisible(false)
					var_0_2:createInstance("ship_detail"):show(var_0_8.enter_ship_detail_type.ship_map, var_9_0, nil, nil, 1, false)
				end)
				self.model.mask.already_get_btn.button.onClick:RemoveAllListeners()
				self.model.mask.already_get_btn.button.onClick:AddListener(function()
					self:setVisible(false)
					var_0_2:createInstance("ship_detail"):show(var_0_8.enter_ship_detail_type.ship_map, var_9_0, nil, nil, 1, false)
				end)
			elseif self._now_type == var_0_8.go_to_ship_available.equip_go then
				local var_9_1 = var_0_10.find_object_by_cid(var_6_0[arg_9_1 + 1])

				self.model.mask.icon:SetActive(true)
				self.model.mask.not_get_btn:SetActive(self._already_list[var_6_0[arg_9_1 + 1]] == 0)

				self.model.mask.not_get_btn.Text.text.text = var_0_3:getNowLang("medaltypeungain")

				self.model.mask.already_get_btn:SetActive(self._already_list[var_6_0[arg_9_1 + 1]] ~= 0)

				self.model.mask.icon.image.sprite = self:loadSprite(var_0_8:get_ship_icon(var_0_8.equip_icon.large, var_9_1.pic_id))
				self.model.bg.image.sprite = self:loadSprite(var_0_4(var_0_8.equip_back.equip_back_normal, var_9_1.star))

				self.model.mask.not_get_btn.button.onClick:RemoveAllListeners()
				self.model.mask.not_get_btn.button.onClick:AddListener(function()
					self:setVisible(false)
					var_0_2:createInstance("equip_datail"):show(1, var_9_1)
				end)
				self.model.mask.already_get_btn.button.onClick:RemoveAllListeners()
				self.model.mask.already_get_btn.button.onClick:AddListener(function()
					self:setVisible(false)
					var_0_2:createInstance("equip_datail"):show(1, var_9_1)
				end)
			end
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_15_0)
		return
	end

	function arg_1_0:__init_mask_move()
		self._control.content.bg_layer.mask.glow:SetActive(true)

		self._control.content.bg_layer.mask.glow.rectTransform.anchoredPosition = var_0_6(-684, 422)
		self._seq = self:autoKillDOTween(var_0_5.Sequence())

		self._seq:Append(self._control.content.bg_layer.mask.glow.transform:DOBlendableLocalMoveBy(Vector3.New(1368, -945), 3):SetEase(DG.Tweening.Ease.Linear))
		self._seq:SetLoops(-1)
		self._seq:Play()
	end

	function arg_1_0:__pause_mask_move()
		self._control.content.bg_layer.mask.glow:SetActive(false)
	end

	function arg_1_0:_play_into_se(arg_18_1)
		self:playSE(arg_18_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_19_0)
	local var_19_0 = var_0_2:class("ship_available")

	var_19_0._reusable_cell = nil
	var_19_0._now_data = nil
	var_19_0._now_type = nil
	var_19_0._already_list = nil
	var_19_0._equip_config = nil

	var_19_0:__initia_lize()

	return var_19_0
end

return var_0_0
