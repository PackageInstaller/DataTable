local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.item_config
local var_0_9 = gamecore.prompt
local var_0_10 = gamecore.util_func

gamecore.UILoader:define("core_list", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:_play_into_se(arg_3_1)
		self:playSE(arg_3_1, false)
	end

	function arg_1_0:update_data(arg_4_1)
		self._data = var_0_3:get_all_items_by_type(var_0_7.ship_item_type.core)

		self:__updata_user_res_1(arg_4_1)
		self:__update_cell(arg_4_1)
	end

	function arg_1_0:__onVisible(arg_5_1)
		if not arg_5_1 then
			return
		end

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.content.bg_layer.title.text.text = var_0_1:getNowLang("evocorelistbtn")

		self:__init_core_list()
		var_0_7:play_in_out_animation(self._control.bg.uITweenSequence, true)
		self:__init_mask_move()
		self:update_data(true)

		self._already_init = true
	end

	function arg_1_0:__init_mask_move()
		self._control.content.bg_layer.mask.glow.rectTransform.anchoredPosition = Vector2(-684, 422)
		self._seq = self:autoKillDOTween(var_0_6.Sequence())

		self._seq:Append(self._control.content.bg_layer.mask.glow.transform:DOBlendableLocalMoveBy(Vector3.New(1368, -945), 3):SetEase(DG.Tweening.Ease.Linear))
		self._seq:SetLoops(-1)
		self._seq:Play()
	end

	function arg_1_0:__init_core_list()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.content.scroll.Viewport.Content.endlessScrollView, self._control.content.scroll.Viewport.Content, "single_core", "core_list")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell(arg_9_1)
		local var_9_0 = {
			{
				id = 10141,
				count = 0
			},
			{
				id = 10241,
				count = 0
			},
			{
				id = 10341,
				count = 0
			},
			{
				id = 10441,
				count = 0
			},
			{
				id = 10541,
				count = 0
			}
		}

		for iter_9_0, iter_9_1 in ipairs(self._data) do
			for iter_9_2, iter_9_3 in ipairs(var_9_0) do
				if iter_9_1.id == iter_9_3.id then
					iter_9_3.count = iter_9_1.count
				end
			end
		end

		if arg_9_1 then
			self._dispose_data = {}
		end

		self._reusable_cell:set_data(var_9_0)

		function self._reusable_cell:_set_func(arg_10_1)
			local var_10_0 = var_9_0[arg_10_1 + 1].id
			local var_10_1 = var_0_8.find_object_by_cid(var_9_0[arg_10_1 + 1].id)

			self.icon_part.icon_btn.image.sprite = self:loadSprite(var_0_4(var_0_7.icon.item_icon, var_9_0[arg_10_1 + 1].id))
			self.normal.core_title.text.text = var_10_1.title
			self.normal.desc.text.text = var_10_1.desc
			self.normal.drop_desc.text.text = var_10_1.drop_desc
			self.normal.diamantle_btn.text.text.text = var_0_1:getNowLang("decompose")
			self.normal.own_item.title.text.text = var_0_1:getNowLang("evoitemown")
			self.normal.own_item.num.text.text = var_9_0[arg_10_1 + 1].count
			self.oper.core_title.text.text = var_0_1:getNowLang("ui_corelisttip1")
			self.oper.confirm_btn.text.text.text = var_0_1:getNowLang("ui_cbtn1")
			self.oper.own_item.title.text.text = var_0_1:getNowLang("evoitemown")
			self.oper.own_item.num.text.text = var_9_0[arg_10_1 + 1].count

			local var_10_2 = {
				self.oper.item_1,
				self.oper.item_2,
				self.oper.item_3,
				self.oper.item_4
			}
			local var_10_3

			if not self._dispose_data[var_10_0] then
				local var_10_4 = {
					num = 0,
					is_click_dispose_btn = false,
					id = var_10_0
				}

				var_10_3 = var_10_4.num
				self._dispose_data[var_10_0] = var_10_4

				self:__res_will_get(var_10_2, var_10_3, var_10_1)
			else
				var_10_3 = self._dispose_data[var_10_0].num

				self:__res_will_get(var_10_2, self._dispose_data[var_10_0].num, var_10_1)
			end

			self.oper.num.text.text = var_10_3

			self.normal:SetActive(not self._dispose_data[var_10_0].is_click_dispose_btn)
			self.oper:SetActive(self._dispose_data[var_10_0].is_click_dispose_btn)
			self.icon_part.icon_btn.button.onClick:RemoveAllListeners()
			self.icon_part.icon_btn.button.onClick:AddListener(function()
				var_0_2:createInstance("item_tip"):show(var_10_1)
			end)
			self.normal.diamantle_btn.button.onClick:RemoveAllListeners()
			self.normal.diamantle_btn.button.onClick:AddListener(function()
				self.normal:SetActive(false)
				self.oper:SetActive(true)

				self._dispose_data[var_10_0].is_click_dispose_btn = true
			end)
			self.oper.confirm_btn.button.onClick:RemoveAllListeners()
			self.oper.confirm_btn.button.onClick:AddListener(function()
				self.normal:SetActive(true)
				self.oper:SetActive(false)

				self._dispose_data[var_10_0].num = 0
				self._dispose_data[var_10_0].is_click_dispose_btn = false

				if var_10_3 == 0 then
					var_0_9:show(var_0_1:getNowLang("amountcantbezero"))
				else
					var_0_3:req_DecomposeCore({
						id = var_10_0,
						count = var_10_3
					})
				end
			end)
			self.oper.add_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.oper.add_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				if var_10_3 >= 999 then
					return
				end

				if var_10_3 + 1 > var_9_0[arg_10_1 + 1].count then
					var_10_3 = var_9_0[arg_10_1 + 1].count or var_10_3 + 1
				end

				self._dispose_data[var_10_0].num = var_10_3
				self.oper.num.text.text = var_10_3

				self:__res_will_get(var_10_2, var_10_3, var_10_1)
			end)
			self.oper.add_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.oper.add_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				if var_10_3 >= 999 then
					return
				end

				if var_10_3 + 1 > var_9_0[arg_10_1 + 1].count then
					var_10_3 = var_9_0[arg_10_1 + 1].count or var_10_3 + 1
				end

				self._dispose_data[var_10_0].num = var_10_3
				self.oper.num.text.text = var_10_3

				self:__res_will_get(var_10_2, var_10_3, var_10_1)
			end)
			self.oper.minus_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.oper.minus_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				if var_10_3 <= 0 then
					return
				end

				var_10_3 = var_10_3 - 1 < 0 and 0 or var_10_3 - 1
				self._dispose_data[var_10_0].num = var_10_3
				self.oper.num.text.text = var_10_3

				self:__res_will_get(var_10_2, var_10_3, var_10_1)
			end)
			self.oper.minus_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.oper.minus_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				if var_10_3 <= 0 then
					return
				end

				var_10_3 = var_10_3 - 1 < 0 and 0 or var_10_3 - 1
				self._dispose_data[var_10_0].num = var_10_3
				self.oper.num.text.text = var_10_3

				self:__res_will_get(var_10_2, var_10_3, var_10_1)
			end)
		end
	end

	function arg_1_0.__res_will_get(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		if not arg_18_2 or arg_18_2 == 0 then
			for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
				iter_18_1.num.text.text = 0
			end
		end

		for iter_18_2, iter_18_3 in pairs(arg_18_3.dismantle) do
			if iter_18_3.id == var_0_7.ship_item_cid.oil then
				arg_18_1[1].num.text.text = iter_18_3.value * arg_18_2
			elseif iter_18_3.id == var_0_7.ship_item_cid.bullet then
				arg_18_1[2].num.text.text = iter_18_3.value * arg_18_2
			elseif iter_18_3.id == var_0_7.ship_item_cid.steel then
				arg_18_1[3].num.text.text = iter_18_3.value * arg_18_2
			elseif iter_18_3.id == var_0_7.ship_item_cid.alum then
				arg_18_1[4].num.text.text = iter_18_3.value * arg_18_2
			end
		end
	end

	function arg_1_0:__updata_user_res_1(arg_19_1)
		local var_19_0 = self._control.content.user_res_1
		local var_19_1 = var_0_3:get_use_info_data()
		local var_19_2 = var_0_10.get_simplify_num(var_19_1.oil)
		local var_19_3 = var_0_10.get_simplify_num(var_19_1.bullet)
		local var_19_4 = var_0_10.get_simplify_num(var_19_1.fe)
		local var_19_5 = var_0_10.get_simplify_num(var_19_1.al)

		if arg_19_1 then
			var_19_0.oil_num.text.text = var_19_2
			var_19_0.bullet_num.text.text = var_19_3
			var_19_0.iron_num.text.text = var_19_4
			var_19_0.mineral_num.text.text = var_19_5
		else
			if tonumber(var_19_2) then
				if var_19_2 > self._orgin_oil then
					var_19_0.oil_num.fontJump:IncreaseAnim(self._orgin_oil, var_19_2)
				end
			else
				var_19_0.oil_num.text.text = var_19_2
			end

			if tonumber(var_19_3) then
				if var_19_3 > self._orgin_bullet then
					var_19_0.bullet_num.fontJump:IncreaseAnim(self._orgin_bullet, var_19_3)
				end
			else
				var_19_0.bullet_num.text.text = var_19_3
			end

			if tonumber(var_19_4) then
				if var_19_4 > self._orgin_fe then
					var_19_0.iron_num.fontJump:IncreaseAnim(self._orgin_fe, var_19_4)
				end
			else
				var_19_0.iron_num.text.text = var_19_4
			end

			if tonumber(var_19_5) then
				if var_19_5 > self._orgin_al then
					var_19_0.mineral_num.fontJump:IncreaseAnim(self._orgin_al, var_19_5)
				end
			else
				var_19_0.mineral_num.text.text = var_19_5
			end
		end

		self:__record_orgin_user_data()
	end

	function arg_1_0.__record_orgin_user_data(arg_20_0)
		local var_20_0 = var_0_3:get_use_info_data()

		arg_20_0._orgin_oil = var_0_10.get_simplify_num(var_20_0.oil)
		arg_20_0._orgin_bullet = var_0_10.get_simplify_num(var_20_0.bullet)
		arg_20_0._orgin_fe = var_0_10.get_simplify_num(var_20_0.fe)
		arg_20_0._orgin_al = var_0_10.get_simplify_num(var_20_0.al)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_21_0)
	local var_21_0 = var_0_2:class("core_list")

	var_21_0._already_init = false
	var_21_0._dispose_data = {}
	var_21_0._reusable_cell = nil
	var_21_0._data = {}
	var_21_0._seq = nil
	var_21_0._orgin_oil = 0
	var_21_0._orgin_bullet = 0
	var_21_0._orgin_fe = 0
	var_21_0._orgin_al = 0

	return var_21_0
end

return var_0_0
