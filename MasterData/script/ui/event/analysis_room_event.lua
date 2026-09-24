local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.prompt
local var_0_6 = UnityEngine.Vector2

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_return_btn(arg_2_0)
		return
	end

	function arg_1_0:__onClick_npc_image()
		if self._can_click_npc then
			self:__reset_talk_tween()
			self:__show_talk()
		end
	end

	function arg_1_0:__onClick_normal_card()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		self._click_enter_type = var_0_3.tower_get_chip_type.normal

		self:__init_active()

		if not self._normal_card then
			var_0_5:show(var_0_4:getNowLang("ui_tower_buff_stone_zero"))
		else
			self._control.shop_bounced.gameObject:SetActive(true)

			self._control.shop_bounced.main.main.use_text.text.text = var_0_4:getNowLang("ui_tower_buff_draw_content_0")
			self._control.shop_bounced.main.main.normal.former_num.text.text = self._normal_card.count
			self._control.shop_bounced.main.main.normal.former_num.arrow.latter_num.text.text = self._normal_card.count - 1
		end
	end

	function arg_1_0:__onClick_advanced_card()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		self._click_enter_type = var_0_3.tower_get_chip_type.advanced

		self:__init_active()

		if not self._advanced_card and not self._speical_card then
			var_0_5:show(var_0_4:getNowLang("ui_tower_buff_stone_zero"))
		else
			self._control.shop_bounced.gameObject:SetActive(true)

			self._control.shop_bounced.main.main.use_text.text.text = var_0_4:getNowLang("ui_tower_buff_draw_content_1")

			local var_5_0 = 0
			local var_5_1 = 0
			local var_5_2 = 0
			local var_5_3 = 0
			local var_5_4 = true

			if self._advanced_card then
				if self._advanced_card.count > 0 then
					var_5_0 = self._advanced_card.count
					var_5_2 = self._advanced_card.count - 1
					var_5_4 = false
				else
					var_5_2 = self._advanced_card.count
				end
			end

			if self._speical_card then
				var_5_1 = self._speical_card.count
				var_5_3 = var_5_4 and var_5_1 > 0 and var_5_1 - 1 or var_5_1
			end

			self._control.shop_bounced.main.main.advanced.former_num.text.text = var_5_0
			self._control.shop_bounced.main.main.advanced.former_num.arrow.latter_num.text.text = var_5_2
			self._control.shop_bounced.main.main.advanced.former_num_2.text.text = var_5_1
			self._control.shop_bounced.main.main.advanced.former_num_2.arrow.latter_num.text.text = var_5_3
		end
	end

	function arg_1_0:__shop_bounced_show_animation()
		self._control.shop_bounced.transform.localScale = var_0_6.New(0.1, 0.1)

		self._control.shop_bounced.transform:DOScale(1, 0.15):SetEase(DG.Tweening.Ease.OutBack)
	end

	function arg_1_0:__onClick_machine_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		local var_7_0 = var_0_1:createInstance("tactical_machine")

		var_7_0:show()
		var_7_0:__do_position(true)
	end

	function arg_1_0:__onClick_library_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		var_0_1:createInstance("buffmap"):show()
	end

	function arg_1_0:__onClick_shop_bounced_main_confirmbtn()
		self._control.shop_bounced.gameObject:SetActive(false)
		self:__card_ani_func()
	end

	function arg_1_0:__onClick_shop_bounced_main_quitbtn()
		self._control.shop_bounced.gameObject:SetActive(false)
	end

	function arg_1_0.__onClick_card_ani(arg_11_0)
		return
	end
end

function var_0_0.extend_obj(arg_12_0)
	arg_12_0._click_enter_type = nil
end

return var_0_0
