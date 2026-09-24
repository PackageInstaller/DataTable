local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = gameenum.common_type
local var_0_6 = table.insert
local var_0_7 = table.remove
local var_0_8 = gameconfig.task_config
local var_0_9 = lx.clone_table
local var_0_10 = gameconfig.ship_config
local var_0_11 = table.sort
local var_0_12 = gamecore.util_func
local var_0_13 = UnityEngine.Vector2
local var_0_14 = gameconfig.item_config
local var_0_15 = gameconfig.chat_head_config
local var_0_16 = gameconfig.ship_cg_config
local var_0_17 = gameconfig.equip_config
local var_0_18 = DG.Tweening.DOTween
local var_0_19 = gamecore.PreloadManager
local var_0_20 = {
	btnthree = "btnthree",
	btnone = "btnone",
	btnfive = "btnfive",
	btnfour = "btnfour",
	btntwo = "btntwo"
}

gamecore.UILoader:define("task", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:updata_data()
		self._task_data = var_0_3:get_task_list()
		self._data = {}

		for iter_3_0, iter_3_1 in pairs(self._task_data) do
			var_0_6(self._data, iter_3_1)
		end

		self._copy_data = var_0_9(self._data)

		for iter_3_2 = #self._copy_data, 1, -1 do
			if self._copy_data[iter_3_2].state == 1 then
				-- block empty
			elseif self._copy_data[iter_3_2].state == 2 then
				var_0_7(self._copy_data, iter_3_2)
			end
		end

		self:__set_log_data(self._copy_data)
	end

	function arg_1_0:show(arg_4_1, arg_4_2)
		self:setVisible(true)

		self.activity_type = arg_4_1
		self.activity_id = arg_4_2
	end

	function arg_1_0:get_guide_btn_pos_info(arg_5_1)
		if arg_5_1 == var_0_5.guide_const_id.five_group.five or arg_5_1 == var_0_5.guide_const_id.second_group.three or arg_5_1 == var_0_5.guide_const_id.seven_group.three then
			return self._control.maintop.topmenu.returnbtn.transform
		elseif arg_5_1 == var_0_5.guide_const_id.second_group.one or arg_5_1 == var_0_5.guide_const_id.five_group.one or arg_5_1 == var_0_5.guide_const_id.five_group.three or arg_5_1 == var_0_5.guide_const_id.seven_group.one then
			return self._reward_btn_trans
		end
	end

	function arg_1_0:__onVisible(arg_6_1)
		if not arg_6_1 then
			return
		end

		self:updata_data()
		self:__init_panel()

		self._already_init = true
	end

	function arg_1_0:__init_panel()
		self:__init_task_list()

		self._control.maintop.topmenu.topbtn.btnone.text.text.text = var_0_1:getNowLang("tbt1")
		self._control.maintop.topmenu.topbtn.btntwo.text.text.text = var_0_1:getNowLang("tbt2")
		self._control.maintop.topmenu.topbtn.btnthree.text.text.text = var_0_1:getNowLang("tbt3")
		self._control.maintop.topmenu.topbtn.btnfour.text.text.text = var_0_1:getNowLang("tbt4")
		self._control.maintop.topmenu.topbtn.btnfive.text.text.text = var_0_1:getNowLang("tbt5")

		self._control.maintop.topmenu.topbtn.tip.gameObject:SetActive(false)
		self:__init_select()
		self:_tip_have()
		var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true)

		self._control.infoline.select_all_btn.select_all_btn_txt.text.text = var_0_1:getNowLang("all_receive")
		self._control.infoline.show_txt.text.text = var_0_1:getNowLang("task_desc")
	end

	function arg_1_0:__init_select()
		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one("btnone", true)

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:_tip_have()
		self._control.maintop.topmenu.topbtn.tip.gameObject:SetActive(false)

		if self._finish_task == "" then
			return
		end

		for iter_9_0, iter_9_1 in pairs(self._finish_task) do
			local var_9_0 = var_0_8.find_object_by_cid(iter_9_1.id)

			if var_9_0 and var_9_0.end_utc_time ~= nil and var_9_0.start_utc_time < lx.ServerTime:getUtcTime() and var_9_0.end_utc_time > lx.ServerTime:getUtcTime() then
				self._control.maintop.topmenu.topbtn.tip.gameObject:SetActive(true)

				break
			end
		end
	end

	function arg_1_0:__select_one(arg_10_1, arg_10_2)
		if self._now_label == arg_10_1 and not arg_10_2 then
			return
		end

		self._now_label = arg_10_1

		if self._now_content then
			self._last_content = self._now_content

			self:__set_title_style(self._now_content, false)
		end

		self:__set_current_content(arg_10_1)
		self:__set_title_style(self._now_content, true)

		if self._last_content then
			var_0_5:play_in_out_animation(self._last_content.uITweenSequence, false, function()
				self:__set__now_data(self._now_label)

				if self._now_content then
					var_0_5:play_in_out_animation(self._now_content.uITweenSequence, true)
				end
			end)
		else
			var_0_5:play_in_out_animation(self._now_content.uITweenSequence, true)
			self:__set__now_data(self._now_label)
		end

		self._control.mainalltask.mid.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_13.New(0, 0)
	end

	function arg_1_0:__set_current_content(arg_12_1)
		if arg_12_1 == var_0_20.btnone then
			self._now_content = self._control.maintop.topmenu.topbtn.btnone
		elseif arg_12_1 == var_0_20.btntwo then
			self._now_content = self._control.maintop.topmenu.topbtn.btntwo
		elseif arg_12_1 == var_0_20.btnthree then
			self._now_content = self._control.maintop.topmenu.topbtn.btnthree
		elseif arg_12_1 == var_0_20.btnfour then
			self._now_content = self._control.maintop.topmenu.topbtn.btnfour
		elseif arg_12_1 == var_0_20.btnfive then
			self._now_content = self._control.maintop.topmenu.topbtn.btnfive
		end
	end

	function arg_1_0.__set_title_style(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_2 then
			arg_13_1.text.text.fontSize = 30
			arg_13_1.text.text.color = Color.New(1, 1, 1)
		else
			arg_13_1.text.text.fontSize = 26
			arg_13_1.text.text.color = Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373)
		end
	end

	function arg_1_0:__is_already_init()
		return self._already_init
	end

	function arg_1_0:__set__now_data(arg_15_1)
		if arg_15_1 == var_0_20.btnone then
			self:__get_data_by_index(1)
		elseif arg_15_1 == var_0_20.btntwo then
			self:__get_data_by_index(2)
		elseif arg_15_1 == var_0_20.btnthree then
			self:__get_data_by_index(3)
		elseif arg_15_1 == var_0_20.btnfour then
			self:__get_data_by_index(4)
		elseif arg_15_1 == var_0_20.btnfive then
			self:__get_data_by_index(5)
		end

		self:__update_cell()

		self._control.mainalltask.mid.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_13(1.3, 0)
	end

	function arg_1_0:__init_task_list()
		if self._already_init then
			return
		end

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainalltask.mid.scrollview.viewport.content.endlessScrollView, self._control.mainalltask.mid.scrollview.viewport.content, "taskmodel", "task")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:_contrast_data(arg_17_1)
		for iter_17_0, iter_17_1 in pairs(self._finish_task) do
			if iter_17_1.id == arg_17_1 then
				var_0_6(self._server_data, iter_17_1)
			end
		end
	end

	function arg_1_0:__update_cell()
		self:updata_data()

		local var_18_0 = self._now_data

		self._cp_data = self._now_data

		for iter_18_0 = #self._now_data, 1, -1 do
			if self._now_data[iter_18_0] and self._now_data[iter_18_0].start_time ~= "" and self._now_data[iter_18_0].end_time ~= "" and self._now_data[iter_18_0].start_utc_time and self._now_data[iter_18_0].end_utc_time and (self._now_data[iter_18_0].start_utc_time > lx.ServerTime:getUtcTime() or self._now_data[iter_18_0].end_utc_time < lx.ServerTime:getUtcTime()) then
				var_0_7(self._now_data, iter_18_0)
			end
		end

		self._server_data = {}

		for iter_18_1, iter_18_2 in pairs(self._now_data) do
			self:_contrast_data(iter_18_2.cid)
		end

		self._reusable_cell:set_data(self._now_data)

		function self._reusable_cell:_set_func(arg_19_1)
			if arg_19_1 == 0 and var_0_3:get_guide_state() then
				self.main.nametimefinish.gameObject.name = var_0_5.guide_const_name.task_parent_guide_name
			end

			self.main.maintask.markone.gameObject:SetActive(false)
			self.main.nametimefinish.finishbtn.gameObject:SetActive(false)

			self.main.nametimefinish.goal.taskgoal.text.text = var_0_1:getNowLang("ui_tasktip1", true)
			self.main.maintask.activity.content.text.text = var_0_1:getNowLang("limittimetitle")
			self.main.taskreward.reward.text.text = var_0_1:getNowLang("ui_campaigntip1")
			self.main.nametimefinish.gobtn.text.text.text = var_0_1:getNowLang("questgo")
			self.main.nametimefinish.finishbtn.text.text.text = var_0_1:getNowLang("questfinishaction")

			self.main.maintask.activity.gameObject:SetActive(false)

			self.main.nametimefinish.tasktime.text.text = nil

			local var_19_0 = {
				self.main.taskreward.rewartypeone,
				self.main.taskreward.rewartypetwo,
				self.main.taskreward.rewartypethree,
				self.main.taskreward.rewartypefour,
				self.main.taskreward.rewartypefive,
				self.main.taskreward.rewartypesix
			}

			self.main.progress.text.text.text = var_0_1:getNowLang("questfinishpercent")
			self.main.nametimefinish.namearea.taskname.text.text = var_18_0[arg_19_1 + 1].title

			local var_19_2 = self.main.nametimefinish.goal.taskgoal.goalmain_move:GetComponent("TextHorizonScroller")

			var_19_2.isRich = true

			var_19_2:SetText(var_0_1:convert_rich_text(var_18_0[arg_19_1 + 1].desc, true))

			if var_18_0[arg_19_1 + 1].cid < 1103532 and var_18_0[arg_19_1 + 1].cid > 1101230 then
				var_19_2.isRich = true

				var_19_2:SetText(var_0_12.parseSpecialWord((var_0_1:convert_rich_text(var_18_0[arg_19_1 + 1].desc, true))))
			end

			self.main.maintask.typeimg.image.sprite = self:loadSprite(var_0_4(var_0_5.task_type, var_18_0[arg_19_1 + 1].icon_type))
			self.main.maintask.typebg.image.sprite = self:loadSprite(var_0_4(var_0_5.task_type_bg, 1))

			local var_19_3 = false
			local var_19_4 = true

			if var_18_0[arg_19_1 + 1].start_time ~= "" and var_18_0[arg_19_1 + 1].end_time ~= "" and var_18_0[arg_19_1 + 1].start_time ~= "0" and var_18_0[arg_19_1 + 1].end_time ~= "0" then
				var_19_3 = true

				if var_18_0[arg_19_1 + 1].start_utc_time - lx.ServerTime:getUtcTime() > 0 then
					var_19_4 = false
				elseif var_18_0[arg_19_1 + 1].end_utc_time - lx.ServerTime:getUtcTime() < 0 then
					var_19_4 = false
				end
			end

			if var_19_3 and var_19_4 then
				self.main.maintask.activity.gameObject:SetActive(true)

				if var_18_0[arg_19_1 + 1].grounp_no == 1 then
					self.main.maintask.activity.content.text.text = var_0_1:getNowLang("choice")
					self.main.maintask.typebg.image.sprite = self:loadSprite(var_0_4(var_0_5.task_type_bg, 3))
				else
					self.main.maintask.typebg.image.sprite = self:loadSprite(var_0_4(var_0_5.task_type_bg, 2))
				end
			else
				self.main.maintask.activity.gameObject:SetActive(false)
			end

			local var_19_5
			local var_19_7

			if self._server_data[arg_19_1 + 1] then
				var_19_5 = self._server_data[arg_19_1 + 1].progresses
			end

			if var_19_5 then
				local var_19_9 = var_0_8.find_object_by_cid(self._server_data[arg_19_1 + 1].id or 0)

				if var_19_9 then
					var_19_7 = math.floor(var_19_5[1].counter * 100 / var_19_9.condition[2])
				end
			end

			self.main.progress.number.text.text = var_19_7 and (var_19_7 >= 100 and "100%" or var_19_7 .. "%") or "0" .. "%"

			if var_19_7 then
				if var_19_7 < 100 then
					self.main.finish.gameObject:SetActive(false)
					self.main.nametimefinish.gobtn.gameObject:SetActive(true)
					self.main.nametimefinish.finishbtn.gameObject:SetActive(false)
					self.main.progress.gameObject:SetActive(true)
				elseif var_19_7 >= 100 then
					self.main.finish.gameObject:SetActive(true)
					self.main.nametimefinish.gobtn.gameObject:SetActive(false)
					self.main.nametimefinish.finishbtn.gameObject:SetActive(true)
					self.main.progress.gameObject:SetActive(false)
				end
			end

			for iter_19_0 = 1, 6 do
				var_19_0[iter_19_0].gameObject:SetActive(false)
			end

			var_0_11(var_18_0[arg_19_1 + 1].award, function(arg_20_0, arg_20_1)
				return arg_20_0.id < arg_20_1.id
			end)

			for iter_19_1 = 1, #var_18_0[arg_19_1 + 1].award do
				local var_19_10 = var_18_0[arg_19_1 + 1].award

				var_19_0[iter_19_1].gameObject:SetActive(true)

				var_19_0[iter_19_1].rewardimg.image.sprite = self:loadSprite(var_0_4(var_0_5.mail_box))

				local var_19_11
				local var_19_12 = var_19_10[iter_19_1].id % 100 == 43 or var_19_10[iter_19_1].id % 100 == 44

				var_19_11 = (var_19_10[iter_19_1].id == 88841 or var_19_10[iter_19_1].id == 66641) and var_0_14.find_object_by_cid(var_19_10[iter_19_1].id).title or var_19_10[iter_19_1].id % 100 == 81 and var_0_16.find_object_by_cid(var_19_10[iter_19_1].id).title or var_19_10[iter_19_1].id > 10000000 and var_19_10[iter_19_1].id % 10000000 % 100 == 61 and var_0_15.find_object_by_cid(var_19_10[iter_19_1].id).title or var_19_10[iter_19_1].id % 10000000 % 10000 % 100 == 21 and var_0_17.find_object_by_cid(var_19_10[iter_19_1].id).title or var_19_12 and var_0_14.find_object_by_cid(var_19_10[iter_19_1].id).title or var_19_10[iter_19_1].count

				local var_19_13 = var_19_0[iter_19_1].reward_move_text:GetComponent("TextHorizonScroller")

				var_19_13:SetText(var_19_11)

				if var_0_8.get_sequence(var_19_10[iter_19_1].id) and var_19_10[iter_19_1].id > 10000000 and var_19_10[iter_19_1].id < 20000000 and var_19_10[iter_19_1].id % 10000000 % 10000 % 1000 % 100 <= 15 then
					var_19_0[iter_19_1].rewardimg.image.sprite = self:loadSprite(var_0_4(var_0_5.mail_boat))

					var_19_13:SetText(var_0_10.find_object_by_cid(var_19_10[iter_19_1].id).title)
				elseif var_0_8.get_sequence(var_19_10[iter_19_1].id) and var_19_10[iter_19_1].id > 0 and var_19_10[iter_19_1].id < 100000 then
					if not var_19_12 then
						var_19_0[iter_19_1].rewardimg.image.sprite = var_19_10[iter_19_1].id % 100 == 81 and self:loadSprite(var_0_4(var_0_5.mail_cg)) or self:loadSprite(var_0_4(var_0_5.mail_icon, var_19_10[iter_19_1].id))
					end
				elseif var_0_8.get_sequence(var_19_10[iter_19_1].id) and var_19_10[iter_19_1].id > 1000000000 then
					var_19_0[iter_19_1].rewardimg.image.sprite = self:loadSprite(var_0_4(var_0_5.mail_clothes))
				end

				var_19_0[iter_19_1].rewardimg.image.sprite = var_19_0[iter_19_1].rewardimg.image.sprite or self:loadSprite(var_0_4(var_0_5.mail_box))
			end

			self.main.nametimefinish.gobtn.button.onClick:RemoveAllListeners()
			self.main.nametimefinish.gobtn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.task_goto))
				self:__init_select()

				if var_18_0[arg_19_1 + 1].link[1] == 11 then
					self:setVisible(false)
					var_0_2:createInstance("dock_team"):show(1)
				elseif var_18_0[arg_19_1 + 1].link[1] == 31 then
					self:setVisible(false)

					local var_21_0 = var_0_2:createInstance("gotofight")

					if #var_18_0[arg_19_1 + 1].link == 2 then
						var_21_0:show({
							is_open_init = true,
							toggle_index = var_0_5.fight_type.gotofight,
							init_chapter_index = tonumber(var_0_4("%.0f", var_18_0[arg_19_1 + 1].link[2] / 100)),
							init_map_index = tonumber(var_18_0[arg_19_1 + 1].link[2] % 100)
						})
					else
						var_21_0:show({
							is_open_init = true
						})
					end
				elseif var_18_0[arg_19_1 + 1].link[1] == 32 then
					self:setVisible(false)
					var_0_2:createInstance("gotofight"):show({
						toggle_index = var_0_5.fight_type.exercise
					})
				elseif var_18_0[arg_19_1 + 1].link[1] == 33 then
					self:setVisible(false)
					var_0_2:createInstance("gotofight"):show({
						init_chapter_index = 1,
						toggle_index = var_0_5.fight_type.farfight
					})
				elseif var_18_0[arg_19_1 + 1].link[1] == 12 then
					self:setVisible(false)
					var_0_2:createInstance("bathroom"):show()
				elseif var_18_0[arg_19_1 + 1].link[1] == 13 then
					self:setVisible(false)

					local var_21_2 = var_0_2:createInstance("dock_team")

					var_21_2:show()
					var_21_2:update_content(var_0_5.dock_team_toggle_type.supply)

					var_21_2._control.bg.top_menu.tab_toggle.tab_3.toggle.isOn = true
				elseif var_18_0[arg_19_1 + 1].link[1] == 14 then
					self:setVisible(false)

					local var_21_3 = var_0_2:createInstance("dock_team")

					var_21_3:show()
					var_21_3:update_content(var_0_5.dock_team_toggle_type.equipment)

					var_21_3._control.bg.top_menu.tab_toggle.tab_4.toggle.isOn = true
				elseif var_18_0[arg_19_1 + 1].link[1] == 23 then
					self:setVisible(false)

					local var_21_4 = var_0_2:createInstance("dock")

					var_21_4:show(true, "research")
					var_21_4:set_enter_type("task")
					var_21_4:select_one("research", true)
				elseif var_18_0[arg_19_1 + 1].link[1] == 21 then
					self:setVisible(false)

					local var_21_5 = var_0_2:createInstance("dock")

					var_21_5:show(true, "constructure")
					var_21_5:set_enter_type("task")
					var_21_5:select_one("constructure", true)
				elseif var_18_0[arg_19_1 + 1].link[1] == 22 then
					self:setVisible(false)

					local var_21_6 = var_0_2:createInstance("dock")

					var_21_6:show(true, "disassemble")
					var_21_6:set_enter_type("task")
					var_21_6:select_one("disassemble", true)
				elseif var_18_0[arg_19_1 + 1].link[1] == 41 then
					self:setVisible(false)

					local var_21_7 = var_0_2:createInstance("remake")

					var_21_7:set_enter_type("task")
					var_21_7:show(true)
				elseif var_18_0[arg_19_1 + 1].link[1] == 80 then
					self:setVisible(false)
					var_0_2:createInstance("restaurant"):show()
				elseif var_18_0[arg_19_1 + 1].link[1] == 81 then
					self:setVisible(false)
					var_0_2:createInstance("captainroom"):show()
				elseif var_18_0[arg_19_1 + 1].link[1] == 82 then
					self:setVisible(false)

					local var_21_8 = var_0_2:createInstance("dormitory")

					local function var_21_9()
						local var_22_0 = var_0_2:createInstance("dorm_warehouse")

						var_22_0:set_sort_data()
						var_22_0:show()
						var_22_0:setVisible(false)
					end

					local var_21_10 = 0

					for iter_21_0, iter_21_1 in pairs((var_0_3:get_dormitory_furniture())) do
						if iter_21_1.room == 0 then
							var_21_10 = var_21_10 + 1
						end
					end

					if var_21_10 == 0 then
						self:setVisible(false)
						var_21_8:show(var_21_9)

						return
					end

					local var_21_11 = 0

					local function var_21_12()
						var_21_11 = var_21_11 + 1

						if var_21_11 == var_21_10 then
							self:setVisible(false)
							var_21_8:show(var_21_9)
						end
					end

					for iter_21_2, iter_21_3 in pairs(var_0_3:get_dormitory_furniture()) do
						if iter_21_3.room == 0 then
							var_21_12()
						end
					end

					self.seq = self:autoKillDOTween(var_0_18.Sequence())

					for iter_21_4, iter_21_5 in pairs(var_0_3:get_dormitory_furniture()) do
						if iter_21_5.room == 0 then
							self.seq:AppendInterval(0.01)
							self.seq:AppendCallback(function()
								var_0_19:preload_dormitory_asset(iter_21_5)

								if iter_21_4 == var_21_10 and self.seq then
									self.seq:Kill()

									self.seq = nil
								end
							end)
						end
					end
				elseif var_18_0[arg_19_1 + 1].link[1] == 61 then
					self:setVisible(false)

					if self.activity_type == var_0_5.pve_active_type.normal then
						local var_21_13 = var_0_2:createInstance("fearlessness_sea")

						if var_21_13 then
							var_21_13:show(self.activity_id, false)
						end
					elseif self.activity_type == var_0_5.pve_active_type.eighth_event then
						local var_21_14 = var_0_2:createInstance("eighth_main_map")

						if var_21_14 then
							var_21_14:show(var_0_5.pve_active_eighth_id)
						end
					end
				end
			end)

			if arg_19_1 == 0 then
				self._reward_btn_trans = self.main.nametimefinish.finishbtn.transform
			end

			self.main.nametimefinish.finishbtn.button.onClick:RemoveAllListeners()
			self.main.nametimefinish.finishbtn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.task_goto))
				var_0_3:req_committaskreq(var_18_0[arg_19_1 + 1].cid)
				self:updata_data()
			end)
		end
	end

	function arg_1_0:__set_log_data(arg_26_1)
		self._finish_task = {}

		local var_26_0 = {}

		for iter_26_0, iter_26_1 in pairs(arg_26_1) do
			local var_26_1 = var_0_8.find_object_by_cid(iter_26_1.id)

			if var_26_1 then
				for iter_26_2, iter_26_3 in pairs(iter_26_1.progresses) do
					if iter_26_3.counter / var_26_1.condition[2] < 1 then
						var_0_6(var_26_0, iter_26_1)
					elseif iter_26_3.counter / var_26_1.condition[2] >= 1 then
						var_0_6(self._finish_task, iter_26_1)
					end
				end
			end
		end

		if var_0_3:get_guide_state() then
			for iter_26_4, iter_26_5 in pairs(var_26_0) do
				if var_0_8.find_object_by_cid(iter_26_5.id).type == 4 then
					var_0_7(var_26_0, iter_26_4)
				end
			end

			for iter_26_6, iter_26_7 in pairs(self._finish_task) do
				if var_0_8.find_object_by_cid(iter_26_7.id).type == 4 then
					var_0_7(self._finish_task, iter_26_6)
				end
			end
		end

		var_0_11(var_26_0, function(arg_27_0, arg_27_1)
			local var_27_0 = var_0_8.find_object_by_cid(arg_27_0.id)
			local var_27_1 = var_0_8.find_object_by_cid(arg_27_1.id)
			local var_27_2 = arg_27_0.progresses[1].counter / var_27_0.condition[2]
			local var_27_3 = arg_27_1.progresses[1].counter / var_27_1.condition[2]

			if var_27_0.grounp_no == 1 and var_27_1.grounp_no == 1 or var_27_0.grounp_no ~= 1 and var_27_1.grounp_no ~= 1 then
				if var_27_0.type == 4 and var_27_1.type == 4 or var_27_0.type ~= 4 and var_27_1.type ~= 4 then
					if var_27_2 == var_27_3 then
						return var_27_0.cid < var_27_1.cid
					end

					return var_27_3 < var_27_2
				elseif var_27_0.type == 4 then
					return true
				elseif var_27_1.type == 4 then
					return false
				end

				return var_27_0.type == 4
			elseif var_27_0.grounp_no == 1 then
				return true
			elseif var_27_1.grounp_no == 1 then
				return false
			end

			return var_27_0.grounp_no == 1
		end)
		var_0_11(self._finish_task, function(arg_28_0, arg_28_1)
			local var_28_0 = var_0_8.find_object_by_cid(arg_28_0.id)
			local var_28_1 = var_0_8.find_object_by_cid(arg_28_1.id)

			if var_28_0.grounp_no == 1 and var_28_1.grounp_no == 1 or var_28_0.grounp_no ~= 1 and var_28_1.grounp_no ~= 1 then
				if var_28_0.type == 4 and var_28_1.type == 4 or var_28_0.type ~= 4 and var_28_1.type ~= 4 then
					return var_28_0.cid < var_28_1.cid
				elseif var_28_0.type == 4 then
					return true
				elseif var_28_1.type == 4 then
					return false
				end

				return var_28_0.type == 4
			end

			return var_28_0.grounp_no == 1
		end)

		for iter_26_8, iter_26_9 in ipairs(var_26_0) do
			var_0_6(self._finish_task, iter_26_9)
		end

		local var_26_2 = {}

		for iter_26_10, iter_26_11 in pairs(self._finish_task) do
			self.task_table_array = var_0_8.find_object_by_cid(iter_26_11.id)

			local var_26_3 = lx.ServerTime:getUtcTime()
			local var_26_4 = var_0_8.find_object_by_cid(iter_26_11.id)

			if var_26_4 then
				if var_26_4.end_utc_time == nil or var_26_3 < var_26_4.end_utc_time then
					var_0_6(var_26_2, self.task_table_array)
				end
			end
		end

		local var_26_5 = {}
		local var_26_6 = {}
		local var_26_7 = {}
		local var_26_8 = {}

		for iter_26_12, iter_26_13 in pairs(var_26_2) do
			if iter_26_13.type == 1 then
				var_0_6(var_26_5, iter_26_13)
			elseif iter_26_13.type == 2 then
				var_0_6(var_26_6, iter_26_13)
			elseif iter_26_13.type == 3 then
				var_0_6(var_26_7, iter_26_13)
			elseif iter_26_13.type == 4 then
				var_0_6(var_26_8, iter_26_13)
			end
		end

		self._data_by_type = {
			var_26_2,
			var_26_5,
			var_26_6,
			var_26_7,
			var_26_8
		}

		self:_finish_task_sum()
	end

	function arg_1_0:__get_data_by_index(arg_29_1)
		self._now_data = self._data_by_type[arg_29_1]

		return self._now_data
	end

	function arg_1_0:_finish_task_sum()
		local var_30_0 = 0

		self._task_array = {}

		for iter_30_0, iter_30_1 in pairs((var_0_3:get_task_list())) do
			var_0_6(self._task_array, iter_30_1)
		end

		local var_30_1 = var_0_9(self._task_array)

		for iter_30_2 = #var_30_1, 1, -1 do
			if var_30_1[iter_30_2].state == 2 then
				var_0_7(var_30_1, iter_30_2)
			end

			if var_30_1[iter_30_2] then
				local var_30_2 = var_0_8.find_object_by_cid(var_30_1[iter_30_2].id)

				if var_30_2 then
					if var_30_2.end_utc_time and lx.ServerTime:getUtcTime() > var_30_2.end_utc_time then
						var_0_7(var_30_1, iter_30_2)
					end
				end
			end
		end

		for iter_30_3, iter_30_4 in pairs(var_30_1) do
			local var_30_3 = var_0_8.find_object_by_cid(iter_30_4.id)

			if var_30_3 then
				for iter_30_5, iter_30_6 in pairs(iter_30_4.progresses) do
					if iter_30_6.counter / var_30_3.condition[2] * 100 >= 100 then
						var_30_0 = var_30_0 + 1

						break
					end
				end
			end
		end

		if var_30_0 >= 1 then
			self._control.infoline.select_all_btn:SetActive(true)
		else
			self._control.infoline.select_all_btn:SetActive(false)
		end
	end

	function arg_1_0:_play_into_se(arg_31_1)
		self:playSE(arg_31_1, false)
	end

	function arg_1_0.__onReset(arg_32_0)
		arg_32_0._already_init = false
		arg_32_0._last_content = nil
		arg_32_0._now_label = nil
		arg_32_0._now_content = nil
		arg_32_0._data_by_type = {}
		arg_32_0._now_data = {}
		arg_32_0._task_data = nil
		arg_32_0._task_table = nil
		arg_32_0._task_type = nil
		arg_32_0._task_timelimits = {}
		arg_32_0._timelimits = nil
		arg_32_0._task_use = {}
		arg_32_0._task_one = nil
		arg_32_0.task_table_array = nil
		arg_32_0._task_progresses = nil
		arg_32_0._cell_copy = nil
		arg_32_0._cell_index = nil
		arg_32_0._task_award = {}
		arg_32_0._finish_task = {}
		arg_32_0._cp_data = {}
		arg_32_0._server_data = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_33_0)
	local var_33_0 = var_0_2:class("task")

	var_33_0._already_init = false
	var_33_0._last_content = nil
	var_33_0._now_label = nil
	var_33_0._now_content = nil
	var_33_0._reusable_cell = nil
	var_33_0._data_by_type = {}
	var_33_0._now_data = {}
	var_33_0._task_data = nil
	var_33_0._task_table = nil
	var_33_0._task_type = nil
	var_33_0._task_timelimits = {}
	var_33_0._timelimits = nil
	var_33_0._task_use = {}
	var_33_0._task_one = nil
	var_33_0.task_table_array = nil
	var_33_0._task_progresses = nil
	var_33_0._cell_copy = nil
	var_33_0._cell_index = nil
	var_33_0._task_award = {}
	var_33_0._finish_task = {}
	var_33_0._cp_data = {}
	var_33_0._server_data = {}

	return var_33_0
end

return var_0_0
