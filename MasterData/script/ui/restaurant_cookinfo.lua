local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_6 = gameconfig.cook_book_config
local var_0_10 = gamecore.prompt
local var_0_11 = {
	have_set = "have_set",
	no_use = "no_use",
	no_have = "no_have",
	have = "have"
}

gamecore.UILoader:define("restaurant_cookinfo", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self:setVisible(true)

		arg_2_5 = arg_2_5 or var_0_4.enter_restaurant_type.myself

		local var_2_0 = var_0_3:getInstance("chest_open_layer")

		if var_2_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_2_0._panel.transform:GetComponent("Canvas").sortingOrder + 102
		end

		self._enter_type = arg_2_5
		self._friend_data = arg_2_6

		if self._enter_type == var_0_4.enter_restaurant_type.friend then
			var_0_1:set_friend_restaurant_data(self._friend_data)
		end

		self:__init_panel(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end

	function arg_1_0:set_cookbook_layer(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		self._control.cook_get_info:SetActive(false)

		local var_3_0 = var_0_1:get_restaurant_have_cookbook()
		local var_3_1 = var_0_6.find_object_by_cid(arg_3_2)
		local var_3_2 = self._control.cook_info

		self._food_cid = arg_3_2
		self._tyle = arg_3_1

		self:set_cookbook_info(arg_3_2, var_3_2.single_food_able)

		var_3_2.name_txt.text.text = var_3_1.title
		var_3_2.desc.text.text = string.gsub(var_3_1.effect_desc, "%^C[^%^]+", function(arg_4_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_4_0, 3, 10), (string.sub(arg_4_0, 19, #arg_4_0)))
		end)
		var_3_2.consume.text.text = var_0_2:getNowLang("cookcost")
		var_3_2.consume_item_1.count.text.text = var_3_1.oil
		var_3_2.consume_item_2.count.text.text = var_3_1.ammo
		var_3_2.consume_item_3.count.text.text = var_3_1.steel
		var_3_2.consume_item_4.count.text.text = var_3_1.aluminium

		var_3_2.set_btn:SetActive(true)
		var_3_2.no_use:SetActive(false)

		if arg_3_1 == 1 then
			if arg_3_3 then
				if arg_3_4 == var_0_11.have then
					var_3_2.set_btn.txt.text.text = var_0_2:getNowLang("settingmenu")
					self._now_cookbook_info_tyle = 1
				elseif arg_3_4 == var_0_11.have_set then
					var_3_2.set_btn.txt.text.text = var_0_2:getNowLang("xiexiacaipu")
					self._now_cookbook_info_tyle = 2
				elseif arg_3_4 == var_0_11.no_use then
					var_3_2.set_btn:SetActive(false)
					var_3_2.no_use:SetActive(true)
				else
					var_3_2.set_btn:SetActive(false)
				end
			else
				var_3_2.set_btn.txt.text.text = var_0_2:getNowLang("xiexiacaipu")
				self._now_cookbook_info_tyle = 2
			end
		else
			var_3_2.set_btn.txt.text.text = var_0_2:getNowLang("use")
		end

		var_3_2:SetActive(true)
	end

	function arg_1_0:set_cookbook_info(arg_5_1, arg_5_2)
		local var_5_0 = var_0_6.find_object_by_cid(arg_5_1)

		arg_5_2.food_quality.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.food_quality, var_5_0.star))
		arg_5_2.food_quality.food_cover.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.food_cover, var_5_0.star))
		arg_5_2.food_quality.food_small.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.cook_book_icon, var_5_0.icon))
		arg_5_2.food_quality.food_small.transform.localScale = Vector3.New(1, 1, 1)

		local var_5_1 = var_0_1:get_restaurant_the_cook_cookbook(arg_5_1)

		if self._enter_type == var_0_4.enter_restaurant_type.friend then
			for iter_5_0, iter_5_1 in pairs(var_0_1:get_friend_info(self._friend_data.account_id).cook.cookbook) do
				if self._food_cid == iter_5_1.id and iter_5_1.exp < 100 then
					var_5_1 = iter_5_1.exp

					break
				elseif self._food_cid == iter_5_1.id and iter_5_1.exp >= 100 then
					var_5_1 = 100

					break
				end
			end
		end

		local var_5_2 = tostring(var_5_1) .. " / 100"

		if var_5_1 >= 100 then
			arg_5_2.progress.exp_text.text.text = "MAX"
		end

		arg_5_2.progress.scrollview:GetComponent("ScrollRect").enabled = #var_5_0.desc2 > 180
		arg_5_2.progress.scrollview.content.cook_desc.text.text = var_5_0.desc2
	end

	function arg_1_0:set_cookbook_get_layer(arg_6_1)
		self._control.cook_info:SetActive(false)

		local var_6_0 = var_0_1:get_restaurant_have_cookbook()
		local var_6_1 = var_0_6.find_object_by_cid(arg_6_1)

		self:set_cookbook_get_info(arg_6_1, self._control.cook_get_info.single_food_able)

		self._control.cook_get_info.name_txt.text.text = var_6_1.title
		self._control.cook_get_info.desc.text.text = string.gsub(var_6_1.effect_desc, "%^C[^%^]+", function(arg_7_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_7_0, 3, 10), (string.sub(arg_7_0, 19, #arg_7_0)))
		end)
		self._control.cook_get_info.consume.text.text = var_0_2:getNowLang("cookcost")
		self._control.cook_get_info.consume_item_1.count.text.text = var_6_1.oil
		self._control.cook_get_info.consume_item_2.count.text.text = var_6_1.ammo
		self._control.cook_get_info.consume_item_3.count.text.text = var_6_1.steel
		self._control.cook_get_info.consume_item_4.count.text.text = var_6_1.aluminium

		self._control.cook_get_info:SetActive(true)
	end

	function arg_1_0:set_cookbook_get_info(arg_8_1, arg_8_2)
		local var_8_0 = var_0_6.find_object_by_cid(arg_8_1)

		arg_8_2.food_quality.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.food_quality, var_8_0.star))
		arg_8_2.food_quality.food_cover.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.food_cover, var_8_0.star))
		arg_8_2.food_quality.food_small.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.cook_book_icon, var_8_0.icon))
		arg_8_2.food_quality.food_small.transform.localScale = Vector3.New(1, 1, 1)
		arg_8_2.progress.scrollview:GetComponent("ScrollRect").enabled = not not (#var_8_0.desc2 > 180 or gamecore.util_func.check_channel_is_en())
		arg_8_2.progress.scrollview.content.cook_desc.text.text = var_8_0.desc2
	end

	function arg_1_0.is_have_buff(arg_9_0)
		local var_9_1 = var_0_1:get_restaurant_cookbook_buff()

		return (var_9_1.id and lx.ServerTime:getUtcTime() < var_9_1.end_time or nil) and true
	end

	function arg_1_0:__can_cook()
		local var_10_0 = var_0_1:get_use_info_data()

		if (self._enter_type == var_0_4.enter_restaurant_type.friend and var_10_0.friend_cook_count or var_10_0.cook_count) >= 3 then
			var_0_10:show(var_0_2:getNowLang("cook_count_tip"))
		elseif self._enter_type == var_0_4.enter_restaurant_type.friend or self._enter_type == var_0_4.enter_restaurant_type.cardbook or self._enter_type == var_0_4.enter_restaurant_type.tower then
			var_0_1:req_UseFriendCookBookReq({
				id = self._food_cid,
				account_id = self._friend_data.account_id
			})
		else
			var_0_1:req_UseCookBookReq(self._food_cid)
		end
	end

	function arg_1_0:__init_panel(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		if not self._is_already_init then
			self:__init_language()
		end

		if self._enter_type ~= var_0_4.enter_restaurant_type.get_info then
			self:set_cookbook_layer(arg_11_1, arg_11_2, arg_11_3, arg_11_4)

			self._is_already_init = true
		elseif self._enter_type == var_0_4.enter_restaurant_type.get_info then
			self:set_cookbook_get_layer(arg_11_2)

			self._is_already_init = true
		end
	end

	function arg_1_0:__init_language()
		self._control.cook_info.title.text.text = var_0_2:getNowLang("fooddetailtitle")
		self._control.cook_info.consume.text.text = var_0_2:getNowLang("cookcost")
		self._control.cook_info.single_food_able.progress.level.text.text = var_0_2:getNowLang("goodat")
		self._control.cook_info.no_use.txt.text.text = var_0_2:getNowLang("disable")
		self._control.new_buff.tip.text.text = var_0_2:getNowLang("newbuffwillcoveroldbuff")
		self._control.new_buff.cancel_btn.txt.text.text = var_0_2:getNowLang("ui_cbtn2")
		self._control.new_buff.confirm_btn.txt.text.text = var_0_2:getNowLang("ui_cbtn1")
	end

	function arg_1_0:_play_into_se(arg_13_1)
		self:playSE(arg_13_1, false)
	end

	function arg_1_0:_play_audio(arg_14_1)
		self:playBackgroundMusic(arg_14_1)
	end

	function arg_1_0.__onReset(arg_15_0)
		arg_15_0._enter_type = nil
		arg_15_0._friend_data = nil
		arg_15_0._food_cid = nil
		arg_15_0._now_cookbook_info_tyle = nil
		arg_15_0._tyle = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_16_0)
	local var_16_0 = var_0_3:class("restaurant_cookinfo")

	var_16_0._is_already_init = false
	var_16_0._enter_type = nil
	var_16_0._friend_data = nil
	var_16_0._food_cid = nil
	var_16_0._now_cookbook_info_tyle = nil
	var_16_0._tyle = nil

	return var_16_0
end

return var_0_0
