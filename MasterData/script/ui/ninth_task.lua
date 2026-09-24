local var_0_0 = {}
local var_0_1 = lan_rand
local var_0_2 = gamecore.user
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = UnityEngine.Vector3
local var_0_7 = string.format
local var_0_8 = gamecore.util_func
local var_0_9 = lx.clone_table
local var_0_10 = gameenum.common_type
local var_0_11 = gameconfig.ship_config
local var_0_13 = gameconfig.pve_ninth_task_config
local var_0_14 = gameconfig.pve_ninth_task_server_config

gamecore.UILoader:define("ninth_task", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:enter_or_return_tween(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self:destroyChildren("single_ninth_task")

		if not self._is_init then
			self:__initial_func()

			self._is_init = true
		end

		self:set_npc_img()

		self._current_task_type = "all_task"

		self:__init_data()
		self:__init_reusable_cell()

		self._control.task_bg.middle.tab_toggle.tab_1.toggle.isOn = true

		self:__update_cell(self._current_task_type)
	end

	function arg_1_0:__initial_func()
		self._control.task_bg.middle.tab_toggle.tab_1.sbt1.text.text = var_0_4:getNowLang("ninth_task_1")
		self._control.task_bg.middle.tab_toggle.tab_2.sbt2.text.text = var_0_4:getNowLang("ninth_task_2")
		self._control.task_bg.middle.desc.desc_text.text.text = var_0_4:getNowLang("ninth_task_desc")
	end

	function arg_1_0:__init_data()
		self:__set_scroll_to_top()
	end

	function arg_1_0:__init_reusable_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.task_bg.middle.taskcontent.scrollview.viewport.content.endlessScrollView, self._control.task_bg.middle.taskcontent.scrollview.viewport.content, "single_ninth_task", "ninth_task")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell(arg_8_1)
		local var_8_0, var_8_1 = var_0_13.get_sequence()
		local var_8_2, var_8_3 = var_0_14.get_sequence()
		local var_8_4 = var_0_9(var_8_2)

		if arg_8_1 == "all_task" then
			var_8_4 = var_0_9(var_8_2)
		elseif arg_8_1 == "self_task" then
			var_8_4 = var_0_9(var_8_0)
		end

		local var_8_5 = self:__sort_task(var_8_4, arg_8_1)

		self._reusable_cell:set_data(var_8_5)

		function self._reusable_cell:_set_func(arg_9_1)
			self.bg.get_icon:SetActive(false)
			self.taskreward.goto_btn:SetActive(true)

			self.taskreward.goto_btn.Text.text.text = var_0_4:getNowLang("questgo")

			local var_9_0 = var_0_7(var_0_10.ninth_task_monster_pic, var_8_5[arg_9_1 + 1].task_boss)

			if self:findPath(var_9_0) then
				self.bg.monster.image.sprite = self:loadSprite(var_9_0)
			end

			local var_9_1 = var_0_7(var_0_10.ninth_task_bg_pic, var_8_5[arg_9_1 + 1].task_bg)

			if self:findPath(var_9_1) then
				self.bg.monster_bg.image.sprite = self:loadSprite(var_9_1)
			end

			local var_9_2 = var_0_7(var_0_10.ninth_task_left_pic, var_8_5[arg_9_1 + 1].task_bg)

			if self:findPath(var_9_2) then
				self.bg.left_top.image.sprite = self:loadSprite(var_9_2)
			end

			self.tasktext.task_tittle.text.text = var_0_4:getNowLang("tasktargettitle")
			self.tasktext.task_progress.text.text = var_0_4:getNowLang("questfinishpercent")

			if arg_8_1 == "all_task" then
				self.tasktext.task_progress:SetActive(true)

				self.tasktext.task_text.text.text = var_0_4:convert_rich_text(var_8_5[arg_9_1 + 1].desc)

				local var_9_3 = math.floor(var_0_2:get_ninth_level_pass_num(var_8_5[arg_9_1 + 1].level_id) / var_8_5[arg_9_1 + 1].num * 100)

				self.tasktext.task_progress.task_num.text.text = var_9_3 .. "%"

				if var_9_3 >= 100 then
					self.tasktext.task_progress:SetActive(false)
					self.bg.get_icon:SetActive(true)
					self.taskreward.goto_btn:SetActive(false)
				end
			elseif arg_8_1 == "self_task" then
				self.tasktext.task_text.text.text = var_0_4:convert_rich_text(var_8_5[arg_9_1 + 1].condition_desc)

				self.tasktext.task_progress:SetActive(false)

				if var_0_8.have_data(var_0_2:get_ninth_task_info_list(), var_8_5[arg_9_1 + 1].id) then
					self.bg.get_icon:SetActive(true)
					self.taskreward.goto_btn:SetActive(false)
				end
			end

			table.sort(var_8_5[arg_9_1 + 1].award, function(arg_10_0, arg_10_1)
				return arg_10_0.id > arg_10_1.id
			end)

			self.taskreward.reward.text.text = var_0_4:getNowLang("warresultrewardtitle") .. ":"

			if #var_8_5[arg_9_1 + 1].award < 4 then
				self.taskreward.reward.rewartypefour:SetActive(false)
			end

			if #var_8_5[arg_9_1 + 1].award < 3 then
				self.taskreward.reward.rewartypethree:SetActive(false)
			end

			if #var_8_5[arg_9_1 + 1].award < 2 then
				self.taskreward.reward.rewartypetwo:SetActive(false)
			end

			for iter_9_0 = 1, #var_8_5[arg_9_1 + 1].award do
				if iter_9_0 == 1 then
					self.taskreward.reward.rewartypeone.rewardimg.image.sprite = self:loadSprite(var_0_7(var_0_10.mail_icon, var_8_5[arg_9_1 + 1].award[iter_9_0].id))
					self.taskreward.reward.rewartypeone.rewardname.text.text = var_8_5[arg_9_1 + 1].award[iter_9_0].value

					self.taskreward.reward.rewartypeone:SetActive(true)
				end

				if iter_9_0 == 2 then
					self.taskreward.reward.rewartypetwo.rewardimg.image.sprite = self:loadSprite(var_0_7(var_0_10.mail_icon, var_8_5[arg_9_1 + 1].award[iter_9_0].id))
					self.taskreward.reward.rewartypetwo.rewardname.text.text = var_8_5[arg_9_1 + 1].award[iter_9_0].value

					self.taskreward.reward.rewartypetwo:SetActive(true)
				end

				if iter_9_0 == 3 then
					self.taskreward.reward.rewartypethree.rewardimg.image.sprite = self:loadSprite(var_0_7(var_0_10.mail_icon, var_8_5[arg_9_1 + 1].award[iter_9_0].id))
					self.taskreward.reward.rewartypethree.rewardname.text.text = var_8_5[arg_9_1 + 1].award[iter_9_0].value

					self.taskreward.reward.rewartypethree:SetActive(true)
				end
			end

			self.taskreward.goto_btn.button.onClick:RemoveAllListeners()
			self.taskreward.goto_btn.button.onClick:AddListener(function()
				var_0_3:destroyInstance("ninth_task")

				local var_11_0 = var_0_3:getInstance("ninth_main_map")

				if var_11_0 then
					var_11_0:show()
				else
					var_0_3:createInstance("ninth_main_map"):show()
				end
			end)
			self.taskreward.reward_btn.button.onClick:RemoveAllListeners()
			self.taskreward.reward_btn.button.onClick:AddListener(function()
				return
			end)
		end
	end

	function arg_1_0.__sort_task(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_2 == "all_task" then
			for iter_13_0, iter_13_1 in pairs(arg_13_1) do
				iter_13_1.finish = var_0_2:get_ninth_level_pass_num(iter_13_1.level_id) >= iter_13_1.num and 1 or 0
			end
		elseif arg_13_2 == "self_task" then
			for iter_13_2, iter_13_3 in pairs(arg_13_1) do
				iter_13_3.finish = var_0_8.have_data(var_0_2:get_ninth_task_info_list(), iter_13_3.id) and 1 or 0
			end
		end

		table.sort(arg_13_1, function(arg_14_0, arg_14_1)
			if arg_14_0.finish == arg_14_1.finish then
				return arg_14_0.id < arg_14_1.id
			else
				return arg_14_0.finish < arg_14_1.finish
			end
		end)

		return arg_13_1
	end

	function arg_1_0:__set_scroll_to_top()
		self._control.task_bg.middle.taskcontent.scrollview.scrollbarvertical:GetComponent("Scrollbar").value = 1
	end

	function arg_1_0:set_npc_img()
		local var_16_0 = var_0_10.ninth_npc_list[var_0_1(1, #var_0_10.ninth_npc_list)]
		local var_16_1 = var_0_8:use_big_break_painting(var_0_11.find_object_by_cid(10000113), var_0_10.ship_icon_type.model_l, false)
		local var_16_2, var_16_3 = self:loadSprite(var_0_10:get_ship_icon(var_16_1, var_16_0))

		self._control.task_bg.npc.img.image.sprite = self:loadSprite(var_0_10:get_ship_icon(var_16_1, var_16_0))

		if var_16_3 and self._control.task_bg.npc.img.transform.localScale.x == 1 and self._control.task_bg.npc.img.transform.localScale.y == 1 and self._control.task_bg.npc.img.transform.localScale.z == 1 then
			var_0_10:hd_sprite_half_scale(self._control.task_bg.npc.img.transform)
		end
	end

	function arg_1_0:__onReset()
		self._control.task_bg.middle.tab_toggle.tab_1.toggle.isOn = true

		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_18_0)
		return
	end

	function arg_1_0:enter_or_return_tween(arg_19_1)
		local var_19_0 = self:autoKillDOTween(var_0_5.Sequence())
		local var_19_1 = self._control.task_bg.top.transform
		local var_19_2 = self._control.task_bg.npc.transform
		local var_19_3 = self._control.task_bg.middle.transform
		local var_19_4 = self._control.task_bg.top.transform.localPosition
		local var_19_5 = self._control.task_bg.npc.transform.localPosition
		local var_19_6 = self._control.task_bg.middle.transform.localPosition

		if arg_19_1 then
			self._control.task_bg.top.transform.localPosition = self._control.task_bg.top.transform.localPosition + var_0_6.New(0, 150, 0)
			self._control.task_bg.npc.transform.localPosition = self._control.task_bg.npc.transform.localPosition + var_0_6.New(-550, 0, 0)
			self._control.task_bg.middle.transform.localPosition = self._control.task_bg.middle.transform.localPosition + var_0_6.New(900, 0, 0)

			self._control.task_bg.top.transform:DOLocalMoveY(self._control.task_bg.top.transform.localPosition.y, 0.2)
			self._control.task_bg.npc.transform:DOLocalMoveX(self._control.task_bg.npc.transform.localPosition.x, 0.2)
			self._control.task_bg.middle.transform:DOLocalMoveX(self._control.task_bg.middle.transform.localPosition.x, 0.2)
		else
			self._control.task_bg.top.transform:DOLocalMoveY(self._control.task_bg.top.transform.localPosition.y + 150, 0.2)
			self._control.task_bg.npc.transform:DOLocalMoveX(self._control.task_bg.npc.transform.localPosition.x - 550, 0.2)
			self._control.task_bg.middle.transform:DOLocalMoveX(self._control.task_bg.middle.transform.localPosition.x + 900, 0.2):OnComplete(function()
				var_19_1.localPosition = var_19_4
				var_19_2.localPosition = var_19_5
				var_19_3.localPosition = var_19_6

				self:setVisible(false)
				self:return_func()
			end)
		end
	end

	function arg_1_0:enter_or_return_tween_for_tab(arg_21_1)
		local var_21_0 = self:autoKillDOTween(var_0_5.Sequence())
		local var_21_1 = self._control.task_bg.middle.taskcontent.transform
		local var_21_2 = self._control.task_bg.middle.taskcontent.transform.localPosition

		if arg_21_1 then
			self._control.task_bg.middle.taskcontent.transform.localPosition = self._control.task_bg.middle.taskcontent.transform.localPosition + var_0_6.New(900, 0, 0)

			self._control.task_bg.middle.taskcontent.transform:DOLocalMoveX(self._control.task_bg.middle.taskcontent.transform.localPosition.x, 0.2)
		else
			self._control.task_bg.middle.taskcontent.transform:DOLocalMoveX(self._control.task_bg.middle.taskcontent.transform.localPosition.x + 900, 0.2):OnComplete(function()
				var_21_1.localPosition = var_21_2

				self:setVisible(false)
				self:return_func()
			end)
		end
	end

	function arg_1_0.return_func(arg_23_0)
		var_0_3:destroyInstance("ninth_task")

		local var_23_0 = var_0_3:getInstance("ninth_main_map")

		if var_23_0 then
			var_23_0:setVisible(true)
		else
			log.print_r("这怕是有问题！！！score_main_map")
		end
	end

	function arg_1_0:_play_audio(arg_24_1)
		self:playBackgroundMusic(arg_24_1)
	end

	function arg_1_0:_play_into_se(arg_25_1)
		self:playSE(arg_25_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_26_0)
	local var_26_0 = var_0_3:class("ninth_task")

	var_26_0._current_task_type = "all_task"

	var_26_0:__initia_lize()

	return var_26_0
end

return var_0_0
