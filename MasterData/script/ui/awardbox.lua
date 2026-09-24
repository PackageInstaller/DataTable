local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_8 = table.sort
local var_0_9 = math.floor
local var_0_10 = gameconfig.tower_map_config
local var_0_11 = gameconfig.ship_config
local var_0_12 = gameconfig.equip_config

gamecore.UILoader:define("awardbox", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show()
		self:setVisible(true)
		self:_init_panel()
	end

	function arg_1_0:_init_panel()
		self:__initial_func()
		self:__init_data()
		self:__init_reusable_cell()
		self:__init_select()
	end

	function arg_1_0:__init_data()
		self._data, self._num = var_0_10.get_sequence()
		self.tips = {
			self._control.awardbox_bg.bottom.tip1,
			self._control.awardbox_bg.bottom.tip2,
			self._control.awardbox_bg.bottom.tip3,
			self._control.awardbox_bg.bottom.tip4,
			self._control.awardbox_bg.bottom.tip5
		}
		self._now_clearance_level = var_0_3:get_tower_max_level()
		self._max_level = var_0_3:get_tower_open_level()

		self:__init_award_page()

		self.__now_page = 1
	end

	function arg_1_0:__init_award_page()
		self.__page_list = {}
		self.__max_page = 0

		local var_6_0 = {}

		for iter_6_0 = 1, self._max_level do
			if iter_6_0 < 10 then
				var_0_7(var_6_0, var_0_10.find_object_by_level(iter_6_0))
			else
				var_0_7(var_6_0, var_0_10.find_object_by_level(iter_6_0))

				self.__max_page = self.__max_page + 1

				var_0_7(self.__page_list, self.__max_page, var_6_0)

				var_6_0 = {}
			end
		end
	end

	function arg_1_0:__init_select()
		self:__init_select_tip()

		self._control.awardbox_bg.middle.awardcontent.scrollview.scrollRect.content.localPosition = Vector2.zero
		self.__now_data = self.__page_list[self.__now_page]

		self._control.awardbox_bg.middle.lefthandle.gameObject:SetActive(self.__now_page > 1)
		self._control.awardbox_bg.middle.righthandle.gameObject:SetActive(self.__now_page < self.__max_page)
		self:__update_cell()
	end

	function arg_1_0:__init_select_tip()
		for iter_8_0 = 1, #self.tips do
			if iter_8_0 <= self.__max_page then
				self.tips[iter_8_0].gameObject:SetActive(true)
			end

			if iter_8_0 == self.__now_page then
				self.tips[self.__now_page].image.sprite = self:loadSprite(var_0_5.tower_award_tips.select_tip)
			else
				self.tips[iter_8_0].image.sprite = self:loadSprite(var_0_5.tower_award_tips.normal_tip)
			end
		end
	end

	function arg_1_0:__init_reusable_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content.endlessScrollView, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content, "awardbox_item", "awardbox")

		self._reusable_cell:init()
	end

	function arg_1_0:sort_awrd_data(arg_10_1)
		if not arg_10_1 then
			return
		end

		local var_10_0 = {}
		local var_10_1 = {}
		local var_10_2 = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			if iter_10_1.id > 10000000 then
				var_0_7(var_10_0, lx.clone_table(iter_10_1))
			elseif iter_10_1.id >= 20 and iter_10_1.id <= 22 then
				var_0_7(var_10_1, lx.clone_table(iter_10_1))
			else
				var_0_7(var_10_2, lx.clone_table(iter_10_1))
			end
		end

		table.sort(var_10_2, function(arg_11_0, arg_11_1)
			local var_11_0

			if arg_11_0 and arg_11_1 then
				::label_11_1::

				var_11_0 = arg_11_0.id and arg_11_1.id and arg_11_0.id < arg_11_1.id
			end

			return var_11_0
		end)

		for iter_10_2, iter_10_3 in pairs(var_10_2) do
			if not self:has_table(var_10_0, iter_10_3) then
				var_0_7(var_10_0, iter_10_3)
			end
		end

		for iter_10_4, iter_10_5 in pairs(var_10_1) do
			if not self:has_table(var_10_0, iter_10_5) then
				var_0_7(var_10_0, iter_10_5)
			end
		end

		return var_10_0
	end

	function arg_1_0.tables_is_same_value(arg_12_0, arg_12_1, arg_12_2)
		if not arg_12_1 or not arg_12_2 then
			return false
		end

		local var_12_0 = 0
		local var_12_1 = 0

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			if arg_12_2[iter_12_0] ~= iter_12_1 then
				return false
			end

			var_12_0 = var_12_0 + 1
		end

		for iter_12_2, iter_12_3 in pairs(arg_12_2) do
			var_12_1 = var_12_1 + 1
		end

		return var_12_0 == var_12_1
	end

	function arg_1_0:has_table(arg_13_1, arg_13_2)
		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if self:tables_is_same_value(iter_13_1, arg_13_2) then
				return true
			end
		end

		return false
	end

	function arg_1_0:__update_cell()
		local var_14_0 = lx.clone_table(self.__now_data)

		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if iter_14_1.award then
				var_14_0[iter_14_0].award = self:sort_awrd_data(var_14_0[iter_14_0].award)
			end
		end

		for iter_14_2, iter_14_3 in pairs(var_14_0) do
			local var_14_1 = lx.clone_table(iter_14_3.award)
			local var_14_2 = {}

			for iter_14_4, iter_14_5 in pairs(var_14_0[iter_14_2].award_icon) do
				if not self:has_table(var_14_1, iter_14_5) then
					var_0_7(var_14_2, lx.clone_table(iter_14_5))
				end
			end

			var_14_0[iter_14_2].award_icon = var_14_1

			for iter_14_6, iter_14_7 in pairs(var_14_2) do
				var_0_7(var_14_0[iter_14_2].award_icon, iter_14_7)
			end
		end

		self._reusable_cell:set_data(var_14_0)

		function self._reusable_cell:_set_func(arg_15_1)
			local var_15_0 = (self.__now_page - 1) * 10 + arg_15_1 + 1
			local var_15_1 = {
				self.left.itemlist.item1,
				self.left.itemlist.item2,
				self.left.itemlist.item3,
				self.left.itemlist.item4,
				self.left.itemlist.item5,
				self.left.itemlist.item6
			}

			self.right.btn.text.text.text = var_0_1:getNowLang("mbtnget")

			for iter_15_0 = 1, #var_15_1 do
				var_15_1[iter_15_0].gameObject:SetActive(false)
			end

			self.left.title.text.text = var_14_0[arg_15_1 + 1].award_title

			for iter_15_1 = 1, #var_14_0[arg_15_1 + 1].award_icon do
				var_15_1[iter_15_1].gameObject:SetActive(true)

				var_15_1[iter_15_1].img.image.sprite = self:loadSprite(var_0_6(var_0_5.normal_str, var_14_0[arg_15_1 + 1].award_icon[iter_15_1].id))

				local var_15_2 = var_14_0[arg_15_1 + 1].award_icon[iter_15_1].value

				if var_14_0[arg_15_1 + 1].award_icon[iter_15_1].value == 1 or var_15_2 == "1" then
					var_15_2 = ""
				end

				var_15_1[iter_15_1].text.text.text = var_15_2

				if var_15_1[iter_15_1].img.image.sprite == nil then
					var_15_1[iter_15_1].img.image.sprite = self:loadSprite(var_0_6(var_0_5.normal_str, 88841))
				end

				local var_15_3 = var_14_0[arg_15_1 + 1].award_icon[iter_15_1].id
				local var_15_4 = var_0_9(var_14_0[arg_15_1 + 1].award_icon[iter_15_1].id % 100)
				local var_15_5 = var_15_4 == 21

				var_15_1[iter_15_1].rewardbg.image.sprite = var_15_4 == 21 and self:loadSprite(var_0_6(var_0_5.ship_equip_pic.equipbg, var_0_12.find_object_by_cid(var_15_3).star)) or self:loadSprite(var_0_5.ship_equip_pic.have_sign)

				var_15_1[iter_15_1].btn.button.onClick:RemoveAllListeners()
				var_15_1[iter_15_1].btn.button.onClick:AddListener(function()
					if var_15_3 < 10000000 then
						var_0_2:createInstance("specificdetails"):show(var_15_3, var_0_5.enter_icon_detail_type.sign)
					elseif var_15_5 then
						self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

						self._equip_attr._panel.transform:SetParent(self._control.detail_shadow.transform)
						self._equip_attr:show((var_0_12.find_object_by_cid(var_15_3)))
						self._control.detail_shadow.gameObject:SetActive(true)
					elseif var_15_4 == 61 then
						-- block empty
					elseif var_15_4 == 72 then
						var_0_2:createInstance("specificdetails"):show(var_15_3, var_0_5.enter_icon_detail_type.combatshop_cook)
					elseif var_15_4 % 100 == 11 or var_15_4 % 100 == 12 or var_15_4 % 100 == 13 then
						var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.bootyshop, (var_0_11.find_object_by_cid(var_15_3)))
					end
				end)
			end

			self.right.btn.gameObject:SetActive(false)
			self.shadow.gameObject:SetActive(false)
			self.right.already.gameObject:SetActive(false)

			if (self.__now_page - 1) * 10 + arg_15_1 + 1 < self._now_clearance_level then
				local var_15_6 = var_0_3:get_tower_data_by_level((self.__now_page - 1) * 10 + arg_15_1 + 1)

				self.right.btn.gameObject:SetActive(var_15_6.get_reward == false)
				self.shadow.gameObject:SetActive(var_15_6.get_reward == true)
				self.right.already.gameObject:SetActive(var_15_6.get_reward == true)
			end

			self.right.btn.button.onClick:RemoveAllListeners()
			self.right.btn.button.onClick:AddListener(function()
				self._now_label = self
				self._now_index = arg_15_1 + 1

				self.right.btn.gameObject:SetActive(false)
				self.shadow.gameObject:SetActive(true)
				self.right.already.gameObject:SetActive(true)
				var_0_3:req_TowerGetRewardReq(var_15_0)
			end)
		end
	end

	function arg_1_0:__award_msgbox_list(arg_18_1, arg_18_2)
		self._control.award_msgbox.gameObject:SetActive(true)
		self._control.award_msgbox.main.gameObject:SetActive(true)

		local var_18_0 = {
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive
		}

		for iter_18_0 = 1, 5 do
			var_18_0[iter_18_0].gameObject:SetActive(false)
		end

		local var_18_1 = {}
		local var_18_2 = {}

		for iter_18_1, iter_18_2 in pairs(arg_18_1) do
			var_0_7(var_18_2, iter_18_2)
		end

		for iter_18_3, iter_18_4 in pairs(var_18_2) do
			if iter_18_4.type ~= 4 and iter_18_4.type ~= 1 and iter_18_4.id ~= 13 then
				var_0_7(var_18_1, iter_18_4)
			end
		end

		var_0_8(var_18_1, function(arg_19_0, arg_19_1)
			return arg_19_0.id < arg_19_1.id
		end)

		for iter_18_5 = 1, #var_18_1 do
			local var_18_3 = gameconfig.item_config.find_object_by_cid(var_18_1[iter_18_5].id).title

			var_18_0[iter_18_5].gameObject:SetActive(true)
			var_18_0[iter_18_5].title_mask:GetComponent("TextHorizonScroller"):SetText(var_18_3)

			var_18_0[iter_18_5].icon.image.sprite = self:loadSprite(var_0_6(var_0_5.icon.item_icon, var_18_1[iter_18_5].id))

			if var_18_1[iter_18_5].count == 1 then
				var_18_0[iter_18_5].number.text.text = nil
			else
				var_18_0[iter_18_5].number.text.text = var_18_1[iter_18_5].count
			end
		end

		if arg_18_2 then
			self._control.award_msgbox.main.confirm.button.onClick:RemoveAllListeners()
			self._control.award_msgbox.main.confirm.button.onClick:AddListener(function()
				self._control.award_msgbox:SetActive(false)
				arg_18_2()
			end)
		end
	end

	function arg_1_0:_play_into_se(arg_21_1)
		self:playSE(arg_21_1, false)
	end

	function arg_1_0:__initial_func()
		local var_22_0 = {
			{
				nodetext = "mbtnget",
				node = self._control.awardbox_bg.top.toptitle.text
			},
			{
				nodetext = "mbtnget",
				node = self._control.awardbox_bg.top.topdescribe.prestigedes_text
			},
			{
				nodetext = "mbtnget",
				node = self._control.award_msgbox.main.title_text
			},
			{
				nodetext = "confirm",
				node = self._control.award_msgbox.main.confirm.text
			}
		}
		local var_22_1 = {
			{
				state = false,
				node = self._control.awardbox_bg.bottom.tip1
			},
			{
				state = false,
				node = self._control.awardbox_bg.bottom.tip2
			},
			{
				state = false,
				node = self._control.awardbox_bg.bottom.tip3
			},
			{
				state = false,
				node = self._control.awardbox_bg.bottom.tip4
			},
			{
				state = false,
				node = self._control.awardbox_bg.bottom.tip5
			},
			{
				state = false,
				node = self._control.awardbox_bg.middle.lefthandle
			},
			{
				state = true,
				node = self._control.awardbox_bg.middle.righthandle
			},
			{
				state = false,
				node = self._control.detail_shadow
			},
			{
				state = false,
				node = self._control.award_msgbox
			}
		}
		local var_22_2 = {
			init_language = function(self, arg_23_1)
				self.text.text = var_0_1:getNowLang(arg_23_1)
			end,
			init_active = function(self, arg_24_1)
				self.gameObject:SetActive(arg_24_1)
			end
		}

		for iter_22_0 = 1, #var_22_0 do
			var_22_2.init_language(var_22_0[iter_22_0].node, var_22_0[iter_22_0].nodetext)
		end

		for iter_22_1 = 1, #var_22_1 do
			var_22_2.init_active(var_22_1[iter_22_1].node, var_22_1[iter_22_1].state)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_25_0)
	local var_25_0 = var_0_2:class("awardbox")

	var_25_0._data = nil
	var_25_0.__page_list = nil
	var_25_0.__now_page = nil
	var_25_0.__now_data = nil
	var_25_0.__max_page = nil
	var_25_0.tips = {}
	var_25_0._max_level = nil

	gamecore.extend_obj(var_25_0)

	return var_25_0
end

return var_0_0
