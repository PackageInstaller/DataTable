local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_6 = string.format
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.furniture_shop_config

gamecore.UILoader:define("exchange_shop_panel", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__onUpdate()
		self._reusable_cell:update()
	end

	function arg_1_0:update_res_data()
		self:__init_fur_point()
		var_0_3:show(var_0_4:getNowLang("shopbuysuccess"))
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_furniture_list()
		end

		self:__init_furniture_shop_data()
		self:__init_fur_point()
		self:__update_cell()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.top_layer.title.text.text = var_0_4:getNowLang("exchangestore")
	end

	function arg_1_0:__init_furniture_shop_data()
		local var_7_0, var_7_1 = var_0_8:get_sequence()

		self._furniture_shop_config_list = var_7_0

		self:__get_sort_data(self._furniture_shop_config_list)
	end

	function arg_1_0:__init_fur_point()
		self._control.top_layer.diamon_node.diamond_num.text.text = var_0_1:get_use_info_data().furniture_point
	end

	function arg_1_0.__get_sort_data(arg_9_0, arg_9_1)
		var_0_2(arg_9_1, function(arg_10_0, arg_10_1)
			return arg_10_0.sort < arg_10_1.sort
		end)
	end

	function arg_1_0:__init_furniture_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.scrollview.viewport.content.endlessScrollView, self._control.scrollview.viewport.content, "single_mall_item", "exchange_shop_panel")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell()
		local var_12_0 = self._furniture_shop_config_list

		self._reusable_cell:set_data(self._furniture_shop_config_list)

		function self._reusable_cell:_set_func(arg_13_1)
			self.bg_lock:SetActive(false)
			self.pricebtn.tokenimg.gameObject:SetActive(false)

			self.equipimg.img.image.sprite = self:loadSprite(var_0_6(var_0_7.shop_item_bg, var_12_0[arg_13_1 + 1].icon))
			self.pricebtn.priceimg.image.sprite = self:loadSprite(var_0_7.dorm_exchange_shop_bg)

			self.pricebtn.priceimg.image:SetNativeSize()

			self.name_mask.equipname.text.text = var_12_0[arg_13_1 + 1].title

			self.name_mask:GetComponent("TextHorizonScroller"):SetText(var_12_0[arg_13_1 + 1].title)

			self.pricebtn.pricenumber.text.text = var_12_0[arg_13_1 + 1].furn_point

			self.numberof.gameObject:SetActive(false)
			self.equipimg.imgbtn.button.onClick:RemoveAllListeners()
			self.equipimg.imgbtn.button.onClick:AddListener(function()
				local var_14_0 = var_0_5:createInstance("item_info")

				var_14_0:show({
					type = 4,
					title = var_12_0[arg_13_1 + 1].title,
					describe = var_12_0[arg_13_1 + 1].desc,
					icon = var_12_0[arg_13_1 + 1].icon
				})
				var_14_0:set_listener(function()
					self:__set_item_info_panel_state()
				end, function()
					self:__set_exchange_shop_panel_state()
				end)
			end)
			self.pricebtn.button.onClick:RemoveAllListeners()
			self.pricebtn.button.onClick:AddListener(function()
				if var_12_0[arg_13_1 + 1].furn_point ~= 0 and var_0_1:get_use_info_data().furniture_point < var_12_0[arg_13_1 + 1].furn_point then
					var_0_3:show(var_0_4:getNowLang("errorcode_277"))

					return
				end

				var_0_5:createInstance("shop_bounced_repeat"):show({
					title = var_12_0[arg_13_1 + 1].title,
					price = var_12_0[arg_13_1 + 1].furn_point,
					id = var_12_0[arg_13_1 + 1].id
				}, "furniture")
			end)
		end
	end

	function arg_1_0:__set_item_info_panel_state()
		self:setVisible(true)
		var_0_5:getInstance("item_info"):setVisible(true)
	end

	function arg_1_0:__set_exchange_shop_panel_state()
		self:setVisible(false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_20_0)
	local var_20_0 = var_0_5:class("exchange_shop_panel")

	var_20_0._is_already_init = nil
	var_20_0._furniture_shop_config_list = {}
	var_20_0._reusable_cell = nil

	return var_20_0
end

return var_0_0
