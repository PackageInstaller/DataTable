local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = DG.Tweening.DOTween
local var_0_5 = string.format
local var_0_6 = gameenum.common_type
local var_0_7 = UnityEngine.Vector2
local var_0_8 = gameconfig.login_award_config

gamecore.UILoader:define("signin", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		if arg_2_1 then
			self:setVisible(true)
			var_0_3:set_close_sign(true)
		else
			self:setVisible(false)
		end

		self._user_data = var_0_3:get_use_info_data()

		self:__init_panel()
		self:_init_move()
		self:__init_one()

		self._already_init = true
	end

	function arg_1_0:__init_panel()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))

		self._configs = var_0_8.get_sequence()
		self._getaward = self._user_data.login_award.is_already_get
		self._sign_day = self._user_data.login_award.cumulative_days

		if self._getaward then
			self._sign_day = self._sign_day - 1
		end

		if self._sign_day <= 28 then
			self._reset_day = self._sign_day
		else
			self._reset_day = self._sign_day % 28

			if self._reset_day == 0 then
				self._reset_day = 28
			end
		end

		self._cumulatives = gameconfig.login_award_config.find_object_by_id(self._reset_day)
		self._remainder = math.ceil(self._reset_day / 7)
		self._contents = {
			self._control.fragment.rewardone,
			self._control.fragment.rewardtwo,
			self._control.fragment.rewardthree,
			self._control.fragment.rewardfour,
			self._control.fragment.rewardfive,
			self._control.fragment.rewardsix,
			self._control.fragment.rewardseven
		}
		self._str = var_0_6.normal_str

		for iter_3_0, iter_3_1 in pairs(self._cumulatives.award) do
			self._picn = iter_3_1.id
			self._numn = iter_3_1.value
		end

		self._todayurl = var_0_5(self._str, self._picn)
		self._rewardname = self._cumulatives.type

		self:__init_rewardone()
		self:play_in_out_animation(true)

		local var_3_0 = {
			self._control.fragment.rewardone,
			self._control.fragment.rewardtwo,
			self._control.fragment.rewardthree,
			self._control.fragment.rewardfour,
			self._control.fragment.rewardfive,
			self._control.fragment.rewardsix,
			self._control.fragment.rewardseven
		}

		self._control.fragment.mainfragment.title.text.text = var_0_1:getNowLang("ui_everydaytitle")

		for iter_3_2 = 1, 7 do
			var_3_0[iter_3_2].oneday.text.text = var_0_1:getNowLang(var_0_5("continueloginday%d", iter_3_2))
		end

		self._control.fragment.btn.text.text.text = var_0_1:getNowLang("mbtnget")
		self._control.fragment.rewardseven.rewardone.image.sprite = self:loadSprite(var_0_5(var_0_6.normal_str, 336))

		if self._getaward then
			self._control.fragment.btn.button.interactable = false
			self._control.fragment.btn.text.text.text = var_0_1:getNowLang("marketinghaveget")
		else
			self._control.fragment.btn.button.interactable = true
		end
	end

	function arg_1_0:play_in_out_animation(arg_4_1, arg_4_2)
		if arg_4_1 then
			self._control.mask.uITweenSequence:Play(function()
				if arg_4_2 then
					arg_4_2()
				end
			end)
		else
			self._control.mask.uITweenSequence:PlayReverse(function()
				if arg_4_2 then
					arg_4_2()
				end
			end)
		end
	end

	function arg_1_0:__init_issiginone(arg_7_1)
		for iter_7_0 = 1, 7 do
			self._contents[iter_7_0].finish:SetActive(false)

			self._contents[iter_7_0].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.no_sign)

			self._contents[iter_7_0].selected:SetActive(false)

			if iter_7_0 == 7 then
				self._contents[iter_7_0].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.no_sign)

				self._contents[iter_7_0].finishone:SetActive(false)
			end
		end

		local var_7_0

		if arg_7_1 == 0 then
			arg_7_1 = 1
		end

		var_7_0 = arg_7_1 <= 8 and arg_7_1 or arg_7_1 % 7

		if self._getaward then
			if var_7_0 == 0 then
				var_7_0 = 8
			end

			self._contents[var_7_0].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

			self._contents[var_7_0].finish:SetActive(true)
			self._contents[var_7_0].selected:SetActive(false)

			if var_7_0 == 7 then
				self._contents[var_7_0].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[var_7_0].finishone:SetActive(true)
			end

			for iter_7_1 = 1, var_7_0 - 1 do
				self._contents[iter_7_1].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[iter_7_1].finish:SetActive(true)
				self._contents[iter_7_1].selected:SetActive(false)
			end
		else
			if var_7_0 == 8 then
				var_7_0 = 1
			end

			if var_7_0 == 0 then
				var_7_0 = 7
			end

			self._contents[var_7_0].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

			self._contents[var_7_0].finish:SetActive(false)
			self._contents[var_7_0].selected:SetActive(true)

			if var_7_0 == 7 then
				self._contents[var_7_0].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[var_7_0].finishone:SetActive(false)
			end

			for iter_7_2 = 1, var_7_0 - 1 do
				self._contents[iter_7_2].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[iter_7_2].finish:SetActive(true)
				self._contents[iter_7_2].selected:SetActive(false)
			end
		end
	end

	function arg_1_0:__init_issigintwo()
		for iter_8_0 = 1, 7 do
			self._contents[iter_8_0].finish:SetActive(false)

			self._contents[iter_8_0].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.no_sign)

			self._contents[iter_8_0].selected:SetActive(false)

			if iter_8_0 == 7 then
				self._contents[iter_8_0].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.no_sign)

				self._contents[iter_8_0].finishone:SetActive(false)
			end
		end

		local var_8_0 = self._sign_day % 7

		if self._sign_day % 7 == 0 then
			var_8_0 = 7
		end

		if self._getaward then
			for iter_8_1 = 1, var_8_0 do
				self._contents[iter_8_1].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[iter_8_1].finish:SetActive(true)
				self._contents[iter_8_1].selected:SetActive(false)

				if iter_8_1 == 7 then
					self._contents[iter_8_1].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

					self._contents[iter_8_1].finishone:SetActive(true)
				end
			end
		elseif self._getaward then
			for iter_8_2 = 1, var_8_0 do
				self._contents[iter_8_2].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[iter_8_2].finish:SetActive(true)
				self._contents[iter_8_2].selected:SetActive(false)
			end

			if var_8_0 == 7 then
				self._contents[var_8_0].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[var_8_0].finishone:SetActive(true)
			end
		elseif not self._getaward and var_8_0 <= 8 and var_8_0 > 0 then
			for iter_8_3 = 1, var_8_0 do
				self._contents[iter_8_3].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[iter_8_3].finish:SetActive(true)
				self._contents[iter_8_3].selected:SetActive(false)
			end

			if var_8_0 == 8 then
				var_8_0 = 7
			end

			self._contents[var_8_0].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

			self._contents[var_8_0].finish:SetActive(false)
			self._contents[var_8_0].selected:SetActive(true)

			if var_8_0 == 7 then
				self._contents[var_8_0].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[var_8_0].finishone:SetActive(false)
			end
		else
			for iter_8_4 = 1, var_8_0 do
				self._contents[iter_8_4].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[iter_8_4].finish:SetActive(true)
				self._contents[iter_8_4].selected:SetActive(false)
			end

			if var_8_0 == 7 then
				self._contents[var_8_0].rewardbgone.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.have_sign)

				self._contents[var_8_0].finishone:SetActive(true)
			end
		end
	end

	function arg_1_0:__init_rewardone()
		local var_9_0 = self._reset_day

		if self._reset_day > 28 then
			var_9_0 = var_9_0 % 28

			if var_9_0 == 0 then
				var_9_0 = 7
			end
		end

		local var_9_1 = math.ceil(var_9_0 / 7)

		for iter_9_0 = (var_9_1 - 1) * 7 + 1, var_9_1 * 7 do
			if var_9_0 < 8 then
				for iter_9_1, iter_9_2 in pairs(gameconfig.login_award_config.find_object_by_id(iter_9_0).award) do
					self._pics = iter_9_2.id
					self._numbs = iter_9_2.value
				end

				self._contents[iter_9_0].reward.image.sprite = self:loadSprite((var_0_5(self._str, self._pics)))
				self._contents[iter_9_0].number.text.text = self._numbs

				if condition then
					-- block empty
				end

				self:__init_issiginone(var_9_0)
			elseif var_9_0 >= 8 then
				local var_9_2 = gameconfig.login_award_config.find_object_by_id(iter_9_0)
				local var_9_3 = var_9_2.id % 7

				if var_9_2.id % 7 == 0 then
					var_9_3 = 7
				end

				self._contents[var_9_3].rewardbg.image.sprite = self:loadSprite(var_0_6.ship_equip_pic.no_sign)

				for iter_9_3, iter_9_4 in pairs(var_9_2.award) do
					self._pics = iter_9_4.id
					self._numbs = iter_9_4.value
				end

				self._contents[var_9_3].reward.image.sprite = self:loadSprite((var_0_5(self._str, self._pics)))
				self._contents[var_9_3].number.text.text = self._numbs

				self:__init_issigintwo()
			end
		end
	end

	function arg_1_0:__init_one()
		if self._already_init then
			return
		end
	end

	function arg_1_0:_init_move()
		self._control.fragment.mainfragment.mask.glow.rectTransform.anchoredPosition = var_0_7(-500, 171)

		if not self._signin_seq then
			self._signin_seq = self:autoKillDOTween(var_0_4.Sequence())

			self._signin_seq:Append(self._control.fragment.mainfragment.mask.glow.transform:DOBlendableLocalMoveBy(Vector3.New(2500, 0), 5):SetEase(DG.Tweening.Ease.Linear))
			self._signin_seq:SetLoops(-1)
			self._signin_seq:Play()
		end
	end

	function arg_1_0:is_signin()
		if self._getaward then
			-- block empty
		elseif not self._getaward and var_0_3:get_close_sign() then
			-- block empty
		elseif not var_0_3:get_guide_state() then
			self:show(true)
		end
	end

	function arg_1_0:_play_into_se(arg_13_1)
		self:playSE(arg_13_1, false)
	end

	function arg_1_0.__onReset(arg_14_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_2:class("signin")

	var_15_0._already_init = false
	var_15_0._user_data = nil
	var_15_0._cumulatives = nil
	var_15_0._configs = nil
	var_15_0._getaward = nil
	var_15_0._contents = {}
	var_15_0._str = nil
	var_15_0._picn = nil
	var_15_0._todayurl = nil
	var_15_0._numn = nil
	var_15_0._rewardname = nil
	var_15_0._pics = nil
	var_15_0._numbs = nil
	var_15_0._signin_seq = nil
	var_15_0._remainder = nil
	var_15_0._sign_day = nil
	var_15_0._reset_day = nil

	return var_15_0
end

return var_0_0
