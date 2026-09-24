local var_0_0 = {}
local var_0_1 = lan_rand
local var_0_2 = gamecore.user
local var_0_3 = table.sort
local var_0_4 = gamecore.prompt
local var_0_5 = table.insert
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.UILoader
local var_0_8 = string.format
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = gamecore.util_func
local var_0_11 = gameenum.common_type
local var_0_12 = gameconfig.ship_config
local var_0_14 = gameconfig.pve_ninth_buff_config

gamecore.UILoader:define("ninth_cia", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)

		self._enter_type = arg_3_1

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self:destroyChildren("single_ninth_cia")

		if not self._is_init then
			self:__initial_func()
			self:__init_filter_type_list()
			self:set_npc_img()

			self._is_init = true
		end

		self:__init_page()
		self:__init_reusable_cell()
		self:__set_scroll_to_top()
		self:__set_current_content_and_data(self.__now_label)
	end

	function arg_1_0:__initial_func()
		local var_5_0 = {
			{
				nodetext = "ninth_buff",
				node = self._control.top.title_text
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
				nodetext = "ninth_buff_state_3",
				node = self._control.type.btn_group.active.text
			},
			{
				nodetext = "ninth_buff_state_1",
				node = self._control.type.btn_group.disable.text
			},
			{
				nodetext = "ninth_buff_state_2",
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
		local var_5_1 = {
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
		local var_5_2 = {
			init_language = function(self, arg_6_1)
				self.text.text = var_0_6:getNowLang(arg_6_1)
			end,
			init_active = function(self, arg_7_1)
				self.gameObject:SetActive(arg_7_1)
			end
		}

		for iter_5_0 = 1, #var_5_0 do
			var_5_2.init_language(var_5_0[iter_5_0].node, var_5_0[iter_5_0].nodetext)
		end

		for iter_5_1 = 1, #var_5_1 do
			var_5_2.init_active(var_5_1[iter_5_1].node, var_5_1[iter_5_1].state)
		end

		for iter_5_2, iter_5_3 in ipairs({
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
			iter_5_3.Label.text.text = var_0_6:getNowLang("country" .. iter_5_2 - 1)
		end

		for iter_5_4, iter_5_5 in pairs(var_0_11.filter_type) do
			self._control.type_layer.type_group.toggle_group[iter_5_4].Label.text.text = iter_5_4 == "CLT" and var_0_6:getNowLang("shiptype9") or var_0_6:getNowLang(string.format("shiptype%s", iter_5_5))
		end

		self._control.type_layer.buff_type_group.toggle_group.all.Label.text.text = var_0_6:getNowLang("evoshiptype0")
		self._control.type_layer.buff_type_group.toggle_group.attribute_up.Label.text.text = var_0_6:getNowLang("ninth_buff_type_1")
		self._control.type_layer.buff_type_group.toggle_group.damage_up.Label.text.text = var_0_6:getNowLang("ninth_buff_type_2")
		self._control.type_layer.buff_type_group.toggle_group.ignore_hurt.Label.text.text = var_0_6:getNowLang("ninth_buff_type_3")
		self._control.type_layer.buff_type_group.toggle_group.ignore_lack_ammu.Label.text.text = var_0_6:getNowLang("ninth_buff_type_4")
		self._control.type_layer.buff_type_group.toggle_group.capacity_up.Label.text.text = var_0_6:getNowLang("ninth_buff_type_5")
		self._control.type_layer.buff_type_group.toggle_group.support_atk.Label.text.text = var_0_6:getNowLang("ninth_buff_type_6")
		self._control.top.ship_type_btn.text.text.text = var_0_6:getNowLang("type")
		self._control.top.type_btn.text.text.text = var_0_6:getNowLang("filterlabel")

		self._control.top.title_text.desc:GetComponent("TextHorizonScroller"):SetText(var_0_6:getNowLang("ninth_buff_desc"))
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
			attribute_up = self._control.type_layer.buff_type_group.toggle_group.attribute_up,
			damage_up = self._control.type_layer.buff_type_group.toggle_group.damage_up,
			ignore_hurt = self._control.type_layer.buff_type_group.toggle_group.ignore_hurt,
			ignore_lack_ammu = self._control.type_layer.buff_type_group.toggle_group.ignore_lack_ammu,
			capacity_up = self._control.type_layer.buff_type_group.toggle_group.capacity_up,
			support_atk = self._control.type_layer.buff_type_group.toggle_group.support_atk
		}
		self._toggle_buff_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"attribute_up",
			"damage_up",
			"ignore_hurt",
			"ignore_lack_ammu",
			"capacity_up",
			"support_atk"
		}, self._toggle_buff_type_group)
	end

	function arg_1_0:__init_page()
		self._buff_data = var_0_14.get_sequence()

		if self._enter_type > 0 then
			if self._enter_type == var_0_11.fight_type.fearlessness_sea then
				local var_9_0 = var_0_2:get_push_info_coin()

				self._buff_point = var_9_0
				self._control.top.score.score_num.text.text = var_9_0
			end
		else
			local var_9_1 = var_0_2:get_ninth_cia_buff_point()

			self._buff_point = var_9_1
			self._control.top.score.score_num.text.text = var_9_1
		end

		self._normal_data = {}

		for iter_9_0, iter_9_1 in pairs(self._buff_data) do
			var_0_5(self._normal_data, iter_9_1)
			self:sort_rule(self._normal_data)
		end

		local var_9_2 = self._normal_data
		local var_9_3 = {}
		local var_9_4 = {}
		local var_9_5 = {}

		self._ninth_map_buff_list = self._enter_type == var_0_11.fight_type.fearlessness_sea and var_0_2:get_push_cia_buff_info() or var_0_2:get_ninth_cia_buff_info()

		for iter_9_2, iter_9_3 in pairs(var_9_2) do
			local var_9_6 = var_0_14.find_object_by_id(iter_9_3.id)

			if self._ninth_map_buff_list and next(self._ninth_map_buff_list) and var_0_10.have_data(self._ninth_map_buff_list, iter_9_3.id) then
				var_0_5(var_9_3, iter_9_3)
			elseif var_9_6.price <= self._buff_point and var_9_6.unlock and not next(var_9_6.unlock) then
				var_0_5(var_9_5, iter_9_3)
			end

			self:__check_unlock_bg(var_9_6, var_9_4, var_9_5)
		end

		self.__now_list = {
			var_9_2,
			var_9_3,
			var_9_4,
			var_9_5
		}
	end

	function arg_1_0:check_all_buff_coin()
		local var_10_0 = self._buff_point

		if self._ninth_map_buff_list and next(self._ninth_map_buff_list) then
			for iter_10_0, iter_10_1 in pairs(self._ninth_map_buff_list) do
				var_10_0 = var_10_0 + var_0_14.find_object_by_id(iter_10_1).price
			end
		end

		return var_10_0
	end

	function arg_1_0:__init_type_data()
		self:__update_cell()
	end

	function arg_1_0.sort_rule(arg_12_0, arg_12_1)
		var_0_3(arg_12_1, function(arg_13_0, arg_13_1)
			return arg_13_0.id < arg_13_1.id
		end)

		return arg_12_1
	end

	function arg_1_0:__set_current_content_and_data(arg_14_1)
		if arg_14_1 == "all" then
			self.__now_content = self._control.type.btn_group.all
			self.__now_data = self.__now_list[1]
			self._control.top.type_btn.type_text.text.text = var_0_6:getNowLang(var_0_8("ui_4th_shop_sort_%s", arg_14_1))
		elseif arg_14_1 == "active" then
			self.__now_content = self._control.type.btn_group.active
			self.__now_data = self.__now_list[2]
			self._control.top.type_btn.type_text.text.text = var_0_6:getNowLang(var_0_8("ninth_buff_state_3"))
		elseif arg_14_1 == "disable" then
			self.__now_content = self._control.type.btn_group.disable
			self.__now_data = self.__now_list[3]
			self._control.top.type_btn.type_text.text.text = var_0_6:getNowLang(var_0_8("ninth_buff_state_1"))
		elseif arg_14_1 == "brought" then
			self.__now_content = self._control.type.btn_group.brought
			self.__now_data = self.__now_list[4]
			self._control.top.type_btn.type_text.text.text = var_0_6:getNowLang(var_0_8("ninth_buff_state_2"))
		end

		self:__update_cell()
	end

	function arg_1_0:set_npc_img()
		local var_15_0 = var_0_11.ninth_npc_list[var_0_1(1, #var_0_11.ninth_npc_list)]
		local var_15_1 = var_0_10:use_big_break_painting(var_0_12.find_object_by_cid(10000113), var_0_11.ship_icon_type.model_l, false)
		local var_15_2, var_15_3 = self:loadSprite(var_0_11:get_ship_icon(var_15_1, var_15_0))

		self._control.npc.img.image.sprite = self:loadSprite(var_0_11:get_ship_icon(var_15_1, var_15_0))

		if var_15_3 and self._control.npc.img.transform.localScale.x == 1 and self._control.npc.img.transform.localScale.y == 1 and self._control.npc.img.transform.localScale.z == 1 then
			var_0_11:hd_sprite_half_scale(self._control.npc.img.transform)
		end
	end

	function arg_1_0:_play_into_se(arg_16_1)
		self:playSE(arg_16_1, false)
	end

	function arg_1_0:__init_reusable_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainpage.scrollview.viewport.content.endlessScrollView, self._control.mainpage.scrollview.viewport.content, "single_ninth_cia", "ninth_cia")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell()
		self._ninth_map_buff_list = self._enter_type == var_0_11.fight_type.fearlessness_sea and var_0_2:get_push_cia_buff_info() or var_0_2:get_ninth_cia_buff_info()

		local var_18_0 = self:__set_type_layer_data(self.__now_data)

		for iter_18_0, iter_18_1 in pairs((self:__set_type_link_data(self.__now_data))) do
			var_0_5(var_18_0, iter_18_1)
		end

		local var_18_1 = self:__set_buff_type_layer_data((self:__set_country_layer_data(var_18_0)))

		self._reusable_cell:set_data(var_18_1)

		function self._reusable_cell:_set_func(arg_19_1)
			self.btns.buy_btn.button.interactable = true

			local var_19_0, var_19_1 = self:__show_unlock_bg(var_18_1[arg_19_1 + 1])

			if var_19_0 then
				self.unlock_bg:SetActive(var_19_0)

				self.unlock_bg.limit_0.text.text = var_0_6:getNowLang("cinema_jiesuotiaojian")

				if #var_18_1[arg_19_1 + 1].unlock_desc >= 1 then
					self.unlock_bg.limit_1:SetActive(true)

					self.unlock_bg.limit_1.text.text = var_18_1[arg_19_1 + 1].unlock_desc[1]
					self.unlock_bg.limit_1.text.color = var_19_1[1] and Color.New(0.3411764705882353, 0.792156862745098, 1) or Color.New(1, 1, 1, 0.7843137254901961)
				else
					self.unlock_bg.limit_1:SetActive(false)
				end

				if #var_18_1[arg_19_1 + 1].unlock_desc >= 2 then
					self.unlock_bg.limit_2:SetActive(true)

					self.unlock_bg.limit_2.text.text = var_18_1[arg_19_1 + 1].unlock_desc[2]
					self.unlock_bg.limit_2.text.color = var_19_1[2] and Color.New(0.3411764705882353, 0.792156862745098, 1) or Color.New(1, 1, 1, 0.7843137254901961)
				else
					self.unlock_bg.limit_2:SetActive(false)
				end

				if #var_18_1[arg_19_1 + 1].unlock_desc >= 3 then
					self.unlock_bg.limit_3:SetActive(true)

					self.unlock_bg.limit_3.text.text = var_18_1[arg_19_1 + 1].unlock_desc[3]
					self.unlock_bg.limit_3.text.color = var_19_1[3] and Color.New(0.3411764705882353, 0.792156862745098, 1) or Color.New(1, 1, 1, 0.7843137254901961)
				else
					self.unlock_bg.limit_3:SetActive(false)
				end

				self.btns.buy_btn.button.interactable = not var_19_0
			else
				self.unlock_bg:SetActive(var_19_0)
			end

			if self._ninth_map_buff_list and next(self._ninth_map_buff_list) and var_0_10.have_data(self._ninth_map_buff_list, var_18_1[arg_19_1 + 1].id) then
				self.btns.buy_btn.gameObject:SetActive(false)
				self.btns.active_btn.gameObject:SetActive(true)
				self.btns.disable_btn.gameObject:SetActive(false)
			else
				self.btns.buy_btn.gameObject:SetActive(true)
				self.btns.active_btn.gameObject:SetActive(false)
				self.btns.disable_btn.gameObject:SetActive(false)
			end

			self.btns.buy_btn.text.text.text = tostring(var_18_1[arg_19_1 + 1].price)
			self.btns.active_btn.text.text.text = var_0_6:getNowLang(var_0_8("medaltypegain"))
			self.btns.disable_btn.text.text.text = tostring(var_18_1[arg_19_1 + 1].price)
			self.desc_text.text.color = Color.New(0.5882352941176471, 0.5882352941176471, 0.5882352941176471)
			self.limit_text.text.text = var_0_6:convert_rich_text(var_18_1[arg_19_1 + 1].effect_desc)
			self.desc_text.text.text = var_18_1[arg_19_1 + 1].desc

			self.title:GetComponent("TextHorizonScroller"):SetText(var_18_1[arg_19_1 + 1].title)

			self.icon_bg.icon.image.sprite = self:loadSprite(var_0_8(var_0_11.score_buff_icon, var_18_1[arg_19_1 + 1].buff_icon))

			self.btns.buy_btn.button.onClick:RemoveAllListeners()
			self.btns.buy_btn.button.onClick:AddListener(function()
				self._control.buy_msgbox.main.title_text.text.text = var_0_6:getNowLang("ui_4th_buff_change_title")
				self._control.buy_msgbox.main.main_text.text.text.text = var_0_8(var_0_6:getNowLang("ninth_buff_buy"), var_18_1[arg_19_1 + 1].price, var_18_1[arg_19_1 + 1].title)
				self._control.buy_msgbox.main.confirmbtn.text.text.text = var_0_6:getNowLang("ui_cbtn1")
				self._control.buy_msgbox.main.quitbtn.text.text.text = var_0_6:getNowLang("ui_cbtn2")

				self._control.buy_msgbox.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.quitbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn_revert.gameObject:SetActive(false)
				self._control.buy_msgbox.main.quitbtn_revert.gameObject:SetActive(false)
				self._control.buy_msgbox.main.confirmbtn.button.onClick:RemoveAllListeners()
				self._control.buy_msgbox.main.confirmbtn.button.onClick:AddListener(function()
					if var_18_1[arg_19_1 + 1].price > self._buff_point then
						var_0_4:show(var_0_6:getNowLang("errorcode_308"))
						self._control.buy_msgbox.gameObject:SetActive(false)

						return
					end

					self._control.buy_msgbox.gameObject:SetActive(false)
					self.btns.buy_btn.gameObject:SetActive(false)
					self.btns.active_btn.gameObject:SetActive(true)

					self.scrollbar_value = self._control.mainpage.scrollview.scrollbarvertical:GetComponent("Scrollbar").value

					if self._enter_type == var_0_11.fight_type.fearlessness_sea then
						var_0_2:req_PushBuyBuffReq(var_18_1[arg_19_1 + 1].id)
					else
						var_0_2:req_NinthBuyReq(var_18_1[arg_19_1 + 1].id)
					end
				end)
			end)

			if self._ninth_map_buff_list and next(self._ninth_map_buff_list) then
				if not var_0_10.have_data(self._ninth_map_buff_list, var_18_1[arg_19_1 + 1].id) and var_18_1[arg_19_1 + 1].price > self._buff_point then
					self.btns.disable_btn.gameObject:SetActive(true)
					self.btns.buy_btn.gameObject:SetActive(false)

					self.btns.disable_btn.text.text.text = tostring(var_18_1[arg_19_1 + 1].price)
				end
			elseif var_18_1[arg_19_1 + 1].price > self._buff_point then
				self.btns.disable_btn.gameObject:SetActive(true)
				self.btns.buy_btn.gameObject:SetActive(false)

				self.btns.disable_btn.text.text.text = tostring(var_18_1[arg_19_1 + 1].price)
			end
		end
	end

	function arg_1_0:__check_unlock_bg(arg_22_1, arg_22_2, arg_22_3)
		if arg_22_1.unlock and next(arg_22_1.unlock) then
			local var_22_0 = {}

			for iter_22_0, iter_22_1 in pairs(arg_22_1.unlock) do
				if iter_22_1.type == 1 then
					var_22_0[iter_22_0] = true

					for iter_22_2, iter_22_3 in pairs(iter_22_1.level_id) do
						if self._enter_type == var_0_11.fight_type.fearlessness_sea then
							if not var_0_2:is_map_pass(iter_22_3) then
								var_22_0[iter_22_0] = false
							end
						elseif not var_0_2:ninth_map_is_pass(iter_22_3) then
							var_22_0[iter_22_0] = false
						end
					end
				elseif iter_22_1.type == 2 then
					var_22_0[iter_22_0] = true

					if self._enter_type == var_0_11.fight_type.fearlessness_sea then
						if self:check_all_buff_coin() < iter_22_1.num then
							var_22_0[iter_22_0] = false
						end
					elseif var_0_2:get_ninth_pass_award_score() < iter_22_1.num then
						var_22_0[iter_22_0] = false
					end
				elseif iter_22_1.type == 3 then
					var_22_0[iter_22_0] = true

					for iter_22_4, iter_22_5 in pairs(iter_22_1.level_id) do
						if var_0_2:get_ninth_level_pass_num(iter_22_5) < iter_22_1.num then
							var_22_0[iter_22_0] = false
						end
					end
				end
			end

			if var_22_0 and next(var_22_0) then
				if #var_22_0 == 1 then
					if var_22_0[1] == true then
						if not self:_have_data(arg_22_3, arg_22_1.id) and not self:_have_data_2(self._ninth_map_buff_list, arg_22_1.id) and arg_22_1.price <= self._buff_point then
							var_0_5(arg_22_3, arg_22_1)
						end
					else
						var_0_5(arg_22_2, arg_22_1)
					end
				elseif #var_22_0 == 2 then
					if var_22_0[1] == true and var_22_0[2] == true then
						if not self:_have_data(arg_22_3, arg_22_1.id) and not self:_have_data_2(self._ninth_map_buff_list, arg_22_1.id) and arg_22_1.price <= self._buff_point then
							var_0_5(arg_22_3, arg_22_1)
						end
					else
						var_0_5(arg_22_2, arg_22_1)
					end
				elseif #var_22_0 == 3 then
					if var_22_0[1] == true and var_22_0[2] == true and var_22_0[3] == true then
						if not self:_have_data(arg_22_3, arg_22_1.id) and not self:_have_data_2(self._ninth_map_buff_list, arg_22_1.id) and arg_22_1.price <= self._buff_point then
							var_0_5(arg_22_3, arg_22_1)
						end
					else
						var_0_5(arg_22_2, arg_22_1)
					end
				end
			end
		end
	end

	function arg_1_0._have_data(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = false

		if arg_23_1 and next(arg_23_1) then
			for iter_23_0, iter_23_1 in pairs(arg_23_1) do
				if iter_23_1.id == arg_23_2 then
					var_23_0 = true
				end
			end
		end

		return var_23_0
	end

	function arg_1_0._have_data_2(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = false

		if arg_24_1 and next(arg_24_1) then
			for iter_24_0, iter_24_1 in pairs(arg_24_1) do
				if iter_24_1 == arg_24_2 then
					var_24_0 = true
				end
			end
		end

		return var_24_0
	end

	function arg_1_0:__show_unlock_bg(arg_25_1)
		if arg_25_1.unlock and next(arg_25_1.unlock) then
			local var_25_0 = {}

			for iter_25_0, iter_25_1 in pairs(arg_25_1.unlock) do
				if iter_25_1.type == 1 then
					var_25_0[iter_25_0] = true

					for iter_25_2, iter_25_3 in pairs(iter_25_1.level_id) do
						if self._enter_type == var_0_11.fight_type.fearlessness_sea then
							if not var_0_2:is_map_pass(iter_25_3) then
								var_25_0[iter_25_0] = false
							end
						elseif not var_0_2:ninth_map_is_pass(iter_25_3) then
							var_25_0[iter_25_0] = false
						end
					end
				elseif iter_25_1.type == 2 then
					var_25_0[iter_25_0] = true

					if self._enter_type == var_0_11.fight_type.fearlessness_sea then
						if self:check_all_buff_coin() < iter_25_1.num then
							var_25_0[iter_25_0] = false
						end
					elseif var_0_2:get_ninth_pass_award_score() < iter_25_1.num then
						var_25_0[iter_25_0] = false
					end
				elseif iter_25_1.type == 3 then
					var_25_0[iter_25_0] = true

					for iter_25_4, iter_25_5 in pairs(iter_25_1.level_id) do
						if var_0_2:get_ninth_level_pass_num(iter_25_5) < iter_25_1.num then
							var_25_0[iter_25_0] = false
						end
					end
				end
			end

			for iter_25_6, iter_25_7 in pairs(var_25_0) do
				if not iter_25_7 then
					return true, var_25_0
				end
			end

			return false
		else
			return false
		end
	end

	function arg_1_0:__select_one(arg_26_1, arg_26_2)
		if self.__now_label == arg_26_1 and not arg_26_2 then
			return
		end

		self.__now_label = arg_26_1

		if self.__now_content then
			self.__now_content.toggle.isOn = false

			self:__set_btn_style(self.__now_content, false)
		end

		self:__set_current_content_and_data(arg_26_1)
		self:__set_btn_style(self.__now_content, true)
	end

	function arg_1_0:__set_scroll_to_top()
		self._control.mainpage.scrollview.scrollbarvertical:GetComponent("Scrollbar").value = self.scrollbar_value ~= 1 and self.scrollbar_value or 1
	end

	function arg_1_0:get_buff_type_select()
		return self._buff_data_select or "all"
	end

	function arg_1_0:__set_type_layer_data(arg_29_1)
		local var_29_0 = {}

		self.now_maip_type = {}
		self.now_tons_type = {}

		for iter_29_0, iter_29_1 in pairs(arg_29_1) do
			local var_29_1 = iter_29_1

			if (function()
				if var_0_10.dict_lenght(self._type_toggle_data) < 2 then
					return true
				end

				local var_30_0 = false
				local var_30_1 = 0
				local var_30_2 = 0

				for iter_30_0, iter_30_1 in pairs(self._type_toggle_data) do
					if iter_30_1 then
						var_30_1 = var_0_11:get_ship_size_type(var_0_11.filter_type[iter_30_0])

						if type(var_0_11.filter_type[iter_30_0]) == "table" then
							var_30_1 = var_0_11:get_ship_size_type(var_0_11.filter_type[iter_30_0][1])
						end
					end

					if var_29_1.effect[1] and var_29_1.effect[1].shipTypes then
						for iter_30_2, iter_30_3 in pairs(var_29_1.effect[1].shipTypes) do
							if var_0_11.filter_type[iter_30_0] == iter_30_3 then
								var_30_2 = iter_30_3
								var_30_0 = true
							end
						end
					end

					if var_30_2 ~= 0 then
						if not var_0_10.have_data(self.now_tons_type, var_0_11:get_ship_size_type(var_30_2)) then
							var_0_5(self.now_tons_type, var_0_11:get_ship_size_type(var_30_2))
						end

						if var_0_10.have_data(var_0_11.maip_ship_type, var_30_2) and not var_0_10.have_data(self.now_maip_type, var_30_2) then
							var_0_5(self.now_maip_type, var_0_11.guard_type.main_ship)
						elseif var_0_10.have_data(var_0_11.protect_ship_type, var_30_2) and not var_0_10.have_data(self.now_maip_type, var_30_2) then
							var_0_5(self.now_maip_type, var_0_11.guard_type.protect_ship)
						end
					elseif var_30_1 ~= 0 and not var_0_10.have_data(self.now_tons_type, var_30_1) then
						var_0_5(self.now_tons_type, var_30_1)
					end

					if self._toggle_size_group.large.toggle.isOn and var_29_1.effect[1] and var_29_1.effect[1].shipTons and var_0_11.ship_ton.large == var_29_1.effect[1].shipTons[1] then
						var_30_0 = true

						break
					end

					if self._toggle_size_group.middle.toggle.isOn and var_29_1.effect[1] and var_29_1.effect[1].shipTons and var_0_11.ship_ton.middle == var_29_1.effect[1].shipTons[1] then
						var_30_0 = true

						break
					end

					if self._toggle_size_group.small.toggle.isOn and var_29_1.effect[1] and var_29_1.effect[1].shipTons and var_0_11.ship_ton.small == var_29_1.effect[1].shipTons[1] then
						var_30_0 = true

						break
					end

					if self._toggle_size_group.protect.toggle.isOn and var_29_1.effect[1] and var_29_1.effect[1].guardType and var_0_11.guard_type.protect_ship == var_29_1.effect[1].guardType[1] then
						var_30_0 = true

						break
					end

					if self._toggle_size_group.maip.toggle.isOn and var_29_1.effect[1] and var_29_1.effect[1].guardType and var_0_11.guard_type.main_ship == var_29_1.effect[1].guardType[1] then
						var_30_0 = true

						break
					end

					if var_30_0 then
						break
					end
				end

				return var_30_0
			end)() and not self:_have_data(var_29_0, iter_29_1.id) then
				var_0_5(var_29_0, iter_29_1)
			end
		end

		return var_29_0
	end

	function arg_1_0:__set_type_link_data(arg_31_1)
		local var_31_0 = {}

		if (not self.now_tons_type or not next(self.now_tons_type)) and (not self.now_maip_type or not next(self.now_maip_type)) then
			return var_31_0
		end

		for iter_31_0, iter_31_1 in pairs(arg_31_1) do
			local var_31_1 = iter_31_1

			if (function()
				if var_0_10.dict_lenght(self._type_toggle_data) < 2 then
					return true
				end

				local var_32_0 = false

				for iter_32_0, iter_32_1 in pairs(self._type_toggle_data) do
					if self.now_tons_type and next(self.now_tons_type) and var_31_1.effect[1] and var_31_1.effect[1].shipTons then
						for iter_32_2, iter_32_3 in pairs(var_31_1.effect[1].shipTons) do
							if var_0_10.have_data(self.now_tons_type, iter_32_3) then
								var_32_0 = true

								break
							end
						end
					end

					if self.now_maip_type and next(self.now_maip_type) and var_31_1.effect[1] and var_31_1.effect[1].guardType and var_0_10.have_data(self.now_maip_type, var_31_1.effect[1].guardType[1]) then
						var_32_0 = true

						break
					end

					if var_32_0 then
						break
					end
				end

				return var_32_0
			end)() and not self:_have_data(var_31_0, iter_31_1.id) then
				var_0_5(var_31_0, iter_31_1)
			end
		end

		return var_31_0
	end

	function arg_1_0:__set_country_layer_data(arg_33_1)
		local var_33_0 = {}

		for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
			local var_33_1 = iter_33_1

			if (function()
				if var_0_10.dict_lenght(self._country_toggle_data) < 2 then
					return true
				end

				local var_34_0 = false

				for iter_34_0, iter_34_1 in pairs(self._country_toggle_data) do
					if iter_34_0 == "other_country" then
						for iter_34_2, iter_34_3 in pairs(var_0_11.filter_country[iter_34_0]) do
							if var_33_1.effect[1] and var_33_1.effect[1].country then
								for iter_34_4, iter_34_5 in pairs(var_33_1.effect[1].country) do
									if var_0_11.filter_country[iter_34_0] == iter_34_5 then
										var_34_0 = true

										break
									end
								end
							end
						end
					elseif var_33_1.effect[1] and var_33_1.effect[1].country then
						for iter_34_6, iter_34_7 in pairs(var_33_1.effect[1].country) do
							if var_0_11.filter_country[iter_34_0] == iter_34_7 then
								var_34_0 = true
							end
						end
					end

					if var_34_0 then
						break
					end
				end

				return var_34_0
			end)() and not self:_have_data(var_33_0, iter_33_1.id) then
				var_0_5(var_33_0, iter_33_1)
			end
		end

		return var_33_0
	end

	function arg_1_0:__set_buff_type_layer_data(arg_35_1)
		local var_35_0 = {}

		for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
			local var_35_1 = iter_35_1

			if (function()
				if self:get_buff_type_select() == "all" then
					return true
				else
					local var_36_0 = false

					if self:get_buff_type_select() == "attribute_up" then
						if var_35_1.effect[1] and var_35_1.effect[1].type and (var_35_1.effect[1].type == 1 or var_35_1.effect[1].type == 2 or var_35_1.effect[1].type == 10) then
							var_36_0 = true
						end
					elseif self:get_buff_type_select() == "damage_up" then
						if var_35_1.effect[1] and var_35_1.effect[1].type and var_35_1.effect[1].type == 3 then
							var_36_0 = true
						end
					elseif self:get_buff_type_select() == "ignore_hurt" then
						if var_35_1.effect[1] and var_35_1.effect[1].type and var_35_1.effect[1].type == 5 then
							var_36_0 = true
						end
					elseif self:get_buff_type_select() == "ignore_lack_ammu" then
						if var_35_1.effect[1] and var_35_1.effect[1].type and var_35_1.effect[1].type == 6 then
							var_36_0 = true
						end
					elseif self:get_buff_type_select() == "capacity_up" then
						if var_35_1.effect[1] and var_35_1.effect[1].type and (var_35_1.effect[1].type == 7 or var_35_1.effect[1].type == 8 or var_35_1.effect[1].type == 9) then
							var_36_0 = true
						end
					elseif self:get_buff_type_select() == "support_atk" and var_35_1.effect[1] and var_35_1.effect[1].type and var_35_1.effect[1].type == 11 then
						var_36_0 = true
					end

					return var_36_0
				end
			end)() and not self:_have_data(var_35_0, iter_35_1.id) then
				var_0_5(var_35_0, iter_35_1)
			end
		end

		return var_35_0
	end

	function arg_1_0:enter_or_return_tween(arg_37_1)
		local var_37_0 = self:autoKillDOTween(var_0_9.Sequence())
		local var_37_1 = self._control.top.transform
		local var_37_2 = self._control.npc.transform
		local var_37_3 = self._control.mainpage.transform
		local var_37_4 = self._control.top.transform.localPosition
		local var_37_5 = self._control.npc.transform.localPosition
		local var_37_6 = self._control.mainpage.transform.localPosition

		if arg_37_1 then
			self._control.top.transform.localPosition = self._control.top.transform.localPosition + Vector3.New(0, 150, 0)
			self._control.npc.transform.localPosition = self._control.npc.transform.localPosition + Vector3.New(-550, 0, 0)
			self._control.mainpage.transform.localPosition = self._control.mainpage.transform.localPosition + Vector3.New(900, 0, 0)

			self._control.top.transform:DOLocalMoveY(self._control.top.transform.localPosition.y, 0.2)
			self._control.npc.transform:DOLocalMoveX(self._control.npc.transform.localPosition.x, 0.2)
			self._control.mainpage.transform:DOLocalMoveX(self._control.mainpage.transform.localPosition.x, 0.2)
		else
			self._control.top.transform:DOLocalMoveY(self._control.top.transform.localPosition.y + 150, 0.2)
			self._control.npc.transform:DOLocalMoveX(self._control.npc.transform.localPosition.x - 550, 0.2)
			self._control.mainpage.transform:DOLocalMoveX(self._control.mainpage.transform.localPosition.x + 900, 0.2):OnComplete(function()
				var_37_1.localPosition = var_37_4
				var_37_2.localPosition = var_37_5
				var_37_3.localPosition = var_37_6

				self:setVisible(false)
				self:return_func()
			end)
		end
	end

	function arg_1_0:show_sort_layer(arg_39_1)
		self._control.type_layer:SetActive(arg_39_1)

		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		self:__save_toggle_group_all_set_data()
	end

	function arg_1_0:__set_btn_style(arg_40_1, arg_40_2)
		arg_40_1.image.sprite = arg_40_2 and self:loadSprite(var_0_11.forth_sort_type_const.selected) or self:loadSprite(var_0_11.forth_sort_type_const.btn)
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
		var_0_7:destroyInstance("ninth_cia")

		local var_41_0 = var_0_7:getInstance("ninth_main_map")

		if var_41_0 then
			var_41_0:setVisible(true)
		else
			log.print_r("这怕是有问题！！！")
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_43_0)
		return
	end

	function arg_1_0.reset_init(arg_44_0)
		arg_44_0._is_init = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_45_0)
	local var_45_0 = var_0_7:class("ninth_cia")

	var_45_0._is_init = false
	var_45_0._ninth_map_buff_list = {}
	var_45_0._normal_data = {}
	var_45_0.__now_label = "all"
	var_45_0.__now_data = {}
	var_45_0.__now_list = {}
	var_45_0._buff_data_select = nil
	var_45_0.now_maip_type = {}
	var_45_0.now_tons_type = {}
	var_45_0.scrollbar_value = 1
	var_45_0._enter_type = 0
	var_45_0._buff_point = 0

	return var_45_0
end

return var_0_0
