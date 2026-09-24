local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_8 = table.sort
local var_0_9 = math.floor
local var_0_11 = gameconfig.ship_config
local var_0_12 = gameconfig.equip_config
local var_0_13 = gameconfig.pve_fifth_task_config
local var_0_14 = gameconfig.pve_fifth_award_config

gamecore.UILoader:define("fifth_awardbox", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_task_cell then
			self._reusable_task_cell:update()
		end

		if self._reusable_award_cell then
			self._reusable_award_cell:update()
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
		self:__update_task_cell()
		self:__update_award_cell()
	end

	function arg_1_0.set_close_func(arg_5_0, arg_5_1)
		arg_5_0._close_func = arg_5_1
	end

	function arg_1_0:__init_data()
		self._task_data, self._task_num = var_0_13.get_sequence()
		self._award_data, self._award_num = var_0_14.get_sequence()
		self._concerto_info = var_0_3:get_concerto_info()

		if self._concerto_info.point then
			self._control.awardbox_bg.top.topdescribe.prestige_bg.prestigenum_text.text.text = self._concerto_info.point or 0
		end

		for iter_6_0 = 1, #self._award_data do
			for iter_6_1 = 1, #self._award_data[iter_6_0].award do
				var_0_8(self._award_data[iter_6_0].award, function(arg_7_0, arg_7_1)
					return arg_7_0.id > arg_7_1.id
				end)
			end
		end
	end

	function arg_1_0:__init_reusable_cell()
		self:destroyChildren("fifth_taskmodel")

		self._control.awardbox_bg.middle.taskcontent.scrollview.scrollbarvertical.image.color = Color.New(0.2, 0.2, 0.2, 0)

		self._control.awardbox_bg.middle.taskcontent.scrollview.scrollbarvertical.slidingarea.gameObject:SetActive(false)

		self._control.awardbox_bg.middle.awardcontent.scrollview.scrollbarvertical.image.color = Color.New(0.2, 0.2, 0.2, 0)

		self._control.awardbox_bg.middle.awardcontent.scrollview.scrollbarvertical.slidingarea.gameObject:SetActive(false)

		self._reusable_task_cell = gamecore.reusable_cell:create(self, self._control.awardbox_bg.middle.taskcontent.scrollview.viewport.content.endlessScrollView, self._control.awardbox_bg.middle.taskcontent.scrollview.viewport.content, "fifth_taskmodel", "fifth_awardbox")

		self._reusable_task_cell:init()
		self:destroyChildren("fifth_awardbox_item")

		self._reusable_award_cell = gamecore.reusable_cell:create(self, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content.endlessScrollView, self._control.awardbox_bg.middle.awardcontent.scrollview.viewport.content, "fifth_awardbox_item", "fifth_awardbox")

		self._reusable_award_cell:init()
	end

	function arg_1_0:__update_task_cell()
		local var_9_0 = self._task_data

		self._reusable_task_cell:set_data(self._task_data)

		function self._reusable_task_cell:_set_func(arg_10_1)
			self.main.nametimefinish.namearea.taskname.text.text = var_9_0[arg_10_1 + 1].title
			self.main.nametimefinish.goal.goalmain.text.text = var_0_1:convert_rich_text(var_9_0[arg_10_1 + 1].condition_desc)
			self.main.taskreward.reward.text.text = var_0_1:getNowLang("pvecampaignrewardlabel")
			self.main.taskreward.rewartypeone.rewardname.text.text = var_9_0[arg_10_1 + 1].award
		end
	end

	function arg_1_0:__update_award_cell()
		local var_11_0 = self._award_data

		self._reusable_award_cell:set_data(self._award_data)

		function self._reusable_award_cell:_set_func(arg_12_1)
			local var_12_0 = {
				self.left.itemlist.item1,
				self.left.itemlist.item2,
				self.left.itemlist.item3,
				self.left.itemlist.item4,
				self.left.itemlist.item5,
				self.left.itemlist.item6
			}

			self.right.btn.text.text.text = var_0_1:getNowLang("mbtnget")

			for iter_12_0 = 1, #var_12_0 do
				var_12_0[iter_12_0].gameObject:SetActive(false)
			end

			self.left.title.text.text = var_0_1:getNowLang("ui_5th_reward_user_point")
			self.left.title.prestige_bg.prestigenum_text.text.text = var_11_0[arg_12_1 + 1].score

			local var_12_1 = 0

			for iter_12_1, iter_12_2 in pairs(var_11_0[arg_12_1 + 1].award) do
				var_12_1 = var_12_1 + 1

				var_12_0[var_12_1].gameObject:SetActive(true)

				var_12_0[var_12_1].img.image.sprite = self:loadSprite(var_0_6(var_0_5.normal_str, iter_12_2.id))

				if iter_12_2.count == 1 then
					var_12_0[var_12_1].text.text.text = nil
				else
					var_12_0[var_12_1].text.text.text = iter_12_2.count
				end

				if var_12_0[var_12_1].img.image.sprite == nil then
					var_12_0[var_12_1].img.image.sprite = self:loadSprite(var_0_6(var_0_5.normal_str, 10004761))
				end

				var_12_0[iter_12_1].rewardbg.image.sprite = (iter_12_2.id == 10046121 or iter_12_2.id == 10045721 or iter_12_2.id == 10042712) and self:loadSprite(var_0_6(var_0_5.buy_spoils_equip_bg, 4)) or (iter_12_2.id == 10045621 or iter_12_2.id == 10046021 or iter_12_2.id == 10045921) and self:loadSprite(var_0_6(var_0_5.buy_spoils_equip_bg, 5)) or iter_12_2.id == 10045821 and self:loadSprite(var_0_6(var_0_5.buy_spoils_equip_bg, 6)) or self:loadSprite(var_0_6(var_0_5.sign_bg_two))

				var_12_0[var_12_1].btn.button.onClick:RemoveAllListeners()
				var_12_0[var_12_1].btn.button.onClick:AddListener(function()
					if var_11_0[arg_12_1 + 1].award[iter_12_1].id == 10004561 then
						return
					end

					if var_11_0[arg_12_1 + 1].award[iter_12_1].id < 10000000 then
						if var_11_0[arg_12_1 + 1].award[iter_12_1].id == 10681 then
							var_0_2:createInstance("specificdetails"):show(var_11_0[arg_12_1 + 1].award[iter_12_1].id, var_0_5.enter_icon_detail_type.combatshop_cg)
						else
							var_0_2:createInstance("specificdetails"):show(var_11_0[arg_12_1 + 1].award[iter_12_1].id, var_0_5.enter_icon_detail_type.sign)
						end
					elseif var_0_9(var_11_0[arg_12_1 + 1].award[iter_12_1].id % 100) == 21 then
						if not nil then
							self._equip_attr = self:loadUI("equip_attr")
						end

						self._control.detail_shadow.gameObject:SetActive(true)

						if self._equip_attr then
							self._equip_attr._panel.transform.anchoredPosition = Vector2.New(0, 0)

							self._equip_attr:show((var_0_12.find_object_by_cid(var_11_0[arg_12_1 + 1].award[iter_12_1].id)))
						end
					else
						var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.bootyshop, (var_0_11.find_object_by_cid(var_11_0[arg_12_1 + 1].award[iter_12_1].id)))
					end
				end)
			end

			self.right.btn.gameObject:SetActive(var_11_0[arg_12_1 + 1].score <= self._concerto_info.point)
			self.shadow.gameObject:SetActive(false)
			self.right.already.gameObject:SetActive(false)
			self.right.btn.button.onClick:RemoveAllListeners()
			self.right.btn.button.onClick:AddListener(function()
				self.right.btn.gameObject:SetActive(false)
				self.shadow.gameObject:SetActive(true)
				self.right.already.gameObject:SetActive(true)
				var_0_3:req_ConcertoGetRewardReq(var_11_0[arg_12_1 + 1].id)
			end)

			if self._concerto_info.reward then
				for iter_12_3, iter_12_4 in pairs(self._concerto_info.reward) do
					if iter_12_4 == arg_12_1 + 1 then
						self.right.btn:SetActive(false)
						self.right.already:SetActive(true)
					end
				end
			end
		end
	end

	function arg_1_0:__award_msgbox_list(arg_15_1)
		self._control.award_msgbox.gameObject:SetActive(true)
		self._control.award_msgbox.main.gameObject:SetActive(true)

		local var_15_0 = {
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour,
			self._control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive
		}

		for iter_15_0 = 1, 5 do
			var_15_0[iter_15_0].gameObject:SetActive(false)
		end

		local var_15_1 = {}
		local var_15_2 = {}

		for iter_15_1, iter_15_2 in pairs(arg_15_1) do
			var_0_7(var_15_2, iter_15_2)
		end

		for iter_15_3, iter_15_4 in pairs(var_15_2) do
			if iter_15_4.type ~= 4 and iter_15_4.type ~= 1 and iter_15_4.id ~= 13 then
				var_0_7(var_15_1, iter_15_4)
			end
		end

		var_0_8(var_15_1, function(arg_16_0, arg_16_1)
			return arg_16_0.id < arg_16_1.id
		end)

		for iter_15_5 = 1, #var_15_1 do
			if var_15_1[iter_15_5].id ~= 10004561 then
				local var_15_3 = gameconfig.item_config.find_object_by_cid(var_15_1[iter_15_5].id).title

				var_15_0[iter_15_5].gameObject:SetActive(true)
				var_15_0[iter_15_5].title_mask:GetComponent("TextHorizonScroller"):SetText(var_15_3)

				var_15_0[iter_15_5].icon.image.sprite = self:loadSprite(var_0_6(var_0_5.icon.item_icon, var_15_1[iter_15_5].id))

				if var_15_1[iter_15_5].count == 1 then
					var_15_0[iter_15_5].number.text.text = nil
				else
					var_15_0[iter_15_5].number.text.text = var_15_1[iter_15_5].count
				end
			end
		end
	end

	function arg_1_0:_play_into_se(arg_17_1)
		self:playSE(arg_17_1, false)
	end

	function arg_1_0:__initial_func()
		local var_18_0 = {
			{
				nodetext = "ui_5th_reward",
				node = self._control.awardbox_bg.top.toptitle.text
			},
			{
				nodetext = "ui_5th_point",
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
		local var_18_1 = {
			{
				state = false,
				node = self._control.award_msgbox
			}
		}
		local var_18_2 = {
			init_language = function(self, arg_19_1, arg_19_2)
				self.text.text = var_0_1:getNowLang(arg_19_1)

				if arg_19_2 then
					self.text.text = self.text.text .. arg_19_2
				end
			end,
			init_active = function(self, arg_20_1)
				self.gameObject:SetActive(arg_20_1)
			end
		}

		for iter_18_0 = 1, #var_18_0 do
			var_18_2.init_language(var_18_0[iter_18_0].node, var_18_0[iter_18_0].nodetext, var_18_0[iter_18_0].extre_txt)
		end

		for iter_18_1 = 1, #var_18_1 do
			var_18_2.init_active(var_18_1[iter_18_1].node, var_18_1[iter_18_1].state)
		end
	end

	function arg_1_0.__onReset(arg_21_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_22_0)
	local var_22_0 = var_0_2:class("fifth_awardbox")

	var_22_0._task_data = nil
	var_22_0._award_data = nil
	var_22_0._concerto_info = nil
	var_22_0._close_func = nil

	gamecore.extend_obj(var_22_0)

	return var_22_0
end

return var_0_0
