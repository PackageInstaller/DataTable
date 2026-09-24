local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.UILoader
local var_0_8 = string.format
local var_0_10 = gamecore.util_func
local var_0_11 = lx.clone_table
local var_0_12 = gameenum.common_type
local var_0_14 = gameconfig.ship_config
local var_0_15 = gameconfig.equip_config
local var_0_17 = gameconfig.pve_ninth_award_config
local var_0_18 = {
	[21] = 4,
	[61] = 7,
	[81] = 5,
	[11] = 3,
	[12] = 2,
	[43] = 6,
	[13] = 1,
	[82] = 8
}

gamecore.UILoader:define("ninth_awardbox", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_language()
		self._control.awardbox_bg.top.toptitle.title.text.text = var_0_6:getNowLang("mbtnget")
		self._control.awardbox_bg.top.topdescribe.des_text.text.text = var_0_6:getNowLang("ninth_award_1")
	end

	function arg_1_0:__init_panel(arg_5_1)
		local var_5_0 = var_0_7:getInstance("ninth_main_map")

		if var_5_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_5_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self:__init_language()
		self:__init_data()
		self:__init_reusable_cell()
		self:__update_award_cell()
	end

	function arg_1_0:__init_data()
		self._award_data, self._award_num = var_0_17.get_sequence()
		self._ninth_user_point = var_0_1:get_ninth_score_info()
		self._control.awardbox_bg.top.topdescribe.point_text.text.text = self._ninth_user_point

		for iter_6_0 = 1, #self._award_data do
			for iter_6_1 = 1, #self._award_data[iter_6_0].award do
				var_0_2(self._award_data[iter_6_0].award, function(arg_7_0, arg_7_1)
					return arg_7_0.id > arg_7_1.id
				end)
			end
		end
	end

	function arg_1_0:__init_reusable_cell()
		self:destroyChildren("ninth_awardbox_item")

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content.endlessScrollView, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content, "ninth_awardbox_item", "ninth_awardbox")

		self._reusable_cell:init()
	end

	function arg_1_0._have_data(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = false

		if arg_9_1 and next(arg_9_1) then
			for iter_9_0, iter_9_1 in pairs(arg_9_1) do
				if iter_9_1.id == arg_9_2 then
					var_9_0 = true
				end
			end
		end

		return var_9_0
	end

	function arg_1_0._have_data_2(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = false

		if arg_10_1 and next(arg_10_1) then
			for iter_10_0, iter_10_1 in pairs(arg_10_1) do
				if iter_10_1 == arg_10_2 then
					var_10_0 = true
				end
			end
		end

		return var_10_0
	end

	function arg_1_0:__update_award_cell()
		for iter_11_0 = 1, #self._award_data do
			for iter_11_1 = 1, #self._award_data[iter_11_0].award do
				self._award_data[iter_11_0].award[iter_11_1].sort_id = var_0_18[self._award_data[iter_11_0].award[iter_11_1].id % 100] == nil and 99 or var_0_18[self._award_data[iter_11_0].award[iter_11_1].id % 100]
			end

			var_0_2(self._award_data[iter_11_0].award, function(arg_12_0, arg_12_1)
				return arg_12_0.sort_id < arg_12_1.sort_id
			end)
		end

		local var_11_0 = var_0_11((var_0_1:get_ninth_award_data()))
		local var_11_1 = var_0_11(self._award_data)

		if var_11_0 and next(var_11_0) then
			for iter_11_2, iter_11_3 in pairs(var_11_1) do
				iter_11_3.already_get = var_0_10.have_data(var_11_0, iter_11_3.id) and 1 or 0
			end

			var_0_2(var_11_1, function(arg_13_0, arg_13_1)
				if arg_13_0.already_get == arg_13_1.already_get then
					return arg_13_0.id < arg_13_1.id
				else
					return arg_13_0.already_get < arg_13_1.already_get
				end
			end)
		end

		local var_11_2 = var_0_11(var_11_1)

		self._reusable_cell:set_data(var_11_2)

		function self._reusable_cell:_set_func(arg_14_1)
			local var_14_0 = {
				self.left.itemlist.item1,
				self.left.itemlist.item2,
				self.left.itemlist.item3,
				self.left.itemlist.item4,
				self.left.itemlist.item5,
				self.left.itemlist.item6
			}

			self.left.topdescribe.des_text.text.text = var_0_6:getNowLang("ninth_award_2")
			self.left.topdescribe.des_text.point_text.text.text = var_11_2[arg_14_1 + 1].score

			for iter_14_0 = 1, #var_14_0 do
				var_14_0[iter_14_0].gameObject:SetActive(false)
			end

			self.shadow.gameObject:SetActive(false)
			self.right.already.gameObject:SetActive(false)
			self.right.btn.gameObject:SetActive(self._ninth_user_point >= var_11_2[arg_14_1 + 1].score)
			self.right.lock.gameObject:SetActive(self._ninth_user_point < var_11_2[arg_14_1 + 1].score)

			if var_11_2[arg_14_1 + 1].level_id > 0 then
				self.left.topdescribe.des_text.text.text = var_0_6:getNowLang("ninth_award_2") .. var_11_2[arg_14_1 + 1].title

				local var_14_1 = var_0_1:get_ninth_map_data()

				if var_14_1 and next(var_14_1) then
					if var_14_1[var_11_2[arg_14_1 + 1].level_id] and var_14_1[var_11_2[arg_14_1 + 1].level_id].state == 2 and self._ninth_user_point >= var_11_2[arg_14_1 + 1].score then
						self.right.btn.gameObject:SetActive(true)
					else
						self.right.btn.gameObject:SetActive(false)
					end
				else
					self.right.btn.gameObject:SetActive(false)
				end
			end

			if self:_have_data_2(var_11_0, var_11_2[arg_14_1 + 1].id) then
				self.right.btn.gameObject:SetActive(false)
				self.right.already.gameObject:SetActive(true)
			end

			for iter_14_1, iter_14_2 in pairs(var_11_2[arg_14_1 + 1].award) do
				local var_14_2 = var_11_2[arg_14_1 + 1].award[iter_14_1].id

				var_14_0[iter_14_1].gameObject:SetActive(true)

				var_14_0[iter_14_1].rewardbg.image.sprite = self:loadSprite((var_0_10.get_item_star_bg_by_item_id(var_11_2[arg_14_1 + 1].award[iter_14_1].id)))
				var_14_0[iter_14_1].img.image.sprite = self:loadSprite(var_0_8(var_0_12.normal_str, var_11_2[arg_14_1 + 1].award[iter_14_1].id))

				if var_11_2[arg_14_1 + 1].award[iter_14_1].count > 1 then
					var_14_0[iter_14_1].text.gameObject:SetActive(true)

					var_14_0[iter_14_1].text.text.text = var_11_2[arg_14_1 + 1].award[iter_14_1].count
				else
					var_14_0[iter_14_1].text.gameObject:SetActive(false)
				end

				var_14_0[iter_14_1].btn.button.onClick:RemoveAllListeners()
				var_14_0[iter_14_1].btn.button.onClick:AddListener(function()
					if var_14_2 > 10000000 and var_14_2 % 100 == 61 then
						return
					end

					if var_14_2 < 10000000 then
						if var_14_2 % 100 == 81 then
							var_0_7:createInstance("specificdetails"):show(var_14_2, var_0_12.enter_icon_detail_type.combatshop_cg)
						else
							var_0_7:createInstance("specificdetails"):show(var_14_2, var_0_12.enter_icon_detail_type.sign)
						end
					elseif var_14_2 % 100 == 21 then
						local var_15_0 = var_0_15.find_object_by_cid(var_14_2)

						if not self._equip_attr then
							self._equip_attr = self:loadUI("equip_attr")
						else
							self._equip_attr = {}
							self._equip_attr = self:loadUI("equip_attr")
						end

						self._equip_attr._panel.transform:SetParent(self._control.detail_shadow.rectTransform, false)

						self._equip_attr._panel.transform.anchoredPosition = Vector2.New(-63, -66)
						self._equip_attr._panel.transform.anchoredPosition = Vector2.New(self._equip_attr._panel.transform.anchoredPosition.x, self._equip_attr._panel.transform.anchoredPosition.y < -117 and -117 or self._equip_attr._panel.transform.anchoredPosition.y)

						self._equip_attr:show(var_15_0)
						self._control.detail_shadow.gameObject:SetActive(true)
					else
						var_0_7:createInstance("ship_detail"):show(var_0_12.enter_ship_detail_type.bootyshop, (var_0_14.find_object_by_cid(var_14_2)))
					end
				end)
				self.right.btn.button.onClick:RemoveAllListeners()
				self.right.btn.button.onClick:AddListener(function()
					self.right.btn.gameObject:SetActive(false)
					self.right.lock.gameObject:SetActive(false)
					self.shadow.gameObject:SetActive(true)
					self.right.already.gameObject:SetActive(true)

					self._award_id = var_11_2[arg_14_1 + 1].id

					var_0_1:req_NinthGetAwardReq(self._award_id)
				end)
			end
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_18_0)
		arg_1_0._reusable_cell = {}
		arg_1_0._award_data = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_19_0)
	local var_19_0 = var_0_7:class("ninth_awardbox")

	var_19_0:__initia_lize()

	var_19_0._reusable_cell = {}
	var_19_0._award_data = {}
	var_19_0._award_id = nil
	var_19_0._ninth_user_point = 0

	return var_19_0
end

return var_0_0
