local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_6 = gameenum.common_type

gamecore.UILoader:define("analysis_room", function(arg_1_0)
	local var_1_0 = DG.Tweening.DOTween
	local var_1_1

	function arg_1_0:show()
		self:setVisible(true)
		self:__back_func("climb_tower")
		self:__init_panel()
		self:__show_talk()
	end

	function arg_1_0:__init_panel()
		self:__initial_func()
		self:__init_data()
		self:__init_active()
		self:__set_card_count()
		self._control.card_ani:SetActive(false)
	end

	function arg_1_0:show_by_bype(arg_4_1)
		self:show()
		self:__back_func(arg_4_1)
	end

	function arg_1_0:__back_func(arg_5_1)
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
		self._control.return_btn.button.onClick:RemoveAllListeners()
		self._control.return_btn.button.onClick:AddListener(function()
			var_0_2:destroyInstance("analysis_room")

			local var_6_0 = var_0_2:getInstance(arg_5_1)

			if var_6_0 then
				var_6_0:setVisible(true)
			else
				var_0_2:createInstance(arg_5_1):show()
			end
		end)
	end

	function arg_1_0:set_panel_clickable(arg_7_1)
		self._canvas_group = self._canvas_group or self._panel:GetComponent("CanvasGroup")
		self._canvas_group.blocksRaycasts = arg_7_1 or false
	end

	function arg_1_0:__card_ani_func()
		local var_8_0 = self._control.card_ani

		self._control.card_ani:SetActive(true)

		function var_1_1()
			if self._click_enter_type == var_0_6.tower_get_chip_type.normal then
				var_0_3:req_TowerGetChipReq(var_0_6.tower_get_chip_type.normal)
			elseif self._click_enter_type == var_0_6.tower_get_chip_type.advanced then
				var_0_3:req_TowerGetChipReq(var_0_6.tower_get_chip_type.advanced)
			end

			var_8_0.button.onClick:RemoveAllListeners()
			var_8_0:SetActive(false)

			var_1_1 = nil

			self._card_req:Kill()
		end

		self._card_req = self:autoKillDOTween(var_1_0.Sequence())

		self._card_req:InsertCallback(2, var_1_1)
		self._card_req:Play()
		self._control.card_ani.button.onClick:AddListener(var_1_1)
	end

	function arg_1_0:__show_talk()
		local var_10_0 = var_0_1:getNowLang("ui_tower_buff_tip_" .. lan_rand(1, 3))

		if var_10_0 == "" then
			return
		end

		self._control.talk.popVerticalAdaptive:SetText(var_10_0)

		self._control.talk.lable_txt.text.text = ""

		self._control.talk:SetActive(true)

		self._talk_tween_seq = self:autoKillDOTween(var_1_0.Sequence())

		self._talk_tween_seq:Append(self._control.talk.canvasGroup:DOFade(1, 0.3))
		self._talk_tween_seq:Append(self._control.talk.lable_txt.text:DOText(var_10_0, #var_10_0 * 0.03):SetEase(DG.Tweening.Ease.Linear))
		self._talk_tween_seq:AppendInterval(#var_10_0 * 0.03 + 0.5)
		self._talk_tween_seq:Append(self._control.talk.canvasGroup:DOFade(0, 0.5):OnComplete(function()
			self._can_click_npc = true
		end))

		self._can_click_npc = false

		self._talk_tween_seq:Play()
	end

	function arg_1_0:__reset_talk_tween()
		if self._talk_tween_seq then
			self._talk_tween_seq:Kill()

			self._talk_tween_seq = nil
		end

		self._control.talk.popVerticalAdaptive:SetText("")

		self._control.talk.lable_txt.text.text = ""
		self._control.talk.canvasGroup.alpha = 0
		self._can_click_npc = true
	end

	function arg_1_0:__set_card_count()
		self:update_card_count()
	end

	function arg_1_0.__init_data(arg_14_0)
		arg_14_0.__chip_info = var_0_3:get_tower_chip_info()
	end

	function arg_1_0:__init_active()
		self._control.shop_bounced.main.main.normal.gameObject:SetActive(self._click_enter_type == var_0_6.tower_get_chip_type.normal)
		self._control.shop_bounced.main.main.advanced.gameObject:SetActive(self._click_enter_type == var_0_6.tower_get_chip_type.advanced)
	end

	function arg_1_0:__set_return_btn_active(arg_16_1)
		self._control.return_btn.button.interactable = arg_16_1 or false
	end

	function arg_1_0:update_card_count()
		self._normal_card = var_0_3:get_item(var_0_6.analysis_card_ticket.normal_ticket)
		self._advanced_card = var_0_3:get_item(var_0_6.analysis_card_ticket.advanced_ticket)
		self._speical_card = var_0_3:get_item(var_0_6.analysis_card_ticket.special_ticket)

		local var_17_0

		if self._advanced_card then
			var_17_0 = self._advanced_card.count or 0

			local var_17_1

			if self._speical_card then
				var_17_1 = self._speical_card.count or 0
			end
		end

		self._advanced_card_count = var_17_0 + var_17_1
		self._control.red_transform.card_count.text.text = self._advanced_card_count

		if self._normal_card then
			self._control.black_transform.card_count.text.text = self._normal_card.count or 0
		end
	end

	function arg_1_0:_play_into_se(arg_18_1)
		self:playSE(arg_18_1, false)
	end

	function arg_1_0:__initial_func()
		local var_19_0 = {
			{
				nodetext = "ui_tower_buff_draw_title",
				node = self._control.shop_bounced.main.title_text
			},
			{
				nodetext = "space_confirm",
				node = self._control.shop_bounced.main.confirmbtn.text
			},
			{
				nodetext = "space_cancel",
				node = self._control.shop_bounced.main.quitbtn.text
			}
		}
		local var_19_1 = {
			{
				state = false,
				node = self._control.shop_bounced
			},
			{
				state = false,
				node = self._control.shop_bounced.main.main.normal
			},
			{
				state = false,
				node = self._control.shop_bounced.main.main.advanced
			}
		}
		local var_19_2 = {
			init_language = function(self, arg_20_1)
				self.text.text = var_0_1:getNowLang(arg_20_1)
			end,
			init_active = function(self, arg_21_1)
				self.gameObject:SetActive(arg_21_1)
			end
		}

		for iter_19_0 = 1, #var_19_0 do
			var_19_2.init_language(var_19_0[iter_19_0].node, var_19_0[iter_19_0].nodetext)
		end

		for iter_19_1 = 1, #var_19_1 do
			var_19_2.init_active(var_19_1[iter_19_1].node, var_19_1[iter_19_1].state)
		end
	end

	function arg_1_0:__onReset()
		self:__reset_talk_tween()
		self:__set_return_btn_active(true)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_23_0)
	local var_23_0 = var_0_2:class("analysis_room")

	var_23_0._lower_card = nil
	var_23_0._speical_card = nil
	var_23_0._hight_card = nil
	var_23_0._all_hight_card = 0
	var_23_0._click_enter_type = nil

	return var_23_0
end

return var_0_0
