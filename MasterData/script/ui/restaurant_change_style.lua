local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_7 = gameconfig.cook_style_config

gamecore.UILoader:define("restaurant_change_style", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		local var_2_0 = 1

		if arg_2_1 == 11145 then
			var_2_0 = 1
		elseif arg_2_1 == 11245 then
			var_2_0 = 2
		elseif arg_2_1 == 11345 then
			var_2_0 = 3
		elseif arg_2_1 == 11445 then
			var_2_0 = 4
		elseif arg_2_1 == 11545 then
			var_2_0 = 5
		end

		self._now_selected_style = var_2_0

		self:__init_panel()
	end

	function arg_1_0:contrast_data()
		for iter_3_0, iter_3_1 in pairs((var_0_1:get_restaurant_style())) do
			local var_3_0 = 0

			for iter_3_2, iter_3_3 in ipairs(self._my_style) do
				if iter_3_3.id == iter_3_1 then
					var_3_0 = iter_3_2
				end
			end

			self._my_style[var_3_0].is_have = true
		end
	end

	function arg_1_0:set_lock_txt()
		local var_4_0 = {
			self._control.bg.scrollview.viewport.content.style_1.lv_1,
			self._control.bg.scrollview.viewport.content.style_1.lv_2,
			self._control.bg.scrollview.viewport.content.style_1.lv_3,
			self._control.bg.scrollview.viewport.content.style_2.lv_1,
			self._control.bg.scrollview.viewport.content.style_3.lv_1
		}

		for iter_4_0 = 1, #var_4_0 do
			if self._my_style[iter_4_0].is_have then
				var_4_0[iter_4_0].lock_txt.text.text = var_0_2:getNowLang("restaurantstylepopular1")
				var_4_0[iter_4_0].normal.image.sprite = self:loadSprite(var_0_4.restaurant_const.unselect)
			else
				var_4_0[iter_4_0].lock_txt.text.text = var_0_5(var_0_2:getNowLang("restaurantstylepopular2"), var_0_7.find_object_by_cid(self._my_style[iter_4_0].id).total_popularity)
				var_4_0[iter_4_0].normal.image.sprite = self:loadSprite(var_0_4.restaurant_const.unselect1)
			end
		end

		self:set_panel_by_style(self._now_selected_style)

		var_4_0[self._now_selected_style].toggle.isOn = true
	end

	function arg_1_0:set_panel_by_style(arg_5_1)
		self._now_selected_style = arg_5_1
		self._control.bg.restaurant_bg.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.restaurant_bg_s, self._my_style[arg_5_1].id))
		self._control.bg.restaurant_bg.tips.text.text = var_0_7.find_object_by_cid(self._my_style[arg_5_1].id).desc

		self._control.bg.not_use:SetActive(not self._my_style[arg_5_1].is_have)
	end

	function arg_1_0:reset_toggle()
		self._control.bg.scrollview.viewport.content.style_1.lv_1.toggle.isOn = true
	end

	function arg_1_0:set_style_success()
		var_0_3:getInstance("restaurant"):set_restaurant_style()
		self:reset_toggle()
		self:setVisible(false)
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
		end

		self:__init_style_tab()
		self:contrast_data()
		self:set_lock_txt()

		self._is_already_init = true
	end

	function arg_1_0:__init_style_tab()
		self._my_style = {}

		for iter_9_0, iter_9_1 in ipairs(var_0_3:getInstance("restaurant")._restaurant_style_config) do
			table.insert(self._my_style, {
				is_have = false,
				id = iter_9_1.cid
			})
		end
	end

	function arg_1_0:__init_language()
		self._control.bg.changestyle.text.text = var_0_2:getNowLang("changestyle")
		self._control.bg.styleselect.text.text = var_0_2:getNowLang("styleselect")
		self._control.bg.scrollview.viewport.content.style_1.title.text.text = var_0_2:getNowLang("restauranttype1")
		self._control.bg.scrollview.viewport.content.style_2.title.text.text = var_0_2:getNowLang("restauranttype2")
		self._control.bg.scrollview.viewport.content.style_3.title.text.text = var_0_2:getNowLang("restauranttype3")
	end

	function arg_1_0:__play_enlarge_animation()
		self._control.bg.transform.localScale = Vector3.New(0, 0, 0)

		self._control.bg.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack)
	end

	function arg_1_0:__play_narrow_animation()
		self._control.bg.transform.localScale = Vector3.New(1, 1, 1)
		self._control.bg.transform:DOScale(0, 0.3):SetEase(DG.Tweening.Ease.InQuint).onComplete = function()
			self:setVisible(false)
		end
	end

	function arg_1_0:__onVisible(arg_14_1)
		if arg_14_1 then
			self:__play_enlarge_animation()
		end
	end

	function arg_1_0:_play_into_se(arg_15_1)
		self:playSE(arg_15_1, false)
	end

	function arg_1_0.__onReset(arg_16_0)
		arg_16_0._my_style = {}
		arg_16_0._now_selected_style = 0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_17_0)
	local var_17_0 = var_0_3:class("restaurant_change_style")

	var_17_0._is_already_init = false
	var_17_0._my_style = {}
	var_17_0._now_selected_style = 0

	return var_17_0
end

return var_0_0
