local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.specil_login_award_config
local var_0_7 = string.format
local var_0_9 = gameconfig.ship_config
local var_0_11 = table.sort
local var_0_12 = UnityEngine.Vector2

gamecore.UILoader:define("sp_sign", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show()
		self:setVisible(true)
		var_0_3:set_close_sp_sign(true)
		self:updata_info()
		self:__init_panel()
		self:__update_cell()
	end

	function arg_1_0.updata_info(arg_4_0)
		arg_4_0._user_data = var_0_3:get_use_info_data()
		arg_4_0._data, arg_4_0._num = var_0_6:get_sequence()
	end

	function arg_1_0:__init_sign_list()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.main.main.sign_main.scrollview.viewport.content.endlessScrollView, self._control.main.main.sign_main.scrollview.viewport.content, "sp_sign_cell", "sp_sign")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__update_cell()
		self.sign_day = self._user_data.once_login_award.cumulative_days
		self._control.main.main.sign_main.scrollview.viewport.content.rectTransform.anchoredPosition = self.sign_day == 1 and var_0_12(1.3, 0) or var_0_12(1.3, (self.sign_day - 1) * 140)

		local var_6_0 = self._data

		self.data_length = #self._data

		local var_6_1 = self._user_data.once_login_award.is_already_get

		if self.sign_day > 10 then
			var_0_2:getInstance("home")._control.bottom.main_float_content.main_float_5:SetActive(false)
		end

		self._reusable_cell:set_data(var_6_0)

		function self._reusable_cell:_set_func(arg_7_1)
			local var_7_0 = {
				self.item.rewardone_item_1,
				self.item.rewardone_item_2,
				self.item.rewardone_item_3,
				self.item.rewardone_item_4
			}

			self._contents = var_7_0

			for iter_7_0 = 1, #var_6_0 do
				self.is_have.day.text.text = var_6_0[arg_7_1 + 1].tips
			end

			self.is_have.day.gameObject:SetActive(true)
			self.is_have.btn.gameObject:SetActive(false)
			self.is_have.text.gameObject:SetActive(false)

			self.is_have.btn.text.text.text = var_0_1:getNowLang("marketingbtnget")
			self.is_have.text.text.text = var_0_1:getNowLang("marketinghaveget")

			for iter_7_1 = 1, 4 do
				var_7_0[iter_7_1].gameObject:SetActive(false)
			end

			var_0_11(var_6_0[arg_7_1 + 1].award, function(arg_8_0, arg_8_1)
				if arg_8_0.value == arg_8_1.value then
					return arg_8_0.id < arg_8_1.id
				end

				return arg_8_0.value < arg_8_1.value
			end)

			for iter_7_2 = 1, #var_6_0[arg_7_1 + 1].award do
				if var_6_0[arg_7_1 + 1].id == 2 then
					var_0_11(var_6_0[2].award, function(arg_9_0, arg_9_1)
						if arg_9_0.value == arg_9_1.value then
							return arg_9_0.id < arg_9_1.id
						end

						return arg_9_0.value < arg_9_1.value
					end)
				end

				if var_6_0[arg_7_1 + 1].id == 10 then
					var_0_11(var_6_0[10].award, function(arg_10_0, arg_10_1)
						return arg_10_0.id > arg_10_1.id
					end)
				end

				local var_7_1 = var_6_0[arg_7_1 + 1].award[iter_7_2].id

				var_7_0[iter_7_2].gameObject:SetActive(true)
				var_7_0[iter_7_2].finish:SetActive(false)

				if var_6_0[arg_7_1 + 1].award[iter_7_2].value == 1 then
					var_7_0[iter_7_2].number.text.text = nil
				else
					var_7_0[iter_7_2].number.text.text = var_6_0[arg_7_1 + 1].award[iter_7_2].value
				end

				var_7_0[iter_7_2].reward.image.sprite = self:loadSprite(var_0_7(var_0_5.normal_str, var_6_0[arg_7_1 + 1].award[iter_7_2].id))

				if var_7_0[iter_7_2].reward.image.sprite == nil then
					var_7_0[iter_7_2].reward.image.sprite = self:loadSprite(var_0_7(var_0_5.normal_str, 0))
				end

				var_7_0[iter_7_2].rewardbg.image.sprite = var_7_1 ~= 10009711 and self:loadSprite(var_0_7(var_0_5.sign_bg_two)) or self:loadSprite(var_0_7(var_0_5.buy_spoils_equip_bg, var_0_9.find_object_by_cid(var_7_1).star))

				var_7_0[iter_7_2].btn.button.onClick:RemoveAllListeners()
				var_7_0[iter_7_2].btn.button.onClick:AddListener(function()
					if var_7_1 ~= 10009711 then
						local var_11_0 = var_0_2:createInstance("specificdetails")

						if var_7_1 == 10781 then
							var_11_0:show(var_7_1, var_0_5.enter_icon_detail_type.bootyshop_cg)
						else
							var_11_0:show(var_7_1, var_0_5.enter_icon_detail_type.sign)
						end
					else
						var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.upgradeawards, (var_0_9.find_object_by_cid(var_7_1)))
					end
				end)
			end

			self.is_have.day.gameObject:SetActive(true)
			self.is_have.btn.gameObject:SetActive(false)
			self.is_have.text.gameObject:SetActive(false)

			for iter_7_3 = 1, #var_6_0[arg_7_1 + 1].award do
				var_7_0[iter_7_3].rewardbg.image.sprite = var_6_0[arg_7_1 + 1].award[iter_7_3].id ~= 10009711 and self:loadSprite(var_0_7(var_0_5.sign_bg_two)) or self:loadSprite(var_0_7(var_0_5.buy_spoils_equip_bg, var_0_9.find_object_by_cid(var_6_0[arg_7_1 + 1].award[iter_7_3].id).star))
			end

			if not var_6_1 and self.sign_day == 1 then
				if self.sign_day == var_6_0[arg_7_1 + 1].id then
					self.is_have.day.gameObject:SetActive(false)
					self.is_have.btn.gameObject:SetActive(true)
					self.is_have.text.gameObject:SetActive(false)
				end
			elseif var_6_1 then
				for iter_7_4 = 1, self.sign_day - 1 do
					if iter_7_4 == var_6_0[arg_7_1 + 1].id or self.sign_day > 10 then
						self.is_have.day.gameObject:SetActive(false)
						self.is_have.btn.gameObject:SetActive(false)
						self.is_have.text.gameObject:SetActive(true)

						for iter_7_5 = 1, #var_6_0[arg_7_1 + 1].award do
							var_7_0[iter_7_5].finish:SetActive(true)
						end
					end
				end
			elseif not var_6_1 and self.sign_day > 1 then
				for iter_7_6 = 1, self.sign_day - 1 do
					if iter_7_6 == var_6_0[arg_7_1 + 1].id then
						self.is_have.day.gameObject:SetActive(false)
						self.is_have.btn.gameObject:SetActive(false)
						self.is_have.text.gameObject:SetActive(true)

						for iter_7_7 = 1, #var_6_0[arg_7_1 + 1].award do
							var_7_0[iter_7_7].finish:SetActive(true)
						end
					end

					if self.sign_day == var_6_0[arg_7_1 + 1].id then
						self.is_have.day.gameObject:SetActive(false)
						self.is_have.btn.gameObject:SetActive(true)
						self.is_have.text.gameObject:SetActive(false)
					end
				end
			end

			self.is_have.btn.button.onClick:RemoveAllListeners()
			self.is_have.btn.button.onClick:AddListener(function()
				self.is_have.btn.gameObject:SetActive(false)
				var_0_3:req_Sp_signin()
			end)
		end
	end

	function arg_1_0:__init_panel()
		self._control.main.main.sign_main.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_12(1.3, 0)

		var_0_5:play_in_out_animation(self._control.mask.uITweenSequence, true)

		self._control.main.main.introduce.introduce_text.text.text = var_0_1:getNowLang("UI_Special_Login_Tip")

		self:__init_sign_list()
	end

	function arg_1_0:__play_into_se(arg_14_1)
		self:playSE(arg_14_1, false)
	end

	function arg_1_0.__onReset(arg_15_0)
		arg_15_0._need_sign = false
		arg_15_0._user_data = {}
		arg_15_0._data = {}
		arg_15_0._num = nil
		arg_15_0._now_label = nil
		arg_15_0._sign_array = {}
		arg_15_0._data_sign_array = {}
		arg_15_0.sign_day = nil
		arg_15_0._now_award_length = nil
		arg_15_0._contents = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_16_0)
	local var_16_0 = var_0_2:class("sp_sign")

	var_16_0._need_sign = false
	var_16_0._user_data = {}
	var_16_0._reusable_cell = nil
	var_16_0._data = {}
	var_16_0._num = nil
	var_16_0._now_label = nil
	var_16_0._sign_array = {}
	var_16_0._data_sign_array = {}
	var_16_0.sign_day = nil
	var_16_0.data_length = nil
	var_16_0._now_award_length = nil
	var_16_0._contents = nil
	var_16_0._already_init = false

	return var_16_0
end

return var_0_0
