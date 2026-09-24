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
local var_0_13 = gameconfig.pve_score_buff_config
local var_0_17 = UnityEngine.Vector3
local var_0_18 = DG.Tweening.DOTween
local var_0_19 = 0
local var_0_20 = 30

gamecore.UILoader:define("ocean_cia", function(arg_1_0)
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
		local var_5_0 = self:autoKillDOTween(var_0_18.Sequence())
		local var_5_1 = self._control.top.transform
		local var_5_2 = self._control.npc.transform
		local var_5_3 = self._control.mainpage.transform
		local var_5_4 = self._control.top.transform.localPosition
		local var_5_5 = self._control.npc.transform.localPosition
		local var_5_6 = self._control.mainpage.transform.localPosition

		if arg_5_1 then
			self._control.top.transform.localPosition = self._control.top.transform.localPosition + var_0_17.New(0, 150, 0)
			self._control.npc.transform.localPosition = self._control.npc.transform.localPosition + var_0_17.New(-550, 0, 0)
			self._control.mainpage.transform.localPosition = self._control.mainpage.transform.localPosition + var_0_17.New(900, 0, 0)

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
		self._need_revert = false

		self:_reset_type_layer()

		local var_7_0 = var_0_3:getInstance("score_push_map")

		if var_7_0 then
			var_7_0:setVisible(true)
		else
			log.print_r("这怕是有问题！！！ocean_main_map")
		end
	end

	function arg_1_0:__init_data(arg_8_1)
		self._is_hard = arg_8_1 and 1 or 0
		self._user_data = var_0_4:get_ocean_shop_data()
		self._ocean_map_buff_list = var_0_4:get_ocean_map_buff_list()
		self._normal_data = {}
		self._hard_data = {}
		self.page_list = {
			all = 1,
			active = 4,
			disable = 5,
			lock = 2,
			unlock = 3
		}
		self._buff_data = var_0_13.get_sequence()

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

		self._control.top.score.score_num.text.text = self._is_hard == 1 and self._user_data.hard_coin or self._user_data.coin
	end

	function arg_1_0:__init_page(arg_10_1)
		local var_10_0 = arg_10_1 and self._hard_data or self._normal_data
		local var_10_1 = {}
		local var_10_2 = {}
		local var_10_3 = {}
		local var_10_4 = {}

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.buy_desc == "0" then
				var_0_9(var_10_1, iter_10_1)
			end

			if iter_10_1.buy_desc ~= "0" then
				var_0_9(var_10_2, iter_10_1)
			end

			if var_0_6.have_data(self._ocean_map_buff_list, iter_10_1.id) then
				var_0_9(var_10_3, iter_10_1)
			else
				var_0_9(var_10_4, iter_10_1)
			end
		end

		self.__now_list = {
			var_10_0,
			var_10_1,
			var_10_2,
			var_10_3,
			var_10_4
		}
	end

	function arg_1_0:__init_type_data()
		self:__update_cell()
	end

	function arg_1_0.__set_type_layer_data(arg_12_0, arg_12_1)
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
			local var_12_1 = iter_12_1

			if (function()
				if var_0_6.dict_lenght(arg_12_0._type_toggle_data) < 2 then
					return true
				end

				local var_13_0 = false

				for iter_13_0, iter_13_1 in pairs(arg_12_0._type_toggle_data) do
					if var_0_7.filter_type[iter_13_0] == var_12_1.effect[1].type then
						var_13_0 = true
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
							if iter_15_3 == var_14_1.effect[1].countrys[1] then
								var_15_0 = true

								break
							end
						end
					elseif var_0_7.filter_country[iter_15_0] == var_14_1.effect[1].countrys[1] then
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

	function arg_1_0:__init_select()
		if self.__now_content then
			self.__now_content.toggle.isOn = false
		end

		self:__select_one("all", true)

		self.__now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_17_1, arg_17_2)
		if self.__now_label == arg_17_1 and not arg_17_2 then
			return
		end

		self.__now_label = arg_17_1

		if self.__now_content then
			self.__now_content.toggle.isOn = false

			self:__set_btn_style(self.__now_content, false)
		end

		self:__set_current_content_and_data(arg_17_1)
		self:__set_btn_style(self.__now_content, true)
	end

	function arg_1_0:__set_current_content_and_data(arg_18_1)
		if arg_18_1 == "all" then
			self.__now_content = self._control.type.btn_group.all
			self.__now_data = self.__now_list[1]
		elseif arg_18_1 == "unlock" then
			self.__now_content = self._control.type.btn_group.unlock
			self.__now_data = self.__now_list[2]
		elseif arg_18_1 == "lock" then
			self.__now_content = self._control.type.btn_group.lock
			self.__now_data = self.__now_list[3]
		elseif arg_18_1 == "active" then
			self.__now_content = self._control.type.btn_group.active
			self.__now_data = self.__now_list[4]
		elseif arg_18_1 == "disable" then
			self.__now_content = self._control.type.btn_group.disable
			self.__now_data = self.__now_list[5]
		end

		self._control.top.type_btn.type_text.text.text = var_0_2:getNowLang(var_0_8("ui_4th_shop_sort_%s", arg_18_1))

		self:__update_cell()
	end

	function arg_1_0:__set_btn_style(arg_19_1, arg_19_2)
		arg_19_1.image.sprite = arg_19_2 and self:loadSprite(var_0_7.forth_sort_type_const.selected) or self:loadSprite(var_0_7.forth_sort_type_const.btn)
	end

	function arg_1_0:__init_reusable_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainpage.scrollview.viewport.content.endlessScrollView, self._control.mainpage.scrollview.viewport.content, "single_ocean_cia", "ocean_cia")

		self._reusable_cell:init()
	end

	function arg_1_0:after_reset_succeed_update()
		self._ocean_map_buff_list = {}

		self:after_buy_succeed_update()
		self:__set_resetbtn_state()
	end

	function arg_1_0:after_buy_succeed_update()
		self._user_data = var_0_4:get_ocean_shop_data()

		self:__init_page()
		self:__init_data_show()
		self:__set_current_content_and_data(self.__now_label)
		self:__update_cell()
	end

	function arg_1_0:__update_cell()
		local var_23_0 = self:__set_country_layer_data((self:__set_type_layer_data(self.__now_data)))

		self._reusable_cell:set_data(var_23_0)

		function self._reusable_cell:_set_func(arg_24_1)
			if var_0_6.have_data(self._ocean_map_buff_list, var_23_0[arg_24_1 + 1].id) then
				self.btns.buy_btn.gameObject:SetActive(false)
				self.btns.active_btn.gameObject:SetActive(true)
				self.btns.disable_btn.gameObject:SetActive(false)
			else
				self.btns.buy_btn.gameObject:SetActive(false)
				self.btns.active_btn.gameObject:SetActive(false)
				self.btns.disable_btn.gameObject:SetActive(true)
			end

			self.btns.buy_btn.text.text.text = tostring(var_23_0[arg_24_1 + 1].price)
			self.btns.active_btn.text.text.text = var_0_2:getNowLang("ui_4th_shop_sort_activity")
			self.btns.disable_btn.text.text.text = tostring(var_23_0[arg_24_1 + 1].price)
			self.desc_text.text.text = "这里应该是文案描述"
			self.desc_text.text.color = Color.New(0.5882352941176471, 0.5882352941176471, 0.5882352941176471)
			self.limit_text.text.text = var_23_0[arg_24_1 + 1].effect_desc

			self.title:GetComponent("TextHorizonScroller"):SetText(var_23_0[arg_24_1 + 1].title)

			self.icon_bg.icon.image.sprite = self:loadSprite(var_0_8(var_0_7.score_buff_icon, var_23_0[arg_24_1 + 1].buff_icon))

			self.btns.buy_btn.button.onClick:RemoveAllListeners()
			self.btns.buy_btn.button.onClick:AddListener(function()
				self._control.buy_msgbox.main.title_text.text.text = var_0_2:getNowLang("ui_4th_buff_change_title")
				self._control.buy_msgbox.main.main_text.text.text.text = var_0_8(var_0_2:getNowLang("ui_4th_buff_change_content"), var_23_0[arg_24_1 + 1].score, var_23_0[arg_24_1 + 1].title)

				self._control.buy_msgbox.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.quitbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn_revert.gameObject:SetActive(false)
				self._control.buy_msgbox.main.quitbtn_revert.gameObject:SetActive(false)
				self._control.buy_msgbox.main.confirmbtn.button.onClick:RemoveAllListeners()
				self._control.buy_msgbox.main.confirmbtn.button.onClick:AddListener(function()
					if var_23_0[arg_24_1 + 1].score > self._user_data.coin then
						var_0_1:show(var_0_2:getNowLang("errorcode_308"))
						self._control.buy_msgbox.gameObject:SetActive(false)

						return
					end

					self._control.buy_msgbox.gameObject:SetActive(false)
					self.btns.buy_btn.gameObject:SetActive(false)
					self.btns.active_btn.gameObject:SetActive(true)
					var_0_4:req_OceanBuyReq(var_23_0[arg_24_1 + 1].id)
				end)
			end)

			if var_23_0[arg_24_1 + 1].price > self._user_data.coin then
				self.btns.disable_btn.gameObject:SetActive(true)
				self.btns.buy_btn.gameObject:SetActive(false)

				self.btns.disable_btn.text.text.text = tostring(var_23_0[arg_24_1 + 1].price)
			end
		end
	end

	function arg_1_0.__num_to_time_str(arg_27_0, arg_27_1)
		local function var_27_0(arg_28_0)
			if arg_28_0 < 10 then
				return "0" .. arg_28_0
			else
				return arg_28_0
			end
		end

		return var_27_0((math.floor(arg_27_1 / 3600))) .. ":" .. var_27_0((math.floor(arg_27_1 / 60 % 60))) .. ":" .. var_27_0(arg_27_1 % 60)
	end

	function arg_1_0:__updata_reset_time_txt()
		var_0_19 = var_0_19 + 1

		if not self.__if_revert_btn and var_0_19 >= var_0_20 then
			var_0_19 = 0

			self:__set_resetbtn_state()
		end
	end

	function arg_1_0:__set_resetbtn_state()
		if self._user_data then
			local var_30_0

			if self._is_hard then
				if self._is_hard == 0 then
					var_30_0 = self._user_data.time
				elseif self._is_hard == 1 then
					var_30_0 = self._user_data.hard_time
				end
			end

			local var_30_2 = math.ceil(var_30_0 - lx.ServerTime:getUtcTime())

			if var_30_2 > 0 then
				self._control.top.revert_btn.revert_text.text.text = self:__num_to_time_str(var_30_2)

				if self.__is_revert_btn ~= false then
					self.__if_revert_btn = false
					self._control.top.revert_btn.image.sprite = self:loadSprite("data/ui/4th_event/cia/intelligence_button_reset_disable.png")
				end
			else
				self._control.top.revert_btn.image.sprite = self:loadSprite("data/ui/4th_event/cia/intelligence_button_reset_normal.png")
				self._control.top.revert_btn.revert_text.text.text = var_0_2:getNowLang("campaignreset")
				self.__if_revert_btn = true
			end
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
			"CBG",
			"BBG",
			"BG"
		}, self._toggle_type_group)
		self._toggle_size_group = {
			all = self._control.type_layer.size_group.toggle_group.all,
			large = self._control.type_layer.size_group.toggle_group.large,
			middle = self._control.type_layer.size_group.toggle_group.middle,
			small = self._control.type_layer.size_group.toggle_group.small
		}
		self._toggle_size_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"large",
			"middle",
			"small"
		}, self._toggle_size_group)
	end

	function arg_1_0:_play_into_se(arg_32_1)
		self:playSE(arg_32_1, false)
	end

	function arg_1_0.sort_rule(arg_33_0, arg_33_1)
		var_0_10(arg_33_1, function(arg_34_0, arg_34_1)
			return arg_34_0.id < arg_34_1.id
		end)

		return arg_33_1
	end

	function arg_1_0:__initial_func()
		local var_35_0 = {
			{
				nodetext = "ui_4th_shop",
				node = self._control.top.title_text
			},
			{
				nodetext = "ui_4th_shop_tip",
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
				nodetext = "ui_4th_shop_sort_unlock",
				node = self._control.type.btn_group.unlock.text
			},
			{
				nodetext = "ui_4th_shop_sort_lock",
				node = self._control.type.btn_group.lock.text
			},
			{
				nodetext = "ui_4th_shop_sort_active",
				node = self._control.type.btn_group.active.text
			},
			{
				nodetext = "ui_4th_shop_sort_disable",
				node = self._control.type.btn_group.disable.text
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
			}
		}
		local var_35_1 = {
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
		local var_35_2 = {
			init_language = function(self, arg_36_1)
				self.text.text = var_0_2:getNowLang(arg_36_1)
			end,
			init_active = function(self, arg_37_1)
				self.gameObject:SetActive(arg_37_1)
			end
		}

		for iter_35_0 = 1, #var_35_0 do
			var_35_2.init_language(var_35_0[iter_35_0].node, var_35_0[iter_35_0].nodetext)
		end

		for iter_35_1 = 1, #var_35_1 do
			var_35_2.init_active(var_35_1[iter_35_1].node, var_35_1[iter_35_1].state)
		end

		for iter_35_2, iter_35_3 in ipairs({
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
			iter_35_3.Label.text.text = var_0_2:getNowLang("country" .. iter_35_2 - 1)
		end

		for iter_35_4, iter_35_5 in pairs(var_0_7.filter_type) do
			self._control.type_layer.type_group.toggle_group[iter_35_4].Label.text.text = iter_35_4 == "CLT" and var_0_2:getNowLang("shiptype9") or var_0_2:getNowLang(string.format("shiptype%s", iter_35_5))
		end
	end

	function arg_1_0:show_sort_layer(arg_38_1)
		self._control.type_layer:SetActive(arg_38_1)
	end

	function arg_1_0.__onReset(arg_39_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_40_0)
	local var_40_0 = var_0_3:class("ocean_cia")

	var_40_0._is_init = false
	var_40_0._normal_data = {}
	var_40_0._hard_data = {}
	var_40_0.page_list = {}
	var_40_0.__data_list = {}
	var_40_0._ocean_map_buff_list = {}
	arg_40_0.__now_content = nil
	var_40_0.__now_data = nil
	var_40_0.__if_revert_btn = false

	gamecore.extend_obj(var_40_0)

	return var_40_0
end

return var_0_0
