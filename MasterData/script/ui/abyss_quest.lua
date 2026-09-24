local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = gameconfig.abyss_award_config
local var_0_8 = gamecore.reusable_cell
local var_0_9 = table.insert
local var_0_10 = gameconfig.ship_config
local var_0_11 = gameconfig.equip_config
local var_0_12 = gamecore.util_func
local var_0_13 = table.sort

gamecore.UILoader:define("abyss_quest", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		if not self._init_comp then
			self:__init_language()
			self:__init_data()

			self._init_comp = true
		end

		self:update_data()
	end

	function arg_1_0:__init_data()
		self._award_cfg = var_0_7.get_sequence()

		self:__init_quest_data()

		self._award_list = var_0_8:create(self, self._control.mian.middle.award.scrollview.viewport.content.endlessScrollView, self._control.mian.middle.award.scrollview.viewport.content, "abyss_award_item", "abyss_quest", false)

		self._award_list:init()
	end

	function arg_1_0:update_data()
		self._control.mian.top.point.num.text.text = var_0_3:get_user_abyss_point()

		local var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs((var_0_3:get_user_abyss_award())) do
			if var_0_7.find_object_by_id(iter_5_1.id).type == 0 then
				var_0_9(var_5_0, lx.clone_table(iter_5_1))
			end
		end

		var_0_13(var_5_0, function(arg_6_0, arg_6_1)
			return arg_6_0.id < arg_6_1.id
		end)

		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			var_0_13(iter_5_3, function(arg_7_0, arg_7_1)
				return arg_7_0.id < arg_7_1.id
			end)
		end

		local var_5_1 = {}

		for iter_5_4, iter_5_5 in ipairs(self._award_cfg) do
			if iter_5_5.type == 0 then
				self._award_hold_list[iter_5_4] = var_0_3:check_abyss_user_award(iter_5_5.id) or false
				self._award_hold_list[iter_5_4] = not not (var_5_0[iter_5_4] and var_5_0[iter_5_4].id == iter_5_5.id)

				var_0_13(iter_5_5.award, function(arg_8_0, arg_8_1)
					return arg_8_0.id < arg_8_1.id
				end)

				for iter_5_6, iter_5_7 in pairs(var_5_0) do
					if iter_5_7.id == iter_5_5.id then
						self._award_hold_list[iter_5_6] = true
					end
				end

				var_0_9(var_5_1, iter_5_5)
			end
		end

		var_0_13(var_5_1, function(arg_9_0, arg_9_1)
			return arg_9_0.score < arg_9_1.score
		end)

		local var_5_2 = {}

		if #var_5_0 ~= 0 then
			for iter_5_8, iter_5_9 in pairs(var_5_0) do
				for iter_5_10, iter_5_11 in pairs(var_5_1) do
					if iter_5_11.id == iter_5_9.id then
						table.insert(var_5_2, iter_5_10)
					end
				end
			end

			for iter_5_12 = #var_5_2, 1, -1 do
				table.remove(var_5_1, var_5_2[iter_5_12])
			end
		end

		if #var_5_0 ~= 0 then
			for iter_5_13 = 1, #var_5_0 do
				table.insert(var_5_1, (var_0_7.find_object_by_id(var_5_0[iter_5_13].id)))
			end
		end

		self:__update_point_award_data(var_5_1)
		self:__update_quest_data()
	end

	function arg_1_0:__init_quest_data()
		if not self._award_cfg then
			return
		end

		local var_10_0 = var_0_7.get_sequence()
		local var_10_1 = 0

		self._boss_quest = {}

		local var_10_2 = {}
		local var_10_3 = {}

		for iter_10_0, iter_10_1 in ipairs((var_0_3:get_user_abyss_award())) do
			if var_0_7.find_object_by_id(iter_10_1.id).type ~= 0 then
				var_0_9(var_10_2, iter_10_1)
			end
		end

		for iter_10_2, iter_10_3 in ipairs(self._award_cfg) do
			if iter_10_3.type ~= 0 then
				var_0_9(var_10_3, iter_10_3)

				local var_10_4 = iter_10_3.award
				local var_10_5, var_10_6 = self:loadUIPrefab("abyss_quest_item", self._control.mian.middle.task.scrollview.viewport.content.transform)

				var_10_6.bg.image.sprite = self:loadSprite(var_0_6(var_0_4.abyss_const.abyss_boss_quest_bg, iter_10_3.id))
				var_10_6.bg.title.text.text = var_0_1:getNowLang("cinema_jiesuotiaojian")
				var_10_6.bg.quest1.text.text = var_0_1:getNowLang("ui_ny21_award_layer_single_title")
				var_10_6.bg.quest1.point.text.text = iter_10_3.score
				var_10_6.bg.quest1.point.icon.image.sprite = self:loadSprite(var_0_4.abyss_const.abyss_quest_icon)
				var_10_6.bg.quest2.content.info_txt.text.text = var_0_12.convert_rich_text(var_0_1:getNowLang(var_0_6("ui_abyss_boss_quest_%s", iter_10_3.id)))
				var_10_6.info.desc.text.text = var_0_1:getNowLang("ui_ny21_quest_status")
				var_10_6.info.state.txt.text.text = var_0_1:getNowLang("ui_4th_shop_sort_lock")
				var_10_6.info.confirm_btn.txt.text.text = var_0_1:getNowLang("mbtnget")

				self:__active_canvas(var_10_6.info.confirm_btn.canvasGroup, false)
				var_10_6.bg.preview_btn.button.onClick:RemoveAllListeners()
				var_10_6.bg.preview_btn.button.onClick:AddListener(function()
					if var_10_4 then
						var_0_2:createInstance("msgbox"):showOnes(var_10_4, function()
							var_0_2:destroyInstance("msgbox")
						end, var_0_1:getNowLang("space_confirm"), var_0_1:getNowLang("award_preview"), var_0_4.msg_type.rewards, nil, true, true)
					end
				end)

				local var_10_7 = var_0_3:get_user_abyss_point()

				var_10_5:setVisible(true)

				self._boss_quest[var_10_1] = var_10_6
				var_10_1 = var_10_1 + 1
			end
		end

		if var_10_1 <= 2 then
			self._control.mian.middle.task.scrollview.scrollRect.vertical = false
		end
	end

	function arg_1_0:__onUpdate()
		if self._award_list then
			self._award_list:update()
		end
	end

	function arg_1_0:__update_quest_data()
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in ipairs((var_0_3:get_user_abyss_award())) do
			if var_0_7.find_object_by_id(iter_14_1.id).type ~= 0 then
				var_0_9(var_14_0, iter_14_1)
			end
		end

		local var_14_2 = var_0_3:get_user_abyss_point()

		var_0_3:req_AbyssBossInfoReq(4)

		local var_14_3 = var_0_3:get_abyss_world_boss_info(4)

		if var_14_2 >= 950 then
			if var_14_2 >= 950 and var_14_3.step == 1 and var_14_3.hp == 0 or var_14_2 >= 950 and var_14_3.step == 2 or var_14_2 >= 950 and var_14_3.step == 3 then
				self._boss_quest[0].info.state.txt.text.text = var_0_1:getNowLang("ui_4th_shop_sort_unlock")

				self:__active_canvas(self._boss_quest[0].info.confirm_btn.canvasGroup, true)
			end

			self._boss_quest[0].info.confirm_btn.button.onClick:RemoveAllListeners()
			self._boss_quest[0].info.confirm_btn.button.onClick:AddListener(function()
				var_0_3:req_AbyssGetAwardReq(11)
			end)
		end

		if var_14_2 >= 1500 then
			if var_14_2 >= 1500 and var_14_3.step == 2 and var_14_3.hp == 0 or var_14_2 >= 1500 and var_14_3.step == 3 then
				self._boss_quest[1].info.state.txt.text.text = var_0_1:getNowLang("ui_4th_shop_sort_unlock")

				self:__active_canvas(self._boss_quest[1].info.confirm_btn.canvasGroup, true)
			end

			self._boss_quest[1].info.confirm_btn.button.onClick:RemoveAllListeners()
			self._boss_quest[1].info.confirm_btn.button.onClick:AddListener(function()
				var_0_3:req_AbyssGetAwardReq(12)
			end)
		end

		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			local var_14_4 = var_0_7.find_object_by_id(iter_14_3.id)

			if var_14_4.type == 1 then
				self._boss_quest[0].info.confirm_btn:SetActive(false)

				self._boss_quest[0].info.state.txt.text.text = var_0_1:getNowLang("ui_havegetattach")

				self._boss_quest[0].info.finish:SetActive(true)
			end

			if var_14_4.type == 2 then
				self._boss_quest[1].info.confirm_btn:SetActive(false)

				self._boss_quest[1].info.state.txt.text.text = var_0_1:getNowLang("ui_havegetattach")

				self._boss_quest[1].info.finish:SetActive(true)
			end
		end
	end

	function arg_1_0:__update_point_award_data(arg_17_1)
		if not arg_17_1 or not self._award_list then
			return
		end

		local var_17_0 = {
			"item1",
			"item2",
			"item3",
			"item4",
			"item5",
			"item6"
		}
		local var_17_1 = var_0_3:get_user_abyss_point()

		self._award_list:set_data(arg_17_1)

		function self._award_list:_set_func(arg_18_1)
			local var_18_0 = arg_17_1[arg_18_1 + 1].award
			local var_18_1 = arg_17_1[arg_18_1 + 1].score or 0
			local var_18_2 = var_18_1 <= var_17_1

			self.left.title.text.text = var_0_1:getNowLang("ui_ny21_award_layer_single_title")
			self.left.title.point.num.text.text = var_18_1

			for iter_18_0, iter_18_1 in pairs(var_17_0) do
				if var_18_0[iter_18_0] then
					local var_18_3 = var_18_0[iter_18_0].id
					local var_18_4 = var_18_0[iter_18_0].count
					local var_18_5 = self._award_hold_list[iter_18_0]

					self.left.itemlist[iter_18_1].img.image.sprite = self:loadSprite(var_0_6(var_0_4.normal_str, var_18_0[iter_18_0].id))
					self.left.itemlist[iter_18_1].text.text.text = var_18_4 == 1 and "" or var_18_4
					self.left.itemlist[iter_18_1].rewardbg.image.sprite = self:get_item_bg_sprite(var_18_3)

					if not var_18_5 then
						self.left.itemlist[iter_18_1].btn.button.onClick:RemoveAllListeners()
						self.left.itemlist[iter_18_1].btn.button.onClick:AddListener(function()
							local var_19_0

							if var_18_3 >= 10000000 then
								if var_18_3 % 100 == 21 then
									local var_19_1 = var_0_2:createInstance("equip_attr")

									if var_19_1 then
										var_19_1:show((var_0_11.find_object_by_cid(var_18_3)))
									end

									self:__active_canvas(self._control.shadow.canvasGroup, true)

									var_19_0 = true
								elseif var_18_3 % 100 == 18 or var_18_3 % 100 == 11 or var_18_3 % 100 == 12 or var_18_3 % 100 == 13 then
									var_19_0 = true
								end
							end

							if not var_19_0 then
								local var_19_2 = var_0_2:createInstance("specificdetails")

								if var_19_2 then
									var_19_2:show(var_18_3, var_0_4.enter_icon_detail_type.bootyshop_item)
								end
							end
						end)
					end

					self.left.itemlist[iter_18_1].gameObject:SetActive(true)
				else
					self.left.itemlist[iter_18_1].gameObject:SetActive(false)
				end
			end

			self.right.btn.button.onClick:RemoveAllListeners()

			if not self._award_hold_list[arg_18_1 + 1] then
				if var_18_2 then
					self.right.btn.gameObject:SetActive(true)

					self.right.btn.text.text.text = var_0_1:getNowLang("mbtnget")

					self.right.btn.button.onClick:AddListener(function()
						var_0_3:req_AbyssGetAwardReq(arg_17_1[arg_18_1 + 1].id)
					end)
				else
					self.right.btn.gameObject:SetActive(false)
				end

				self.right.already.gameObject:SetActive(false)
				self.shadow.gameObject:SetActive(false)
			else
				self.right.btn.gameObject:SetActive(false)
				self.right.already.gameObject:SetActive(true)
				self.shadow.gameObject:SetActive(true)
			end
		end
	end

	function arg_1_0:get_item_bg_sprite(arg_21_1)
		if not arg_21_1 then
			return
		end

		local var_21_0 = var_0_4.ship_equip_pic.have_sign

		if arg_21_1 >= 10000000 then
			if arg_21_1 % 100 == 21 then
				var_21_0 = var_0_6(var_0_4.equip_back.equip_back_normal, var_0_11.find_object_by_cid(arg_21_1).star)
			elseif arg_21_1 % 100 == 18 or arg_21_1 % 100 == 11 or arg_21_1 % 100 == 12 or arg_21_1 % 100 == 13 then
				var_21_0 = var_0_10.find_object_by_cid(arg_21_1).boss == 1 and var_0_4.abyss_ship_back_ground_1 or var_0_4.abyss_ship_back_ground_0
			end
		end

		return self:loadSprite(var_21_0)
	end

	function arg_1_0:__close_equip_detail()
		self:__active_canvas(self._control.shadow.canvasGroup, false)

		local var_22_0 = var_0_2:getActiveInstance("equip_attr")

		if var_22_0 then
			var_22_0:setVisible(false)
		end
	end

	function arg_1_0.__active_canvas(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		if not arg_23_1 then
			return
		end

		arg_23_1.alpha = arg_23_2 and 1 or 0

		if arg_23_3 then
			return
		end

		arg_23_1.blocksRaycasts = arg_23_2
		arg_23_1.interactable = arg_23_2
	end

	function arg_1_0.__destroy_panel(arg_24_0)
		var_0_2:destroyInstance("specificdetails")
		var_0_2:destroyInstance("equip_attr")
		var_0_2:destroyInstance("abyss_quest")
	end

	function arg_1_0:__init_language()
		self._control.mian.top.title.text.text = var_0_1:getNowLang("ui_ny21_award_layer_title")
		self._control.mian.top.point.desc.text.text = var_0_1:getNowLang("ui_ny21_award_layer_score")
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_26_0)
	local var_26_0 = var_0_2:class("abyss_quest")

	var_26_0._award_cfg = {}
	var_26_0._init_comp = false
	var_26_0._boss_quest = {}
	var_26_0._award_list = nil
	var_26_0._boss_node_list = {}
	var_26_0._award_hold_list = {}

	gamecore.extend_obj(var_26_0)

	return var_26_0
end

return var_0_0
