local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = table.insert
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_8 = gameenum.common_type
local var_0_9 = gameconfig.chat_head_config
local var_0_10 = lx.clone_table

gamecore.UILoader:define("ninth_honor_list", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)

		self.enter_type = arg_3_1
		self.server_honor_list = self.enter_type == var_0_8.pve_active_type.score_event and var_0_10(var_0_1:get_answer_server_honor_list()) or self.enter_type == var_0_8.pve_active_type.strike_event and var_0_10(var_0_1:get_solid_server_honor_list()) or var_0_10(var_0_1:get_server_honor_list())

		self:__init_panel()

		local var_3_0 = var_0_5:getInstance("home")

		if var_3_0 then
			var_3_0:setVisible(false)
		end

		if self.enter_type == var_0_8.pve_active_type.score_event then
			local var_3_1 = var_0_5:getInstance("score_push_map")

			if var_3_1 then
				var_3_1:setVisible(false)
			end
		elseif self.enter_type == var_0_8.pve_active_type.score_event then
			local var_3_2 = var_0_5:getInstance("strike_main")

			if var_3_2 then
				var_3_2:setVisible(false)
			end

			local var_3_3 = var_0_5:getInstance("strike_weather")

			if var_3_3 then
				var_3_3:setVisible(false)
			end
		else
			local var_3_4 = var_0_5:getInstance("ninth_main_map")

			if var_3_4 then
				var_3_4:setVisible(false)
			end
		end
	end

	function arg_1_0:__init_panel()
		self.need_server_honor_list = {}
		self._control.bg.top.title_txt.text.text = var_0_4:getNowLang("ninth_rank")
		self._control.bg.rank_title.rank_title_1.btn_1.txt.text.text = var_0_4:getNowLang("rank")
		self._control.bg.rank_title.rank_title_1.btn_2.txt.text.text = var_0_4:getNowLang("leaderboardusername")
		self._control.bg.rank_title.rank_title_1.btn_3.txt.text.text = var_0_4:getNowLang("leaderboarduserlevel2")
		self._control.bg.rank_title.rank_title_1.btn_4.txt.text.text = var_0_4:getNowLang("ninth_rank_1")
		self._control.bg.rank_title.rank_title_1.btn_5.txt.text.text = var_0_4:getNowLang("leaderboardfinishtime")

		self._control.bg.top.title_txt.desc.mask:GetComponent("TextHorizonScroller"):SetText(var_0_4:getNowLang("ninth_rank_desc"))

		self._control.bg.bottom.info_1.info_title.text.text = var_0_4:getNowLang("myrank")
		self._control.bg.bottom.info_1.info_txt.text.text = var_0_4:getNowLang("leaderboardnotranked")

		self._control.bg.bottom.info_1.info_txt:SetActive(false)

		self._control.bg.bottom.info_2.info_title.text.text = var_0_4:getNowLang("leaderboardfinishtime")

		self._control.bg.bottom.info_2.info_txt:SetActive(false)

		self.user_uid = var_0_1:get_account_id()

		var_0_2(self.server_honor_list, function(arg_5_0, arg_5_1)
			return arg_5_0.time < arg_5_1.time
		end)

		for iter_4_0, iter_4_1 in pairs(self.server_honor_list) do
			if iter_4_0 <= 500 then
				var_0_3(self.need_server_honor_list, iter_4_1)
			end
		end

		self:__init_reusable_cell()
		self:__update_cell()
	end

	function arg_1_0:__init_reusable_cell()
		for iter_6_0 = 1, self._control.bg.scrollview_1.viewport.content.transform.childCount do
			self:destroyChildren("single_ninth_honor_list")
		end

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.bg.scrollview_1.viewport.content.endlessScrollView, self._control.bg.scrollview_1.viewport.content, "single_ninth_honor_list", "ninth_honor_list")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__update_cell()
		self._control.bg.scrollview_1:SetActive(true)

		local var_7_0 = self.need_server_honor_list

		self:check_player_honor_rank()
		self._reusable_cell:set_data(self.need_server_honor_list)

		function self._reusable_cell:_set_func(arg_8_1)
			local var_8_0 = var_0_9.find_object_by_cid(var_7_0[arg_8_1 + 1].chat_head)

			self.user_icon.image.sprite = self:loadSprite(var_8_0 and var_0_8:get_format_url(var_0_8.captainroom_head, var_8_0.icon) or var_0_8:get_format_url(var_0_8.captainroom_head, "1"))

			self.name_mask:GetComponent("TextHorizonScroller"):SetText(var_7_0[arg_8_1 + 1].name)

			self.merit_txt.text.text = tostring(var_7_0[arg_8_1 + 1].level)
			self.badge_txt.text.text = var_0_8.server_id[var_7_0[arg_8_1 + 1].channel]
			self.time_txt.text.text = self:__time_format(var_7_0[arg_8_1 + 1].time)
			self.rank_sort_txt.text.text = arg_8_1 > 0 and var_7_0[arg_8_1 + 1].time == var_7_0[arg_8_1].time and tostring(arg_8_1) or tostring(arg_8_1 + 1)

			self.rank_head_bg:SetActive(false)

			if arg_8_1 + 1 < 4 then
				self.rank_head_bg:SetActive(true)
			end

			if var_7_0[arg_8_1 + 1].account_id == self.user_uid and var_0_8.server_name[var_0_1:get_server_name()] == var_7_0[arg_8_1 + 1].channel then
				self._control.bg.bottom.info_1.info_txt.text.text = tostring(arg_8_1 + 1)
				self._control.bg.bottom.info_2.info_txt.text.text = self:__time_format_line(var_7_0[arg_8_1 + 1].time)

				self._control.bg.bottom.info_2.info_txt:SetActive(true)
			end
		end

		self._control.bg.bottom.info_1.info_txt:SetActive(true)
	end

	function arg_1_0:check_player_honor_rank()
		local var_9_0 = var_0_1:get_server_name()

		for iter_9_0, iter_9_1 in pairs(self.need_server_honor_list) do
			if iter_9_1.account_id == self.user_uid and var_0_8.server_name[var_9_0] == iter_9_1.channel then
				self._control.bg.bottom.info_1.info_txt.text.text = tostring(iter_9_0)
				self._control.bg.bottom.info_2.info_txt.text.text = self:__time_format_line(iter_9_1.time)

				self._control.bg.bottom.info_2.info_txt:SetActive(true)
			end
		end
	end

	function arg_1_0:_play_into_se(arg_10_1)
		self:playSE(arg_10_1, false)
	end

	function arg_1_0.__time_format(arg_11_0, arg_11_1)
		return (os.date("%Y-%m-%d\n%H:%M:%S", arg_11_1))
	end

	function arg_1_0.__time_format_line(arg_12_0, arg_12_1)
		return (os.date("%Y-%m-%d   %H:%M:%S", arg_12_1))
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0:__initia_lize()
		self._reusable_cell = nil

		self:destroyChildren("single_ninth_honor_list")
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_5:class("ninth_honor_list")

	var_15_0.server_honor_list = {}
	var_15_0.need_server_honor_list = {}
	var_15_0.user_uid = 0
	var_15_0._reusable_cell = nil
	var_15_0.enter_type = nil

	return var_15_0
end

return var_0_0
