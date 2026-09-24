local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_pve_active_config
local var_0_6 = gameconfig.abyss_chapter_config
local var_0_7 = Vector2
local var_0_8 = string.format
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = DG.Tweening.Ease
local var_0_11 = lan_rand
local var_0_12 = math.floor
local var_0_13 = gameconfig.pve_guide_config
local var_0_14 = UnityEngine.Object.Instantiate
local var_0_15 = gameenum.config_data
local var_0_16 = gameconfig.ship_config
local var_0_17 = gameconfig.ship_rule_config

gamecore.UILoader:define("abyss_event", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)
		var_0_3:set_into_cinema(true)
		var_0_3:set_goto_abyss(true)
		self:__init_panel(arg_2_2)
		self._control.npc.bubble:SetActive(false)

		if var_0_3:check_abyss_first_in() then
			self:__switch_desc_panel(true, function()
				self:__show_talk()
				var_0_3:req_AbyssGuideReq()
			end)
		elseif arg_2_1 then
			self:__show_talk()
		end
	end

	function arg_1_0:__init_panel(arg_4_1)
		if not self._is_already_bgm then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.abyss_activity_bgm))

			self._is_already_bgm = true
		end

		if not self._init_comp then
			self._activity_cfg = var_0_5.find_object_by_id(var_0_4.pve_active_list.abyss_event)
			self._boss_chapter_cfg, self._sub_chapter_cfg = self:__get_chapter_cfg()
			self._node_root = self._control.map.node_root.transform

			if not self._node_root then
				log.print_r("node root not found")

				return
			end

			self:__init_language()
			self:__generate_boss_node()
			self:__init_desc_panel()

			self._init_comp = true
		end

		self:update_panel(arg_4_1)
		self._control.npc.bubble:SetActive(false)
	end

	function arg_1_0:__init_desc_panel()
		local var_5_0 = var_0_4.abyss_const.abyss_desc_id
		local var_5_1 = var_0_4.abyss_const.abyss_guide_pic_path

		self._desc_panel_page = {}
		self._desc_now_page = 1
		self._desc_max_page = var_0_4.abyss_const.abyss_desc_num
		self._desc_page_string = var_0_1:getNowLang("ui_new_guide_page")

		for iter_5_0 = 1, var_0_4.abyss_const.abyss_desc_num do
			local var_5_2

			if iter_5_0 == 1 then
				var_5_2 = self._control.desc_panel.main.main_tip.gameObject

				self._control.desc_panel.main.main_tip.gameObject.transform:SetParent(nil)
				self._control.desc_panel.main.main_tip.gameObject.transform:SetParent(self._control.desc_panel.main.main_tip.gameObject.transform.parent)
			else
				var_5_2 = var_0_14(self._control.desc_panel.main.main_tip.gameObject, self._control.desc_panel.main.main_tip.gameObject.transform.parent)
			end

			var_5_2.name = "page_" .. iter_5_0

			local var_5_3 = var_0_13.find_object_by_guide_id(var_5_0 + iter_5_0)

			var_5_2.transform:Find("main_pic"):GetComponent("Image").sprite = self:loadSprite(var_0_8(var_5_1, var_5_3.pic_id))
			var_5_2.transform:Find("tip_word"):GetComponent("Text").text = var_0_1:convert_rich_text(var_5_3.desc, true)
			self._desc_panel_page[iter_5_0] = var_5_2:GetComponent("CanvasGroup")

			self:__active_canvas(self._desc_panel_page[iter_5_0], iter_5_0 == 1, true)
		end

		self:switch_desc_page(1)
	end

	function arg_1_0:switch_desc_page(arg_6_1)
		if not self._desc_max_page then
			return
		end

		if arg_6_1 < 1 or arg_6_1 > self._desc_max_page then
			return
		end

		if arg_6_1 == 1 then
			self._control.desc_panel.prev:SetActive(false)
		else
			self._control.desc_panel.prev:SetActive(true)
		end

		if arg_6_1 == self._desc_max_page then
			self._control.desc_panel.next:SetActive(false)
		else
			self._control.desc_panel.next:SetActive(true)
		end

		if self._desc_now_page and self._desc_now_page ~= arg_6_1 then
			self:__active_canvas(self._desc_panel_page[self._desc_now_page], false, true)
		end

		self:__active_canvas(self._desc_panel_page[arg_6_1], true, true)

		self._desc_now_page = arg_6_1
		self._control.desc_panel.page.txt.text.text = var_0_8(self._desc_page_string, arg_6_1, self._desc_max_page)
	end

	function arg_1_0:update_panel(arg_7_1)
		if not self._init_comp then
			return
		end

		log.print_r(self._node_dic, "章节字典")

		local function var_7_0()
			log.print_r(self._node_dic, "章节字典111")

			if self._node_dic then
				for iter_8_0, iter_8_1 in pairs(self._node_dic) do
					local var_8_0 = var_0_3:get_abyss_world_boss_info(iter_8_0)

					if var_8_0 then
						local var_8_1 = var_8_0.step or 1
						local var_8_2 = iter_8_1.control

						iter_8_1.control.plate.boss.image.sprite = self:loadSprite(var_0_8(var_0_4.abyss_const.abyss_level_boss_node_img, iter_8_0, var_8_1))
						var_8_2.plate.boss.image.alphaHitTestMinimumThreshold = 0.1

						if self._boss_chapter_cfg then
							local var_8_3 = self._boss_chapter_cfg[iter_8_0]

							if self._boss_chapter_cfg[iter_8_0] then
								local var_8_4 = var_8_3["hp" .. var_8_1] or 0
								local var_8_5 = var_0_17.find_object_by_id(23)
								local var_8_6 = var_8_4 == 0 and 0 or var_0_12(var_8_0.hp / var_8_4 * 100)

								log.print_r(var_8_6, "hp_perc")

								var_8_2.hp.rest.image.fillAmount = var_8_6 > 100 and 100 or var_8_6 / 100

								if var_8_1 ~= 3 then
									if var_8_0.hp == 0 then
										self:__active_canvas(var_8_2.state.canvasGroup, true)
										self:__active_canvas(var_8_2.hp.canvasGroup, false)
									else
										self:__active_canvas(var_8_2.hp.canvasGroup, true)
									end
								else
									self:__active_canvas(var_8_2.state.canvasGroup, false)
									self:__active_canvas(var_8_2.hp.canvasGroup, false)
								end

								local var_8_7 = 0

								for iter_8_2, iter_8_3 in ipairs(var_8_3.need_chapter) do
									if var_0_3:check_chapter_pass(iter_8_3) then
										if var_8_2.lock["pass_point" .. iter_8_3] then
											self:__active_canvas(var_8_2.lock["pass_point" .. iter_8_3].canvasGroup, true, true)
										end

										if iter_8_1.children[iter_8_3] then
											iter_8_1.children[iter_8_3].control.plate.image.sprite = self:loadSprite(var_0_4.abyss_const.abyss_sub_plate_open)

											self:__active_canvas(iter_8_1.children[iter_8_3].control.state.canvasGroup, true)

											iter_8_1.children[iter_8_3].route.open.image.fillAmount = 1
										end

										var_8_7 = var_8_7 + 1
									else
										if var_8_2.lock["pass_point" .. iter_8_3] then
											self:__active_canvas(var_8_2.lock["pass_point" .. iter_8_3].canvasGroup, false, true)
										end

										if iter_8_1.children[iter_8_3] then
											iter_8_1.children[iter_8_3].control.plate.image.sprite = self:loadSprite(var_0_4.abyss_const.abyss_sub_plate)

											self:__active_canvas(iter_8_1.children[iter_8_3].control.state.canvasGroup, false)

											iter_8_1.children[iter_8_3].route.open.image.fillAmount = 0
										end
									end
								end

								if var_8_7 == #var_8_3.need_chapter then
									self:__active_canvas(var_8_2.lock.canvasGroup, false, true)

									var_8_2.plate.image.sprite = self:loadSprite(var_0_4.abyss_const.abyss_boss_plate_open)
									var_8_2.plate.boss.button.enabled = true

									var_0_3:set_boss_open(true)
								else
									self:__active_canvas(var_8_2.lock.canvasGroup, true, true)

									var_8_2.plate.image.sprite = self:loadSprite(var_0_4.abyss_const.abyss_boss_plate)
									var_8_2.plate.boss.button.enabled = false
								end
							end
						end
					end
				end
			end
		end

		if arg_7_1 then
			var_7_0()
		else
			var_0_3:setAbyssBossInfoRespCallback(var_7_0)
			var_0_3:req_AbyssBossInfoReq(4)
		end
	end

	function arg_1_0:create_chapter_cfg()
		return self:__get_chapter_cfg()
	end

	function arg_1_0.__get_chapter_cfg(arg_10_0)
		local var_10_0 = var_0_3:get_boss_chapter_config()
		local var_10_1 = var_0_3:get_sub_chapter_config()

		if not next(var_10_0) or not next(var_10_1) then
			local var_10_2 = var_0_6.get_sequence()

			if var_10_2 then
				for iter_10_0, iter_10_1 in ipairs(var_10_2) do
					if iter_10_1.type == var_0_4.abyss_chapter_type.boss then
						var_10_0[iter_10_1.chapter_id] = iter_10_1
					else
						var_10_1[iter_10_1.chapter_id] = iter_10_1
					end
				end
			end

			var_0_3:set_boss_chapter_config(var_10_0)
			var_0_3:set_sub_chapter_config(var_10_1)
		end

		return var_10_0, var_10_1
	end

	function arg_1_0.__get_real_pos(arg_11_0, arg_11_1, arg_11_2)
		return var_0_7(arg_11_1, -arg_11_2)
	end

	function arg_1_0:__generate_boss_node()
		if not self._boss_chapter_cfg then
			return
		end

		self._node_dic = {}

		for iter_12_0, iter_12_1 in pairs(self._boss_chapter_cfg) do
			local var_12_0, var_12_1 = self:loadUIPrefab("abyss_level_node", self._node_root)

			var_12_1.plate.image.sprite = self:loadSprite(var_0_4.abyss_const.abyss_boss_plate)
			var_12_0._panel.transform.anchoredPosition = self:__get_real_pos(iter_12_1.position.x, iter_12_1.position.y)

			self:__active_canvas(var_12_1.hp.canvasGroup, true, true)
			var_12_1.plate.boss.button.onClick:RemoveAllListeners()
			var_12_1.plate.boss.button.onClick:AddListener(function()
				self:setVisible(false)

				local var_13_0 = var_0_2:createInstance("abyss_preview")

				if var_13_0 then
					var_13_0:show(iter_12_1)
				end
			end)
			self:__active_canvas(var_12_1.lock.canvasGroup, true)

			var_12_1.plate.boss.button.enabled = false
			self._node_dic[iter_12_0] = {}
			self._node_dic[iter_12_0].control = var_12_1

			var_12_0:setVisible(true)
			self:__generate_sub_node(iter_12_1, iter_12_1.need_chapter)
			var_12_0._panel.transform:SetParent(nil)
			var_12_0._panel.transform:SetParent(self._node_root)
		end
	end

	function arg_1_0:__generate_sub_node(arg_14_1, arg_14_2)
		if not arg_14_2 or not self._sub_chapter_cfg or not self._node_dic[arg_14_1.chapter_id] then
			return
		end

		local var_14_0 = self._node_root

		self._node_dic[arg_14_1.chapter_id].children = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
			local var_14_1 = self._sub_chapter_cfg[iter_14_1]

			if self._sub_chapter_cfg[iter_14_1] then
				local var_14_2, var_14_3 = self:loadUIPrefab("abyss_level_node", var_14_0)

				var_14_3.plate.boss.image.sprite = self:loadSprite(var_0_8(var_0_4.abyss_const.abyss_level_node_img, iter_14_1))
				var_14_3.plate.boss.image.alphaHitTestMinimumThreshold = 0.1

				var_14_3.plate.boss.image:SetNativeSize()

				var_14_3.plate.boss.transform.anchoredPosition = var_14_3.plate.boss.transform.anchoredPosition + var_0_7(0, -13)
				var_14_3.plate.image.sprite = self:loadSprite(var_0_4.abyss_const.abyss_sub_plate)

				var_14_3.plate.image:SetNativeSize()

				var_14_2._panel.transform.anchoredPosition = self:__get_real_pos(self._sub_chapter_cfg[iter_14_1].position.x, self._sub_chapter_cfg[iter_14_1].position.y)

				var_14_3.plate.boss.button.onClick:RemoveAllListeners()
				var_14_3.plate.boss.button.onClick:AddListener(function()
					self:setVisible(false)

					local var_15_0 = var_0_2:createInstance("abyss_preview")

					if var_15_0 then
						var_15_0:show(var_14_1)
					end
				end)

				self._node_dic[arg_14_1.chapter_id].children[iter_14_1] = {}
				self._node_dic[arg_14_1.chapter_id].children[iter_14_1].control = var_14_3

				var_14_2:setVisible(true)

				self._node_dic[arg_14_1.chapter_id].children[iter_14_1].route = self:__generate_route(arg_14_1, self._sub_chapter_cfg[iter_14_1])
			end
		end
	end

	function arg_1_0:__generate_route(arg_16_1, arg_16_2)
		if arg_16_2 and arg_16_2.arrow then
			local var_16_0, var_16_1 = self:loadUIPrefab("abyss_route", self._node_root)

			var_16_1.off.image.sprite = self:loadSprite(var_0_8(var_0_4.abyss_const.abyss_node_route_img, arg_16_2.chapter_id, arg_16_1.chapter_id))

			var_16_1.off.image:SetNativeSize()

			var_16_1.open.image.sprite = self:loadSprite(var_0_8(var_0_4.abyss_const.abyss_open_route_img, arg_16_2.chapter_id, arg_16_1.chapter_id))

			var_16_1.open.image:SetNativeSize()

			var_16_0._panel.transform.anchoredPosition = self:__get_real_pos(arg_16_2.arrow[1].x, arg_16_2.arrow[1].y)

			var_16_0:setVisible(true)

			return var_16_1
		end
	end

	function arg_1_0.play_unlock_ani(arg_17_0, arg_17_1)
		return
	end

	function arg_1_0:__show_talk()
		if self._npc_talk_tween then
			return
		end

		local var_18_0 = var_0_1:getNowLang("ui_ny21_main_tip_" .. var_0_11(1, 3))

		var_18_0 = var_18_0 or ""

		local var_18_1 = 3

		if #var_18_0 == 0 or var_18_0 == "" then
			self._control.npc.bubble:SetActive(false)

			return
		else
			self._control.npc.bubble:SetActive(true)
		end

		self._control.npc.bubble.popVerticalAdaptive:SetText(var_18_0)

		self._control.npc.bubble.label_txt.text.text = ""

		local var_18_2 = self:autoKillDOTween(var_0_9.Sequence())

		self._npc_talk_tween = var_18_2

		var_18_2:AppendInterval(0.2)
		var_18_2:Append(self._control.npc.bubble.canvasGroup:DOFade(1, 0.2):SetAutoKill(true))
		var_18_2:Append(self._control.npc.bubble.label_txt.text:DOText(var_18_0, #var_18_0 * 0.03):SetEase(var_0_10.Linear):SetAutoKill(true))
		var_18_2:AppendInterval(var_18_1 - #var_18_0 * 0.03 + 1)
		var_18_2:Append(self._control.npc.bubble.canvasGroup:DOFade(0, 0.3):SetAutoKill(true))
		var_18_2:AppendCallback(function()
			var_18_2:Kill()

			self._npc_talk_tween = nil
		end)
		var_18_2:Play()
	end

	function arg_1_0:__switch_desc_panel(arg_20_1, arg_20_2)
		self:__active_canvas(self._control.desc_panel.canvasGroup, arg_20_1)

		if self._desc_dead_func then
			self._desc_dead_func()
		end

		self._desc_dead_func = arg_20_2
	end

	function arg_1_0.__active_canvas(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		if not arg_21_1 then
			return
		end

		arg_21_1.alpha = arg_21_2 and 1 or 0

		if arg_21_3 then
			return
		end

		arg_21_1.blocksRaycasts = arg_21_2
		arg_21_1.interactable = arg_21_2
	end

	function arg_1_0.__destroy_panel(arg_22_0)
		var_0_2:destroyInstance("abyss_event")

		if var_0_2:createInstance("combat_result") then
			var_0_2:destroyInstance("combat_result")
		end
	end

	function arg_1_0.__open_reward_box(arg_23_0)
		local var_23_0 = var_0_2:createInstance("abyss_quest")

		if var_23_0 then
			var_23_0:show()
		end
	end

	function arg_1_0:__init_language()
		if not self._activity_cfg then
			return
		end

		self._control.top.main_title.text.text = self._activity_cfg.title
		self._control.desc_panel.main.title.text.text = var_0_1:getNowLang("activityinstruction")
		self._control.desc_panel.prev.text.text.text = var_0_1:getNowLang("ui_new_guide_last")
		self._control.desc_panel.next.text.text.text = var_0_1:getNowLang("ui_new_guide_next")
	end

	function arg_1_0:__init_abyss_ship()
		self._control.abyss_msgbox:SetActive(true)

		self._control.abyss_msgbox.main.title.text.text = var_0_1:getNowLang("btngetship")
		self._control.abyss_msgbox.main.one.text.text.text = var_0_1:getNowLang("ensure")

		for iter_25_0, iter_25_1 in pairs({
			self._control.abyss_msgbox.main.rewards.scrollview.viewport.content.rewardone,
			self._control.abyss_msgbox.main.rewards.scrollview.viewport.content.rewardtwo,
			self._control.abyss_msgbox.main.rewards.scrollview.viewport.content.rewardthree,
			self._control.abyss_msgbox.main.rewards.scrollview.viewport.content.rewardfour,
			self._control.abyss_msgbox.main.rewards.scrollview.viewport.content.rewardfive,
			self._control.abyss_msgbox.main.rewards.scrollview.viewport.content.rewardsix
		}) do
			iter_25_1.icon.image.sprite = self:loadSprite(var_0_8(var_0_4.normal_str, var_0_15.abyss_init_ship[iter_25_0].id))
			iter_25_1.number.text.text = var_0_15.abyss_init_ship[iter_25_0].num

			if var_0_15.abyss_init_ship[iter_25_0].num == 1 then
				iter_25_1.number:SetActive(false)
			end

			local var_25_0 = var_0_16.find_object_by_cid(var_0_15.abyss_init_ship[iter_25_0].id)

			iter_25_1.title_mask.reward_name.text.text = var_25_0.title

			iter_25_1.title_mask:GetComponent("TextHorizonScroller"):SetText(var_25_0.title)

			iter_25_1.bg.image.sprite = var_25_0.boss == 0 and self:loadSprite(var_0_4.abyss_ship_back_ground_0) or self:loadSprite(var_0_4.abyss_ship_back_ground_1)
		end
	end

	function arg_1_0:_play_audio(arg_26_1)
		self:playBackgroundMusic(arg_26_1, true)
	end

	function arg_1_0:__onReset()
		if self._npc_talk_tween then
			self._npc_talk_tween:Kill()

			self._npc_talk_tween = nil
		end

		self:switch_desc_page(1)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_28_0)
	local var_28_0 = var_0_2:class("abyss_event")

	arg_28_0._init_comp = nil
	arg_28_0._node_dic = nil
	arg_28_0._boss_chapter_cfg = nil
	arg_28_0._sub_chapter_cfg = nil
	arg_28_0._is_already_bgm = false

	gamecore.extend_obj(var_28_0)

	return var_28_0
end

return var_0_0
