local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_6 = gamecore.user

gamecore.UILoader:define("marry", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self:setVisible(true)
		self:__init_panel(arg_2_1)
		self:__init_language()

		self._ship_detail_back_data = arg_2_2
	end

	function arg_1_0:update_data()
		self:__init_panel(self._data)
		self:__init_language()
	end

	function arg_1_0:marry_ok()
		self:setVisible(false)
		var_0_2:createInstance("ship_detail"):setVisible(false)
		var_0_2:createInstance("marry_ok"):show(self._data.cid, self._data.id, "marry")
	end

	function arg_1_0:__init_panel(arg_5_1)
		self._data = arg_5_1
		self._control.content.cur_love.text.text = math.floor(arg_5_1.love / 100)

		local var_5_0 = arg_5_1.marry and var_0_3.ship_love.marry_love_limit or var_0_3.ship_love.love_init_limit

		self._control.content.need_love.text.text = "/" .. var_5_0 / 100

		local var_5_1 = var_0_6:get_item_count(var_0_3.ship_item_cid.love_ring)

		self._control.content.select_btn:SetActive(not arg_5_1.marry)

		self._love_enough = arg_5_1.love == var_5_0

		if self._love_enough == true then
			self._love_state = true
			self._control.content.select_btn.image.sprite = self:loadSprite(var_0_3.common_icon.can_marry_pick)
			self._control.content.select_btn.button.interactable = true
		else
			self._love_state = false
			self._control.content.select_btn.image.sprite = self:loadSprite(var_0_3.common_icon.cannot_marry_gray)
			self._control.content.select_btn.button.interactable = false
		end

		if var_5_1 > 0 then
			self._control.content.select_btn.title.text.text = var_0_1:getNowLang("loveinfoceremony")
			self._have_ring = true
		else
			self._control.content.select_btn.title.text.text = var_0_1:getNowLang("lbtnbuy")
			self._control.content.select_btn.image.sprite = self:loadSprite(var_0_3.common_icon.can_marry_pick)
			self._control.content.select_btn.button.interactable = true
			self._have_ring = false
		end

		self._control.content.heart_mask.heart.transform.anchoredPosition = Vector2.New(self._control.content.heart_mask.heart.transform.anchoredPosition.x, -(self._control.content.heart_mask.heart.transform.sizeDelta.y * (1 - arg_5_1.love / var_5_0)))
		self._control.content.cur_ring.text.text = var_5_1

		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	function arg_1_0:__init_language()
		self._control.content.title.text.text = var_0_1:getNowLang("lovering")
		self._control.content.love_info_have.text.text = self._love_state and var_0_1:getNowLang("loveinfoneed") or var_0_1:getNowLang("loveinfohave")
		self._control.content.ceremony_desc.text.text = self._data.love == 10000 and not self._data.marry and var_0_1:getNowLang("loveinfoceremonydesc") or self._data.love < 5000 and var_0_1:getNowLang("loveinfodown") or var_0_1:getNowLang("lovenotenough")
	end

	function arg_1_0:_play_into_se(arg_7_1)
		self:playSE(arg_7_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_2:class("marry")

	var_8_0._data = nil
	var_8_0._already_init = false
	var_8_0._have_ring = false
	var_8_0._love_enough = false
	var_8_0._love_state = false
	var_8_0._ship_detail_back_data = nil

	return var_8_0
end

return var_0_0
