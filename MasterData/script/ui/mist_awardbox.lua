local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_6 = gameenum.common_type
local var_0_7 = string.format
local var_0_9 = table.sort
local var_0_11 = gameconfig.pve_mist_award_config
local var_0_12 = gameconfig.ship_config
local var_0_13 = gameconfig.equip_config
local var_0_15 = gamecore.util_func
local var_0_16 = UnityEngine.Vector3

gamecore.UILoader:define("mist_awardbox", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self._active_info = arg_3_1

		self:setVisible(true)
		self:_init_panel()
	end

	function arg_1_0:_init_panel()
		self:__initial_func()
		self:__init_data()
		self:__init_reusable_cell()

		local var_4_0 = var_0_2:getInstance("nf_main_interface")

		if var_4_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_4_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end
	end

	function arg_1_0:__init_data()
		self._user_award_data = var_0_3:get_mist_award_data()
		self._data, self._num = var_0_11.get_sequence()

		for iter_5_0 = 1, #self._data do
			for iter_5_1 = 1, #self._data[iter_5_0].award do
				var_0_9(self._data[iter_5_0].award, function(arg_6_0, arg_6_1)
					return arg_6_0.id < arg_6_1.id
				end)
			end
		end

		self.__temprory_user_point = self._active_info.pass_score
		self._control.awardbox_bg.top.topdescribe.point_text.text.text = self._active_info.pass_score
	end

	function arg_1_0:__init_reusable_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content.endlessScrollView, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content, "strike_awardbox_item", "strike_awardbox")

		self._reusable_cell:init()
		self:__update_cell()
	end

	function arg_1_0:__update_cell()
		local var_8_0 = self._data

		self._user_award_data = var_0_3:get_mist_award_data()

		self._reusable_cell:set_data(self._data)

		function self._reusable_cell:_set_func(arg_9_1)
			self.right.btn.gameObject:SetActive(self.__temprory_user_point >= var_8_0[arg_9_1 + 1].score)
			self.right.lock.gameObject:SetActive(self.__temprory_user_point < var_8_0[arg_9_1 + 1].score)
			self.shadow.gameObject:SetActive(false)
			self.right.already.gameObject:SetActive(false)

			self.left.topdescribe.des_text.point_icon.image.sprite = self:loadSprite(var_0_7(var_0_6.mist_reward_icon, 31))

			if self._user_award_data[var_8_0[arg_9_1 + 1].id] then
				self.right.btn.gameObject:SetActive(false)
				self.right.lock.gameObject:SetActive(false)
				self.shadow.gameObject:SetActive(true)
				self.right.already.gameObject:SetActive(true)
			end

			self.left.topdescribe.des_text.text.text = var_0_1:getNowLang("mist_score2")
			self.left.topdescribe.des_text.point_text.text.text = var_8_0[arg_9_1 + 1].score

			local var_9_0 = {
				self.left.itemlist.item1,
				self.left.itemlist.item2,
				self.left.itemlist.item3,
				self.left.itemlist.item4,
				self.left.itemlist.item5,
				self.left.itemlist.item6
			}

			for iter_9_0 = 1, #var_9_0 do
				var_9_0[iter_9_0].gameObject:SetActive(false)
			end

			for iter_9_1 = 1, #var_8_0[arg_9_1 + 1].award do
				local var_9_1 = var_8_0[arg_9_1 + 1].award[iter_9_1].id

				var_9_0[iter_9_1].gameObject:SetActive(true)

				var_9_0[iter_9_1].rewardbg.image.sprite = self:loadSprite((var_0_15.get_item_star_bg_by_item_id(var_8_0[arg_9_1 + 1].award[iter_9_1].id)))
				var_9_0[iter_9_1].img.image.sprite = self:loadSprite(var_0_7(var_0_6.normal_str, var_8_0[arg_9_1 + 1].award[iter_9_1].id))

				if var_8_0[arg_9_1 + 1].award[iter_9_1].count > 1 then
					var_9_0[iter_9_1].text.gameObject:SetActive(true)

					var_9_0[iter_9_1].text.text.text = var_8_0[arg_9_1 + 1].award[iter_9_1].count
				else
					var_9_0[iter_9_1].text.gameObject:SetActive(false)
				end

				var_9_0[iter_9_1].btn.button.onClick:RemoveAllListeners()
				var_9_0[iter_9_1].btn.button.onClick:AddListener(function()
					if var_9_1 < 10000000 then
						if var_9_1 % 100 == 81 then
							var_0_2:createInstance("specificdetails"):show(var_9_1, var_0_6.enter_icon_detail_type.combatshop_cg)
						else
							var_0_2:createInstance("specificdetails"):show(var_9_1, var_0_6.enter_icon_detail_type.sign)
						end
					elseif var_9_1 % 100 == 21 then
						local var_10_0 = var_0_13.find_object_by_cid(var_9_1)

						if not self._equip_attr then
							self._equip_attr = self:loadUI("equip_attr")
						else
							self._equip_attr = {}
							self._equip_attr = self:loadUI("equip_attr")
						end

						self._equip_attr._panel.transform:SetParent(var_9_0[iter_9_1].rectTransform, false)

						self._equip_attr._panel.transform.anchoredPosition = Vector2.New(-63, -66)

						self._equip_attr._panel.transform:SetParent(self._control.rectTransform)

						self._equip_attr._panel.transform.anchoredPosition = Vector2.New(self._equip_attr._panel.transform.anchoredPosition.x, self._equip_attr._panel.transform.anchoredPosition.y < -117 and -117 or self._equip_attr._panel.transform.anchoredPosition.y)

						self._equip_attr._panel.transform:SetParent(var_9_0[iter_9_1].rectTransform)
						self._equip_attr:show(var_10_0)
						self._control.detail_shadow.gameObject:SetActive(true)
					elseif var_9_1 % 100 == 61 then
						-- block empty
					else
						local var_10_2 = var_0_2:createInstance("ship_detail")

						var_10_2:show(var_0_6.enter_ship_detail_type.bootyshop, (var_0_12.find_object_by_cid(var_9_1)))

						var_10_2._panel.transform:GetComponent("Canvas").sortingOrder = 505
					end
				end)
				self.right.btn.button.onClick:RemoveAllListeners()
				self.right.btn.button.onClick:AddListener(function()
					var_0_3:req_MistGetAwardReq(var_8_0[arg_9_1 + 1].id)
				end)
			end
		end
	end

	function arg_1_0.sort_rule(arg_12_0, arg_12_1)
		var_0_9(arg_12_1, function(arg_13_0, arg_13_1)
			return arg_13_0.id < arg_13_1.id
		end)

		return arg_12_1
	end

	function arg_1_0:_play_into_se(arg_14_1)
		self:playSE(arg_14_1, false)
	end

	function arg_1_0:__initial_func()
		local var_15_0 = {
			{
				nodetext = "mist_score",
				node = self._control.awardbox_bg.top.topdescribe.des_text
			}
		}
		local var_15_1 = {}
		local var_15_2 = {
			init_language = function(self, arg_16_1)
				self.text.text = var_0_1:getNowLang(arg_16_1)
			end,
			init_active = function(self, arg_17_1)
				self.gameObject:SetActive(arg_17_1)
			end
		}

		for iter_15_0 = 1, #var_15_0 do
			var_15_2.init_language(var_15_0[iter_15_0].node, var_15_0[iter_15_0].nodetext)
		end

		for iter_15_1 = 1, #var_15_1 do
			var_15_2.init_active(var_15_1[iter_15_1].node, var_15_1[iter_15_1].state)
		end

		function arg_1_0:__onReset()
			self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content.anchoredPosition = var_0_16(0, 0, 0)
		end
	end

	function arg_1_0.__onReset(arg_19_0)
		arg_19_0._reusable_cell = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_20_0)
	local var_20_0 = var_0_2:class("mist_awardbox")

	var_20_0._data = nil
	var_20_0._user_award_data = nil

	gamecore.extend_obj(var_20_0)

	return var_20_0
end

return var_0_0
