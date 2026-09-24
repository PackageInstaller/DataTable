local var_0_0 = {}
local var_0_2 = gamecore.user
local var_0_3 = table.sort
local var_0_4 = gamecore.prompt
local var_0_5 = string.find
local var_0_6 = table.insert
local var_0_7 = table.remove
local var_0_8 = gamecore.Language
local var_0_9 = gamecore.UILoader
local var_0_10 = string.format
local var_0_11 = UnityEngine.Vector2
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = gamecore.util_func
local var_0_14 = lx.clone_table
local var_0_17 = gameenum.common_type
local var_0_18 = gameconfig.ship_config
local var_0_19 = gameconfig.skin_config
local var_0_20 = gameconfig.equip_config
local var_0_21 = gameconfig.spoils_shop_config
local var_0_23 = {
	btnthree = "btnthree",
	btnone = "btnone",
	btnfive = "btnfive",
	btnfour = "btnfour",
	btntwo = "btntwo"
}
local var_0_24 = {
	btnthree = "btnthree",
	btnfour = "btnfour",
	btnone = "btnone",
	btntwo = "btntwo"
}
local var_0_25 = 30
local var_0_26 = 26
local var_0_27 = {
	stay = 3,
	fade_out = 1,
	fade_in = 0.5,
	enter_delay = 0.5
}

