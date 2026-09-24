local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_6 = string.format
local var_0_7 = gamecore.util_func
local var_0_8 = gameenum.common_type

gamecore.UILoader:define("shop_bounced", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:setVisible(true)

		self._control.main.confirmbtn.image.sprite = self:loadSprite("data/ui/common/common_btn_bg_16.png")
		self._control.main.confirmbtn.text.text.color = Color.New(0, 0, 0)
		self._enter_panel_type = nil

		if arg_2_2 then
			self._enter_panel_type = arg_2_2
		end

		self.confirm_func = arg_2_3

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:show_blue(arg_3_1, arg_3_2, arg_3_3)
		self:setVisible(true)

		self._control.main.confirmbtn.image.sprite = self:loadSprite("data/ui/common/common_btn_bg_15.png")
		self._control.main.confirmbtn.text.text.color = Color.New(1, 1, 1)
		self._enter_panel_type = nil

		if arg_3_2 then
			self._enter_panel_type = arg_3_2
		end

		self.confirm_func = arg_3_3

		self:__init_panel(arg_3_1)
	end

	function arg_1_0:get_curr_enter_panel()
		return self._enter_panel_type
	end

	function arg_1_0:__init_panel(arg_5_1)
		self._control.main.closebtn.gameObject:SetActive(false)
		self._control.main.diamond_icon.gameObject:SetActive(true)
		self._control.main.combat_icon.gameObject:SetActive(false)

		self._control.main.title.text.text = not arg_5_1.lang_title and var_0_4:getNowLang("shopconfirmbuy") or arg_5_1.lang_title
		self._control.main.confirmbtn.text.text.text = var_0_4:getNowLang("ui_cbtn1")
		self._control.main.quitbtn.text.text.text = var_0_4:getNowLang("ui_cbtn2")
		self._already_init = true

		self._control.main.main_text:SetActive(true)
		self._control.main.change_user_name:SetActive(false)

		if self._enter_panel_type == var_0_8.buy_enter_type.mall_shop then
			self:__show_change_name_view(arg_5_1)
		elseif self._enter_panel_type == var_0_8.buy_enter_type.exchange_shop_panel then
			var_0_8:play_in_out_animation(self._control.maskbg.uITweenSequence, true)
			self:__set_arrow_state(false)

			self._control.main.main_text.use.text.text = var_0_6(var_0_4:getNowLang("shopconfirmbuyfurniture"), arg_5_1.price, arg_5_1.title)
		elseif self._enter_panel_type == var_0_8.buy_enter_type.exchangel_campaign_panel then
			self:__show_diamond_calculate_data(arg_5_1)
			self:__set_arrow_state(true)

			self._control.main.main_text.use.text.text = var_0_6(var_0_4:getNowLang("campaignresettip"), arg_5_1.price, arg_5_1.title)
		elseif self._enter_panel_type == var_0_8.buy_enter_type.combat_shop then
			self:__show_diamond_calculate_data(arg_5_1, self._enter_panel_type)
			self:__set_arrow_state(true)
			self._control.main.diamond_icon.gameObject:SetActive(false)
			self._control.main.combat_icon.gameObject:SetActive(true)

			self._control.main.main_text.use.text.text = var_0_6(var_0_4:getNowLang("combatshopconfirmbuycontent"), arg_5_1.price, arg_5_1.title)
		else
			self:__show_normal_prompt_info(arg_5_1)
		end

		self._now_select_item_data = arg_5_1
	end

	function arg_1_0:__show_normal_prompt_info(arg_6_1)
		self:__show_diamond_calculate_data(arg_6_1)
		self:__set_arrow_state(true)

		self._control.main.main_text.use.text.text = not arg_6_1.is_sale and var_0_6(var_0_4:getNowLang("shopconfirmbuycontent"), arg_6_1.price, arg_6_1.title) or var_0_7._get_open_time(arg_6_1.sale_start_time, arg_6_1.sale_end_time) and var_0_6(var_0_4:getNowLang("shopconfirmbuycontent"), arg_6_1.discount, arg_6_1.title) or var_0_6(var_0_4:getNowLang("shopconfirmbuycontent"), arg_6_1.price, arg_6_1.title)
	end

	function arg_1_0:__show_diamond_calculate_data(arg_7_1, arg_7_2)
		local var_7_0 = self._control.main.former_num.arrow.latter_num

		if arg_7_2 == var_0_8.buy_enter_type.combat_shop then
			local var_7_1 = var_0_1:_get_six_info()

			self._control.main.former_num.text.text = var_7_1.token

			local var_7_2 = var_7_1.token - arg_7_1.price

			if var_7_1.token - arg_7_1.price < 0 then
				var_7_2 = var_0_4:getNowLang("token_lack")
				var_7_0.text.color = Color.New(0.9058823529411765, 0.0196078431372549, 0)
			else
				var_7_0.text.color = Color.New(0, 0.6862745098039216, 0.9333333333333333)
			end

			var_7_0.text.text = var_7_2
		else
			local var_7_3 = var_0_1:get_use_info_data()

			self._control.main.former_num.text.text = var_7_3.diamond

			local var_7_4 = 0

			var_7_4 = not arg_7_1.is_sale and var_7_3.diamond - arg_7_1.price or var_0_7._get_open_time(arg_7_1.sale_start_time, arg_7_1.sale_end_time) and var_7_3.diamond - arg_7_1.discount or var_7_3.diamond - arg_7_1.price

			if var_7_4 < 0 then
				var_7_4 = var_0_4:getNowLang("errorcode_010")
				var_7_0.text.color = Color.New(0.9058823529411765, 0.0196078431372549, 0)
			else
				var_7_0.text.color = Color.New(0, 0.6862745098039216, 0.9333333333333333)
			end

			var_7_0.text.text = var_7_4
			self._control.main.diamond_icon.image.sprite = self:loadSprite(var_0_6(var_0_8.common_icon.common_source, 5))
		end
	end

	function arg_1_0.__show_token_calculate_data(arg_8_0, arg_8_1)
		return
	end

	function arg_1_0:__set_arrow_state(arg_9_1)
		self._control.main.former_num:SetActive(arg_9_1)
		self._control.main.diamond_icon:SetActive(arg_9_1)
	end

	function arg_1_0:_play_into_se(arg_10_1)
		self:playSE(arg_10_1, false)
	end

	function arg_1_0:__show_change_name_view(arg_11_1)
		self._control.main.main_text:SetActive(false)
		self._control.main.change_user_name:SetActive(true)

		local var_11_0, var_11_1 = var_0_7.calculate_utf8_char_length(arg_11_1.name)

		while var_11_0 > var_0_8.shop_const.name_length do
			arg_11_1.name = var_0_7.utf8sub(arg_11_1.name, 1, var_11_1 - 1)
			var_11_0, var_11_1 = var_0_7.calculate_utf8_char_length(arg_11_1.name)
		end

		self._control.main.change_user_name.user_name.text.text = var_0_6(var_0_4:getNowLang("renametxt5", true), arg_11_1.name)
		self._control.main.change_user_name.diamond_des.text.text = var_0_6("%s%s%s", var_0_4:getNowLang("renametxt33"), arg_11_1.price, var_0_4:getNowLang("renametxt44"))

		self:__show_diamond_calculate_data(arg_11_1)
		self:__set_arrow_state(true)
	end

	function arg_1_0.__show_buff_stone_coin_info(arg_12_0, arg_12_1)
		return
	end

	function arg_1_0:__show_tactical_machine(arg_13_1)
		local var_13_0 = var_0_1:get_item(var_0_8.analysis_card.normal_ticket)
		local var_13_1 = var_0_1:get_item(var_0_8.analysis_card.advanced_ticket)
		local var_13_2 = var_0_1:get_item(var_0_8.analysis_card.special_ticket)
		local var_13_3 = (var_13_1 and var_13_1.count or 0) + (var_13_2 and var_13_2.count or 0)
		local var_13_4 = self._control.main.former_num.arrow.latter_num
		local var_13_5

		if arg_13_1.typeof == var_0_8.tactical_machine_type.lower then
			var_13_5 = (var_13_0 and var_13_0.count or 0) - arg_13_1.price
			self._control.main.diamond_icon.image.sprite = self:loadSprite(var_0_8.analysis_card.tower_buff_stone_1)
		else
			var_13_5 = var_13_3 - arg_13_1.price
			self._control.main.diamond_icon.image.sprite = self:loadSprite(var_0_8.analysis_card.tower_buff_stone_2)
		end

		if var_13_5 < 0 then
			var_13_5 = var_0_4:getNowLang("ui_tower_buff_stone_zero")
			var_13_4.text.color = Color.New(0.9058823529411765, 0.0196078431372549, 0)
		else
			var_13_4.text.color = Color.New(0, 0.6862745098039216, 0.9333333333333333)
		end

		var_13_4.text.text = var_13_5
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_14_0)
	local var_14_0 = var_0_5:class("shop_bounced")

	var_14_0._now_select_item_data = {}
	var_14_0._enter_panel_type = nil
	var_14_0._already_init = false

	return var_14_0
end

return var_0_0
