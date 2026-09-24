local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.prompt
local var_0_5 = gameenum.common_type
local var_0_6 = table.insert
local var_0_7 = table.remove
local var_0_8 = table.sort
local var_0_9 = string.format
local var_0_10 = gameconfig.ship_config
local var_0_11 = gameconfig.combats_shop_config
local var_0_12 = gameconfig.equip_config
local var_0_13 = gameconfig.skin_config
local var_0_14 = lx.clone_table
local var_0_15 = UnityEngine.Vector2

gamecore.UILoader:define("combat_shop", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self._enter_type = arg_2_1

		self:setVisible(true)
		self:_init_panel()
	end

	function arg_1_0:_init_panel()
		self:__initial_func()
		self:_update_data()
		self:_init_combat_list()
		self:_init_select()

		self.__already_init = true
	end

	function arg_1_0:__is_already_init()
		return self.__already_init
	end

	function arg_1_0:__set_scroll_to_top()
		self._scroll_bar = self._scroll_bar or self._control.mainprops.scrollview.scrollbarvertical:GetComponent("Scrollbar")
		self._scroll_bar.value = 1
	end

	function arg_1_0:__initial_func()
		local function var_6_0(arg_7_0)
			var_0_8(arg_7_0, function(arg_8_0, arg_8_1)
				return arg_8_0.award_cid > arg_8_1.award_cid
			end)

			return arg_7_0
		end

		local var_6_1 = {
			{
				nodetext = "shiptype0",
				node = self._control.maintop.topmenu.topbtn.btnone.text
			},
			{
				nodetext = "te",
				node = self._control.maintop.topmenu.topbtn.btntwo.text
			},
			{
				nodetext = "shopitem",
				node = self._control.maintop.topmenu.topbtn.btnthree.text
			},
			{
				nodetext = "tsh",
				node = self._control.maintop.topmenu.topbtn.btnfour.text
			},
			{
				nodetext = "to",
				node = self._control.maintop.topmenu.topbtn.btnfive.text
			},
			{
				nodetext = "shopbuyconfirmtitle",
				node = self._control.shop_bounced.main.title_text
			},
			{
				nodetext = "space_confirm",
				node = self._control.shop_bounced.main.confirmbtn.text
			},
			{
				nodetext = "ui_cbtn2",
				node = self._control.shop_bounced.main.quitbtn.text
			}
		}
		local var_6_2 = {
			{
				state = false,
				node = self._control.shop_bounced
			}
		}
		local var_6_3 = {
			init_language = function(self, arg_11_1)
				self.text.text = var_0_3:getNowLang(arg_11_1)
			end,
			init_active = function(self, arg_12_1)
				self.gameObject:SetActive(arg_12_1)
			end
		}

		;(function()
			self._sixth_data = var_0_1:_get_six_info()
			self._big_map_info = var_0_1:get_sixth_bigmap_info()

			local var_9_0, var_9_1 = var_0_11:get_sequence()
			local var_9_2 = {}
			local var_9_3 = lx.ServerTime:getUtcTime()

			for iter_9_0, iter_9_1 in pairs((var_6_0(var_0_14(var_9_0)))) do
				if iter_9_1.start_time == 0 or var_9_3 > iter_9_1.start_time and var_9_3 < iter_9_1.end_time then
					var_0_6(var_9_2, iter_9_1)
				end
			end

			local var_9_4 = {}
			local var_9_5 = {}
			local var_9_6 = {}
			local var_9_7 = {}
			local var_9_8 = {}

			for iter_9_2, iter_9_3 in pairs(var_9_2) do
				if iter_9_3.start_time ~= 0 and (iter_9_3.unlock == 0 or iter_9_3.unlock == self._big_map_info.id) then
					var_0_6(var_9_4, iter_9_3)
				elseif iter_9_3.start_time ~= 0 and iter_9_3.unlock ~= self._big_map_info.id then
					var_0_6(var_9_5, iter_9_3)
				elseif iter_9_3.start_time == 0 and (iter_9_3.unlock == 0 or iter_9_3.unlock == self._big_map_info.id) then
					var_0_6(var_9_6, iter_9_3)
				elseif iter_9_3.start_time == 0 and iter_9_3.unlock ~= self._big_map_info.id then
					var_0_6(var_9_7, iter_9_3)
				end
			end

			for iter_9_4, iter_9_5 in pairs(var_9_4) do
				var_0_6(var_9_8, iter_9_5)
			end

			for iter_9_6, iter_9_7 in pairs(var_9_5) do
				var_0_6(var_9_8, iter_9_7)
			end

			for iter_9_8, iter_9_9 in pairs(var_9_6) do
				var_0_6(var_9_8, iter_9_9)
			end

			for iter_9_10, iter_9_11 in pairs(var_9_7) do
				var_0_6(var_9_8, iter_9_11)
			end

			self._data = var_9_8
		end)()
		;(function()
			self._control.maintop.topmenu.combat.combat_num.text.text = self._sixth_data.token
		end)()

		for iter_6_0 = 1, #var_6_1 do
			var_6_3.init_language(var_6_1[iter_6_0].node, var_6_1[iter_6_0].nodetext)
		end

		for iter_6_1 = 1, #var_6_2 do
			var_6_3.init_active(var_6_2[iter_6_1].node, var_6_2[iter_6_1].state)
		end

		var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	function arg_1_0:_play_into_se(arg_13_1)
		self:playSE(arg_13_1, false)
	end

	function arg_1_0:_update_data()
		self:_equip_data()
		self:__update_combats_data()
	end

	function arg_1_0:_equip_data()
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in pairs((var_0_1:get_equipment_list())) do
			var_0_6(var_15_0, iter_15_1)
		end

		for iter_15_2, iter_15_3 in pairs(var_15_0) do
			self:__is_have_equip(iter_15_3.id)
		end
	end

	function arg_1_0:__is_have_equip(arg_16_1)
		for iter_16_0, iter_16_1 in pairs(self._data) do
			if iter_16_1.type == 1 and iter_16_1.is_is_unique and iter_16_1.award_cid == arg_16_1 then
				var_0_7(self._data, iter_16_0)
			end
		end
	end

	function arg_1_0:__update_combats_data()
		self._new_data = var_0_1:get_combats_list()
		self._new_data_array = {}

		for iter_17_0, iter_17_1 in pairs(self._new_data) do
			var_0_6(self._new_data_array, iter_17_1)
		end

		self.__now_all_data = self._data

		for iter_17_2 = 1, #self.__now_all_data do
			if self.__now_all_data[iter_17_2] ~= nil and self.__now_all_data[iter_17_2].limit_num == 0 then
				var_0_7(self.__now_all_data[iter_17_2], iter_17_2)
			end
		end

		for iter_17_3, iter_17_4 in pairs(self._new_data_array) do
			if iter_17_4.id ~= nil then
				self:__set_limit_combats_data(iter_17_4.id, iter_17_4.buy_count)
			end
		end

		self:__set_now_data_by_type(self.__now_all_data)
	end

	function arg_1_0:__set_limit_combats_data(arg_18_1, arg_18_2)
		local var_18_0 = 0
		local var_18_2 = 0

		for iter_18_0, iter_18_1 in pairs(self._data) do
			if iter_18_1.id == arg_18_1 then
				var_18_0 = iter_18_0
				var_18_2 = var_0_11.find_object_by_id(iter_18_1.id).limit_num
			end
		end

		if var_18_2 - arg_18_2 <= 0 and var_18_0 > 0 then
			var_0_7(self._data, var_18_0)
		elseif var_18_2 - arg_18_2 > 0 and var_18_0 > 0 then
			self._data[var_18_0].limit_num = var_18_2 - arg_18_2
		end
	end

	function arg_1_0:__set_now_data_by_type(arg_19_1)
		local var_19_0 = {}
		local var_19_1 = {}
		local var_19_2 = {}
		local var_19_3 = {}

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			if iter_19_1.sort == 1 then
				var_0_6(var_19_0, iter_19_1)
			elseif iter_19_1.sort == 2 then
				var_0_6(var_19_1, iter_19_1)
			elseif iter_19_1.sort == 3 then
				var_0_6(var_19_2, iter_19_1)
			elseif iter_19_1.sort == 4 then
				var_0_6(var_19_3, iter_19_1)
			end
		end

		self.__data_by_type = {
			arg_19_1,
			var_19_0,
			var_19_1,
			var_19_2,
			var_19_3
		}

		if self._now_content_name then
			self:__set_current_content_and_data(self._now_content_name)
		end
	end

	function arg_1_0:_init_select()
		if self.__now_content then
			self.__now_content.toggle.isOn = false
		end

		self:__select_one("btnone", true)

		self.__now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_21_1, arg_21_2)
		if self.__now_label == arg_21_1 and not arg_21_2 then
			return
		end

		self.__now_label = arg_21_1

		if self.__now_content then
			self.__last_content = self.__now_content

			self:__set_title_style(self.__now_content, false)
		end

		self:__set_current_content_and_data(arg_21_1)
		self:__set_title_style(self.__now_content, true)

		if self.__last_content then
			var_0_5:play_in_out_animation(self.__last_content.uITweenSequence, false, function()
				var_0_5:play_in_out_animation(self.__now_content.uITweenSequence, true, nil)
			end)
		else
			var_0_5:play_in_out_animation(self.__now_content.uITweenSequence, true, nil)
		end

		self:__set_scroll_to_top()
	end

	function arg_1_0:__set_current_content_and_data(arg_23_1)
		self._now_content_name = arg_23_1

		if arg_23_1 == "btnone" then
			self.__now_content = self._control.maintop.topmenu.topbtn.btnone
			self.__now_data = self.__data_by_type[1]
		elseif arg_23_1 == "btntwo" then
			self.__now_content = self._control.maintop.topmenu.topbtn.btntwo
			self.__now_data = self.__data_by_type[2]
		elseif arg_23_1 == "btnthree" then
			self.__now_content = self._control.maintop.topmenu.topbtn.btnthree
			self.__now_data = self.__data_by_type[3]
		elseif arg_23_1 == "btnfour" then
			self.__now_content = self._control.maintop.topmenu.topbtn.btnfour
			self.__now_data = self.__data_by_type[4]
		elseif arg_23_1 == "btnfive" then
			self.__now_content = self._control.maintop.topmenu.topbtn.btnfive
			self.__now_data = self.__data_by_type[5]
		end

		self:__update_cell()
		self:__set_scroll_to_top()
	end

	function arg_1_0.__set_title_style(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_2 then
			arg_24_1.text.text.fontSize = 28
			arg_24_1.text.text.color = Color.New(1, 1, 1)
		else
			arg_24_1.text.text.fontSize = 26
			arg_24_1.text.text.color = Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373, 0.6666666666666666)
		end
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:_init_combat_list()
		if self.__already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainprops.scrollview.viewport.content.endlessScrollView, self._control.mainprops.scrollview.viewport.content, "single_mall_item", "combat_shop")

		self._reusable_cell:init()
		self:__is_already_init()
	end

	function arg_1_0:__update_cell()
		local var_27_0 = self.__now_data

		self._reusable_cell:set_data(self.__now_data)

		function self._reusable_cell:_set_func(arg_28_1)
			if var_27_0[arg_28_1 + 1].start_time ~= 0 then
				self.label.gameObject:SetActive(true)

				self.label.label_des.text.text = var_0_3:getNowLang("limittimetitle")
			else
				self.label.gameObject:SetActive(false)
			end

			self.bg_lock.gameObject:SetActive(var_27_0[arg_28_1 + 1].unlock ~= 0)

			self.bg_lock.desc.desctext.text.text = var_27_0[arg_28_1 + 1].unlock_desc

			local var_28_0 = var_0_1:find_prev_bigmap(var_27_0[arg_28_1 + 1].unlock)

			if var_28_0 and var_28_0.state >= var_0_5.level_state.complete then
				self.bg_lock.gameObject:SetActive(false)
			end

			self.name_mask.equipname.text.text = var_27_0[arg_28_1 + 1].title

			self.name_mask:GetComponent("TextHorizonScroller"):SetText(var_27_0[arg_28_1 + 1].title)
			self.pricebtn.priceimg:SetActive(false)
			self.pricebtn.tokenimg:SetActive(true)

			self.pricebtn.pricenumber.text.text = var_27_0[arg_28_1 + 1].combats
			self.numberof.text.text = var_27_0[arg_28_1 + 1].remain_num and var_0_9(var_0_3:getNowLang("remain_num"), var_27_0[arg_28_1 + 1].limit_num) or var_27_0[arg_28_1 + 1].brief
			self.equipimg.bg.image.sprite = self:loadSprite(var_0_9(var_0_5.ship_equip_pic.equipbg, 0))
			self.equipimg.img.image.sprite = self:loadSprite(var_0_9(var_0_5.buy_combats_icon, var_27_0[arg_28_1 + 1].icon))

			self.equipimg.imgbtn.button.onClick:RemoveAllListeners()
			self.equipimg.imgbtn.button.onClick:AddListener(function()
				if var_27_0[arg_28_1 + 1].type == 1 then
					local var_29_0 = var_0_12.find_object_by_cid(var_27_0[arg_28_1 + 1].award_cid)

					self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

					self._equip_attr._panel.transform:SetParent(self.equipimg.rectTransform, false)

					self._equip_attr._panel.transform.anchoredPosition = var_0_15.New(-63, -66)

					self._equip_attr._panel.transform:SetParent(self._control.mainprops.rectTransform)

					self._equip_attr._panel.transform.anchoredPosition = var_0_15.New(self._equip_attr._panel.transform.anchoredPosition.x, self._equip_attr._panel.transform.anchoredPosition.y < -117 and -117 or self._equip_attr._panel.transform.anchoredPosition.y)

					self._equip_attr._panel.transform:SetParent(self.equipimg.rectTransform)
					self._equip_attr:show(var_29_0)
					self._control.bg_shadow.gameObject:SetActive(true)
				elseif var_27_0[arg_28_1 + 1].type == 2 then
					var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.bootyshop, (var_0_10.find_object_by_cid(var_27_0[arg_28_1 + 1].award_cid)))
				elseif var_27_0[arg_28_1 + 1].type == 3 then
					local var_29_2 = var_0_13.find_object_by_cid(var_27_0[arg_28_1 + 1].award_cid)

					var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.bootyshop_clothes, {
						pic_id = var_29_2.skin_id,
						gold = var_29_2.gold,
						title = var_29_2.title,
						desc1 = var_29_2.desc1,
						desc2 = var_29_2.desc2,
						extra_desc = var_29_2.extra_desc,
						cid = var_29_2.cid,
						get_type = var_29_2.get_type,
						ship_name = var_0_10.find_object_by_cid(var_29_2.evo_cid).title,
						skins = {
							var_29_2.cid
						}
					})
				elseif var_27_0[arg_28_1 + 1].type == 5 or var_27_0[arg_28_1 + 1].award_cid == 10030571 or var_27_0[arg_28_1 + 1].award_cid == 10029071 then
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.bootyshop_furniture)
				elseif var_27_0[arg_28_1 + 1].type == 6 then
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.bootyshop_cook)
				elseif var_27_0[arg_28_1 + 1].type == 9 then
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.bootyshop_cg)
				elseif var_27_0[arg_28_1 + 1].type == 10 then
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.combatshop_head)
				elseif var_27_0[arg_28_1 + 1].type == 11 then
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.combatshop_adjutant)
				elseif var_27_0[arg_28_1 + 1].type == 12 then
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.combatshop_exp_card)
				elseif var_27_0[arg_28_1 + 1].type == 13 then
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.combatshop_tactics_card)
				else
					var_0_2:createInstance("specificdetails"):show(var_27_0[arg_28_1 + 1].award_cid, var_0_5.enter_icon_detail_type.bootyshop_item)
				end
			end)
			self.pricebtn.button.onClick:RemoveAllListeners()
			self.pricebtn.button.onClick:AddListener(function()
				if var_27_0[arg_28_1 + 1].remain_num then
					if self._sixth_data.token - var_27_0[arg_28_1 + 1].combats < 0 then
						var_0_4:show(var_0_3:getNowLang("token_lack"))

						return
					end

					var_0_2:createInstance("shop_bounced_repeat"):show({
						title = var_27_0[arg_28_1 + 1].title,
						price = var_27_0[arg_28_1 + 1].combats,
						type = var_27_0[arg_28_1 + 1].type,
						id = var_27_0[arg_28_1 + 1].id,
						now_limit = var_27_0[arg_28_1 + 1].limit_num,
						left_combats = self._sixth_data.token
					}, "combat")
				else
					if self._sixth_data.token - var_27_0[arg_28_1 + 1].combats < 0 then
						var_0_4:show(var_0_3:getNowLang("token_lack"))

						return
					end

					self._control.shop_bounced:SetActive(true)

					self._control.shop_bounced.main.main.use_text.text.text = var_0_9(var_0_3:getNowLang("combatshopconfirmbuycontent"), var_27_0[arg_28_1 + 1].combats, var_27_0[arg_28_1 + 1].title)
					self._control.shop_bounced.main.main.normal.former_num.text.text = self._sixth_data.token
					self._control.shop_bounced.main.main.normal.former_num.arrow.latter_num.text.text = self._sixth_data.token - var_27_0[arg_28_1 + 1].combats

					if self._sixth_data.token - var_27_0[arg_28_1 + 1].combats < 0 then
						self._control.shop_bounced.main.main.normal.former_num.arrow.latter_num.text.color = Color.New(1, 0, 0)
						self._control.shop_bounced.main.main.normal.former_num.arrow.latter_num.text.text = var_0_3:getNowLang("token_lack")
					else
						self._control.shop_bounced.main.main.normal.former_num.arrow.latter_num.text.color = Color.New(0, 0.62, 0.92)
					end

					self._control.shop_bounced.main.confirmbtn.button.onClick:RemoveAllListeners()
					self._control.shop_bounced.main.confirmbtn.button.onClick:AddListener(function()
						self._control.shop_bounced:SetActive(false)
						self:_play_into_se(var_0_5:get_ship_icon(var_0_5.common_icon.music_path, var_0_5.open))

						if var_27_0[arg_28_1 + 1].combats ~= 0 and self._sixth_data.token < var_27_0[arg_28_1 + 1].combats then
							var_0_4:show(var_0_3:getNowLang("token_lack"))
						else
							var_0_1:req_SixthShopBuyReq(var_27_0[arg_28_1 + 1].id)
							self:__update_combats_data()
						end
					end)
				end
			end)
		end
	end

	function arg_1_0:__onReset()
		self:__select_one("btnone")
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_33_0)
	local var_33_0 = var_0_2:class("combat_shop")

	var_33_0.__next_content = nil
	var_33_0.__last_content = nil
	var_33_0.__now_content = nil
	var_33_0.__now_label = ""
	var_33_0._data = nil
	var_33_0._sixth_data = nil
	var_33_0._new_data = nil
	var_33_0._big_map_info = nil
	var_33_0.__now_data = nil
	var_33_0.__now_label_index = 0
	var_33_0.__already_init = false
	var_33_0.__data_by_type = nil
	var_33_0._scroll_bar = nil

	return var_33_0
end

return var_0_0
