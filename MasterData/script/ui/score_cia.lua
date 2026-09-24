local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.user
local var_0_6 = gamecore.util_func
local var_0_7 = gameenum.common_type
local var_0_8 = string.format
local var_0_9 = table.insert
local var_0_10 = table.sort
local var_0_12 = gameconfig.pve_score_buff_config
local var_0_16 = UnityEngine.Vector3
local var_0_17 = DG.Tweening.DOTween
local var_0_18 = 0
local var_0_19 = 30

gamecore.UILoader:define("score_cia", function(arg_1_0)
	function arg_1_0:__onUpdate()
		self:__updata_reset_time_txt()

		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:_init_panel(arg_3_1)
		self:enter_or_return_tween(true)
	end

	function arg_1_0:_init_panel(arg_4_1)
		self:destroyChildren("single_ocean_cia")

		if not self._is_init then
			self:__initial_func()
			self:__init_filter_type_list()

			self._is_init = true
		end

		self:__init_data(arg_4_1)
		self:__init_reusable_cell()
		self:__init_select()
		self:__set_resetbtn_state()
	end

	function arg_1_0:enter_or_return_tween(arg_5_1)
		local var_5_0 = self:autoKillDOTween(var_0_17.Sequence())
		local var_5_1 = self._control.top.transform
		local var_5_2 = self._control.npc.transform
		local var_5_3 = self._control.mainpage.transform
		local var_5_4 = self._control.top.transform.localPosition
		local var_5_5 = self._control.npc.transform.localPosition
		local var_5_6 = self._control.mainpage.transform.localPosition

		if arg_5_1 then
			self._control.top.transform.localPosition = self._control.top.transform.localPosition + var_0_16.New(0, 150, 0)
			self._control.npc.transform.localPosition = self._control.npc.transform.localPosition + var_0_16.New(-550, 0, 0)
			self._control.mainpage.transform.localPosition = self._control.mainpage.transform.localPosition + var_0_16.New(900, 0, 0)

			self._control.top.transform:DOLocalMoveY(self._control.top.transform.localPosition.y, 0.2)
			self._control.npc.transform:DOLocalMoveX(self._control.npc.transform.localPosition.x, 0.2)
			self._control.mainpage.transform:DOLocalMoveX(self._control.mainpage.transform.localPosition.x, 0.2)
		else
			self._control.top.transform:DOLocalMoveY(self._control.top.transform.localPosition.y + 150, 0.2)
			self._control.npc.transform:DOLocalMoveX(self._control.npc.transform.localPosition.x - 550, 0.2)
			self._control.mainpage.transform:DOLocalMoveX(self._control.mainpage.transform.localPosition.x + 900, 0.2):OnComplete(function()
				var_5_1.localPosition = var_5_4
				var_5_2.localPosition = var_5_5
				var_5_3.localPosition = var_5_6

				self:setVisible(false)
				self:return_func()
			end)
		end
	end

	function arg_1_0:return_func()
		self._country_toggle_data = {
			all = true
		}
		self._type_toggle_data = {
			all = true
		}
		self._buff_type_toggle_data = {
			all = true
		}
		self._need_revert = false

		self:_reset_type_layer()

		local var_7_0 = var_0_3:getInstance("score_push_map")

		if var_7_0 then
			var_7_0:setVisible(true)
		else
			log.print_r("这怕是有问题！！！score_main_map")
		end
	end

	function arg_1_0:__init_data(arg_8_1)
		self:__set_scroll_to_top()

		self._is_hard = arg_8_1 and 1 or 0
		self._user_data = var_0_4:get_score_cia_num()
		self._score_map_buff_list = var_0_4:get_score_map_buff_list()
		self._normal_data = {}
		self._hard_data = {}
		self.page_list = {
			all = 1,
			brought = 4,
			active = 2,
			disable = 3
		}
		self._buff_data = var_0_12.get_sequence()

		for iter_8_0, iter_8_1 in pairs(self._buff_data) do
			var_0_9(self._normal_data, iter_8_1)
			self:sort_rule(self._normal_data)
		end

		self:__init_page(arg_8_1)
		self:__init_data_show()
	end

	function arg_1_0:__init_data_show(arg_9_1)
		if arg_9_1 then
			self._is_hard = arg_9_1
		end

		self._control.top.score.score_num.text.text = self._is_hard == 1 and self._user_data.buff_point or self._user_data.buff_point
	end

	function arg_1_0:__init_page(arg_10_1)
		local var_10_0 = arg_10_1 and self._hard_data or self._normal_data
		local var_10_1 = {}
		local var_10_2 = {}
		local var_10_3 = {}

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if self._score_map_buff_list and next(self._score_map_buff_list) then
				local var_10_4 = var_0_12.find_object_by_id(iter_10_1.id)

				if var_0_6.have_data(self._score_map_buff_list.ids, iter_10_1.id) then
					var_0_9(var_10_1, iter_10_1)
				else
					var_0_9(var_10_2, iter_10_1)

					if var_10_4.price <= self._user_data.buff_point then
						var_0_9(var_10_3, iter_10_1)
					end
				end
			end
		end

		self.__now_list = {
			var_10_0,
			var_10_1,
			var_10_2,
			var_10_3
		}
	end

	function arg_1_0:__init_type_data()
		self:__update_cell()
	end

	function arg_1_0.__set_type_layer_data(arg_12_0, arg_12_1)
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			local var_12_1 = iter_12_1

			if (function()
				if var_0_6.dict_lenght(arg_12_0._type_toggle_data) < 2 then
					return true
				end

				local var_13_0 = false

				for iter_13_0, iter_13_1 in pairs(arg_12_0._type_toggle_data) do
					if var_12_1.effect[1] and var_12_1.effect[1].shipTypes then
						for iter_13_2, iter_13_3 in pairs(var_12_1.effect[1].shipTypes) do
							if var_0_7.filter_type[iter_13_0] == iter_13_3 then
								var_13_0 = true
							end
						end
					end

					if arg_12_0._toggle_size_group.large.toggle.isOn and var_12_1.effect[1] and var_12_1.effect[1].shipTons and var_0_7.ship_ton.large == var_12_1.effect[1].shipTons[1] then
						var_13_0 = true

						break
					end

					if arg_12_0._toggle_size_group.middle.toggle.isOn and var_12_1.effect[1] and var_12_1.effect[1].shipTons and var_0_7.ship_ton.middle == var_12_1.effect[1].shipTons[1] then
						var_13_0 = true

						break
					end

					if arg_12_0._toggle_size_group.small.toggle.isOn and var_12_1.effect[1] and var_12_1.effect[1].shipTons and var_0_7.ship_ton.small == var_12_1.effect[1].shipTons[1] then
						var_13_0 = true

						break
					end

					if arg_12_0._toggle_size_group.protect.toggle.isOn and var_12_1.effect[1] and var_12_1.effect[1].guardType and var_0_7.guard_type.protect_ship == var_12_1.effect[1].guardType[1] then
						var_13_0 = true

						break
					end

					if arg_12_0._toggle_size_group.maip.toggle.isOn and var_12_1.effect[1] and var_12_1.effect[1].guardType and var_0_7.guard_type.main_ship == var_12_1.effect[1].guardType[1] then
						var_13_0 = true

						break
					end

					if var_13_0 then
						break
					end
				end

				return var_13_0
			end)() then
				var_0_9(var_12_0, iter_12_1)
			end
		end

		return var_12_0
	end

	function arg_1_0.__set_country_layer_data(arg_14_0, arg_14_1)
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			local var_14_1 = iter_14_1

			if (function()
				if var_0_6.dict_lenght(arg_14_0._country_toggle_data) < 2 then
					return true
				end

				local var_15_0 = false

				for iter_15_0, iter_15_1 in pairs(arg_14_0._country_toggle_data) do
					if iter_15_0 == "other_country" then
						for iter_15_2, iter_15_3 in pairs(var_0_7.filter_country[iter_15_0]) do
							if var_14_1.effect[1] and var_14_1.effect[1].country and iter_15_3 == var_14_1.effect[1].country[1] then
								var_15_0 = true

								break
							end
						end
					elseif var_14_1.effect[1] and var_14_1.effect[1].country and var_0_7.filter_country[iter_15_0] == var_14_1.effect[1].country[1] then
						var_15_0 = true
					end

					if var_15_0 then
						break
					end
				end

				return var_15_0
			end)() then
				var_0_9(var_14_0, iter_14_1)
			end
		end

		return var_14_0
	end

	function arg_1_0.__set_buff_type_layer_data(arg_16_0, arg_16_1)
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
			local var_16_1 = iter_16_1

			if (function()
				if arg_16_0:get_buff_type_select() == "all" then
					return true
				else
					local var_17_0 = false

					if arg_16_0:get_buff_type_select() == "buff_type" then
						if var_16_1.effect[1] and var_16_1.effect[1].type and var_16_1.effect[1].type ~= 9 then
							var_17_0 = true
						end
					elseif arg_16_0:get_buff_type_select() == "nerf_type" and var_16_1.effect[1] and var_16_1.effect[1].type and var_16_1.effect[1].type == 9 then
						var_17_0 = true
					end

					return var_17_0
				end
			end)() then
				var_0_9(var_16_0, iter_16_1)
			end
		end

		return var_16_0
	end

	function arg_1_0:__init_select()
		if self.__now_content then
			self.__now_content.toggle.isOn = false
		end

		self:__select_one("all", true)

		self.__now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_19_1, arg_19_2)
		if self.__now_label == arg_19_1 and not arg_19_2 then
			return
		end

		self.__now_label = arg_19_1

		if self.__now_content then
			self.__now_content.toggle.isOn = false

			self:__set_btn_style(self.__now_content, false)
		end

		self:__set_current_content_and_data(arg_19_1)
		self:__set_btn_style(self.__now_content, true)
	end

	function arg_1_0:__set_current_content_and_data(arg_20_1)
		if arg_20_1 == "all" then
			self.__now_content = self._control.type.btn_group.all
			self.__now_data = self.__now_list[1]
			self._control.top.type_btn.type_text.text.text = var_0_2:getNowLang(var_0_8("ui_4th_shop_sort_%s", arg_20_1))
		elseif arg_20_1 == "active" then
			self.__now_content = self._control.type.btn_group.active
			self.__now_data = self.__now_list[2]
			self._control.top.type_btn.type_text.text.text = var_0_2:getNowLang(var_0_8("medaltypegain"))
		elseif arg_20_1 == "disable" then
			self.__now_content = self._control.type.btn_group.disable
			self.__now_data = self.__now_list[3]
			self._control.top.type_btn.type_text.text.text = var_0_2:getNowLang(var_0_8("medaltypeungain"))
		elseif arg_20_1 == "brought" then
			self.__now_content = self._control.type.btn_group.brought
			self.__now_data = self.__now_list[4]
			self._control.top.type_btn.type_text.text.text = var_0_2:getNowLang(var_0_8("score_buff_can_buy"))
		end

		self:__update_cell()
	end

	function arg_1_0:__set_btn_style(arg_21_1, arg_21_2)
		arg_21_1.image.sprite = arg_21_2 and self:loadSprite(var_0_7.forth_sort_type_const.selected) or self:loadSprite(var_0_7.forth_sort_type_const.btn)
	end

	function arg_1_0:__init_reusable_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainpage.scrollview.viewport.content.endlessScrollView, self._control.mainpage.scrollview.viewport.content, "single_ocean_cia", "score_cia")

		self._reusable_cell:init()
	end

	function arg_1_0:after_reset_succeed_update()
		self._user_data = var_0_4:get_score_cia_num()
		self._score_map_buff_list = var_0_4:get_score_map_buff_list()

		self:after_buy_succeed_update()
		self:__set_resetbtn_state()
	end

	function arg_1_0:after_buy_succeed_update()
		self._user_data = var_0_4:get_score_cia_num()
		self._score_map_buff_list = var_0_4:get_score_map_buff_list()

		self:__init_page()
		self:__init_data_show()
		self:__set_current_content_and_data(self.__now_label)
		self:__update_cell()
	end

	function arg_1_0:__update_cell()
		local var_25_0 = self:__set_buff_type_layer_data((self:__set_country_layer_data((self:__set_type_layer_data(self.__now_data)))))

		self._reusable_cell:set_data(var_25_0)

		function self._reusable_cell:_set_func(arg_26_1)
			if var_0_6.have_data(self._score_map_buff_list.ids, var_25_0[arg_26_1 + 1].id) then
				self.btns.buy_btn.gameObject:SetActive(false)
				self.btns.active_btn.gameObject:SetActive(true)
				self.btns.disable_btn.gameObject:SetActive(false)
			else
				self.btns.buy_btn.gameObject:SetActive(true)
				self.btns.active_btn.gameObject:SetActive(false)
				self.btns.disable_btn.gameObject:SetActive(false)
			end

			self.btns.buy_btn.text.text.text = tostring(var_25_0[arg_26_1 + 1].price)
			self.btns.active_btn.text.text.text = var_0_2:getNowLang(var_0_8("medaltypegain"))
			self.btns.disable_btn.text.text.text = tostring(var_25_0[arg_26_1 + 1].price)
			self.desc_text.text.color = Color.New(0.5882352941176471, 0.5882352941176471, 0.5882352941176471)
			self.limit_text.text.text = var_25_0[arg_26_1 + 1].effect_desc
			self.desc_text.text.text = var_25_0[arg_26_1 + 1].desc

			self.title:GetComponent("TextHorizonScroller"):SetText(var_25_0[arg_26_1 + 1].title)

			self.icon_bg.icon.image.sprite = self:loadSprite(var_0_8(var_0_7.score_buff_icon, var_25_0[arg_26_1 + 1].buff_icon))

			self.btns.buy_btn.button.onClick:RemoveAllListeners()
			self.btns.buy_btn.button.onClick:AddListener(function()
				self._control.buy_msgbox.main.title_text.text.text = var_0_2:getNowLang("ui_4th_buff_change_title")
				self._control.buy_msgbox.main.main_text.text.text.text = var_0_8(var_0_2:getNowLang("score_buff"), var_25_0[arg_26_1 + 1].price, var_25_0[arg_26_1 + 1].title)
				self._control.buy_msgbox.main.confirmbtn.text.text.text = var_0_2:getNowLang("ui_cbtn1")
				self._control.buy_msgbox.main.quitbtn.text.text.text = var_0_2:getNowLang("ui_cbtn2")

				self._control.buy_msgbox.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.quitbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn_revert.gameObject:SetActive(false)
				self._control.buy_msgbox.main.quitbtn_revert.gameObject:SetActive(false)
				self._control.buy_msgbox.main.confirmbtn.button.onClick:RemoveAllListeners()
				self._control.buy_msgbox.main.confirmbtn.button.onClick:AddListener(function()
					if var_25_0[arg_26_1 + 1].price > self._user_data.buff_point then
						var_0_1:show(var_0_2:getNowLang("errorcode_308"))
						self._control.buy_msgbox.gameObject:SetActive(false)

						return
					end

					self._control.buy_msgbox.gameObject:SetActive(false)
					self.btns.buy_btn.gameObject:SetActive(false)
					self.btns.active_btn.gameObject:SetActive(true)
					var_0_4:req_AnswerBuyReq(var_25_0[arg_26_1 + 1].id)
				end)
			end)

			if not var_0_6.have_data(self._score_map_buff_list.ids, var_25_0[arg_26_1 + 1].id) and var_25_0[arg_26_1 + 1].price > self._user_data.buff_point then
				self.btns.disable_btn.gameObject:SetActive(true)
				self.btns.buy_btn.gameObject:SetActive(false)

				self.btns.disable_btn.text.text.text = tostring(var_25_0[arg_26_1 + 1].price)
			end
		end
	end

	function arg_1_0:__set_scroll_to_top()
		self._control.mainpage.scrollview.scrollbarvertical:GetComponent("Scrollbar").value = 1
	end

	function arg_1_0.__num_to_time_str(arg_30_0, arg_30_1)
		local function var_30_0(arg_31_0)
			if arg_31_0 < 10 then
				return "0" .. arg_31_0
			else
				return arg_31_0
			end
		end

		return var_30_0((math.floor(arg_30_1 / 3600))) .. ":" .. var_30_0((math.floor(arg_30_1 / 60 % 60))) .. ":" .. var_30_0(arg_30_1 % 60)
	end

	function arg_1_0:__updata_reset_time_txt()
		var_0_18 = var_0_18 + 1

		if not self.__if_revert_btn and var_0_18 >= var_0_19 then
			var_0_18 = 0

			self:__set_resetbtn_state()
		end
	end

	function arg_1_0:__set_resetbtn_state()
		if self._user_data then
			local var_33_0 = math.ceil(self._user_data.time - lx.ServerTime:getUtcTime())

			self._control.top.revert_btn.image.sprite = self:loadSprite("data/ui/score_event/buff_shop/intelligence_button_reset_normal.png")
			self._control.top.revert_btn.revert_text.text.text = var_0_2:getNowLang("campaignreset")
			self.__if_revert_btn = true
		end
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_country_group = {
			all = self._control.type_layer.country_group.toggle_group.all,
			C_country = self._control.type_layer.country_group.toggle_group.C_country,
			E_country = self._control.type_layer.country_group.toggle_group.E_country,
			F_country = self._control.type_layer.country_group.toggle_group.F_country,
			G_country = self._control.type_layer.country_group.toggle_group.G_country,
			I_country = self._control.type_layer.country_group.toggle_group.I_country,
			J_country = self._control.type_layer.country_group.toggle_group.J_country,
			S_country = self._control.type_layer.country_group.toggle_group.S_country,
			U_country = self._control.type_layer.country_group.toggle_group.U_country,
			other_country = self._control.type_layer.country_group.toggle_group.other_country
		}
		self._toggle_country_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"C_country",
			"E_country",
			"F_country",
			"G_country",
			"I_country",
			"J_country",
			"S_country",
			"U_country",
			"other_country"
		}, self._toggle_country_group)
		self._toggle_type_group = {
			all = self._control.type_layer.type_group.toggle_group.all,
			CV = self._control.type_layer.type_group.toggle_group.CV,
			CVL = self._control.type_layer.type_group.toggle_group.CVL,
			AV = self._control.type_layer.type_group.toggle_group.AV,
			BB = self._control.type_layer.type_group.toggle_group.BB,
			BBV = self._control.type_layer.type_group.toggle_group.BBV,
			BC = self._control.type_layer.type_group.toggle_group.BC,
			CA = self._control.type_layer.type_group.toggle_group.CA,
			CAV = self._control.type_layer.type_group.toggle_group.CAV,
			CLT = self._control.type_layer.type_group.toggle_group.CLT,
			CL = self._control.type_layer.type_group.toggle_group.CL,
			BM = self._control.type_layer.type_group.toggle_group.BM,
			DD = self._control.type_layer.type_group.toggle_group.DD,
			SSG = self._control.type_layer.type_group.toggle_group.SSG,
			SS = self._control.type_layer.type_group.toggle_group.SS,
			SC = self._control.type_layer.type_group.toggle_group.SC,
			AP = self._control.type_layer.type_group.toggle_group.AP,
			ASDG = self._control.type_layer.type_group.toggle_group.ASDG,
			AADG = self._control.type_layer.type_group.toggle_group.AADG,
			KP = self._control.type_layer.type_group.toggle_group.KP,
			CG = self._control.type_layer.type_group.toggle_group.CG,
			CBG = self._control.type_layer.type_group.toggle_group.CBG,
			BBG = self._control.type_layer.type_group.toggle_group.BBG,
			BG = self._control.type_layer.type_group.toggle_group.BG
		}
		self._toggle_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"CV",
			"CVL",
			"AV",
			"BB",
			"BBV",
			"BC",
			"CA",
			"CAV",
			"CLT",
			"CL",
			"BM",
			"DD",
			"SSG",
			"SS",
			"SC",
			"AP",
			"ASDG",
			"AADG",
			"KP",
			"CG",
			"CBG",
			"BBG",
			"BG"
		}, self._toggle_type_group)
		self._toggle_size_group = {
			all = self._control.type_layer.size_group.toggle_group.all,
			large = self._control.type_layer.size_group.toggle_group.large,
			middle = self._control.type_layer.size_group.toggle_group.middle,
			small = self._control.type_layer.size_group.toggle_group.small,
			maip = self._control.type_layer.size_group.toggle_group.maip,
			protect = self._control.type_layer.size_group.toggle_group.protect
		}
		self._toggle_size_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"large",
			"middle",
			"small",
			"maip",
			"protect"
		}, self._toggle_size_group)
		self._toggle_buff_type_group = {
			all = self._control.type_layer.buff_type_group.toggle_group.all,
			buff_type = self._control.type_layer.buff_type_group.toggle_group.buff_type,
			nerf_type = self._control.type_layer.buff_type_group.toggle_group.nerf_type
		}
		self._toggle_buff_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"buff_type",
			"nerf_type"
		}, self._toggle_buff_type_group)
	end

	function arg_1_0:_play_into_se(arg_35_1)
		self:playSE(arg_35_1, false)
	end

	function arg_1_0.sort_rule(arg_36_0, arg_36_1)
		var_0_10(arg_36_1, function(arg_37_0, arg_37_1)
			return arg_37_0.id < arg_37_1.id
		end)

		return arg_36_1
	end

	function arg_1_0:__initial_func()
		local var_38_0 = {
			{
				nodetext = "score_buff_name",
				node = self._control.top.title_text
			},
			{
				nodetext = "score_buff_desc",
				node = self._control.top.desc.desc_text
			},
			{
				nodetext = "campaignreset",
				node = self._control.top.revert_btn.revert_text
			},
			{
				nodetext = "cancel",
				node = self._control.buy_msgbox.main.quitbtn.text
			},
			{
				nodetext = "cancel",
				node = self._control.buy_msgbox.main.quitbtn_revert.text
			},
			{
				nodetext = "ensure",
				node = self._control.buy_msgbox.main.confirmbtn.text
			},
			{
				nodetext = "ensure",
				node = self._control.buy_msgbox.main.confirmbtn_revert.text
			},
			{
				nodetext = "ui_4th_shop_sort_all",
				node = self._control.type.btn_group.all.text
			},
			{
				nodetext = "medaltypegain",
				node = self._control.type.btn_group.active.text
			},
			{
				nodetext = "medaltypeungain",
				node = self._control.type.btn_group.disable.text
			},
			{
				nodetext = "score_buff_can_buy",
				node = self._control.type.btn_group.brought.text
			},
			{
				nodetext = "type",
				node = self._control.type_layer.filter_type.type_txt
			},
			{
				nodetext = "cancel",
				node = self._control.type_layer.btn_series.cancel_btn.cancel
			},
			{
				nodetext = "confirm",
				node = self._control.type_layer.btn_series.confirm_btn.confirm
			},
			{
				nodetext = "shipbigtype0",
				node = self._control.type_layer.size_group.toggle_group.all.Label
			},
			{
				nodetext = "shipbigtype1",
				node = self._control.type_layer.size_group.toggle_group.large.Label
			},
			{
				nodetext = "shipbigtype2",
				node = self._control.type_layer.size_group.toggle_group.middle.Label
			},
			{
				nodetext = "shipbigtype3",
				node = self._control.type_layer.size_group.toggle_group.small.Label
			},
			{
				nodetext = "guard_type1",
				node = self._control.type_layer.size_group.toggle_group.maip.Label
			},
			{
				nodetext = "guard_type2",
				node = self._control.type_layer.size_group.toggle_group.protect.Label
			}
		}
		local var_38_1 = {
			{
				state = false,
				node = self._control.type_layer
			},
			{
				state = false,
				node = self._control.buy_msgbox
			},
			{
				state = false,
				node = self._control.type
			},
			{
				state = false,
				node = self._control.buy_msgbox.main.closebtn
			}
		}
		local var_38_2 = {
			init_language = function(self, arg_39_1)
				self.text.text = var_0_2:getNowLang(arg_39_1)
			end,
			init_active = function(self, arg_40_1)
				self.gameObject:SetActive(arg_40_1)
			end
		}

		for iter_38_0 = 1, #var_38_0 do
			var_38_2.init_language(var_38_0[iter_38_0].node, var_38_0[iter_38_0].nodetext)
		end

		for iter_38_1 = 1, #var_38_1 do
			var_38_2.init_active(var_38_1[iter_38_1].node, var_38_1[iter_38_1].state)
		end

		for iter_38_2, iter_38_3 in ipairs({
			self._control.type_layer.country_group.toggle_group.all,
			self._control.type_layer.country_group.toggle_group.J_country,
			self._control.type_layer.country_group.toggle_group.G_country,
			self._control.type_layer.country_group.toggle_group.E_country,
			self._control.type_layer.country_group.toggle_group.U_country,
			self._control.type_layer.country_group.toggle_group.I_country,
			self._control.type_layer.country_group.toggle_group.F_country,
			self._control.type_layer.country_group.toggle_group.S_country,
			self._control.type_layer.country_group.toggle_group.C_country,
			self._control.type_layer.country_group.toggle_group.other_country
		}) do
			iter_38_3.Label.text.text = var_0_2:getNowLang("country" .. iter_38_2 - 1)
		end

		for iter_38_4, iter_38_5 in pairs(var_0_7.filter_type) do
			self._control.type_layer.type_group.toggle_group[iter_38_4].Label.text.text = iter_38_4 == "CLT" and var_0_2:getNowLang("shiptype9") or var_0_2:getNowLang(string.format("shiptype%s", iter_38_5))
		end

		self._control.type_layer.buff_type_group.toggle_group.all.Label.text.text = var_0_2:getNowLang("evoshiptype0")
		self._control.type_layer.buff_type_group.toggle_group.buff_type.Label.text.text = var_0_2:getNowLang("score_buff_growth")
		self._control.type_layer.buff_type_group.toggle_group.nerf_type.Label.text.text = var_0_2:getNowLang("score_buff_weaken")
		self._control.top.ship_type_btn.text.text.text = var_0_2:getNowLang("type")
		self._control.top.type_btn.text.text.text = var_0_2:getNowLang("filterlabel")
	end

	function arg_1_0:get_buff_type_select()
		return self._buff_data_select or "all"
	end

	function arg_1_0:show_sort_layer(arg_42_1)
		self._control.type_layer:SetActive(arg_42_1)

		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		self:__save_toggle_group_all_set_data()
	end

	function arg_1_0.__onReset(arg_43_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_44_0)
	local var_44_0 = var_0_3:class("score_cia")

	var_44_0._is_init = false
	var_44_0._normal_data = {}
	var_44_0._hard_data = {}
	var_44_0.page_list = {}
	var_44_0.__data_list = {}
	var_44_0._score_map_buff_list = {}
	arg_44_0.__now_content = nil
	var_44_0.__now_data = nil
	var_44_0.__if_revert_btn = false
	var_44_0._buff_data_select = nil

	gamecore.extend_obj(var_44_0)

	return var_44_0
end

return var_0_0
