local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_mainfragment_close()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self._signin_seq:Pause()

		self._signin_seq = nil

		var_0_3:play_in_out_animation(self._control.mask.uITweenSequence, false, function()
			self:setVisible(false)
			self:reset_scroll()
		end)
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardsone_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[1])
		self._contents[1].get:SetActive(false)
		self._contents[1].nowlv:SetActive(false)

		for iter_4_0 = 1, 6 do
			self._contents_one[iter_4_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsone_rewardone_btn(arg_5_0)
		var_0_1:createInstance("specificdetails"):show(2, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsone_rewardtwo_btn(arg_6_0)
		var_0_1:createInstance("specificdetails"):show(3, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsone_rewardthree_btn(arg_7_0)
		var_0_1:createInstance("specificdetails"):show(4, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsone_rewardfour_btn(arg_8_0)
		var_0_1:createInstance("specificdetails"):show(9, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsone_rewardfive_btn(arg_9_0)
		var_0_1:createInstance("specificdetails"):show(241, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsone_rewardsix_btn(arg_10_0)
		var_0_1:createInstance("specificdetails"):show(741, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardstwo_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[2])
		self._contents[2].get:SetActive(false)
		self._contents[2].nowlv:SetActive(false)

		for iter_11_0 = 1, 3 do
			self._contents_two[iter_11_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardstwo_rewardone_btn(arg_12_0)
		var_0_1:createInstance("specificdetails"):show(141, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardstwo_rewardtwo_btn(arg_13_0)
		var_0_1:createInstance("specificdetails"):show(541, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardstwo_rewardthree_btn(arg_14_0)
		var_0_1:createInstance("ship_detail"):show(var_0_3.enter_ship_detail_type.upgradeawards, (var_0_5.find_object_by_cid(10005912)))
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardsthree_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[3])
		self._contents[3].get:SetActive(false)
		self._contents[3].nowlv:SetActive(false)

		for iter_15_0 = 1, 6 do
			self._contents_three[iter_15_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsthree_rewardone_btn(arg_16_0)
		var_0_1:createInstance("specificdetails"):show(2, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsthree_rewardtwo_btn(arg_17_0)
		var_0_1:createInstance("specificdetails"):show(3, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsthree_rewardthree_btn(arg_18_0)
		var_0_1:createInstance("specificdetails"):show(4, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsthree_rewardfour_btn(arg_19_0)
		var_0_1:createInstance("specificdetails"):show(9, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsthree_rewardfive_btn(arg_20_0)
		var_0_1:createInstance("specificdetails"):show(241, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsthree_rewardsix_btn(arg_21_0)
		var_0_1:createInstance("specificdetails"):show(741, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfour_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[4])
		self._contents[4].get:SetActive(false)
		self._contents[4].nowlv:SetActive(false)

		for iter_22_0 = 1, 5 do
			self._contents_four[iter_22_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfour_rewardone_btn(arg_23_0)
		var_0_1:createInstance("specificdetails"):show(2, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfour_rewardtwo_btn(arg_24_0)
		var_0_1:createInstance("specificdetails"):show(3, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfour_rewardthree_btn(arg_25_0)
		var_0_1:createInstance("specificdetails"):show(4, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfour_rewardfour_btn(arg_26_0)
		var_0_1:createInstance("specificdetails"):show(9, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfour_rewardfive_btn(arg_27_0)
		var_0_1:createInstance("ship_detail"):show(var_0_3.enter_ship_detail_type.upgradeawards, (var_0_5.find_object_by_cid(10003013)))
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfive_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[5])
		self._contents[5].get:SetActive(false)
		self._contents[5].nowlv:SetActive(false)

		for iter_28_0 = 1, 3 do
			self._contents_five[iter_28_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfive_rewardone_btn(arg_29_0)
		var_0_1:createInstance("specificdetails"):show(141, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfive_rewardtwo_btn(arg_30_0)
		var_0_1:createInstance("specificdetails"):show(541, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsfive_rewardthree_btn(arg_31_0)
		var_0_1:createInstance("ship_detail"):show(var_0_3.enter_ship_detail_type.upgradeawards, (var_0_5.find_object_by_cid(10001013)))
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardssix_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[6])
		self._contents[6].get:SetActive(false)
		self._contents[6].nowlv:SetActive(false)

		for iter_32_0 = 1, 4 do
			self._contents_six[iter_32_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardssix_rewardone_btn(arg_33_0)
		var_0_1:createInstance("specificdetails"):show(10141, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardssix_rewardtwo_btn(arg_34_0)
		var_0_1:createInstance("specificdetails"):show(10241, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardssix_rewardthree_btn(arg_35_0)
		var_0_1:createInstance("specificdetails"):show(10341, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardssix_rewardfour_btn(arg_36_0)
		var_0_1:createInstance("specificdetails"):show(10441, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardsseven_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[7])
		self._contents[7].get:SetActive(false)
		self._contents[7].nowlv:SetActive(false)

		for iter_37_0 = 1, 4 do
			self._contents_seven[iter_37_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsseven_rewardone_btn(arg_38_0)
		var_0_1:createInstance("specificdetails"):show(2, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsseven_rewardtwo_btn(arg_39_0)
		var_0_1:createInstance("specificdetails"):show(3, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsseven_rewardthree_btn(arg_40_0)
		var_0_1:createInstance("specificdetails"):show(4, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsseven_rewardfour_btn(arg_41_0)
		var_0_1:createInstance("specificdetails"):show(9, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardseight_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[8])
		self._contents[8].get:SetActive(false)
		self._contents[8].nowlv:SetActive(false)

		for iter_42_0 = 1, 4 do
			self._contents_eight[iter_42_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardseight_rewardone_btn(arg_43_0)
		var_0_1:createInstance("specificdetails"):show(241, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardseight_rewardtwo_btn(arg_44_0)
		var_0_1:createInstance("specificdetails"):show(141, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardseight_rewardthree_btn(arg_45_0)
		var_0_1:createInstance("specificdetails"):show(541, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardseight_rewardfour_btn(arg_46_0)
		var_0_1:createInstance("specificdetails"):show(66641, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardsnine_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[9])
		self._contents[9].get:SetActive(false)
		self._contents[9].nowlv:SetActive(false)

		for iter_47_0 = 1, 4 do
			self._contents_nine[iter_47_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsnine_rewardone_btn(arg_48_0)
		var_0_1:createInstance("specificdetails"):show(2, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsnine_rewardtwo_btn(arg_49_0)
		var_0_1:createInstance("specificdetails"):show(3, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsnine_rewardthree_btn(arg_50_0)
		var_0_1:createInstance("specificdetails"):show(4, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsnine_rewardfour_btn(arg_51_0)
		var_0_1:createInstance("specificdetails"):show(9, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0:__onClick_mainfragment_scrollview_viewport_content_upgraderewardsten_get()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		var_0_4:req_LevelAwards(var_0_3.level_up_award_array[10])
		self._contents[10].get:SetActive(false)
		self._contents[10].nowlv:SetActive(false)

		for iter_52_0 = 1, 4 do
			self._contents_ten[iter_52_0].finish:SetActive(true)
		end
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsten_rewardone_btn(arg_53_0)
		var_0_1:createInstance("specificdetails"):show(10242, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsten_rewardtwo_btn(arg_54_0)
		var_0_1:createInstance("specificdetails"):show(10542, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsten_rewardthree_btn(arg_55_0)
		var_0_1:createInstance("specificdetails"):show(88841, var_0_3.enter_icon_detail_type.upgradeawards)
	end

	function arg_1_0.__onClick_mainfragment_scrollview_viewport_content_upgraderewardsten_rewardfour_btn(arg_56_0)
		var_0_1:createInstance("specificdetails"):show(14, var_0_3.enter_icon_detail_type.upgradeawards)
	end
end

function var_0_0.extend_obj(arg_57_0)
	return
end

return var_0_0
