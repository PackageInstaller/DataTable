local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_8 = Vector2

gamecore.UILoader:define("upgradeawards", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:_init_move()
	end

	function arg_1_0:__onVisible(arg_3_1)
		if not arg_3_1 then
			return
		end

		self:__init_panel()

		self._already_init = true
	end

	function arg_1_0:__init_panel()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		self._user_data = var_0_3:get_use_info_data()
		self._user_lv = gameconfig.level_config.find_object_by_level(self._user_data.level).level
		self._getaward_info = self._user_data.level_up_award or {}
		self._getaward = {}

		for iter_4_0, iter_4_1 in pairs(self._getaward_info) do
			var_0_7(self._getaward, iter_4_1)
		end

		self._contents = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardstwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfour,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfive,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardssix,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsseven,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardseight,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsnine,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsten
		}
		self._contents_one = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfour,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfive,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardsix
		}
		self._contents_two = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardthree
		}
		self._contents_three = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfour,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfive,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardsix
		}
		self._contents_four = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfour,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfive
		}
		self._contents_five = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardthree
		}
		self._contents_six = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardfour
		}
		self._contents_seven = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardfour
		}
		self._contents_eight = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardfour
		}
		self._contents_nine = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardfour
		}
		self._contents_ten = {
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardone,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardtwo,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardthree,
			self._control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardfour
		}
		self._control.mainfragment.title.text.text = var_0_1:getNowLang("marketinglevelupbtn")

		local var_4_0 = var_0_1:getNowLang("marketingloginneedlevel", true)
		local var_4_1 = app:getSystem():getChannel()

		if var_4_1 ~= var_0_4.channel.android_jp then
			if var_4_1 == var_0_4.channel.iOS_jp then
				var_4_0 = string.gsub(var_4_0, "% ", "<color=#00000000>.</color>")
			end
		end

		self._contents[1].nowlv.text.text = var_0_6(var_4_0, 10)
		self._contents[2].nowlv.text.text = var_0_6(var_4_0, 20)
		self._contents[3].nowlv.text.text = var_0_6(var_4_0, 30)
		self._contents[4].nowlv.text.text = var_0_6(var_4_0, 40)
		self._contents[5].nowlv.text.text = var_0_6(var_4_0, 50)
		self._contents[6].nowlv.text.text = var_0_6(var_4_0, 60)
		self._contents[7].nowlv.text.text = var_0_6(var_4_0, 70)
		self._contents[8].nowlv.text.text = var_0_6(var_4_0, 80)
		self._contents[9].nowlv.text.text = var_0_6(var_4_0, 90)
		self._contents[10].nowlv.text.text = var_0_6(var_4_0, 100)

		self:_initial_getaward()
		self:_now_getaward()
		var_0_4:play_in_out_animation(self._control.mask.uITweenSequence, true)
		self:_finish_reward()

		local var_4_2 = self:get_init_level_tip()

		if var_4_2 and var_4_2 > 0 then
			if self._getaward and next(self._getaward) then
				if math.floor(self._user_lv / 10) ~= #self._getaward then
					if var_4_2 >= 7 then
						var_4_2 = 7
					end

					self._control.mainfragment.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_8(0, var_4_2 * 145)
				else
					if var_4_2 >= 8 then
						var_4_2 = 8
					end

					self._control.mainfragment.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_8(0, (var_4_2 - 1) * 145)
				end
			else
				if var_4_2 >= 7 then
					var_4_2 = 7
				end

				self._control.mainfragment.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_8(0, var_4_2 * 145)
			end
		end
	end

	function arg_1_0:_initial_getaward()
		for iter_5_0, iter_5_1 in pairs(self._contents_one) do
			iter_5_1.finish:SetActive(false)
		end

		for iter_5_2, iter_5_3 in pairs(self._contents_two) do
			iter_5_3.finish:SetActive(false)
		end

		for iter_5_4, iter_5_5 in pairs(self._contents_three) do
			iter_5_5.finish:SetActive(false)
		end

		for iter_5_6, iter_5_7 in pairs(self._contents_four) do
			iter_5_7.finish:SetActive(false)
		end

		for iter_5_8, iter_5_9 in pairs(self._contents_five) do
			iter_5_9.finish:SetActive(false)
		end

		for iter_5_10, iter_5_11 in pairs(self._contents_six) do
			iter_5_11.finish:SetActive(false)
		end

		for iter_5_12, iter_5_13 in pairs(self._contents_seven) do
			iter_5_13.finish:SetActive(false)
		end

		for iter_5_14, iter_5_15 in pairs(self._contents_eight) do
			iter_5_15.finish:SetActive(false)
		end

		for iter_5_16, iter_5_17 in pairs(self._contents_nine) do
			iter_5_17.finish:SetActive(false)
		end

		for iter_5_18, iter_5_19 in pairs(self._contents_ten) do
			iter_5_19.finish:SetActive(false)
		end

		for iter_5_20, iter_5_21 in pairs(self._getaward) do
			if iter_5_21 == 10 then
				for iter_5_22, iter_5_23 in pairs(self._contents_one) do
					iter_5_23.finish:SetActive(true)
				end
			elseif iter_5_21 == 20 then
				for iter_5_24, iter_5_25 in pairs(self._contents_two) do
					iter_5_25.finish:SetActive(true)
				end
			elseif iter_5_21 == 30 then
				for iter_5_26, iter_5_27 in pairs(self._contents_three) do
					iter_5_27.finish:SetActive(true)
				end
			elseif iter_5_21 == 40 then
				for iter_5_28, iter_5_29 in pairs(self._contents_four) do
					iter_5_29.finish:SetActive(true)
				end
			elseif iter_5_21 == 50 then
				for iter_5_30, iter_5_31 in pairs(self._contents_five) do
					iter_5_31.finish:SetActive(true)
				end
			elseif iter_5_21 == 60 then
				for iter_5_32, iter_5_33 in pairs(self._contents_six) do
					iter_5_33.finish:SetActive(true)
				end
			elseif iter_5_21 == 70 then
				for iter_5_34, iter_5_35 in pairs(self._contents_seven) do
					iter_5_35.finish:SetActive(true)
				end
			elseif iter_5_21 == 80 then
				for iter_5_36, iter_5_37 in pairs(self._contents_eight) do
					iter_5_37.finish:SetActive(true)
				end
			elseif iter_5_21 == 90 then
				for iter_5_38, iter_5_39 in pairs(self._contents_nine) do
					iter_5_39.finish:SetActive(true)
				end
			elseif iter_5_21 == 100 then
				for iter_5_40, iter_5_41 in pairs(self._contents_ten) do
					iter_5_41.finish:SetActive(true)
				end
			end
		end
	end

	function arg_1_0:_now_getaward()
		for iter_6_0 = 1, 5 do
			self._contents[iter_6_0].get:SetActive(false)
		end

		if self._user_lv >= 10 and self._user_lv < 20 then
			self._contents[1].get:SetActive(true)

			self._contents[1].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

			self._contents[1].nowlv:SetActive(false)
		elseif self._user_lv >= 20 and self._user_lv < 30 then
			for iter_6_1 = 1, 2 do
				self._contents[iter_6_1].get:SetActive(true)

				self._contents[iter_6_1].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_1].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 30 and self._user_lv < 40 then
			for iter_6_2 = 1, 3 do
				self._contents[iter_6_2].get:SetActive(true)

				self._contents[iter_6_2].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_2].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 40 and self._user_lv < 50 then
			for iter_6_3 = 1, 4 do
				self._contents[iter_6_3].get:SetActive(true)

				self._contents[iter_6_3].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_3].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 50 and self._user_lv < 60 then
			for iter_6_4 = 1, 5 do
				self._contents[iter_6_4].get:SetActive(true)

				self._contents[iter_6_4].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_4].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 60 and self._user_lv < 70 then
			for iter_6_5 = 1, 6 do
				self._contents[iter_6_5].get:SetActive(true)

				self._contents[iter_6_5].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_5].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 70 and self._user_lv < 80 then
			for iter_6_6 = 1, 7 do
				self._contents[iter_6_6].get:SetActive(true)

				self._contents[iter_6_6].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_6].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 80 and self._user_lv < 90 then
			for iter_6_7 = 1, 8 do
				self._contents[iter_6_7].get:SetActive(true)

				self._contents[iter_6_7].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_7].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 90 and self._user_lv < 100 then
			for iter_6_8 = 1, 9 do
				self._contents[iter_6_8].get:SetActive(true)

				self._contents[iter_6_8].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_8].nowlv:SetActive(false)
			end
		elseif self._user_lv >= 100 then
			for iter_6_9 = 1, 10 do
				self._contents[iter_6_9].get:SetActive(true)

				self._contents[iter_6_9].get.text.text.text = var_0_1:getNowLang("marketingbtnget")

				self._contents[iter_6_9].nowlv:SetActive(false)
			end
		end
	end

	function arg_1_0:get_init_level_tip()
		if self._getaward and next(self._getaward) then
			table.sort(self._getaward, function(arg_8_0, arg_8_1)
				return arg_8_0 < arg_8_1
			end)

			for iter_7_0, iter_7_1 in ipairs(self._getaward) do
				if iter_7_1 / 10 ~= iter_7_0 then
					return iter_7_0 - 1
				end
			end

			if #self._getaward ~= 10 then
				return #self._getaward
			end
		end

		return 0
	end

	function arg_1_0:_finish_reward()
		for iter_9_0, iter_9_1 in pairs(self._getaward) do
			if iter_9_1 == 10 then
				self._contents[1].get:SetActive(false)
				self._contents[1].nowlv:SetActive(false)
			elseif iter_9_1 == 20 then
				self._contents[2].get:SetActive(false)
				self._contents[2].nowlv:SetActive(false)
			elseif iter_9_1 == 30 then
				self._contents[3].get:SetActive(false)
				self._contents[3].nowlv:SetActive(false)
			elseif iter_9_1 == 40 then
				self._contents[4].get:SetActive(false)
				self._contents[4].nowlv:SetActive(false)
			elseif iter_9_1 == 50 then
				self._contents[5].get:SetActive(false)
				self._contents[5].nowlv:SetActive(false)
			elseif iter_9_1 == 60 then
				self._contents[6].get:SetActive(false)
				self._contents[6].nowlv:SetActive(false)
			elseif iter_9_1 == 70 then
				self._contents[7].get:SetActive(false)
				self._contents[7].nowlv:SetActive(false)
			elseif iter_9_1 == 80 then
				self._contents[8].get:SetActive(false)
				self._contents[8].nowlv:SetActive(false)
			elseif iter_9_1 == 90 then
				self._contents[9].get:SetActive(false)
				self._contents[9].nowlv:SetActive(false)
			elseif iter_9_1 == 100 then
				self._contents[10].get:SetActive(false)
				self._contents[10].nowlv:SetActive(false)
			end
		end
	end

	function arg_1_0:__is_already_init()
		return self._already_init
	end

	function arg_1_0:_init_move()
		self._control.mainfragment.mask.glow.rectTransform.anchoredPosition = var_0_8(-610, 282)

		if not self._signin_seq then
			self._signin_seq = self:autoKillDOTween(var_0_5.Sequence())

			self._signin_seq:Append(self._control.mainfragment.mask.glow.transform:DOBlendableLocalMoveBy(Vector3.New(2120, -100), 4.5):SetEase(DG.Tweening.Ease.Linear))
			self._signin_seq:AppendCallback(func)
			self._signin_seq:SetLoops(-1)
			self._signin_seq:Play()
		end
	end

	function arg_1_0:_play_into_se(arg_12_1)
		self:playSE(arg_12_1, false)
	end

	function arg_1_0:reset_scroll()
		self._control.mainfragment.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_8(0, 0)
	end

	function arg_1_0:__onReset()
		self:reset_scroll()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_2:class("upgradeawards")

	var_15_0._user_data = nil
	var_15_0._user_lv = nil
	var_15_0._getaward_info = nil
	var_15_0._level_id = nil
	var_15_0._lv_reward = nil
	var_15_0._contents = {}
	var_15_0._contents_one = {}
	var_15_0._contents_two = {}
	var_15_0._contents_three = {}
	var_15_0._contents_four = {}
	var_15_0._contents_five = {}
	var_15_0._getaward = {}
	var_15_0._signin_seq = nil
	var_15_0._already_init = false

	return var_15_0
end

return var_0_0
