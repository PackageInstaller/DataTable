local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func
local var_0_6 = string.format
local var_0_10 = table.insert
local var_0_12 = table.sort
local var_0_13 = UnityEngine.Vector2
local var_0_14 = UnityEngine.Object.Instantiate

gamecore.UILoader:define("msgbox", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
		self._confirm_func = arg_2_2
		self._cancel_func = arg_2_3
		self._close_func = nil

		if arg_2_7 then
			self._close_func = arg_2_7
		end

		self._msg_type = arg_2_5 or var_0_4.msg_type.tip
		self._control.main.title.text.text = arg_2_4

		self:__init_panel(arg_2_1)

		if self._is_yellow then
			self._control.main.confirm.image.sprite = self:loadSprite("data/ui/common/common_btn_bg_15.png")
			self._control.main.confirm.text.text.color = Color.New(1, 1, 1)
			self._is_yellow = false
		end

		self._control.main.back:SetActive(true)
		self._control.main.three:SetActive(false)
		self._control.main.confirm:SetActive(true)
		self._control.main.one:SetActive(false)

		self._control.main.confirm.text.text.text = var_0_2:getNowLang("ui_cbtn1")
		self._control.main.back.text.text.text = var_0_2:getNowLang("ui_cbtn2")

		if arg_2_5 == var_0_4.msg_type.tip_info then
			self._control.main.title.text.text = var_0_2:getNowLang("shopbuyconfirmtitle")
		elseif not arg_2_4 then
			self._control.main.title.text.text = var_0_2:getNowLang("sure_exit")
		end

		self._have_next = arg_2_6

		self:setVisible(true)

		self._original_canvas_order = self._base_canvas.sortingOrder
	end

	function arg_1_0:showthird(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
		self._confirm_func = arg_3_2
		self._one_func = arg_3_3
		self._three_func = arg_3_4
		self._close_func = nil

		if arg_3_8 then
			self._close_func = arg_3_8
		end

		self._msg_type = arg_3_6 or var_0_4.msg_type.tip
		self._control.main.title.text.text = arg_3_5

		self:__init_panel(arg_3_1)
		self._control.main.back:SetActive(false)
		self._control.main.confirm:SetActive(true)
		self._control.main.one:SetActive(true)
		self._control.main.three:SetActive(true)

		self._control.main.confirm.text.text.text = var_0_2:getNowLang("btndestory")
		self._control.main.one.text.text.text = var_0_2:getNowLang("strengthen")
		self._control.main.three.text.text.text = var_0_2:getNowLang("expantion")
		self._have_next = arg_3_7

		self:setVisible(true)

		self._original_canvas_order = self._base_canvas.sortingOrder
	end

	function arg_1_0:showforth(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
		self._confirm_func = arg_4_2
		self._one_func = arg_4_3
		self._three_func = arg_4_4
		self._close_func = nil

		if arg_4_8 then
			self._close_func = arg_4_8
		end

		self._msg_type = arg_4_6 or var_0_4.msg_type.tip
		self._control.main.title.text.text = arg_4_5

		self:__init_panel(arg_4_1)
		self._control.main.back:SetActive(false)
		self._control.main.confirm:SetActive(true)
		self._control.main.one:SetActive(false)
		self._control.main.three:SetActive(true)

		self._control.main.confirm.text.text.text = var_0_2:getNowLang("btnabandom")
		self._control.main.three.text.text.text = var_0_2:getNowLang("expantion")
		self._have_next = arg_4_7

		self:setVisible(true)

		self._original_canvas_order = self._base_canvas.sortingOrder
	end

	function arg_1_0:set_canvas_order(arg_5_1)
		self._base_canvas.sortingOrder = arg_5_1
	end

	function arg_1_0:reset_canvas_order()
		self._base_canvas.sortingOrder = self._original_canvas_order
	end

	function arg_1_0:show_yellow(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
		self._confirm_func = arg_7_2
		self._cancel_func = arg_7_3
		self._msg_type = arg_7_5 or var_0_4.msg_type.tip
		self._control.main.title.text.text = arg_7_4

		self:__init_panel(arg_7_1)

		if not self._is_yellow then
			self._control.main.confirm.image.sprite = self:loadSprite("data/ui/common/common_btn_bg_16.png")
			self._control.main.confirm.text.text.color = Color.New(0, 0, 0)
			self._is_yellow = true
		end

		self._control.main.back:SetActive(true)
		self._control.main.three:SetActive(false)
		self._control.main.confirm:SetActive(true)
		self._control.main.one:SetActive(false)

		self._control.main.confirm.text.text.text = var_0_2:getNowLang("space_confirm")
		self._control.main.back.text.text.text = var_0_2:getNowLang("space_cancel")
		self._have_next = arg_7_6

		self:setVisible(true)
	end

	function arg_1_0:showOne(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		arg_8_3 = arg_8_3 or var_0_2:getNowLang("ui_cbtn1")
		self._one_func = arg_8_2

		self._control.main.back:SetActive(false)
		self._control.main.three:SetActive(false)
		self._control.main.confirm:SetActive(false)
		self._control.main.one:SetActive(true)

		self._msg_type = arg_8_5 or var_0_4.msg_type.tip
		self._control.main.title.text.text = arg_8_4

		self:__init_panel(arg_8_1)

		self._control.main.one.text.text.text = arg_8_3

		self:setVisible(true)
	end

	function arg_1_0:showOnes(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8)
		arg_9_3 = arg_9_3 or var_0_2:getNowLang("ui_cbtn1")
		self._one_func = arg_9_2

		self._control.main.back:SetActive(false)
		self._control.main.three:SetActive(false)
		self._control.main.confirm:SetActive(false)
		self._control.main.one:SetActive(true)

		self._msg_type = arg_9_5 or var_0_4.msg_type.tip
		self._control.main.title.text.text = arg_9_4
		self._allow_extend = arg_9_7
		self._show_ship_name = arg_9_8

		self:__init_panel(arg_9_1, arg_9_6)

		self._control.main.one.text.text.text = arg_9_3

		self:setVisible(true)
	end

	function arg_1_0:__init_panel(arg_10_1, arg_10_2)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self._control.main.title.three_point_get.gameObject:SetActive(false)
		self._control.main.title.three_point.gameObject:SetActive(true)
		self._control.main.tip:SetActive(self._msg_type == var_0_4.msg_type.tip)
		self._control.main.reduce_cd:SetActive(self._msg_type == var_0_4.msg_type.reduce_cd)
		self._control.main.get_res:SetActive(self._msg_type == var_0_4.msg_type.get_res)
		self._control.main.reward:SetActive(self._msg_type == var_0_4.msg_type.reward)
		self._control.main.rewards:SetActive(self._msg_type == var_0_4.msg_type.rewards)

		if self._msg_type == var_0_4.msg_type.tip then
			self._control.main.tip.text.text.text = arg_10_1

			self._control.main.close.gameObject:SetActive(false)
		elseif self._msg_type == var_0_4.msg_type.tip_info then
			self._control.main.tip:SetActive(self._msg_type == var_0_4.msg_type.tip_info)

			self._control.main.tip.text.text.text = arg_10_1

			self._control.main.close.gameObject:SetActive(false)
		elseif self._msg_type == var_0_4.msg_type.reduce_cd then
			self._control.main.reduce_cd.title.text.text = arg_10_1.title
			self._control.main.reduce_cd.item_1.title.text.text = arg_10_1.title_1
			self._control.main.reduce_cd.item_1.cur.text.text = arg_10_1.cur_count
			self._control.main.reduce_cd.item_1.next.text.text = arg_10_1.cur_count - 1
			self._control.main.reduce_cd.item_2.title.text.text = arg_10_1.title_2
			self._control.main.reduce_cd.item_2.cur.text.text = var_0_5.secondsToTime(arg_10_1.finish_time - lx.ServerTime:getUtcTime())
			self._control.main.reduce_cd.item_2.next.text.text = "00:00:00"
			self._finish_time = arg_10_1.finish_time
		elseif self._msg_type == var_0_4.msg_type.get_res then
			local var_10_0 = self:loadFont("data/font/SourceHanSansSC-Bold.otf")

			self._control.main.get_res.number_1.text.font = var_10_0
			self._control.main.get_res.number_2.text.font = var_10_0
			self._control.main.get_res.number_3.text.font = var_10_0
			self._control.main.get_res.number_4.text.font = var_10_0
			self._control.main.get_res.number_1.text.text = arg_10_1.oil
			self._control.main.get_res.number_2.text.text = arg_10_1.fe
			self._control.main.get_res.number_3.text.text = arg_10_1.bullet
			self._control.main.get_res.number_4.text.text = arg_10_1.al

			self._control.main.close.gameObject:SetActive(true)
		elseif self._msg_type == var_0_4.msg_type.reward then
			self._control.main.reward.icon.image.sprite = self:loadSprite(arg_10_1.url)
			self._control.main.reward.number.text.text = arg_10_1.num

			self._control.main.reward.reward_mask:GetComponent("TextHorizonScroller"):SetText(arg_10_1.reward_name)
		elseif self._msg_type == var_0_4.msg_type.ship_full then
			self._control.main.close.gameObject:SetActive(true)
			self._control.main.tip:SetActive(true)

			self._control.main.tip.text.text.text = arg_10_1 == "shipmaxnobatch" and var_0_2:getNowLang("shipmaxnobatch") or var_0_2:getNowLang("errorcode_187")
		elseif self._msg_type == var_0_4.msg_type.equipment_full then
			self._control.main.close.gameObject:SetActive(true)
			self._control.main.tip:SetActive(true)

			self._control.main.tip.text.text.text = arg_10_1 == "equipmaxnobatch" and var_0_2:getNowLang("equipmaxnobatch") or var_0_2:getNowLang("errorcode_188")
		elseif self._msg_type == var_0_4.msg_type.rewards or self._msg_type == var_0_4.msg_type.abyss_rewards or self._msg_type == var_0_4.msg_type.abyss_node_rewards then
			self._control.main.rewards.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_13(0, 0)

			self._control.main.title.three_point_get.gameObject:SetActive(true)
			self._control.black.gameObject:SetActive(true)
			self._control.main.title.three_point.gameObject:SetActive(false)
			self._control.main.close.gameObject:SetActive(false)

			local var_10_1 = {
				self._control.main.rewards.scrollview.viewport.content.rewardone,
				self._control.main.rewards.scrollview.viewport.content.rewardtwo,
				self._control.main.rewards.scrollview.viewport.content.rewardthree,
				self._control.main.rewards.scrollview.viewport.content.rewardfour,
				self._control.main.rewards.scrollview.viewport.content.rewardfive
			}
			local var_10_2 = var_10_1[1]

			for iter_10_0 = 1, 5 do
				var_10_1[iter_10_0].gameObject:SetActive(false)
			end

			local var_10_3 = {}
			local var_10_5 = {}
			local var_10_6 = {}
			local var_10_7 = {}
			local var_10_8 = {}
			local var_10_9 = 1
			local var_10_10 = 1

			for iter_10_1, iter_10_2 in pairs((var_0_5.little_clone(arg_10_1))) do
				if not arg_10_2 then
					if iter_10_2.id ~= 10242 then
						var_0_10(var_10_5, iter_10_2)
					end
				else
					var_0_10(var_10_5, iter_10_2)
				end
			end

			if self._msg_type == var_0_4.msg_type.abyss_rewards then
				for iter_10_3, iter_10_4 in pairs(var_10_5) do
					if iter_10_4.type ~= 4 and iter_10_4.type ~= 13 and iter_10_4.type ~= 1 and iter_10_4.type ~= 12 then
						var_0_10(var_10_3, iter_10_4)
					end

					if iter_10_4.type == 13 then
						local var_10_12 = gamecore.user:find_abyss_character_by_id(iter_10_4.id).cid

						var_0_10(var_10_8, var_10_12)

						if var_10_12 == 10004618 then
							var_0_10(var_10_6, iter_10_4)

							var_10_9 = iter_10_4.id
						else
							var_0_10(var_10_7, iter_10_4)

							var_10_10 = iter_10_4.id
						end
					end
				end

				if #var_10_6 ~= 0 then
					var_0_10(var_10_3, {
						is_new = false,
						type = 13,
						count = #var_10_6,
						id = var_10_9
					})
				end

				if #var_10_7 ~= 0 then
					var_0_10(var_10_3, {
						is_new = false,
						type = 13,
						count = #var_10_7,
						id = var_10_10
					})
				end

				self._control.main.rewards:SetActive(true)
			elseif self._msg_type == var_0_4.msg_type.abyss_node_rewards then
				for iter_10_5, iter_10_6 in pairs(var_10_5) do
					var_0_10(var_10_3, iter_10_6)
				end

				self._control.main.rewards:SetActive(true)
			else
				for iter_10_7, iter_10_8 in pairs(var_10_5) do
					if iter_10_8.type ~= 4 and iter_10_8.type ~= 1 and iter_10_8.type ~= 13 and iter_10_8.type ~= 8 and iter_10_8.type ~= 12 then
						var_0_10(var_10_3, iter_10_8)
					end
				end
			end

			var_0_12(var_10_3, function(arg_11_0, arg_11_1)
				return arg_11_0.id < arg_11_1.id
			end)

			if not self._recycle_obj_list then
				self._recycle_obj_list = {}
			else
				for iter_10_9, iter_10_10 in pairs(self._recycle_obj_list) do
					iter_10_10.gameObject:SetActive(false)
				end
			end

			for iter_10_11 = 1, #var_10_3 do
				local var_10_13

				if not var_10_1[iter_10_11] then
					var_10_1[iter_10_11] = self._recycle_obj_list[iter_10_11] or var_0_14(var_10_2, var_10_2.transform.parent)
					var_10_1[iter_10_11].name = "clone_reward_" .. iter_10_11
					self._recycle_obj_list[iter_10_11] = var_10_1[iter_10_11]
				end

				var_10_1[iter_10_11].gameObject:SetActive(true)

				if var_10_3[iter_10_11].type == 12 then
					local var_10_14 = gameconfig.ship_cg_config.find_object_by_cid(var_10_3[iter_10_11].id)

					var_10_13 = var_10_14 and var_10_14.title or ""
				elseif var_10_3[iter_10_11].type == 1 then
					local var_10_15 = gameconfig.equip_config.find_object_by_cid(var_10_3[iter_10_11].id)

					var_10_13 = var_10_15 and var_10_15.title or ""
				elseif var_10_3[iter_10_11].type == 13 then
					local var_10_16 = gamecore.user:find_abyss_character_by_id(var_10_3[iter_10_11].id)

					var_10_13 = var_10_16 and var_10_16.title or ""
				elseif var_10_3[iter_10_11].type ~= 12 or var_10_3[iter_10_11].type ~= 1 then
					local var_10_17 = gameconfig.item_config.find_object_by_cid(var_10_3[iter_10_11].id)

					var_10_13 = var_10_17 and var_10_17.title or ""
				end

				if var_10_3[iter_10_11].id % 100 == var_0_4.abyss_cg_num_background then
					local var_10_18 = gameconfig.ship_cg_config.find_object_by_cid(var_10_3[iter_10_11].id)

					var_10_13 = var_10_18 and var_10_18.title or ""
				end

				local var_10_19 = var_10_1[iter_10_11].transform:Find("bg"):GetComponent("Image")

				var_10_19.sprite = self:loadSprite(var_0_4.ship_equip_pic.have_sign)

				local var_10_20 = var_10_3[iter_10_11].id

				if self._show_ship_name and var_10_20 >= 10000000 and (var_10_20 % 100 == 18 or var_10_20 % 100 == 11 or var_10_20 % 100 == 12 or var_10_20 % 100 == 13) then
					local var_10_21 = gameconfig.ship_config.find_object_by_cid(var_10_3[iter_10_11].id)

					var_10_13 = var_10_21 and var_10_21.title or ""
					var_10_19.sprite = var_10_20 % 100 == 18 and self:loadSprite(var_0_4.abyss_ship_back_ground_0) or self:loadSprite(var_0_6(var_0_4.equip_back.equip_back_normal, var_10_21.star))
				end

				var_10_1[iter_10_11].transform:Find("title_mask"):GetComponent("TextHorizonScroller"):SetText(var_10_13)

				if var_10_3[iter_10_11].type == 1 then
					var_10_19.sprite = self:loadSprite(var_0_6(var_0_4.ship_equip_pic.equipbg, gameconfig.equip_config.find_object_by_cid(var_10_3[iter_10_11].id).star))
				end

				if var_10_3[iter_10_11].type == 13 then
					var_10_1[iter_10_11].transform:Find("icon"):GetComponent("Image").sprite = self:loadSprite(var_0_6(var_0_4.icon.item_icon, gamecore.user:find_abyss_character_by_id(var_10_3[iter_10_11].id).cid))
					var_10_19.sprite = self:loadSprite(var_0_4.abyss_ship_back_ground_0)
				else
					var_10_1[iter_10_11].transform:Find("icon"):GetComponent("Image").sprite = self:loadSprite(var_0_6(var_0_4.icon.item_icon, var_10_3[iter_10_11].id))
				end

				var_10_1[iter_10_11].transform:Find("number"):GetComponent("Text").text = var_10_3[iter_10_11].count == 1 and "" or var_10_3[iter_10_11].count
			end

			self._control.main.rewards.scrollview.scrollRect.horizontal = #var_10_3 >= 5
		end
	end

	function arg_1_0:__onUpdate()
		if self._msg_type == var_0_4.msg_type.reduce_cd then
			self._control.main.reduce_cd.item_2.cur.text.text = var_0_5.secondsToTime(self._finish_time - lx.ServerTime:getUtcTime())
		end
	end

	function arg_1_0:__onVisible(arg_13_1)
		if not arg_13_1 then
			return
		end

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, arg_13_1)
	end

	function arg_1_0:__onClick_main_confirm()
		local var_14_0 = false

		if gamecore.user then
			var_14_0 = gamecore.user:get_in_bootyshop()
		end

		local var_14_1 = self._confirm_func

		self._confirm_func = nil

		if self._have_next then
			var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
				if var_14_1 then
					var_14_1()
				end

				var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, true)
			end)
		elseif var_14_0 then
			if var_14_1 then
				var_14_1()
			end

			self:setVisible(false)
		else
			var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
				if var_14_1 then
					var_14_1()
				end

				self:setVisible(false)
			end)
		end
	end

	function arg_1_0:__onClick_main_back()
		local var_17_0 = self._cancel_func

		self._cancel_func = nil

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			self:setVisible(false)

			if var_17_0 then
				var_17_0()
			end
		end)
	end

	function arg_1_0:__onClick_main_one()
		local var_19_0 = self._one_func

		self._one_func = nil

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			if self.setVisible then
				self:setVisible(false)
			end

			if var_19_0 then
				var_19_0()
			end
		end)
	end

	function arg_1_0:__onClick_main_close(arg_21_1)
		local var_21_0

		if self._close_func then
			var_21_0 = nil
			self._cancel_func = nil

			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		else
			var_21_0 = self._cancel_func
			self._cancel_func = nil
		end

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			if self then
				self:setVisible(false)
			end

			if var_21_0 then
				var_21_0()
			end
		end)
	end

	function arg_1_0:__onClick_main_three()
		local var_23_0 = self._three_func

		self._three_func = nil

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			if self.setVisible then
				self:setVisible(false)
			end

			if var_23_0 then
				var_23_0()
			end
		end)
	end

	function arg_1_0:_play_into_se(arg_25_1)
		self:playSE(arg_25_1, false)
	end

	function arg_1_0:__onReset()
		self._allow_extend = nil
		self._show_ship_name = nil

		if self._recycle_obj_list then
			for iter_26_0, iter_26_1 in pairs(self._recycle_obj_list) do
				self:destroyGameObject(iter_26_1)
			end

			self._recycle_obj_list = {}
		end

		self:reset_canvas_order()
	end

	function arg_1_0:get_guide_btn_pos_info(arg_27_1)
		if arg_27_1 == var_0_4.guide_const_id.second_group.two or arg_27_1 == var_0_4.guide_const_id.five_group.two or arg_27_1 == var_0_4.guide_const_id.five_group.four or arg_27_1 == var_0_4.guide_const_id.seven_group.two then
			return self._control.main.one.transform
		elseif arg_27_1 == var_0_4.guide_const_id.six_group.seven then
			return self._control.main.confirm.transform
		end
	end
end)

function var_0_0.create(arg_28_0)
	local var_28_0 = var_0_3:class("msgbox")

	var_28_0._confirm_func = nil
	var_28_0._cancel_func = nil
	var_28_0._one_func = nil
	var_28_0._three_func = nil
	var_28_0._msg_type = nil
	var_28_0._have_next = false
	var_28_0._finish_time = nil
	var_28_0._bgm_state = false
	var_28_0._is_yellow = false

	var_28_0:__registerClickEvent("main/back")
	var_28_0:__registerClickEvent("main/confirm")
	var_28_0:__registerClickEvent("main/btn")
	var_28_0:__registerClickEvent("main/close")

	return var_28_0
end

return var_0_0