gamecore.UILoader:define("bootyshop", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:_first_data()
		local var_3_0, var_3_1 = var_0_21.get_sequence()
		local var_3_2 = var_0_14(var_3_0)
		local var_3_3 = {}
		local var_3_4 = {}
		local var_3_5 = {}
		local var_3_6 = lx.ServerTime:getUtcTime()

		for iter_3_0 = #var_3_2, 1, -1 do
			if var_3_2[iter_3_0].start_time ~= 0 and var_3_2[iter_3_0].end_time ~= 0 and (var_3_6 < var_3_2[iter_3_0].start_time or var_3_6 > var_3_2[iter_3_0].end_time) then
				var_0_7(var_3_2, iter_3_0)
			end
		end

		for iter_3_1 = #var_3_2, 1, -1 do
			if var_3_2[iter_3_1].start_time ~= 0 and var_3_2[iter_3_1].end_time ~= 0 then
				var_0_6(var_3_5, var_3_2[iter_3_1])
				var_0_7(var_3_2, iter_3_1)
			end
		end

		for iter_3_2, iter_3_3 in pairs(var_3_2) do
			if iter_3_3.label == 1 then
				var_0_6(var_3_3, iter_3_3)
			else
				var_0_6(var_3_4, iter_3_3)
			end
		end

		var_0_3(var_3_3, function(arg_4_0, arg_4_1)
			return arg_4_0.award_cid > arg_4_1.award_cid
		end)
		var_0_3(var_3_4, function(arg_5_0, arg_5_1)
			return arg_5_0.award_cid > arg_5_1.award_cid
		end)

		for iter_3_4, iter_3_5 in pairs(var_3_4) do
			var_0_6(var_3_3, iter_3_5)
		end

		for iter_3_6, iter_3_7 in pairs(var_3_3) do
			var_0_6(var_3_5, iter_3_7)
		end

		self._data = var_3_5

		local var_3_7 = var_0_2:get_player_story_unlock_data()
		local var_3_8 = {}

		for iter_3_8 = 1, #var_3_7 do
			if var_3_7[iter_3_8].type == 3 then
				var_0_6(var_3_8, var_3_7[iter_3_8].id)
			end
		end

		local var_3_9 = {}

		for iter_3_9, iter_3_10 in pairs((var_0_2:get_skin_list())) do
			var_0_6(var_3_9, iter_3_10)
		end

		for iter_3_11, iter_3_12 in pairs(var_3_9) do
			self:_is_have_skin(iter_3_12)
		end

		local var_3_10 = {}

		for iter_3_13, iter_3_14 in pairs((var_0_2:get_cardbook_equip_list())) do
			var_0_6(var_3_10, iter_3_14)
		end

		for iter_3_15, iter_3_16 in pairs(var_3_10) do
			self:_is_have_equip(iter_3_16)
		end

		local var_3_11 = {}

		for iter_3_17, iter_3_18 in pairs(var_3_8) do
			var_0_6(var_3_11, iter_3_18)
		end

		for iter_3_19, iter_3_20 in pairs(var_3_11) do
			self:_is_have_picture(iter_3_20)
		end

		local var_3_12 = {}

		for iter_3_21, iter_3_22 in pairs((var_0_2:get_restaurant_have_cookbook())) do
			var_0_6(var_3_12, iter_3_22)
		end

		for iter_3_23, iter_3_24 in pairs(var_3_12) do
			self:_is_have_cookbook(iter_3_24)
		end

		local var_3_13 = {}

		for iter_3_25, iter_3_26 in pairs((var_0_2:get_dormitory_furniture())) do
			var_0_6(var_3_13, iter_3_26.cid)
		end

		for iter_3_27, iter_3_28 in pairs(var_3_13) do
			self:_is_have_furniture(iter_3_28)
		end

		local var_3_14 = {}

		for iter_3_29, iter_3_30 in pairs((var_0_2:get_player_desk_collection_data())) do
			var_0_6(var_3_14, iter_3_30.id)
		end

		for iter_3_31, iter_3_32 in pairs((var_0_2:get_player_wall_collection_data())) do
			var_0_6(var_3_14, iter_3_32.id)
		end

		for iter_3_33, iter_3_34 in pairs((var_0_2:get_all_items_by_type(43))) do
			var_0_6(var_3_14, iter_3_34.id)
		end

		for iter_3_35, iter_3_36 in pairs((var_0_2:get_all_items_by_type(44))) do
			var_0_6(var_3_14, iter_3_36.id)
		end

		for iter_3_37, iter_3_38 in pairs(var_3_14) do
			self:_is_have_collection(iter_3_38)
		end
	end

	function arg_1_0:set_coin_num(arg_6_1)
		if arg_6_1 then
			self._control.maintop.topmenu.bootycoin.coinnumber.text.text = arg_6_1.exploit or "0"
			self._control.maintop.topmenu.bootyprops.propsnumber.text.text = arg_6_1.spoils or "0"
		end
	end

	function arg_1_0:_is_have_equip(arg_7_1)
		for iter_7_0, iter_7_1 in pairs(self._data) do
			if iter_7_1.type == 1 and iter_7_1.is_unique and iter_7_1.award_cid == arg_7_1 then
				var_0_7(self._data, iter_7_0)
			end
		end
	end

	function arg_1_0:_is_have_skin(arg_8_1)
		if #arg_8_1 == 1 then
			for iter_8_0, iter_8_1 in pairs(self._data) do
				if iter_8_1.type == 3 and iter_8_1.is_unique and iter_8_1.award_cid == arg_8_1[1] then
					var_0_7(self._data, iter_8_0)
				end
			end
		end

		if #arg_8_1 > 1 then
			for iter_8_2, iter_8_3 in pairs(arg_8_1) do
				for iter_8_4, iter_8_5 in pairs(self._data) do
					if iter_8_5.type == 3 and iter_8_5.is_unique and iter_8_5.award_cid == iter_8_3 then
						var_0_7(self._data, iter_8_4)
					end
				end
			end
		end
	end

	function arg_1_0:_is_have_picture(arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(self._data) do
			if iter_9_1.type ~= 9 or not iter_9_1.is_unique or iter_9_1.award_cid ~= arg_9_1 then
				var_0_6(var_9_0, iter_9_1)
			end
		end

		self._data = var_9_0
	end

	function arg_1_0:_is_have_cookbook(arg_10_1)
		for iter_10_0, iter_10_1 in pairs(self._data) do
			if iter_10_1.type == 6 and iter_10_1.is_unique and iter_10_1.award_cid == arg_10_1 then
				var_0_7(self._data, iter_10_0)
			end
		end
	end

	function arg_1_0:_is_have_furniture(arg_11_1)
		for iter_11_0, iter_11_1 in pairs(self._data) do
			if iter_11_1.type == 5 and iter_11_1.is_unique and iter_11_1.award_cid == arg_11_1 then
				var_0_7(self._data, iter_11_0)
			end
		end
	end

	function arg_1_0:_is_have_collection(arg_12_1)
		for iter_12_0, iter_12_1 in pairs(self._data) do
			if iter_12_1.type == 4 and iter_12_1.is_unique and iter_12_1.award_cid == arg_12_1 then
				var_0_7(self._data, iter_12_0)
			end
		end
	end

	function arg_1_0:updata_data()
		self:shop_data()
		self:__changedata()
	end

	function arg_1_0:__changedata()
		local var_14_0 = {}

		if self._control.change.text.text.text == var_0_8:getNowLang("trophytype0") then
			var_14_0 = self._data
		elseif self._control.change.text.text.text == var_0_8:getNowLang("trophytype1") then
			var_14_0 = self._pc_data
		elseif self._control.change.text.text.text == var_0_8:getNowLang("trophytype2") then
			var_14_0 = self._ac_data
		elseif self._control.change.text.text.text == var_0_8:getNowLang("score_buff_can_buy") then
			var_14_0 = self._can_buy_data
		end

		self:__set_spoils_data(var_14_0)
	end

	function arg_1_0:shop_data()
		for iter_15_0 = #self._data, 1, -1 do
			if self._data[iter_15_0].limit_num == 0 and self._data[iter_15_0].id ~= 5011 and self._data[iter_15_0].id ~= 4001 and self._data[iter_15_0].id ~= 4000 and self._data[iter_15_0].id ~= 4018 and self._data[iter_15_0].id ~= 4019 then
				var_0_7(self._data, iter_15_0)
			end
		end

		self:_updata_spoils()

		self._pc_data = {}
		self._ac_data = {}
		self._can_buy_data = {}

		for iter_15_1, iter_15_2 in pairs(self._data) do
			if iter_15_2.spoils == 0 then
				var_0_6(self._ac_data, iter_15_2)
			else
				var_0_6(self._pc_data, iter_15_2)
			end
		end

		for iter_15_3, iter_15_4 in ipairs(self._data) do
			if iter_15_4.exploit > 0 and self.user_data.exploit >= iter_15_4.exploit then
				var_0_6(self._can_buy_data, iter_15_4)
			elseif iter_15_4.spoils > 0 and self.user_data.spoils >= iter_15_4.spoils then
				var_0_6(self._can_buy_data, iter_15_4)
			end
		end
	end

	function arg_1_0:_updata_spoils()
		self._new_data = var_0_2:get_spoils_list()
		self.user_data = var_0_2:get_use_info_data()
		self._now_data_array = {}

		for iter_16_0, iter_16_1 in pairs(self._new_data) do
			var_0_6(self._now_data_array, iter_16_1)
		end

		for iter_16_2, iter_16_3 in pairs(self._now_data_array) do
			self:__set_now_spoils_data(iter_16_3.buy_count, iter_16_3.id)
		end
	end

	function arg_1_0:__set_now_spoils_data(arg_17_1, arg_17_2)
		for iter_17_0, iter_17_1 in pairs(self._data) do
			if iter_17_1.id == arg_17_2 and iter_17_1.limit_num == arg_17_1 then
				var_0_7(self._data, iter_17_0)
			end
		end
	end

	function arg_1_0:show(arg_18_1)
		self:setVisible(true)

		self._enter_type = arg_18_1

		self:__update_search_name()
		self:__init_search_listener()
	end

	function arg_1_0:__onVisible(arg_19_1)
		if not arg_19_1 then
			return
		end

		self:_first_data()
		self:updata_data()
		var_0_2:set_in_bootyshop(true)
		self:__init_panel()

		self._already_init = true
	end

	function arg_1_0:__init_panel()
		local var_20_0 = var_0_9:getInstance("home")

		if var_20_0 then
			var_20_0:setVisible(false)
		end

		self.user_data = var_0_2:get_use_info_data()

		local var_20_1 = self:autoKillDOTween(var_0_12.Sequence())

		var_20_1:AppendInterval(var_0_27.enter_delay)
		var_20_1:AppendCallback(function()
			if self:isVisible() and (not self._seq or not self._seq:IsPlaying()) then
				self:_npc_talk()
			end
		end)

		self._need_revert = true
		self._control.maintop.topmenu.topbtn.btnone.text.text.text = var_0_8:getNowLang("ta")
		self._control.maintop.topmenu.topbtn.btnone.text.text.fontSize = var_0_26
		self._control.maintop.topmenu.topbtn.btntwo.text.text.text = var_0_8:getNowLang("te")
		self._control.maintop.topmenu.topbtn.btntwo.text.text.fontSize = var_0_26
		self._control.maintop.topmenu.topbtn.btnthree.text.text.text = var_0_8:getNowLang("ts")
		self._control.maintop.topmenu.topbtn.btnthree.text.text.fontSize = var_0_26
		self._control.maintop.topmenu.topbtn.btnfour.text.text.text = var_0_8:getNowLang("tsh")
		self._control.maintop.topmenu.topbtn.btnfour.text.text.fontSize = var_0_26
		self._control.maintop.topmenu.topbtn.btnfive.text.text.text = var_0_8:getNowLang("to")
		self._control.maintop.topmenu.topbtn.btnfive.text.text.fontSize = var_0_26
		self._control.type_btn.type.text.text = var_0_8:getNowLang("type")
		self._control.maintop.topmenu.bootycoin.coinnumber.text.text = self.user_data.exploit
		self._control.maintop.topmenu.bootyprops.propsnumber.text.text = self.user_data.spoils
		self._control.change.text.text.text = var_0_8:getNowLang("trophytype0")
		self._now_type = var_0_8:getNowLang("trophytype0")
		self._control.mainprops.no_item.text.text = var_0_8:getNowLang("no_trophy_warn")
		self._control.mainmid.change.btnone.text.text.text = var_0_8:getNowLang("trophytype0")
		self._control.mainmid.change.btntwo.text.text.text = var_0_8:getNowLang("trophytype1")
		self._control.mainmid.change.btnthree.text.text.text = var_0_8:getNowLang("trophytype2")
		self._control.mainmid.change.btnfour.text.text.text = var_0_8:getNowLang("score_buff_can_buy")

		self:__init_booty_list()
		self:__init_select()
		self:__init_buy_select()

		self._control.type_btn.type_txt.text.text = var_0_8:getNowLang("equip0")

		var_0_17:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	function arg_1_0:__init_search_listener()
		self._control.change.search.inputField.onEndEdit:RemoveAllListeners()
		self._control.change.search.inputField.onEndEdit:AddListener(function()
			if self._control.change.search.inputField.text ~= "" then
				self._filter_name = self._control.change.search.inputField.text

				local var_23_0, var_23_1 = var_0_5(self._filter_name, "%(")

				if var_23_0 ~= nil and var_23_1 ~= nil then
					self._filter_name = var_0_13._str_insert(self._filter_name, var_23_0, "%")
				end

				local var_23_2, var_23_3 = var_0_5(self._filter_name, "%%")

				if var_23_2 ~= nil and var_23_3 ~= nil then
					self._filter_name = var_0_13._str_insert(self._filter_name, var_23_2, "%")
				end

				local var_23_4, var_23_5 = var_0_5(self._filter_name, "%[")

				if var_23_4 ~= nil and var_23_5 ~= nil then
					self._filter_name = var_0_13._str_insert(self._filter_name, var_23_4, "%")
				end

				local var_23_6, var_23_7 = var_0_5(self._filter_name, "%]")

				if var_23_6 ~= nil and var_23_7 ~= nil then
					self._filter_name = var_0_13._str_insert(self._filter_name, var_23_6, "%")
				end

				local var_23_8, var_23_9 = var_0_5(self._filter_name, "%-")

				if var_23_8 ~= nil and var_23_9 ~= nil then
					self._filter_name = var_0_13._str_insert(self._filter_name, var_23_8, "%")
				end

				self:__update_cell()
			else
				self._filter_name = nil

				self:__update_cell()
			end
		end)
	end

	function arg_1_0:__init_select()
		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one("btnone", true)

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_25_1, arg_25_2)
		if self._now_label == arg_25_1 and not arg_25_2 then
			return
		end

		self._now_label = arg_25_1

		if self._now_content then
			self._last_content = self._now_content

			self:__set_title_style(self._now_content, false)
		end

		self:__set_current_content(arg_25_1)
		self:__set_title_style(self._now_content, true)

		if self._last_content and self._now_content then
			var_0_17:play_in_out_animation(self._last_content.uITweenSequence, false, function()
				if self and self._now_content then
					var_0_17:play_in_out_animation(self._now_content.uITweenSequence, true, nil)
				end
			end)
		elseif self._now_content then
			var_0_17:play_in_out_animation(self._now_content.uITweenSequence, true, nil)
		end

		self:__set__now_data(self._now_label)
		self:__set_scroll_to_top()
	end

	function arg_1_0:__set_scroll_to_top()
		self._scroll_bar = self._scroll_bar or self._control.mainprops.main.scrollview.scrollbarvertical:GetComponent("Scrollbar")
		self._scroll_bar.value = 1
	end

	function arg_1_0:__set_current_content(arg_28_1)
		if arg_28_1 == var_0_23.btnone then
			self._now_content = self._control.maintop.topmenu.topbtn.btnone
		elseif arg_28_1 == var_0_23.btntwo then
			self._now_content = self._control.maintop.topmenu.topbtn.btntwo
		elseif arg_28_1 == var_0_23.btnthree then
			self._now_content = self._control.maintop.topmenu.topbtn.btnthree
		elseif arg_28_1 == var_0_23.btnfour then
			self._now_content = self._control.maintop.topmenu.topbtn.btnfour
		elseif arg_28_1 == var_0_23.btnfive then
			self._now_content = self._control.maintop.topmenu.topbtn.btnfive
		end
	end

	function arg_1_0.__set_title_style(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_2 then
			arg_29_1.text.text.fontSize = var_0_25
			arg_29_1.text.text.color = Color.New(1, 1, 1)
		else
			arg_29_1.text.text.fontSize = var_0_26
			arg_29_1.text.text.color = Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373)
		end

		arg_29_1.btnimg:SetActive(arg_29_2)
	end

	function arg_1_0:__set__now_data(arg_30_1, arg_30_2)
		if arg_30_1 == var_0_23.btnone then
			self:__get_data_by_index(1)
		elseif arg_30_1 == var_0_23.btntwo then
			self:__get_data_by_index(2)
		elseif arg_30_1 == var_0_23.btnthree then
			self:__get_data_by_index(3)
		elseif arg_30_1 == var_0_23.btnfour then
			self:__get_data_by_index(4)
		elseif arg_30_1 == var_0_23.btnfive then
			self:__get_data_by_index(5)
		end

		self:__update_cell()

		if arg_30_2 and self._last_pos then
			self._control.mainprops.main.scrollview.viewport.content.transform.localPosition = self._last_pos
			self._last_pos = nil
		end
	end

	function arg_1_0:__init_buy_select()
		if self._now_buy_content then
			self._now_buy_content.toggle.isOn = false
		end

		self:_select_buy_one("btnone", true)

		self._now_buy_content.toggle.isOn = true

		self:__set__now_data(self._now_label)
	end

	function arg_1_0:_select_buy_one(arg_32_1, arg_32_2)
		if self._now_buy_label == arg_32_1 and not arg_32_2 then
			return
		end

		self._now_buy_label = arg_32_1

		if self._now_buy_content then
			self._last_buy_content = self._now_buy_content
		end

		self:_set_buy_current_content(arg_32_1)
		self:__set__now_data(self._now_label)
	end

	function arg_1_0:_set_buy_current_content(arg_33_1)
		local var_33_0 = ""

		if arg_33_1 == var_0_24.btnone then
			self._now_buy_content = self._control.mainmid.change.btnone
			var_33_0 = var_0_8:getNowLang("trophytype0")

			self:__set_spoils_data(self._data)
		elseif arg_33_1 == var_0_24.btntwo then
			self._now_buy_content = self._control.mainmid.change.btntwo
			var_33_0 = var_0_8:getNowLang("trophytype1")

			self:__set_spoils_data(self._pc_data)
		elseif arg_33_1 == var_0_24.btnthree then
			self._now_buy_content = self._control.mainmid.change.btnthree
			var_33_0 = var_0_8:getNowLang("trophytype2")

			self:__set_spoils_data(self._ac_data)
		elseif arg_33_1 == var_0_24.btnfour then
			self._now_buy_content = self._control.mainmid.change.btnfour
			var_33_0 = var_0_8:getNowLang("score_buff_can_buy")

			self:__set_spoils_data(self._can_buy_data)
		end

		self._now_type = var_33_0
		self._control.change.text.text.text = var_33_0
	end

	function arg_1_0:__init_booty_list()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainprops.main.scrollview.viewport.content.endlessScrollView, self._control.mainprops.main.scrollview.viewport.content, "booty", "bootyshop")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell()
		local var_35_0 = self._now_data
		local var_35_1 = self._now_data_array

		if self._now_data == self._data_by_type[2] then
			local var_35_2 = var_0_9:createInstance("equip_type_layer")

			self._type_toggle_data = var_35_2._type_toggle_data
			self._effect_toggle_data = var_35_2._effect_toggle_data

			if var_35_2._type_toggle_txt ~= "" then
				self._control.type_btn.type_txt.text.text = var_35_2._type_toggle_txt
			end

			var_35_0 = self:get_equip_effect_list((self:get_new_equip_list(self._data_by_type[2])))
		else
			var_35_0 = self._now_data
		end

		self._control.mainprops.no_item.gameObject:SetActive(false)

		if #var_35_0 == 0 then
			self._control.mainprops.no_item.gameObject:SetActive(true)
		end

		if self._filter_name and self._filter_name ~= "" then
			var_35_0 = self:__filter_table_by_name(var_35_0)
		end

		self._reusable_cell:set_data(var_35_0)

		function self._reusable_cell:_set_func(arg_36_1)
			self.timelimit.gameObject:SetActive(false)
			self.numberof.gameObject:SetActive(true)
			self.activity.gameObject:SetActive(false)

			self.activity.content.text.text = var_0_8:getNowLang("new")

			if var_35_0[arg_36_1 + 1].label == 1 or var_35_0[arg_36_1 + 1].start_time ~= 0 and var_35_0[arg_36_1 + 1].end_time ~= 0 then
				self.activity.gameObject:SetActive(true)

				if var_35_0[arg_36_1 + 1].start_time ~= 0 and var_35_0[arg_36_1 + 1].end_time ~= 0 then
					self.activity.content.text.text = var_0_8:getNowLang("limittimetitle")

					self.timelimit.gameObject:SetActive(true)

					local var_36_0 = var_35_0[arg_36_1 + 1].end_time - lx.ServerTime:getUtcTime()

					if var_36_0 >= 86400 then
						self.timelimit.text.text = "(" .. var_0_8:getNowLang("limittimetitle") .. ": " .. var_0_10(var_0_8:getNowLang("daysleft"), math.floor(var_36_0 / 86400)) .. ")"
					elseif var_36_0 >= 3600 and var_36_0 < 86400 then
						self.timelimit.text.text = "(" .. var_0_8:getNowLang("limittimetitle") .. ": " .. var_0_10(var_0_8:getNowLang("ui_nokori"), math.floor(var_36_0 / 3600)) .. var_0_8:getNowLang("hour") .. ")"
					elseif var_36_0 >= 60 and var_36_0 < 3600 then
						self.timelimit.text.text = "(" .. var_0_8:getNowLang("limittimetitle") .. ": " .. var_0_10(var_0_8:getNowLang("minleft1"), (math.floor(var_36_0 / 60)))
					elseif var_36_0 < 60 and var_36_0 > 0 then
						self.timelimit.text.text = "(" .. var_0_8:getNowLang("limittimetitle") .. ": " .. var_0_10(var_0_8:getNowLang("secleft1"), var_36_0)
					elseif var_36_0 <= 0 then
						self.timelimit.gameObject:SetActive(false)
						var_0_7(var_35_0, arg_36_1 + 1)
						self:updata_data()
					end
				end
			end

			self.equipname.text.text = var_35_0[arg_36_1 + 1].title

			if var_35_0[arg_36_1 + 1].spoils == 0 then
				self.priceimg.image.sprite = self:loadSprite(var_0_10(var_0_17.buy_spoils_ac))
				self.pricenumber.text.text = var_35_0[arg_36_1 + 1].exploit
			else
				self.priceimg.image.sprite = self:loadSprite(var_0_10(var_0_17.buy_spoils_pc))
				self.pricenumber.text.text = var_35_0[arg_36_1 + 1].spoils
			end

			self.typename.text.text = var_35_0[arg_36_1 + 1].desc

			if var_35_0[arg_36_1 + 1].id == 5011 or var_35_0[arg_36_1 + 1].id == 4001 or var_35_0[arg_36_1 + 1].id == 4000 or var_35_0[arg_36_1 + 1].id == 4018 or var_35_0[arg_36_1 + 1].id == 4019 then
				self.numberof.gameObject:SetActive(false)
			else
				self.numberof.text.text = string.format(var_0_8:getNowLang("limit_left"), var_35_0[arg_36_1 + 1].limit_num)
			end

			for iter_36_0, iter_36_1 in pairs(var_35_1) do
				if var_35_0[arg_36_1 + 1].id == iter_36_1.id then
					self.numberof.text.text = string.format(var_0_8:getNowLang("limit_left"), var_35_0[arg_36_1 + 1].limit_num - iter_36_1.buy_count)
				end
			end

			self.equipimg.bg.image.sprite = self:loadSprite(var_0_10(var_0_17.ship_equip_pic.equipbg, 0))

			if var_35_0[arg_36_1 + 1].type == 1 then
				self.equipimg.img.image.sprite = self:loadSprite(var_0_10(var_0_17.buy_spoils_equip, var_35_0[arg_36_1 + 1].icon))
				self.equipimg.bg.image.sprite = self:loadSprite(var_0_10(var_0_17.buy_spoils_equip_bg, var_0_20.find_object_by_cid(var_35_0[arg_36_1 + 1].award_cid).star))
			else
				self.equipimg.img.image.sprite = var_35_0[arg_36_1 + 1].type == 3 and self:loadSprite(var_0_10(var_0_17.buy_spoils_skin, var_35_0[arg_36_1 + 1].icon)) or self:loadSprite(var_0_10(var_0_17.buy_spoils_icon, var_35_0[arg_36_1 + 1].icon))
			end

			self.equipimg.imgbtn.button.onClick:RemoveAllListeners()
			self.equipimg.imgbtn.button.onClick:AddListener(function()
				local var_37_0 = var_35_0[arg_36_1 + 1].award_cid

				if var_35_0[arg_36_1 + 1].award_cid > 20000 then
					var_37_0 = var_37_0 % 10000000
					var_37_0 = var_37_0 > 100000 and var_37_0 % 100000 % 1000 % 100 or var_37_0 % 10000 % 1000 % 100
				end

				self._is_fur_or_food = var_37_0

				if var_35_0[arg_36_1 + 1].type == 1 then
					local var_37_1 = var_0_20.find_object_by_cid(var_35_0[arg_36_1 + 1].award_cid)

					self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

					self._equip_attr._panel.transform:SetParent(self.equipimg.rectTransform, false)

					self._equip_attr._panel.transform.anchoredPosition = var_0_11.New(-63, -66)

					self._equip_attr._panel.transform:SetParent(self._control.mainprops.main.rectTransform)

					self._equip_attr._panel.transform.anchoredPosition = var_0_11.New(self._equip_attr._panel.transform.anchoredPosition.x, self._equip_attr._panel.transform.anchoredPosition.y < -117 and -117 or self._equip_attr._panel.transform.anchoredPosition.y)

					self._equip_attr._panel.transform:SetParent(self.equipimg.rectTransform)
					self._equip_attr:show(var_37_1)
					self._control.bg_shadw.gameObject:SetActive(true)
				elseif var_35_0[arg_36_1 + 1].type == 2 then
					var_0_9:createInstance("ship_detail"):show(var_0_17.enter_ship_detail_type.bootyshop, (var_0_18.find_object_by_cid(var_35_0[arg_36_1 + 1].award_cid)))
				elseif var_35_0[arg_36_1 + 1].type == 3 then
					local var_37_3 = var_0_19.find_object_by_cid(var_35_0[arg_36_1 + 1].award_cid)

					var_0_9:createInstance("ship_detail"):show(var_0_17.enter_ship_detail_type.bootyshop_clothes, {
						pic_id = var_37_3.skin_id,
						gold = var_37_3.gold,
						title = var_37_3.title,
						desc1 = var_37_3.desc1,
						desc2 = var_37_3.desc2,
						extra_desc = var_37_3.extra_desc,
						cid = var_37_3.cid,
						get_type = var_37_3.get_type,
						ship_name = var_0_18.find_object_by_cid(var_37_3.evo_cid).title,
						skins = {
							var_37_3.cid
						}
					})
				elseif var_37_0 == 71 and var_35_0[arg_36_1 + 1].type == 5 or var_35_0[arg_36_1 + 1].award_cid == 10030571 or var_35_0[arg_36_1 + 1].award_cid == 10029071 then
					var_0_9:createInstance("specificdetails"):show(var_35_0[arg_36_1 + 1].award_cid, var_0_17.enter_icon_detail_type.bootyshop_furniture)
				elseif var_37_0 == 72 and var_35_0[arg_36_1 + 1].type == 6 then
					var_0_9:createInstance("specificdetails"):show(var_35_0[arg_36_1 + 1].award_cid, var_0_17.enter_icon_detail_type.bootyshop_cook)
				elseif var_35_0[arg_36_1 + 1].type == 9 then
					var_0_9:createInstance("specificdetails"):show(var_35_0[arg_36_1 + 1].award_cid, var_0_17.enter_icon_detail_type.bootyshop_cg)
				else
					var_0_9:createInstance("specificdetails"):show(var_35_0[arg_36_1 + 1].award_cid, var_0_17.enter_icon_detail_type.bootyshop_item)
				end
			end)
			self.price.scaleButton.onClick:RemoveAllListeners()
			self.price.scaleButton.onClick:AddListener(function()
				if var_35_0[arg_36_1 + 1].type == 4 then
					if var_35_0[arg_36_1 + 1].spoils ~= 0 and self.user_data.spoils < var_35_0[arg_36_1 + 1].spoils then
						var_0_4:show(var_0_8:getNowLang("spoils_lack"))

						return
					elseif var_35_0[arg_36_1 + 1].exploit ~= 0 and self.user_data.exploit < var_35_0[arg_36_1 + 1].exploit then
						var_0_4:show(var_0_8:getNowLang("exploit_lack"))

						return
					end

					local var_38_0 = var_35_0[arg_36_1 + 1].limit_num
					local var_38_1 = var_35_0[arg_36_1 + 1].spoils

					for iter_38_0, iter_38_1 in pairs(var_35_1) do
						if var_35_0[arg_36_1 + 1].id == iter_38_1.id then
							var_38_0 = var_35_0[arg_36_1 + 1].limit_num - iter_38_1.buy_count
						end
					end

					if var_35_0[arg_36_1 + 1].spoils == 0 then
						var_38_1 = var_35_0[arg_36_1 + 1].exploit
					end

					local var_38_2 = var_0_9:createInstance("shop_bounced_repeat")
					local var_38_3 = {
						title = var_35_0[arg_36_1 + 1].title,
						price = var_38_1,
						type = var_35_0[arg_36_1 + 1].type,
						id = var_35_0[arg_36_1 + 1].id,
						now_limit = var_38_0
					}

					if var_35_0[arg_36_1 + 1].spoils ~= 0 then
						var_38_2:show(var_38_3, "spoils")
					elseif var_35_0[arg_36_1 + 1].exploit ~= 0 then
						var_38_2:show(var_38_3, "exploit")
					end
				else
					if var_35_0[arg_36_1 + 1].spoils ~= 0 and self.user_data.spoils < var_35_0[arg_36_1 + 1].spoils then
						var_0_4:show(var_0_8:getNowLang("spoils_lack"))

						return
					elseif var_35_0[arg_36_1 + 1].exploit ~= 0 and self.user_data.exploit < var_35_0[arg_36_1 + 1].exploit then
						var_0_4:show(var_0_8:getNowLang("exploit_lack"))

						return
					end

					;(var_0_9:getInstance("msgbox") or var_0_9:createInstance("msgbox")):show(var_0_8:getNowLang("shopbuyconfirmtitle"), function()
						self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.open))

						if var_35_0[arg_36_1 + 1].spoils ~= 0 and self.user_data.spoils < var_35_0[arg_36_1 + 1].spoils then
							var_0_4:show(var_0_8:getNowLang("spoils_lack"))
						elseif var_35_0[arg_36_1 + 1].exploit ~= 0 and self.user_data.exploit < var_35_0[arg_36_1 + 1].exploit then
							var_0_4:show(var_0_8:getNowLang("exploit_lack"))
						else
							var_0_2:req_spoilsbuyReq(var_35_0[arg_36_1 + 1].id)

							self._last_pos = self._control.mainprops.main.scrollview.viewport.content.transform.localPosition

							self:updata_data()
						end
					end, function()
						self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.back))
					end, var_0_8:getNowLang("shopbuyconfirmtitle"), var_0_17.msg_type.tip_info, nil)
				end
			end)
		end
	end

	function arg_1_0:get_new_equip_list(arg_41_1)
		local var_41_0 = {}

		for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
			for iter_41_2, iter_41_3 in pairs(self._type_toggle_data) do
				local var_41_1 = false
				local var_41_2 = var_0_20.find_object_by_cid(iter_41_1.award_cid)

				if iter_41_2 == "all" and iter_41_3 then
					var_41_1 = true
				elseif iter_41_2 == "missile_launcher" then
					if var_0_17.equip_type.anti_ship_missile_launcher == var_41_2.type or var_0_17.equip_type.air_defense_missile_launcher == var_41_2.type then
						var_41_1 = true
					end
				elseif iter_41_2 == "missile" then
					if var_0_17.equip_type.anti_ship_missile == var_41_2.type or var_0_17.equip_type.air_defense_missile == var_41_2.type then
						var_41_1 = true
					end
				elseif var_0_17.equip_type[iter_41_2] == var_41_2.type then
					var_41_1 = true
				end

				if var_41_1 then
					var_0_6(var_41_0, iter_41_1)
				end
			end
		end

		return var_41_0
	end

	function arg_1_0:get_equip_effect_list(arg_42_1)
		local var_42_0 = {}

		for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
			local var_42_1 = false

			for iter_42_2, iter_42_3 in pairs(self._effect_toggle_data) do
				local var_42_2 = var_0_20.find_object_by_cid(iter_42_1.award_cid)

				if iter_42_2 == "all" and iter_42_3 then
					var_42_1 = true
				elseif iter_42_2 == "attack" then
					if var_0_13.have_data(var_42_2.effect_type, 1) then
						var_42_1 = true
					end
				elseif iter_42_2 == "extra_damage" then
					if var_0_13.have_data(var_42_2.effect_type, 2) then
						var_42_1 = true
					end
				elseif iter_42_2 == "exp_up" then
					if var_0_13.have_data(var_42_2.effect_type, 3) then
						var_42_1 = true
					end
				elseif iter_42_2 == "armor_pene" then
					if var_0_13.have_data(var_42_2.effect_type, 4) then
						var_42_1 = true
					end
				elseif iter_42_2 == "expedition_resource" then
					if var_0_13.have_data(var_42_2.effect_type, 5) then
						var_42_1 = true
					end
				elseif iter_42_2 == "hit_rate" then
					if var_0_13.have_data(var_42_2.effect_type, 6) then
						var_42_1 = true
					end
				elseif iter_42_2 == "miss" then
					if var_0_13.have_data(var_42_2.effect_type, 7) then
						var_42_1 = true
					end
				elseif iter_42_2 == "critical_rate" then
					if var_0_13.have_data(var_42_2.effect_type, 8) then
						var_42_1 = true
					end
				elseif iter_42_2 == "anti_air" then
					if var_0_13.have_data(var_42_2.effect_type, 9) then
						var_42_1 = true
					end
				elseif iter_42_2 == "atk_top" and var_0_13.have_data(var_42_2.effect_type, 10) then
					var_42_1 = true
				end
			end

			if var_42_1 then
				var_0_6(var_42_0, iter_42_1)
			end
		end

		return var_42_0
	end

	function arg_1_0.__set_spoils_data(arg_43_0, arg_43_1)
		local var_43_0 = {}
		local var_43_1 = {}
		local var_43_2 = {}
		local var_43_3 = {}

		for iter_43_0, iter_43_1 in pairs(arg_43_1) do
			if iter_43_1.sort == 1 then
				var_0_6(var_43_0, iter_43_1)
			elseif iter_43_1.sort == 2 then
				var_0_6(var_43_2, iter_43_1)
			elseif iter_43_1.sort == 3 then
				var_0_6(var_43_1, iter_43_1)
			elseif iter_43_1.sort == 4 then
				var_0_6(var_43_3, iter_43_1)
			end
		end

		arg_43_0._data_by_type = {
			arg_43_1,
			var_43_0,
			var_43_1,
			var_43_2,
			var_43_3
		}
	end

	function arg_1_0:__get_data_by_index(arg_44_1)
		self._now_data = self._data_by_type[arg_44_1]

		return self._now_data
	end

	function arg_1_0:__is_already_init()
		return self._already_init
	end

	function arg_1_0:_npc_talk()
		self:reset_talk_dialog()

		local var_46_0 = var_0_8:getNowLang("trophytip" .. lan_rand(1, 3))

		if var_46_0 == "" or var_46_0 == "0" then
			return
		end

		self._seq = self:__play_talk(self._control.npc.talk, var_46_0)
	end

	function arg_1_0.__play_talk(arg_47_0, arg_47_1, arg_47_2)
		arg_47_1:SetActive(true)

		arg_47_1.label_txt.text.text = var_0_13.set_dialog_box_width(arg_47_1, arg_47_2, 500, nil) or arg_47_2
		arg_47_1.canvasGroup.alpha = 0

		local var_47_0 = var_0_12.Sequence()

		var_47_0:Append(arg_47_1.canvasGroup:DOFade(1, var_0_27.fade_in))
		var_47_0:AppendInterval(var_0_27.stay)
		var_47_0:Append(arg_47_1.canvasGroup:DOFade(0, var_0_27.fade_out))
		var_47_0:OnKill(function()
			if arg_47_1 and not arg_47_1:Equals(nil) then
				arg_47_1.canvasGroup.alpha = 0

				arg_47_1:SetActive(false)
			end
		end)

		return var_47_0
	end

	function arg_1_0:_play_into_se(arg_49_1)
		self:playSE(arg_49_1, false)
	end

	function arg_1_0:reset_talk_dialog()
		if self._seq then
			self._seq:Kill()

			self._seq = nil
		end
	end

	function arg_1_0:__filter_table_by_name(arg_51_1)
		local var_51_0 = {}

		if not self._filter_name then
			return arg_51_1
		end

		if self._filter_name == "(" then
			self._filter_name = "%("
		end

		for iter_51_0, iter_51_1 in pairs(arg_51_1) do
			if var_0_13.name_filter_match(iter_51_1.title, self._filter_name) then
				var_0_6(var_51_0, iter_51_1)
			end
		end

		self._control.change.search.inputField.text = ""

		return var_51_0
	end

	function arg_1_0:__update_search_name()
		self._filter_name = nil
		self._control.change.search.inputField.text = ""
	end

	function arg_1_0:__onReset()
		self:__select_one("btnone")
		self:_select_buy_one("btnone")

		self._control.mainprops.main.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_11(0, 0)

		self:reset_talk_dialog()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_54_0)
	local var_54_0 = var_0_9:class("bootyshop")

	var_54_0._last_content = nil
	var_54_0._last_buy_content = nil
	var_54_0._now_label = nil
	var_54_0._now_buy_label = nil
	var_54_0._now_content = nil
	var_54_0._now_buy_content = nil
	var_54_0._already_init = false
	var_54_0._data = {}
	var_54_0._data_by_type = {}
	var_54_0._pc_by_type = {}
	var_54_0._ac_by_type = {}
	var_54_0._now_data = {}
	var_54_0._buy_type = nil
	var_54_0._pc_data = {}
	var_54_0._ac_data = {}
	var_54_0._buy_type_one = nil
	var_54_0._buy_type_two = nil
	var_54_0._ac_number = nil
	var_54_0._pc_number = nil
	var_54_0._new_data = {}
	var_54_0._shop_table = {}
	var_54_0.user_data = nil
	var_54_0._now_data_array = {}
	var_54_0._unbuy_table = {}
	var_54_0._have_id = nil
	var_54_0._type_toggle_data = {
		all = true
	}
	var_54_0._effect_toggle_data = {
		all = true
	}
	var_54_0._need_revert = false
	var_54_0._equip_attr = nil
	var_54_0._is_fur_or_food = nil
	var_54_0._enter_type = nil
	var_54_0._last_pos = nil
	var_54_0._filter_name = nil
	var_54_0._can_buy_data = {}

	return var_54_0
end

return var_0_0
