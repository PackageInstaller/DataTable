local var_0_0 = {}
local var_0_1 = table.sort
local var_0_2 = table.insert
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_7 = string.format
local var_0_8 = gamecore.util_func
local var_0_9 = gameenum.common_type

gamecore.UILoader:define("common_reward_view", function(arg_1_0)
	function arg_1_0:show_yellow(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self._confirm_func = arg_2_2
		self._cancel_func = arg_2_3
		self._msg_type = arg_2_5 or var_0_9.msg_type.tip
		self._control.main.title.text.text = arg_2_4

		self:__init_panel(arg_2_1)

		if not self._is_yellow then
			self._control.main.confirm.image.sprite = self:loadSprite("data/ui/common/common_btn_bg_16.png")
			self._control.main.confirm.text.text.color = Color.New(0, 0, 0)
			self._is_yellow = true
		end

		self._control.main.back:SetActive(true)
		self._control.main.confirm:SetActive(true)
		self._control.main.one:SetActive(false)

		self._control.main.confirm.text.text.text = var_0_4:getNowLang("ui_cbtn1")
		self._control.main.back.text.text.text = var_0_4:getNowLang("ui_cbtn2")
		self._have_next = arg_2_6

		self:setVisible(true)
	end

	function arg_1_0:show_rewards(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
		arg_3_3 = arg_3_3 or var_0_4:getNowLang("ui_cbtn1")

		local var_3_0 = self._control.main

		self._one_func = arg_3_2

		var_3_0.back:SetActive(false)
		var_3_0.confirm:SetActive(false)
		var_3_0.one:SetActive(true)

		self._msg_type = arg_3_5 or var_0_9.msg_type.tip
		var_3_0.title.text.text = arg_3_4

		self:__init_panel(arg_3_1)

		var_3_0.one.text.text.text = arg_3_3

		self:setVisible(true)
	end

	function arg_1_0:get_guide_btn_pos_info(arg_4_1)
		if arg_4_1 == var_0_9.guide_const_id.second_group.two or arg_4_1 == var_0_9.guide_const_id.five_group.two or arg_4_1 == var_0_9.guide_const_id.five_group.four or arg_4_1 == var_0_9.guide_const_id.seven_group.two then
			return self._control.main.one.transform
		elseif arg_4_1 == var_0_9.guide_const_id.six_group.seven then
			return self._control.main.confirm.transform
		end
	end

	function arg_1_0:__init_panel(arg_5_1, arg_5_2)
		self:_play_into_se(var_0_9:get_audio_url(var_0_9.common_icon.music_path, var_0_9.open))

		local var_5_0 = self._control.main

		self._control.main.title.three_point_get.gameObject:SetActive(false)
		var_5_0.title.three_point.gameObject:SetActive(true)
		var_5_0.reduce_cd:SetActive(self._msg_type == var_0_9.msg_type.reduce_cd)
		var_5_0.get_res:SetActive(self._msg_type == var_0_9.msg_type.get_res)
		var_5_0.reward:SetActive(self._msg_type == var_0_9.msg_type.reward)
		var_5_0.rewards:SetActive(self._msg_type == var_0_9.msg_type.rewards)

		if self._msg_type == var_0_9.msg_type.tip then
			var_5_0.close.gameObject:SetActive(false)
		elseif self._msg_type == var_0_9.msg_type.reduce_cd then
			var_5_0.reduce_cd.title.text.text = arg_5_1.title
			var_5_0.reduce_cd.item_1.title.text.text = arg_5_1.title_1
			var_5_0.reduce_cd.item_1.cur.text.text = arg_5_1.cur_count
			var_5_0.reduce_cd.item_1.next.text.text = arg_5_1.cur_count - 1
			var_5_0.reduce_cd.item_2.title.text.text = arg_5_1.title_2
			var_5_0.reduce_cd.item_2.cur.text.text = var_0_8.secondsToTime(arg_5_1.finish_time - lx.ServerTime:getUtcTime())
			var_5_0.reduce_cd.item_2.next.text.text = "00:00:00"
			self._finish_time = arg_5_1.finish_time
		elseif self._msg_type == var_0_9.msg_type.get_res then
			var_5_0.get_res.number_1.text.text = arg_5_1.oil
			var_5_0.get_res.number_2.text.text = arg_5_1.fe
			var_5_0.get_res.number_3.text.text = arg_5_1.bullet
			var_5_0.get_res.number_4.text.text = arg_5_1.al
		elseif self._msg_type == var_0_9.msg_type.reward then
			var_5_0.reward.icon.image.sprite = self:loadSprite(arg_5_1.url)
			var_5_0.reward.number.text.text = arg_5_1.num

			var_5_0.reward.reward_mask:GetComponent("TextHorizonScroller"):SetText(arg_5_1.reward_name)
		elseif self._msg_type == var_0_9.msg_type.rewards then
			var_5_0.title.three_point_get.gameObject:SetActive(true)
			self._control.black.gameObject:SetActive(true)
			var_5_0.title.three_point.gameObject:SetActive(false)
			var_5_0.close.gameObject:SetActive(false)

			local var_5_1 = var_0_8.little_clone(arg_5_1)

			if #var_5_1 > 5 then
				-- block empty
			end

			local var_5_3 = {
				var_5_0.rewards.scrollview.viewport.content.rewardone,
				var_5_0.rewards.scrollview.viewport.content.rewardtwo,
				var_5_0.rewards.scrollview.viewport.content.rewardthree,
				var_5_0.rewards.scrollview.viewport.content.rewardfour,
				var_5_0.rewards.scrollview.viewport.content.rewardfive
			}

			for iter_5_0 = 1, 5 do
				var_5_3[iter_5_0].gameObject:SetActive(false)
			end

			local var_5_4 = {}
			local var_5_6 = {}

			for iter_5_1, iter_5_2 in pairs(var_5_1) do
				if not arg_5_2 then
					if iter_5_2.id ~= 10242 then
						var_0_2(var_5_6, iter_5_2)
					end
				else
					var_0_2(var_5_6, iter_5_2)
				end
			end

			for iter_5_3, iter_5_4 in pairs(var_5_6) do
				if iter_5_4.type ~= 4 and iter_5_4.type ~= 1 and iter_5_4.id ~= 13 then
					var_0_2(var_5_4, iter_5_4)
				end
			end

			var_0_1(var_5_4, function(arg_6_0, arg_6_1)
				return arg_6_0.id < arg_6_1.id
			end)

			for iter_5_5 = 1, #var_5_4 do
				var_5_3[iter_5_5].gameObject:SetActive(true)
				var_5_3[iter_5_5].title_mask:GetComponent("TextHorizonScroller"):SetText(var_5_4[iter_5_5].type == 12 and gameconfig.ship_cg_config.find_object_by_cid(var_5_4[iter_5_5].id).title or gameconfig.item_config.find_object_by_cid(var_5_4[iter_5_5].id).title)

				var_5_3[iter_5_5].icon.image.sprite = self:loadSprite(var_0_7(var_0_9.icon.item_icon, var_5_4[iter_5_5].id))

				if var_5_4[iter_5_5].count == 1 then
					var_5_3[iter_5_5].number.text.text = nil
				else
					var_5_3[iter_5_5].number.text.text = var_5_4[iter_5_5].count
				end
			end

			var_5_0.rewards.scrollview.scrollRect.horizontal = #var_5_4 >= 5
		end
	end

	function arg_1_0:__onUpdate()
		if self._msg_type == var_0_9.msg_type.reduce_cd then
			self._control.main.reduce_cd.item_2.cur.text.text = var_0_8.secondsToTime(self._finish_time - lx.ServerTime:getUtcTime())
		end
	end

	function arg_1_0:__onVisible(arg_8_1)
		if not arg_8_1 then
			return
		end

		var_0_9:play_in_out_animation(self._control.emptybox.uITweenSequence, arg_8_1)
	end

	function arg_1_0:__onClick_main_confirm()
		local var_9_0 = self._confirm_func

		self._confirm_func = nil

		if self._have_next then
			var_0_9:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
				if var_9_0 then
					var_9_0()
				end

				var_0_9:play_in_out_animation(self._control.emptybox.uITweenSequence, true)
			end)
		else
			var_0_9:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
				if var_9_0 then
					var_9_0()
				end

				self:setVisible(false)
			end)
		end
	end

	function arg_1_0:__onClick_main_back()
		local var_12_0 = self._cancel_func

		self._cancel_func = nil

		var_0_9:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			self:setVisible(false)

			if var_12_0 then
				var_12_0()
			end
		end)
	end

	function arg_1_0:__onClick_main_one()
		local var_14_0 = self._one_func

		self._one_func = nil

		var_0_9:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			self:setVisible(false)

			if var_14_0 then
				var_14_0()
			end
		end)
	end

	function arg_1_0:__onClick_main_close()
		local var_16_0 = self._cancel_func

		self._cancel_func = nil

		var_0_9:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			self:setVisible(false)

			if var_16_0 then
				var_16_0()
			end
		end)
	end

	function arg_1_0:_play_into_se(arg_18_1)
		self:playSE(arg_18_1, false)
	end
end)

function var_0_0.create(arg_19_0)
	local var_19_0 = var_0_5:class("common_reward_view")

	var_19_0._confirm_func = nil
	var_19_0._cancel_func = nil
	var_19_0._one_func = nil
	var_19_0._msg_type = nil
	var_19_0._have_next = false
	var_19_0._finish_time = nil
	var_19_0._bgm_state = false
	var_19_0._is_yellow = false

	var_19_0:__registerClickEvent("main/back")
	var_19_0:__registerClickEvent("main/confirm")
	var_19_0:__registerClickEvent("main/btn")
	var_19_0:__registerClickEvent("main/close")

	return var_19_0
end

return var_0_0
