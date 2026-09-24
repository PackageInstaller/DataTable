local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_7 = gameconfig.chat_head_config
local var_0_8 = lx.json_decode
local var_0_9 = gameconfig.ship_config
local var_0_11 = string.format

gamecore.UILoader:define("tower_ranking_list", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell_1 then
			self._reusable_cell_1:update()
		end
	end

	function arg_1_0:__get_cell_by_now_lable()
		self._control.bottom.info_1.info_title.text.text = var_0_2:getNowLang("myrank")
		self._control.bottom.info_2.info_title.text.text = var_0_2:getNowLang("ui_tower_rank_clear_time_my")

		return self._reusable_cell_1
	end

	function arg_1_0.__time_format(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_1 == 0 then
			return ""
		end

		if arg_5_2 then
			return os.date("%Y-%m-%d\t%H:%M:%S", arg_5_1)
		end

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

		return var_6_0
	end

	function arg_1_0:__init_rank_list()
		if self._already_init then
			return
		end

		self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.scrollview_1.viewport.content.endlessScrollView, self._control.scrollview_1.viewport.content, "single_rank_tower", "tower_ranking_list")

		self._reusable_cell_1:init()

		self._already_init = true
	end

	function arg_1_0:__update_cell()
		local var_8_0 = self:__get_cell_by_now_lable()

		var_8_0:set_data(self._data)

		function var_8_0:_set_func(arg_9_1)
			local var_9_0 = self._data[arg_9_1 + 1]
			local var_9_1 = var_0_8(self._data[arg_9_1 + 1].json_data)

			var_9_1._is_friend = self:check_if_is_freind(var_9_1.account_id)
			self.rank_sort_txt.text.text = "" .. var_9_0.rank
			self.user_icon.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.captainroom_head, var_0_7.find_object_by_cid(var_9_1.chat_head).icon))
			self.name_txt.text.text = var_9_1.name

			if arg_9_1 < 3 then
				self.rank_sort_txt.text.color = Color.New(0.18823529411764706, 0.6941176470588235, 0.9725490196078431)

				self.rank_head_bg:SetActive(true)
			else
				self.rank_sort_txt.text.color = Color.New(0.32941176470588235, 0.32941176470588235, 0.32941176470588235)

				self.rank_head_bg:SetActive(false)
			end

			local var_9_2 = {
				self.ship_list.ship_1,
				self.ship_list.ship_2,
				self.ship_list.ship_3,
				self.ship_list.ship_4,
				self.ship_list.ship_5,
				self.ship_list.ship_6
			}

			for iter_9_0, iter_9_1 in pairs(var_9_1.team) do
				var_9_2[iter_9_0]:SetActive(true)

				var_9_2[iter_9_0].ship.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, var_0_9.find_object_by_cid(iter_9_1).pic_id))
			end

			self.time_txt.text.text = self:__time_format(var_9_0.rank_time)

			self.btn.button.onClick:RemoveAllListeners()
			self.btn.button.onClick:AddListener(function()
				local var_10_0 = self._control.visit_friend_layer

				self._control.visit_friend_layer.badge_icon.image.sprite = self:loadSprite(var_0_11(var_0_5.common_icon.friend_badge_path, var_9_1.rank))
				var_10_0.badge_level_txt.text.text = var_0_2:getNowLang("usertitle" .. 11 - var_9_1.rank)
				var_10_0.name_info_txt.text.text = var_9_1.name .. " <color=#34B2F9><size=22>Lv." .. var_9_1.level .. "</size></color>"
				var_10_0.friend_uid_txt.text.text = var_9_0.account_id

				var_10_0:SetActive(true)
				var_10_0.visit_btn:SetActive(var_9_0.account_id ~= self._my_id)

				self._click_role_data = var_9_1

				self:__play_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
			end)
		end
	end

	function arg_1_0:get_role_info()
		return self._click_role_data
	end

	function arg_1_0:set_mine_data()
		self._control.bottom.info_1.info_txt.text.text = self:__get_my_rank()
		self._control.bottom.info_2.info_txt.text.text = self:__time_format(self._user_data.tower_best_time, true)
	end

	function arg_1_0:__init_panel(arg_13_1)
		self._my_id = var_0_3:get_account_id()
		self._data = arg_13_1.board_data
		self._user_data = var_0_3:get_use_info_data()
		self._freinds_data = var_0_3:get_friend_list()

		self:__init_language()
		self:__init_rank_list()
		self:__update_cell()
		self:set_mine_data()
		var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true, nil)
		self:set_climb_tower_clickable(false)
	end

	function arg_1_0:__play_se(arg_14_1)
		self:playSE(arg_14_1)
	end

	function arg_1_0:__init_language()
		self._control.top.title_txt.text.text = var_0_2:getNowLang("leaderboardtype6")
		self._control.rank_title.rank_title.btn_1.txt.text.text = var_0_2:getNowLang("rank")
		self._control.rank_title.rank_title.btn_2.txt.text.text = var_0_2:getNowLang("leaderboardusername")
		self._control.rank_title.rank_title.btn_3.txt.text.text = var_0_2:getNowLang("ui_tower_rank_fleet")
		self._control.rank_title.rank_title.btn_4.txt.text.text = var_0_2:getNowLang("ui_tower_rank_clear_time")
		self._control.visit_friend_layer.visit_btn.visit_txt.text.text = var_0_2:getNowLang("visit")
	end

	function arg_1_0:check_if_is_freind(arg_16_1)
		return self._freinds_data and self._freinds_data[arg_16_1] ~= nil
	end

	function arg_1_0.set_climb_tower_clickable(arg_17_0, arg_17_1)
		local var_17_0 = var_0_1:createInstance("climb_tower")

		if arg_17_1 then
			var_17_0:show()
		else
			var_17_0:setVisible(false)
		end
	end

	function arg_1_0.__onReset(arg_18_0)
		arg_18_0._already_init = false
		arg_18_0._click_role_data = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_19_0)
	local var_19_0 = var_0_1:class("tower_ranking_list")

	var_19_0._reusable_cell_1 = nil
	var_19_0._now_label = nil
	var_19_0._my_id = {}
	var_19_0._data = {}
	var_19_0._click_role_data = {}

	return var_19_0
end

return var_0_0
