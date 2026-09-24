local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.ship_rule_config
local var_0_7 = gameconfig.chat_head_config
local var_0_8 = lx.json_decode
local var_0_9 = gameconfig.ship_config
local var_0_10 = gameconfig.ship_level_config
local var_0_11 = UnityEngine.Vector2

gamecore.UILoader:define("cardbook_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._now_label == 1 and self._reusable_cell_1 then
			self._reusable_cell_1:update()
		elseif self._now_label == 2 and self._reusable_cell_2 then
			self._reusable_cell_2:update()
		elseif self._now_label == 3 and self._reusable_cell_3 then
			self._reusable_cell_3:update()
		elseif self._now_label == 4 and self._reusable_cell_4 then
			self._reusable_cell_4:update()
		end
	end

	function arg_1_0:__get_cell_by_now_lable()
		local var_4_0
		local var_4_1

		if self._now_label == 1 then
			var_4_0 = self._reusable_cell_1

			local var_4_2, var_4_3 = self:__get_my_rank()

			self._control.bg.bottom.info_1.info_txt.text.text = var_4_3
			self._control.bg.bottom.info_2.info_txt.text.text = var_4_2
			var_4_1 = self._control.bg.scrollview_1.viewport.content.rectTransform
		elseif self._now_label == 2 then
			var_4_0 = self._reusable_cell_2
			self._control.bg.bottom.info_1.info_txt.text.text = self:__get_my_rank_ship_count()
			var_4_1 = self._control.bg.scrollview_2.viewport.content.rectTransform
		elseif self._now_label == 3 then
			var_4_0 = self._reusable_cell_3
			self._control.bg.bottom.info_1.info_txt.text.text = self:__get_my_strength()
			self._control.bg.bottom.info_2.info_txt.text.text = self:__get_my_rank()
			var_4_1 = self._control.bg.scrollview_3.viewport.content.rectTransform
		elseif self._now_label == 4 then
			var_4_0 = self._reusable_cell_4

			local var_4_4 = var_0_3:get_cardbook_ship_list()

			self._control.bg.bottom.info_1.info_txt.text.text = self:__get_cardbook_completeness(#var_4_4, 1)
			self._control.bg.bottom.info_2.info_txt.text.text = self:__get_cardbook_completeness(#var_4_4, 2)
			self._control.bg.bottom.info_3.info_txt.text.text = self:__get_my_rank()
			var_4_1 = self._control.bg.scrollview_4.viewport.content.rectTransform or var_4_1
		end

		if var_4_1 then
			var_4_1.anchoredPosition = var_0_11(var_4_1.anchoredPosition.x, 0)
		end

		return var_4_0
	end

	function arg_1_0.__time_format(arg_5_0, arg_5_1)
		return (os.date("%Y-%m-%d\n%H:%M:%S", arg_5_1))
	end

	function arg_1_0:__get_my_rank()
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in ipairs(self._data) do
			if iter_6_1.account_id == self._my_id then
				var_6_0 = iter_6_1.rank

				break
			end
		end

		var_6_0 = var_6_0 == 0 and var_0_2:getNowLang("leaderboardnotranked") or tostring(var_6_0)
		self._player_statistics_data = var_0_3:get_player_statistics_data()

		return var_6_0, tostring(self._player_statistics_data.exploit_total or 0)
	end

	function arg_1_0.__totle_ship_exp(arg_7_0)
		local var_7_0 = 0
		local var_7_1 = 0

		for iter_7_0, iter_7_1 in pairs((var_0_3:get_character_list())) do
			local var_7_2 = var_0_10.find_object_by_level(iter_7_1.level)

			var_7_0 = var_7_0 + iter_7_1.exp + var_0_10.get_total_exp_set()[iter_7_1.level] + (var_7_2.exp == 0 and 71800 or var_7_2.exp)
			var_7_1 = var_7_1 + 1
		end

		return var_7_0
	end

	function arg_1_0:__get_my_strength()
		return math.floor(self:__totle_ship_exp() / var_0_5.cardbook_const.ship_strength_param)
	end

	function arg_1_0:__get_my_rank_ship_count()
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in pairs(self._data) do
			if iter_9_1.account_id == self._my_id then
				var_9_0 = var_9_0 + 1
			end
		end

		return var_9_0
	end

	function arg_1_0.__get_cardbook_completeness(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = ""
		local var_10_1 = var_0_6.find_object_by_id(var_0_5.ship_rule.num_config).content.boatNumMax

		if arg_10_2 == 1 then
			if var_10_1 < arg_10_1 then
				arg_10_1 = var_10_1
			end

			var_10_0 = arg_10_1 .. "/" .. var_10_1
		elseif arg_10_2 == 2 then
			if var_10_1 < arg_10_1 then
				arg_10_1 = var_10_1
			end

			var_10_0 = math.floor(arg_10_1 / var_10_1 * 100) .. "%"
		end

		return var_10_0
	end

	function arg_1_0:__show_select_txt(arg_11_1)
		for iter_11_0 = 1, self._control.bg.rank_title.transform.childCount do
			self._control.bg.rank_title.transform:GetChild(iter_11_0 - 1).gameObject:SetActive(false)
		end

		for iter_11_1 = 1, self._control.bg.bottom.transform.childCount do
			self._control.bg.bottom.transform:GetChild(iter_11_1 - 1).gameObject:SetActive(false)
		end

		self._control.bg.rank_title.transform:GetChild(arg_11_1 - 1).gameObject:SetActive(true)
	end

	function arg_1_0:__init_rank_list()
		if self._already_init[self._now_label] == 1 then
			return
		end

		if self._now_label == 1 then
			self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.bg.scrollview_1.viewport.content.endlessScrollView, self._control.bg.scrollview_1.viewport.content, "single_rank_exploit", "cardbook_info")

			self._reusable_cell_1:init()
		elseif self._now_label == 2 then
			self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.bg.scrollview_2.viewport.content.endlessScrollView, self._control.bg.scrollview_2.viewport.content, "single_rank_destroy", "cardbook_info")

			self._reusable_cell_2:init()
		elseif self._now_label == 3 then
			self._reusable_cell_3 = gamecore.reusable_cell:create(self, self._control.bg.scrollview_3.viewport.content.endlessScrollView, self._control.bg.scrollview_3.viewport.content, "single_rank_fleet", "cardbook_info")

			self._reusable_cell_3:init()
		elseif self._now_label == 4 then
			self._reusable_cell_4 = gamecore.reusable_cell:create(self, self._control.bg.scrollview_4.viewport.content.endlessScrollView, self._control.bg.scrollview_4.viewport.content, "single_rank_collection", "cardbook_info")

			self._reusable_cell_4:init()
		end

		self._already_init[self._now_label] = 1
	end

	function arg_1_0:__update_cell()
		self:_show_scroll()

		local var_13_0 = self:__get_cell_by_now_lable()

		var_13_0:set_data(self._data)
		self:__get_friends_data()

		local var_13_1
		local var_13_2

		function var_13_0:_set_func(arg_14_1)
			local var_14_0 = self._data[arg_14_1 + 1]
			local var_14_1 = var_0_8(self._data[arg_14_1 + 1].json_data)

			if self._now_label ~= 2 then
				local var_14_2 = var_0_7.find_object_by_cid(var_14_1.chat_head)

				self.user_icon.image.sprite = self:loadSprite(var_14_2 and var_0_5:get_format_url(var_0_5.captainroom_head, var_14_2.icon) or var_0_5:get_format_url(var_0_5.captainroom_head, "1"))

				self.name_mask.textHorizonScroller:SetText(var_14_1.name)
			end

			if self._now_label == 1 then
				self.merit_txt.text.text = var_14_0.rank_value
				self.badge_icon.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.common_icon.self_info_badge, var_14_1.rank))
				self.badge_txt.text.text = var_0_2:getNowLang("usertitle" .. 11 - var_14_1.rank)
				self.time_txt.text.text = self:__time_format(var_14_0.rank_time)
			elseif self._now_label == 2 then
				self.ship_type_txt.text.text = var_0_2:getNowLang("shiptype" .. var_0_9.find_object_by_cid(var_14_1.ship.cid).type)
				self.ship_level_txt.text.text = "Lv." .. var_14_1.ship.level
				self.destory_num_txt.text.text = "" .. math.ceil(var_14_0.rank_value / 100)

				local var_14_4 = var_0_9.find_object_by_cid(var_14_1.ship.cid)

				self.name_mask.textHorizonScroller:SetText(var_14_4.title)
				self.belong_to_name_mask.textHorizonScroller:SetText(var_14_1.name)

				self.rank_sort_txt.text.text = "" .. var_14_0.rank
				self.maskimage.user_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, var_14_4.ship_index))
			elseif self._now_label == 3 then
				self.merit_txt.text.text = var_14_1.level
				self.badge_icon.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.common_icon.self_info_badge, var_14_1.rank))
				self.badge_txt.text.text = var_0_2:getNowLang("usertitle" .. 11 - var_14_1.rank)
				self.ship_power_txt.text.text = var_14_0.rank_value
				self.rank_sort_txt.text.text = "" .. var_14_0.rank
			elseif self._now_label == 4 then
				self.ship_num_txt.text.text = self:__get_cardbook_completeness(var_14_0.rank_value, 1)
				self.handbook_completeness_txt.text.text = self:__get_cardbook_completeness(var_14_0.rank_value, 2)
				self.time_txt.text.text = self:__time_format(var_14_0.rank_time)
			end

			if self._now_label == 1 or self._now_label == 4 then
				if var_13_1 == nil then
					var_13_1 = var_14_0.rank_time
					var_13_2 = var_14_0.rank
				elseif var_14_0.rank_time == var_13_1 then
					-- block empty
				else
					var_13_1 = var_14_0.rank_time
					var_13_2 = var_14_0.rank
				end

				self.rank_sort_txt.text.text = "" .. var_13_2
			end

			if arg_14_1 < 3 then
				self.rank_sort_txt.text.color = Color.New(0.12941176470588237, 0.6352941176470588, 0.9686274509803922)

				self.rank_head_bg:SetActive(true)
			else
				self.rank_sort_txt.text.color = Color.New(0.27058823529411763, 0.27058823529411763, 0.27058823529411763)

				self.rank_head_bg:SetActive(false)
			end

			self.btn.button.onClick:AddListener(function()
				local var_15_0 = self._control.bg.visit_friend_layer

				self._control.bg.visit_friend_layer.badge_icon.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.common_icon.friend_badge_path, var_14_1.rank))
				var_15_0.badge_level_txt.text.text = var_0_2:getNowLang("usertitle" .. 11 - var_14_1.rank)
				var_15_0.name_info_txt.text.text = var_14_1.name .. " <color=#34B2F9><size=22>Lv." .. var_14_1.level .. "</size></color>"

				local var_15_1 = var_14_0.account_id

				var_15_0.friend_uid_txt.text.text = var_14_0.account_id

				if var_15_1 ~= var_0_3:get_account_id() then
					var_15_0.visit_btn:SetActive(true)
				else
					var_15_0.visit_btn:SetActive(false)
				end

				var_15_0:SetActive(true)

				var_14_1._is_friend = self:__check_if_is_friend(var_15_1)
				self._click_role_data = var_14_1
			end)
		end
	end

	function arg_1_0.__get_friends_data(arg_16_0)
		arg_16_0._freinds_data = var_0_3:get_friend_list()
	end

	function arg_1_0:__check_if_is_friend(arg_17_1)
		return self._freinds_data and self._freinds_data[arg_17_1] ~= nil
	end

	function arg_1_0:_show_scroll()
		local var_18_0 = {
			self._control.bg.scrollview_1,
			self._control.bg.scrollview_2,
			self._control.bg.scrollview_3,
			self._control.bg.scrollview_4
		}

		for iter_18_0 = 1, #var_18_0 do
			var_18_0[iter_18_0]:SetActive(false)
		end

		var_18_0[self._now_label]:SetActive(true)
	end

	function arg_1_0:get_role_info()
		return self._click_role_data
	end

	function arg_1_0:__init_panel(arg_20_1)
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))

		self._my_id = var_0_3:get_account_id()
		self._now_label = arg_20_1.type
		self._data = arg_20_1.board_data
		self._user_data = var_0_3:get_use_info_data()

		self:__init_language()
		self:__init_rank_list()
		self:__update_cell()
		var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true, nil)
	end

	function arg_1_0:__init_language()
		if self._now_label == 1 then
			self._control.bg.top.title_txt.text.text = var_0_2:getNowLang("leaderboardtype1")
			self._control.bg.top.desc.desc_text.text.text = var_0_2:getNowLang("rank_list_tip1")

			local var_21_1 = var_0_2:getNowLang("rank_list_tip1")

			self._control.bg.rank_title.rank_title_1.btn_1.txt.text.text = var_0_2:getNowLang("rank")
			self._control.bg.rank_title.rank_title_1.btn_2.txt.text.text = var_0_2:getNowLang("leaderboardusername")
			self._control.bg.rank_title.rank_title_1.btn_3.txt.text.text = var_0_2:getNowLang("leaderboardwinrate")
			self._control.bg.rank_title.rank_title_1.btn_4.txt.text.text = var_0_2:getNowLang("leaderboarduserlevel")
			self._control.bg.rank_title.rank_title_1.btn_5.txt.text.text = var_0_2:getNowLang("leaderboardfinishtime")

			self:__show_select_txt(self._now_label)

			self._control.bg.bottom.info_1.info_title.text.text = var_0_2:getNowLang("myexploit")
			self._control.bg.bottom.info_2.info_title.text.text = var_0_2:getNowLang("myrank")

			self._control.bg.bottom.info_1:SetActive(true)
			self._control.bg.bottom.info_2:SetActive(true)
		elseif self._now_label == 2 then
			self._control.bg.top.title_txt.text.text = var_0_2:getNowLang("leaderboardtype2")
			self._control.bg.top.desc.desc_text.text.text = var_0_2:getNowLang("rank_list_tip2")

			local var_21_2 = var_0_2:getNowLang("rank_list_tip2")

			self._control.bg.rank_title.rank_title_2.btn_1.txt.text.text = var_0_2:getNowLang("rank")
			self._control.bg.rank_title.rank_title_2.btn_2.txt.text.text = var_0_2:getNowLang("leaderboardmyboatinrank")
			self._control.bg.rank_title.rank_title_2.btn_3.txt.text.text = var_0_2:getNowLang("leaderboardtype2")
			self._control.bg.rank_title.rank_title_2.btn_4.txt.text.text = var_0_2:getNowLang("leaderboardusername")

			self:__show_select_txt(self._now_label)

			self._control.bg.bottom.info_1.info_title.text.text = var_0_2:getNowLang("mydestroy")

			self._control.bg.bottom.info_1:SetActive(true)
		elseif self._now_label == 3 then
			self._control.bg.top.title_txt.text.text = var_0_2:getNowLang("leaderboardtype3")
			self._control.bg.top.desc.desc_text.text.text = var_0_2:getNowLang("rank_list_tip3")

			local var_21_3 = var_0_2:getNowLang("rank_list_tip3")

			self._control.bg.rank_title.rank_title_3.btn_1.txt.text.text = var_0_2:getNowLang("rank")
			self._control.bg.rank_title.rank_title_3.btn_2.txt.text.text = var_0_2:getNowLang("leaderboardusername")
			self._control.bg.rank_title.rank_title_3.btn_3.txt.text.text = var_0_2:getNowLang("leaderboarduserlevel2")
			self._control.bg.rank_title.rank_title_3.btn_4.txt.text.text = var_0_2:getNowLang("leaderboarduserlevel")
			self._control.bg.rank_title.rank_title_3.btn_5.txt.text.text = var_0_2:getNowLang("leaderboardtype3")

			self:__show_select_txt(self._now_label)

			self._control.bg.bottom.info_1.info_title.text.text = var_0_2:getNowLang("mystren")
			self._control.bg.bottom.info_2.info_title.text.text = var_0_2:getNowLang("myrank")

			self._control.bg.bottom.info_1:SetActive(true)
			self._control.bg.bottom.info_2:SetActive(true)
		elseif self._now_label == 4 then
			self._control.bg.top.title_txt.text.text = var_0_2:getNowLang("leaderboardtype4")
			self._control.bg.top.desc.desc_text.text.text = var_0_2:getNowLang("rank_list_tip4")

			local var_21_4 = var_0_2:getNowLang("rank_list_tip4")

			self._control.bg.rank_title.rank_title_4.btn_1.txt.text.text = var_0_2:getNowLang("rank")
			self._control.bg.rank_title.rank_title_4.btn_2.txt.text.text = var_0_2:getNowLang("leaderboardusername")
			self._control.bg.rank_title.rank_title_4.btn_3.txt.text.text = var_0_2:getNowLang("leaderboardshipamount")
			self._control.bg.rank_title.rank_title_4.btn_4.txt.text.text = var_0_2:getNowLang("leaderboardcardrate")
			self._control.bg.rank_title.rank_title_4.btn_5.txt.text.text = var_0_2:getNowLang("leaderboardfinishtime")

			self:__show_select_txt(self._now_label)

			self._control.bg.bottom.info_1.info_title.text.text = var_0_2:getNowLang("myshipcount")
			self._control.bg.bottom.info_2.info_title.text.text = var_0_2:getNowLang("myboardcardrate")
			self._control.bg.bottom.info_3.info_title.text.text = var_0_2:getNowLang("myrank")

			self._control.bg.bottom.info_1:SetActive(true)
			self._control.bg.bottom.info_2:SetActive(true)
			self._control.bg.bottom.info_3:SetActive(true)
		end

		self._control.bg.visit_friend_layer.visit_btn.visit_txt.text.text = var_0_2:getNowLang("visit")
	end

	function arg_1_0:_play_into_se(arg_22_1)
		self:playSE(arg_22_1, false)
	end

	function arg_1_0.__onReset(arg_23_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_24_0)
	local var_24_0 = var_0_1:class("cardbook_info")

	var_24_0._already_init = {
		0,
		0,
		0,
		0
	}
	var_24_0._reusable_cell_1 = nil
	var_24_0._reusable_cell_2 = nil
	var_24_0._reusable_cell_3 = nil
	var_24_0._reusable_cell_4 = nil
	var_24_0._now_label = nil
	var_24_0._my_id = {}
	var_24_0._data = {}
	var_24_0._click_role_data = {}

	return var_24_0
end

return var_0_0
