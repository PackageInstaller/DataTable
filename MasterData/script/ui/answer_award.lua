local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = math.floor
local var_0_4 = table.remove
local var_0_5 = table.insert
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.UILoader
local var_0_8 = string.format
local var_0_9 = gamecore.util_func
local var_0_10 = lx.clone_table
local var_0_11 = gameenum.common_type
local var_0_12 = gameconfig.ship_config
local var_0_13 = gameconfig.equip_config
local var_0_14 = gameconfig.pve_score_task_config
local var_0_16 = gameconfig.pve_score_award_config

gamecore.UILoader:define("answer_award", function(arg_1_0)
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
		self:__init_language()
		self:__init_data()
		self:__init_reusable_cell()
		self:__update_task_cell()
		self:__update_award_cell()
	end

	function arg_1_0.set_close_func(arg_5_0, arg_5_1)
		arg_5_0._close_func = arg_5_1
	end

	function arg_1_0:__init_data()
		self._task_data, self._task_num = var_0_14.get_sequence()
		self._award_data, self._award_num = var_0_16.get_sequence()
		self._one_award_id = self._award_data[1].id
		self._one_task_id = self._task_data[1].id
		self._answer_award_info = var_0_1:get_answer_award_info()

		self:get_answer_all_score()

		for iter_6_0 = 1, #self._award_data do
			for iter_6_1 = 1, #self._award_data[iter_6_0].award do
				var_0_2(self._award_data[iter_6_0].award, function(arg_7_0, arg_7_1)
					return arg_7_0.id > arg_7_1.id
				end)
			end
		end
	end

	function arg_1_0:__init_reusable_cell()
		self:destroyChildren("fifth_taskmodel")

		self._reusable_task_cell = gamecore.reusable_cell:create(self, self._control.mian.middle.task.scrollview.viewport.content.endlessScrollView, self._control.mian.middle.task.scrollview.viewport.content, "fifth_taskmodel", "answer_award")

		self._reusable_task_cell:init()
		self:destroyChildren("fifth_awardbox_item")

		self._reusable_award_cell = gamecore.reusable_cell:create(self, self._control.mian.middle.award.scrollview.viewport.content.endlessScrollView, self._control.mian.middle.award.scrollview.viewport.content, "fifth_awardbox_item", "answer_award")

		self._reusable_award_cell:init()
	end

	function arg_1_0:__update_task_cell()
		local var_9_0 = var_0_1:get_answer_task_info()
		local var_9_1 = self:set_task_get_state()

		self._reusable_task_cell:set_data(var_9_1)

		function self._reusable_task_cell:_set_func(arg_10_1)
			self.main.taskreward.rewardbg.finish:SetActive(false)

			self.main.nametimefinish.namearea.taskname.text.text = var_9_1[arg_10_1 + 1].title
			self.main.nametimefinish.goal.goalmain.text.text = var_0_6:convert_rich_text(var_9_1[arg_10_1 + 1].condition_desc)
			self.main.taskreward.reward.text.text = var_0_6:getNowLang("pvecampaignrewardlabel")
			self.main.taskreward.rewartypeone.rewardname.text.text = var_9_1[arg_10_1 + 1].award

			if next(var_9_0) then
				for iter_10_0, iter_10_1 in pairs(var_9_0) do
					if iter_10_1 == var_9_1[arg_10_1 + 1].id then
						self.main.taskreward.rewardbg.finish:SetActive(true)
					end
				end
			end
		end
	end

	function arg_1_0:set_task_get_state()
		local var_11_0 = var_0_10((var_0_1:get_answer_task_info()))
		local var_11_1 = var_0_10(self._task_data)
		local var_11_2 = {}

		if var_11_0 and next(var_11_0) then
			for iter_11_0, iter_11_1 in pairs(var_11_0) do
				if var_11_1[iter_11_1 - (self._one_task_id - 1)] then
					var_0_5(var_11_2, var_11_1[iter_11_1 - (self._one_task_id - 1)])
				end
			end

			for iter_11_2, iter_11_3 in pairs(var_11_0) do
				for iter_11_4, iter_11_5 in pairs(var_11_1) do
					if iter_11_5.id == iter_11_3 then
						var_0_4(var_11_1, iter_11_4)
					end
				end
			end
		end

		var_0_2(var_11_2, function(arg_12_0, arg_12_1)
			return arg_12_0.id < arg_12_1.id
		end)

		for iter_11_6, iter_11_7 in pairs(var_11_2) do
			var_0_5(var_11_1, iter_11_7)
		end

		return var_11_1
	end

	function arg_1_0:__update_award_cell()
		local var_13_1 = self:set_award_get_state()

		self._reusable_award_cell:set_data(var_13_1)

		function self._reusable_award_cell:_set_func(arg_14_1)
			local var_14_0 = {
				self.left.itemlist.item1,
				self.left.itemlist.item2,
				self.left.itemlist.item3,
				self.left.itemlist.item4,
				self.left.itemlist.item5,
				self.left.itemlist.item6
			}

			self.right.btn.text.text.text = var_0_6:getNowLang("mbtnget")

			for iter_14_0 = 1, #var_14_0 do
				var_14_0[iter_14_0].gameObject:SetActive(false)
			end

			self.left.title.text.text = var_0_6:getNowLang("ui_5th_reward_user_point")
			self.left.title.prestige_bg.prestigenum_text.text.text = var_13_1[arg_14_1 + 1].level_id == 0 and var_13_1[arg_14_1 + 1].score or var_13_1[arg_14_1 + 1].score .. var_13_1[arg_14_1 + 1].title

			local var_14_1 = 0

			for iter_14_1, iter_14_2 in pairs(var_13_1[arg_14_1 + 1].award) do
				var_14_1 = var_14_1 + 1

				var_14_0[var_14_1].gameObject:SetActive(true)

				var_14_0[var_14_1].img.image.sprite = self:loadSprite(var_0_8(var_0_11.normal_str, iter_14_2.id))

				if iter_14_2.count == 1 then
					var_14_0[var_14_1].text.text.text = nil
				else
					var_14_0[var_14_1].text.text.text = iter_14_2.count
				end

				if var_14_0[var_14_1].img.image.sprite == nil then
					var_14_0[var_14_1].img.image.sprite = self:loadSprite(var_0_8(var_0_11.normal_str, 10004761))
				end

				var_14_0[iter_14_1].rewardbg.image.sprite = self:loadSprite((var_0_9.get_item_star_bg_by_item_id(var_13_1[arg_14_1 + 1].award[iter_14_1].id)))

				var_14_0[var_14_1].btn.button.onClick:RemoveAllListeners()
				var_14_0[var_14_1].btn.button.onClick:AddListener(function()
					if var_13_1[arg_14_1 + 1].award[iter_14_1].id > 10000000 and var_13_1[arg_14_1 + 1].award[iter_14_1].id % 100 == 61 then
						return
					end

					if var_13_1[arg_14_1 + 1].award[iter_14_1].id < 10000000 then
						if var_13_1[arg_14_1 + 1].award[iter_14_1].id % 100 == 81 then
							var_0_7:createInstance("specificdetails"):show(var_13_1[arg_14_1 + 1].award[iter_14_1].id, var_0_11.enter_icon_detail_type.combatshop_cg)
						else
							var_0_7:createInstance("specificdetails"):show(var_13_1[arg_14_1 + 1].award[iter_14_1].id, var_0_11.enter_icon_detail_type.sign)
						end
					elseif var_0_3(var_13_1[arg_14_1 + 1].award[iter_14_1].id % 100) == 21 then
						self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

						self._control.detail_shadow.gameObject:SetActive(true)

						if self._equip_attr then
							self._equip_attr._panel.transform.anchoredPosition = Vector2.New(0, 0)

							self._equip_attr:show((var_0_13.find_object_by_cid(var_13_1[arg_14_1 + 1].award[iter_14_1].id)))
						end
					else
						var_0_7:createInstance("ship_detail"):show(var_0_11.enter_ship_detail_type.bootyshop, (var_0_12.find_object_by_cid(var_13_1[arg_14_1 + 1].award[iter_14_1].id)))
					end
				end)
			end

			self.right.btn.gameObject:SetActive(var_13_1[arg_14_1 + 1].score <= self._answer_all_score)

			if var_13_1[arg_14_1 + 1].level_id > 0 and self._answer_all_score >= var_13_1[arg_14_1 + 1].score then
				local var_14_2 = var_0_1:get_score_map_data()

				if var_14_2 and next(var_14_2) and var_14_2[var_13_1[arg_14_1 + 1].level_id] and var_14_2[var_13_1[arg_14_1 + 1].level_id].state == 2 then
					self.right.btn.gameObject:SetActive(true)
				else
					self.right.btn.gameObject:SetActive(false)
				end
			end

			self.shadow.gameObject:SetActive(false)
			self.right.already.gameObject:SetActive(false)
			self.right.btn.button.onClick:RemoveAllListeners()
			self.right.btn.button.onClick:AddListener(function()
				self.right.btn.gameObject:SetActive(false)
				self.shadow.gameObject:SetActive(true)
				self.right.already.gameObject:SetActive(true)

				self._now_award = var_13_1[arg_14_1 + 1].id

				var_0_1:req_AnswerGetAwardReq(var_13_1[arg_14_1 + 1].id)
			end)

			if self._answer_award_info.reward then
				for iter_14_3, iter_14_4 in pairs(self._answer_award_info.reward) do
					if iter_14_4 == var_13_1[arg_14_1 + 1].id then
						self.right.btn:SetActive(false)
						self.right.already:SetActive(true)
					end
				end
			end
		end
	end

	function arg_1_0:set_award_get_state()
		local var_17_0 = var_0_10(self._award_data)
		local var_17_1 = var_0_10(self._answer_award_info.reward)
		local var_17_2 = {}

		if var_17_1 and next(var_17_1) then
			for iter_17_0, iter_17_1 in pairs(var_17_1) do
				if var_17_0[iter_17_1 - (self._one_award_id - 1)] then
					var_0_5(var_17_2, var_17_0[iter_17_1 - (self._one_award_id - 1)])
				end
			end

			for iter_17_2, iter_17_3 in pairs(var_17_1) do
				for iter_17_4, iter_17_5 in pairs(var_17_0) do
					if iter_17_5.id == iter_17_3 then
						var_0_4(var_17_0, iter_17_4)
					end
				end
			end
		end

		var_0_2(var_17_2, function(arg_18_0, arg_18_1)
			return arg_18_0.id < arg_18_1.id
		end)

		for iter_17_6, iter_17_7 in pairs(var_17_2) do
			var_0_5(var_17_0, iter_17_7)
		end

		return var_17_0
	end

	function arg_1_0:get_now_award()
		return self._now_award - self._one_award_id + 1
	end

	function arg_1_0:_play_into_se(arg_20_1)
		self:playSE(arg_20_1, false)
	end

	function arg_1_0:__init_language()
		self._control.mian.top.title.text.text = var_0_6:getNowLang("ui_5th_reward")
		self._control.mian.top.point.desc.text.text = var_0_6:getNowLang("score")
	end

	function arg_1_0:get_answer_all_score()
		local var_22_0 = var_0_1:get_score_cia_num().coin

		self._answer_all_score = var_22_0
		self._control.mian.top.point.num.text.text = var_22_0
	end

	function arg_1_0.__onReset(arg_23_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_24_0)
	local var_24_0 = var_0_7:class("answer_award")

	var_24_0._task_data = nil
	var_24_0._award_data = nil
	var_24_0._answer_award_info = nil
	var_24_0._close_func = nil
	var_24_0._now_award = nil
	var_24_0._answer_all_score = 0
	var_24_0._one_award_id = 0
	var_24_0._one_task_id = 0

	gamecore.extend_obj(var_24_0)

	return var_24_0
end

return var_0_0
