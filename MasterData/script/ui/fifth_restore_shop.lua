local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_8 = table.sort
local var_0_10 = gameconfig.pve_fifth_restore_shop_config

gamecore.UILoader:define("fifth_restore_shop", function(arg_1_0)
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
		if self._init_already then
			self:__update_data()
			self:__update_cell()

			return
		end

		self:__initial_func()
		self:__init_data()
		self:__init_reusable_cell()

		self._init_already = true
	end

	function arg_1_0:__init_data()
		self.__data_list = var_0_10.get_sequence()

		self:__update_data()
	end

	function arg_1_0:__init_reusable_cell()
		self:destroyChildren("single_fifth_restore_shop")

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainpage.scrollview.viewport.content.endlessScrollView, self._control.mainpage.scrollview.viewport.content, "single_ocean_cia", "fifth_restore_shop")

		self._reusable_cell:init()
		self:__update_cell()
	end

	function arg_1_0:__update_cell()
		local var_7_0 = self:__check_item_sell_out(self.__data_list)

		self._reusable_cell:set_data(var_7_0)

		function self._reusable_cell:_set_func(arg_8_1)
			self.btns.buy_btn.icon.image.sprite = self:loadSprite(var_0_5.fifth_event_const.joy.money_icon)

			self.btns.buy_btn.gameObject:SetActive(var_7_0[arg_8_1 + 1].buy_desc == "0")
			self.btns.active_btn.gameObject:SetActive(false)
			self.btns.disable_btn.gameObject:SetActive(var_7_0[arg_8_1 + 1].buy_desc ~= "0")

			self.btns.buy_btn.text.text.text = var_7_0[arg_8_1 + 1].score
			self.btns.active_btn.text.text.text = var_0_1:getNowLang("ui_4th_shop")
			self.btns.disable_btn.text.text.text = var_7_0[arg_8_1 + 1].buy_desc
			self._control.buy_msgbox.main.main_text.text.text.text = var_0_6(var_0_1:getNowLang("ui_4th_buff_change_content"), var_7_0[arg_8_1 + 1].score, var_7_0[arg_8_1 + 1].title)
			self.desc_text.text.text = var_0_1:convert_rich_text(var_7_0[arg_8_1 + 1].effect_desc)
			self.limit_text.text.text = var_0_1:convert_rich_text(var_7_0[arg_8_1 + 1].desc)

			self.silk_bg:SetActive(true)

			self.silk_bg.silk_text.text.text = var_0_6(var_0_1:getNowLang("ui_nokori"), var_7_0[arg_8_1 + 1].rest_num or var_7_0[arg_8_1 + 1].limit_num)

			self.title:GetComponent("TextHorizonScroller"):SetText(var_7_0[arg_8_1 + 1].title)

			self.icon_bg.icon.image.sprite = self:loadSprite(var_0_6(var_0_5.fifth_restore_shop_icon, var_7_0[arg_8_1 + 1].icon))

			self.btns.buy_btn.button.onClick:RemoveAllListeners()
			self.btns.buy_btn.button.onClick:AddListener(function()
				self._control.buy_msgbox.gameObject:SetActive(true)

				self._control.buy_msgbox.main.main_text.text.text.text = var_0_6(var_0_1:getNowLang("ui_4th_buff_change_content"), var_7_0[arg_8_1 + 1].score, var_7_0[arg_8_1 + 1].title)
				self._buy_item_info = var_7_0[arg_8_1 + 1]
			end)
		end
	end

	function arg_1_0.__check_item_sell_out(arg_10_0, arg_10_1)
		local var_10_0 = {}
		local var_10_1 = var_0_3:get_concerto_info().shop_items

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			local var_10_3 = false

			for iter_10_2, iter_10_3 in pairs(var_10_1) do
				if iter_10_1.id == iter_10_2 then
					if iter_10_3 < iter_10_1.limit_num then
						iter_10_1.rest_num = iter_10_1.limit_num - iter_10_3
					else
						var_10_3 = true
					end
				end
			end

			if not var_10_3 then
				table.insert(var_10_0, iter_10_1)
			end
		end

		return var_10_0
	end

	function arg_1_0:__update_data()
		local var_11_0 = var_0_3:get_concerto_info()

		if var_11_0 then
			self._control.top.score.score_num.text.text = tostring(var_11_0.recreation_point or 0)
		end
	end

	function arg_1_0:__buy_selected_item()
		if self._buy_item_info then
			self._control.buy_msgbox:SetActive(false)
			var_0_3:req_RecreationShopBuyReq(self._buy_item_info.id)
		end
	end

	function arg_1_0.__buy_succeed_func(arg_13_0, arg_13_1)
		if arg_13_1 then
			var_0_2:createInstance("msgbox"):showOnes(arg_13_1, function()
				arg_13_0:__update_data()
				arg_13_0:__update_cell()
			end, nil, var_0_1:getNowLang("logget"), var_0_5.msg_type.rewards)
		end
	end

	function arg_1_0:_play_into_se(arg_15_1)
		self:playSE(arg_15_1, false)
	end

	function arg_1_0.sort_rule(arg_16_0, arg_16_1)
		var_0_8(arg_16_1, function(arg_17_0, arg_17_1)
			return arg_17_0.id < arg_17_1.id
		end)

		return arg_16_1
	end

	function arg_1_0:__initial_func()
		local var_18_0 = {
			{
				nodetext = "ui_5th_joy_shop_title",
				node = self._control.top.title_text
			},
			{
				nodetext = "ui_5th_joy_shop_tip",
				node = self._control.top.title_text.desc_text
			},
			{
				nodetext = "ui_4th_buff_change_title",
				node = self._control.buy_msgbox.main.title_text
			},
			{
				nodetext = "cancel",
				node = self._control.buy_msgbox.main.quitbtn.text
			},
			{
				nodetext = "ensure",
				node = self._control.buy_msgbox.main.confirmbtn.text
			}
		}
		local var_18_1 = {
			init_language = function(self, arg_19_1)
				self.text.text = var_0_1:getNowLang(arg_19_1)
			end,
			init_active = function(self, arg_20_1)
				self.gameObject:SetActive(arg_20_1)
			end
		}

		for iter_18_0 = 1, #var_18_0 do
			var_18_1.init_language(var_18_0[iter_18_0].node, var_18_0[iter_18_0].nodetext)
		end
	end

	function arg_1_0.__onReset(arg_21_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_22_0)
	local var_22_0 = var_0_2:class("fifth_restore_shop")

	var_22_0.__data_list = {}

	gamecore.extend_obj(var_22_0)

	return var_22_0
end

return var_0_0
